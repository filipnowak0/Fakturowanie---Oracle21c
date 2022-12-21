-- 01_TOWARY - ZMIANA CENY TOWARU BRUTTO I NETTO --
CREATE OR REPLACE PROCEDURE zmiana_cen_towaru
IS
CURSOR kursor IS
    SELECT towary.id,cenabrutto, cenanetto, stawkavat.stawkavat
    FROM towary
    INNER JOIN stawkavat
    ON towary.stawkavat = stawkavat.id;
r_zmiana kursor%ROWTYPE;
--zmienne
var_brutto towary.cenabrutto%TYPE;
var_netto towary.cenanetto%type;
BEGIN
    FOR r_zmiana IN kursor
    LOOP
        IF (r_zmiana.cenanetto is NOT NULL) THEN
            var_brutto := round(r_zmiana.cenanetto/100*(100+r_zmiana.stawkavat),2);
            
            UPDATE TOWARY
            SET cenabrutto = var_brutto
            WHERE id = r_zmiana.id;
        ELSIF (r_zmiana.cenabrutto is NOT NULL) THEN
            var_netto := round(r_zmiana.cenabrutto/(100+r_zmiana.stawkavat)*100,2);
            
            UPDATE TOWARY
            SET cenanetto = var_netto
            WHERE id = r_zmiana.id;
        END IF;
    END LOOP;
END;

-- 02_TOWARY - PRECYZJA --
CREATE OR REPLACE PROCEDURE zaokraglanie_precyzji IS
CURSOR kursor IS
    SELECT dokumentyszczegoly.id, ilosc, jednostkimiary.precyzja 
    FROM dokumentyszczegoly 
    INNER JOIN towary 
    ON dokumentyszczegoly.idtowaru = towary.id 
    INNER JOIN jednostkimiary 
    ON towary.jm=jednostkimiary.id; 
r_zaokraglanie kursor%ROWTYPE;
BEGIN
    FOR r_zaokraglanie IN kursor
    LOOP
        UPDATE dokumentyszczegoly
        SET ilosc = round(r_zaokraglanie.ilosc,r_zaokraglanie.precyzja)
        WHERE id = r_zaokraglanie.id;
    END LOOP;
END;

-- 03_TOWARY - PODWYZKA LUB OBNIZKA CEN TOWAROW --
CREATE OR REPLACE PROCEDURE zmiana_cen(opcja varchar2,procent number) IS
CURSOR kursor IS
    SELECT count(*)
    FROM towary;
r_zmiana kursor%ROWTYPE;
BEGIN
    CASE
    WHEN opcja = 'podwyzka' THEN
    FOR r_zmiana IN kursor
        LOOP
            UPDATE towary
            SET cenanetto = round(cenanetto/100*(100+procent),2)
            WHERE ID = id;
        END LOOP;
    WHEN opcja = 'obnizka' THEN
    FOR r_zmiana IN kursor
        LOOP
            UPDATE towary
            SET cenanetto = round(cenanetto/(100+procent)*100,2)
            WHERE ID = id;
        END LOOP;
    END CASE;
END;

-- 04_TOWARY - USUWANIE TOWARU KTORY NIE BYL DODANY DO DOKUMENTU --


-- 01_FAKTURA - SUMOWANIE WARTOSCI POZYCJI FAKTURY --
CREATE OR REPLACE PROCEDURE suma_wartosci(id_faktury IN number) IS
CURSOR kursor IS
    SELECT to_char((cenabrutto*ilosc),'fm9999999990D00') as wartosc
    FROM dokumentyszczegoly 
    WHERE iddokumentu = id_faktury;
r_wartosc kursor%ROWTYPE; 
suma number := 0;
BEGIN
DBMS_OUTPUT.PUT_LINE('');
FOR r_wartosc IN kursor
    LOOP
        suma := suma + r_wartosc.wartosc;
        DBMS_OUTPUT.PUT_LINE(lpad(r_wartosc.wartosc,15));
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('---------------');
    DBMS_OUTPUT.PUT_LINE('Suma: '||lpad(to_char(suma,'fm9999999990D00'),9));
END;

-- 02_FAKTURA - WYSWIETLANIE FAKTUR NA DANYM OKRESIE --
CREATE OR REPLACE PROCEDURE daty_faktura(dataod date, datado date)
IS
CURSOR kursor_1 IS
    SELECT nrfaktury, kontrahenci.skrotnazwyfirmy, datasprzedazy, datafaktury, typplatnosci, kontrahenci.bank, kontrahenci.nrkonta
    FROM dokumenty
    INNER JOIN kontrahenci ON dokumenty.idkontrahenta = kontrahenci.id
    WHERE dokumenty.datafaktury between dataod and datado;
r_faktury kursor_1%ROWTYPE;   
BEGIN
FOR r_faktury IN kursor_1
    LOOP    
        DBMS_OUTPUT.PUT_LINE(r_faktury.nrfaktury ||' '|| r_faktury.skrotnazwyfirmy||' '||r_faktury.datasprzedazy||' '|| r_faktury.datafaktury||' '|| r_faktury.typplatnosci||' '|| r_faktury.bank||' '|| r_faktury.nrkonta);
    END LOOP;
END;

-- 03_FAKTURA - EXPORT DO CSV --
CREATE OR REPLACE PROCEDURE exportcsv_raport(dataod date, datado date)
IS
CURSOR kursor_2 IS
    SELECT dokumenty.id, dokumenty.nrfaktury, dokumenty.typplatnosci, dokumenty.datasprzedazy, dokumenty.datafaktury, kontrahenci.skrotnazwyfirmy, kontrahenci.nazwafirmy, kontrahenci.imie, kontrahenci.nazwisko, 
            kontrahenci.miejscowosc, kontrahenci.kodpocztowy, kontrahenci.ulica, kontrahenci.nrbudynku
    FROM dokumenty
    INNER JOIN kontrahenci ON dokumenty.idkontrahenta = kontrahenci.id
    WHERE dokumenty.datafaktury between dataod and datado;
r_naglowek kursor_2%ROWTYPE;
v_wartosc_brutto number;
v_wartosc_netto number;
v_wartosc_vat number;
v_stawkavat number;
BEGIN
FOR r_naglowek IN kursor_2
    LOOP
            DBMS_OUTPUT.PUT_LINE('[NAGLOWEK]');
            DBMS_OUTPUT.PUT_LINE(r_naglowek.nrfaktury);
            DBMS_OUTPUT.PUT_LINE('[ZAWARTOSC]');
            FOR x IN (SELECT TO_CHAR(round(sum(cenabrutto*ilosc),2),'fm9999999990D00') as wartosc_brutto, TO_CHAR(round(sum(cenanetto*ilosc),2),'fm9999999990D00') as wartosc_netto,
            TO_CHAR(round(sum((cenabrutto-cenanetto)*ilosc),2),'fm9999999990D00') as wartosc_vat, stawkavat
                        INTO v_wartosc_brutto, v_wartosc_netto, v_wartosc_vat, v_stawkavat
                        FROM dokumentyszczegoly
                        WHERE iddokumentu = r_naglowek.id
                        GROUP BY stawkavat)
            LOOP
                DBMS_OUTPUT.PUT_LINE(x.wartosc_brutto||' '||x.wartosc_netto||' '||x.wartosc_vat||' '||x.stawkavat);
            END LOOP;
            DBMS_OUTPUT.PUT_LINE(' ');
    END LOOP;
END;

-- utl file --
CREATE OR REPLACE DIRECTORY CSV_FILES AS 'D:\CSVFILES';

CREATE OR REPLACE PROCEDURE exportcsv_raport(dataod date, datado date) IS
n_file utl_file.file_type;
CURSOR kursor_2 IS
    SELECT dokumenty.id, dokumenty.nrfaktury, dokumenty.typplatnosci, dokumenty.datasprzedazy, dokumenty.datafaktury, kontrahenci.skrotnazwyfirmy, kontrahenci.nazwafirmy, kontrahenci.imie, kontrahenci.nazwisko, 
            kontrahenci.miejscowosc, kontrahenci.kodpocztowy, kontrahenci.ulica, kontrahenci.nrbudynku
    FROM dokumenty
    INNER JOIN kontrahenci ON dokumenty.idkontrahenta = kontrahenci.id
    WHERE dokumenty.datafaktury between dataod and datado;
r_naglowek kursor_2%ROWTYPE;
v_wartosc_brutto number;
v_wartosc_netto number;
v_wartosc_vat number;
v_stawkavat number;
BEGIN
n_file := utl_file.fopen('CSVDIR','dane.csv','w',4000);
FOR r_naglowek IN kursor_2
    LOOP
            utl_file.PUT_LINE(n_file,'[NAGLOWEK]');
            utl_file.PUT_LINE(n_file,r_naglowek.nrfaktury);
            utl_file.PUT_LINE(n_file,'[ZAWARTOSC]');
            FOR x IN (SELECT TO_CHAR(round(sum(cenabrutto*ilosc),2),'fm9999999990D00') as wartosc_brutto, TO_CHAR(round(sum(cenanetto*ilosc),2),'fm9999999990D00') as wartosc_netto,
            TO_CHAR(round(sum((cenabrutto-cenanetto)*ilosc),2),'fm9999999990D00') as wartosc_vat, stawkavat
                        INTO v_wartosc_brutto, v_wartosc_netto, v_wartosc_vat, v_stawkavat
                        FROM dokumentyszczegoly
                        WHERE iddokumentu = r_naglowek.id
                        GROUP BY stawkavat)
            LOOP
                utl_file.PUT_LINE(n_file,x.wartosc_brutto||' '||x.wartosc_netto||' '||x.wartosc_vat||' '||x.stawkavat);
            END LOOP;
            utl_file.PUT_LINE(n_file,' ');
    END LOOP;
utl_file.fclose(n_file);

EXCEPTION
    WHEN OTHERS THEN
        IF utl_file.is_open(n_file) THEN
            utl_file.fclose(n_file);
        END IF;
END;

-- 04_FAKTURY PODLICZENIE OKRESOWE -- 
CREATE OR REPLACE PROCEDURE podliczenie_okresowe(kontrahent number, dataod date, datado date)
IS
CURSOR kursor IS
    SELECT iddokumentu, rpad(sum(cenabrutto*ilosc),13) as wartosc_brutto, rpad(sum(cenanetto*ilosc),12) as wartosc_netto, rpad(sum((cenabrutto-cenanetto)*ilosc),15) as wartosc_vat
    FROM dokumentyszczegoly 
    INNER JOIN dokumenty ON dokumentyszczegoly.iddokumentu = dokumenty.id
    WHERE idkontrahenta = kontrahent and datafaktury >= dataod and datafaktury <= datado
    GROUP BY iddokumentu;
r_podliczenie kursor%ROWTYPE;
v_iddok number := 0;
CURSOR kursor2 IS
    SELECT id, nrfaktury, datafaktury 
    FROM dokumenty 
    WHERE id = v_iddok;
r_dok kursor2%ROWTYPE;
BEGIN
DBMS_OUTPUT.PUT_LINE('DataWystawienia  NrFaktury  WartoscBrutto  WartoscNetto  WartoscVAT');
DBMS_OUTPUT.PUT_LINE('---------------  ---------  -------------  ------------  ----------');
FOR r_podliczenie IN kursor
    LOOP
        v_iddok := r_podliczenie.iddokumentu;
        FOR r_dok IN kursor2
        LOOP
            DBMS_OUTPUT.PUT_LINE(rpad(r_dok.datafaktury,15)||'  '||rpad(r_dok.nrfaktury,9)||'  '|| r_podliczenie.wartosc_brutto ||'  '|| r_podliczenie.wartosc_netto||'  '|| r_podliczenie.wartosc_vat);
        END LOOP;
        v_iddok := 0;
    END LOOP;
END;

-- 05_FAKTURY - FAKTURY Z POZYCJAMI (status: zaplacona/niezaplacona (DATY) ) --
CREATE OR REPLACE PROCEDURE status_faktura IS
CURSOR kursor IS
    SELECT id, nrfaktury, datasprzedazy, datafaktury  FROM dokumenty;
r_dok kursor%ROWTYPE;
i number := 0;
licznik number := 0;

CURSOR kursor2 IS
    SELECT nazwatowaru, ilosc, jm, cenabrutto, cenanetto, stawkavat FROM dokumentyszczegoly WHERE iddokumentu = i;
r_dokszcz kursor2%ROWTYPE;
BEGIN
    FOR r_dok IN kursor
    LOOP
        DBMS_OUTPUT.PUT_LINE(r_dok.nrfaktury||' '||r_dok.datasprzedazy||' '||r_dok.datafaktury);
        i := r_dok.id;
        FOR r_dokszcz IN kursor2
        LOOP
            licznik := licznik + 1;
            DBMS_OUTPUT.PUT_LINE('    '||licznik||'. '||r_dokszcz.nazwatowaru||' '||r_dokszcz.ilosc||' '||r_dokszcz.jm||' '||r_dokszcz.cenabrutto||' '||r_dokszcz.cenanetto||' '||r_dokszcz.stawkavat);
        END LOOP;
        licznik := 0;
    END LOOP;
END;

-- 01_KONTRAHENCI - ZLICZANIE ILOSCI DOKUMENTOW (GLOWNIE DO STATYSTYK/WYKRESOW) --
CREATE OR REPLACE PROCEDURE zlicz_dokumenty IS
CURSOR kursor IS
    SELECT idkontrahenta, count(*) as ilosc
    FROM dokumenty 
    GROUP BY idkontrahenta;
r_zlicz kursor%ROWTYPE;
BEGIN
DBMS_OUTPUT.PUT_LINE('KONTRAHENT'||' '||'ILOSC_DOKUMENTOW');
DBMS_OUTPUT.PUT_LINE('----------'||' '||'----------------');
FOR r_zlicz IN kursor
    LOOP
        DBMS_OUTPUT.PUT_LINE(rpad(r_zlicz.idkontrahenta,10)||' '||r_zlicz.ilosc);
    END LOOP;
END;

-- 01_UZYTKOWNICY - HASHOWANIE HASLA --
-- Przed stworzeniem triggera, nalezy dodac uprawnienia --
-- "grant execute on sys.dbms_crypto to &uzytkownik;" --

CREATE OR REPLACE PROCEDURE encrypt_password IS
CURSOR kursor IS
    SELECT id,haslo
    FROM UZYTKOWNICY;
r_encrypt kursor%ROWTYPE;
--zmienne
v_password   VARCHAR2 (2000);
v_key        VARCHAR2 (2000) := '1234567890999999';
v_mod NUMBER := DBMS_CRYPTO.ENCRYPT_AES128 + DBMS_CRYPTO.CHAIN_CBC + DBMS_CRYPTO.PAD_PKCS5;
BEGIN
    FOR r_encrypt IN kursor
        LOOP
            v_password := r_encrypt.haslo;
            v_password := DBMS_CRYPTO.encrypt(UTL_I18N.string_to_raw (v_password, 'AL32UTF8'), v_mod,  UTL_I18N.string_to_raw (v_key, 'AL32UTF8'));
            --DBMS_OUTPUT.PUT_LINE(v_password);
            UPDATE uzytkownicy
            SET haslo = v_password
            WHERE id = r_encrypt.id;
        END LOOP;
END;

-- 02_UZYTKOWNICY - CZAS PRACY --
create or replace PROCEDURE czas_pracy(uzytkownik number, dataod timestamp, datado timestamp) IS
CURSOR kursor IS
    SELECT substr(login,1,17) as login, substr(logout,1,17) as logout, substr((LOGOUT-LOGIN),12,8) as czas_pracy
    FROM logowanie 
    WHERE iduzytkownika = uzytkownik;
r_czas kursor%ROWTYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('LOGIN'||'             '||'LOGOUT'||'           '||' CZAS');
    DBMS_OUTPUT.PUT_LINE('-----------------'||' -----------------'||' --------');
    FOR r_czas IN kursor
    LOOP
        IF r_czas.login >= dataod  and r_czas.login <= datado THEN
            DBMS_OUTPUT.PUT_LINE(r_czas.login||' '||r_czas.logout||' '||r_czas.czas_pracy);
        END IF;
    END LOOP;
END;

-- 03_UZYTKOWNICY - ZLICZANIE WYSTAWIONYCH DOKUMENTOW --
CREATE OR REPLACE PROCEDURE zlicz_dok_uzytkownika IS
CURSOR kursor IS
    SELECT iduzytkownika, count(*) as ilosc
    FROM DOKUMENTY 
    GROUP BY iduzytkownika;
r_zlicz kursor%ROWTYPE;
BEGIN
    FOR r_zlicz IN kursor
    LOOP
        DBMS_OUTPUT.PUT_LINE(r_zlicz.iduzytkownika||' '||r_zlicz.ilosc);
    END LOOP;
END;