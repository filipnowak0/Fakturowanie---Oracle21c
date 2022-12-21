-- TRIGGER ARCHIWUM KONTRAHENCI --
CREATE OR REPLACE TRIGGER TRIGGER_KONTRAHENCI
AFTER UPDATE OR INSERT OR DELETE
ON KONTRAHENCI
FOR EACH ROW
DECLARE
BEGIN
    CASE
    WHEN INSERTING THEN
        INSERT INTO ARCHIWUMKONTRAHENCI
        VALUES(ARCHIWUMKONTRAHENCI_SEQ.nextval, USER, 'INSERT', sysdate,
        :OLD.SKROTNAZWYFIRMY,
        :OLD.NAZWAFIRMY,
        :OLD.IMIE ,
        :OLD.NAZWISKO ,
        :OLD.EMAIL ,
        :OLD.NRTELEFONU,
        :OLD.NIP,
        :OLD.PESEL,
        :OLD.MIEJSCOWOSC,
        :OLD.KODPOCZTOWY,
        :OLD.ULICA,
        :OLD.NRBUDYNKU,
        :OLD.BANK,
        :OLD.NRKONTA,
        :OLD.UWAGI,
        
        :NEW.SKROTNAZWYFIRMY,
        :NEW.NAZWAFIRMY,
        :NEW.IMIE,
        :NEW.NAZWISKO,
        :NEW.EMAIL,
        :NEW.NRTELEFONU,
        :NEW.NIP,
        :NEW.PESEL,
        :NEW.MIEJSCOWOSC,
        :NEW.KODPOCZTOWY,
        :NEW.ULICA,
        :NEW.NRBUDYNKU,
        :NEW.BANK,
        :NEW.NRKONTA,
        :NEW.UWAGI
        );
    WHEN UPDATING THEN
        INSERT INTO ARCHIWUMKONTRAHENCI
        VALUES(ARCHIWUMKONTRAHENCI_SEQ.nextval, USER, 'UPDATE', sysdate,
        :OLD.SKROTNAZWYFIRMY,
        :OLD.NAZWAFIRMY,
        :OLD.IMIE,
        :OLD.NAZWISKO ,
        :OLD.EMAIL ,
        :OLD.NRTELEFONU,
        :OLD.NIP,
        :OLD.PESEL,
        :OLD.MIEJSCOWOSC,
        :OLD.KODPOCZTOWY,
        :OLD.ULICA,
        :OLD.NRBUDYNKU,
        :OLD.BANK,
        :OLD.NRKONTA,
        :OLD.UWAGI,
        
        :NEW.SKROTNAZWYFIRMY,
        :NEW.NAZWAFIRMY,
        :NEW.IMIE,
        :NEW.NAZWISKO,
        :NEW.EMAIL,
        :NEW.NRTELEFONU,
        :NEW.NIP,
        :NEW.PESEL,
        :NEW.MIEJSCOWOSC,
        :NEW.KODPOCZTOWY,
        :NEW.ULICA,
        :NEW.NRBUDYNKU,
        :NEW.BANK,
        :NEW.NRKONTA,
        :NEW.UWAGI
        );
    WHEN DELETING THEN
        INSERT INTO ARCHIWUMKONTRAHENCI
        VALUES(ARCHIWUMKONTRAHENCI_SEQ.nextval, USER, 'DELETE', sysdate,
        :OLD.SKROTNAZWYFIRMY,
        :OLD.NAZWAFIRMY,
        :OLD.IMIE ,
        :OLD.NAZWISKO ,
        :OLD.EMAIL ,
        :OLD.NRTELEFONU,
        :OLD.NIP,
        :OLD.PESEL,
        :OLD.MIEJSCOWOSC,
        :OLD.KODPOCZTOWY,
        :OLD.ULICA,
        :OLD.NRBUDYNKU,
        :OLD.BANK,
        :OLD.NRKONTA,
        :OLD.UWAGI,
        
        :NEW.SKROTNAZWYFIRMY,
        :NEW.NAZWAFIRMY,
        :NEW.IMIE,
        :NEW.NAZWISKO,
        :NEW.EMAIL,
        :NEW.NRTELEFONU,
        :NEW.NIP,
        :NEW.PESEL,
        :NEW.MIEJSCOWOSC,
        :NEW.KODPOCZTOWY,
        :NEW.ULICA,
        :NEW.NRBUDYNKU,
        :NEW.BANK,
        :NEW.NRKONTA,
        :NEW.UWAGI
        );
    END CASE;
END;

-- TRIGGER ARCHIWUM TOWARY --
CREATE OR REPLACE TRIGGER TRIGGER_TOWARY
AFTER UPDATE OR INSERT OR DELETE
ON TOWARY
FOR EACH ROW
DECLARE
BEGIN
    CASE
    WHEN INSERTING THEN
        INSERT INTO ARCHIWUMTOWARY
        VALUES(ARCHIWUMTOWARY_SEQ.nextval, USER, 'INSERT', sysdate,
        :OLD.NAZWATOWARU,
        :OLD.CENABRUTTO,
        :OLD.CENANETTO,
        :OLD.STAWKAVAT,
        :OLD.JM,
        :OLD.SYMBOL,

        :NEW.NAZWATOWARU,
        :NEW.CENABRUTTO,
        :NEW.CENANETTO,
        :NEW.STAWKAVAT,
        :NEW.JM,
        :NEW.SYMBOL
        );
    WHEN UPDATING THEN
        INSERT INTO ARCHIWUMTOWARY
        VALUES(ARCHIWUMTOWARY_SEQ.nextval, USER, 'UPDATE', sysdate,
        :OLD.NAZWATOWARU,
        :OLD.CENABRUTTO,
        :OLD.CENANETTO,
        :OLD.STAWKAVAT,
        :OLD.JM,
        :OLD.SYMBOL,

        :NEW.NAZWATOWARU,
        :NEW.CENABRUTTO,
        :NEW.CENANETTO,
        :NEW.STAWKAVAT,
        :NEW.JM,
        :NEW.SYMBOL
        );
    WHEN DELETING THEN
        INSERT INTO ARCHIWUMTOWARY
        VALUES(ARCHIWUMTOWARY_SEQ.nextval, USER, 'DELETE', sysdate,
        :OLD.NAZWATOWARU,
        :OLD.CENABRUTTO,
        :OLD.CENANETTO,
        :OLD.STAWKAVAT,
        :OLD.JM,
        :OLD.SYMBOL,

        :NEW.NAZWATOWARU,
        :NEW.CENABRUTTO,
        :NEW.CENANETTO,
        :NEW.STAWKAVAT,
        :NEW.JM,
        :NEW.SYMBOL
        );
    END CASE;
END;

-- TRIGGER ARCHIWUM UZYTKWONICY --
CREATE OR REPLACE TRIGGER TRIGGER_UZYTKOWNICY
AFTER UPDATE OR INSERT OR DELETE
ON UZYTKOWNICY
FOR EACH ROW
DECLARE
BEGIN
    CASE
    WHEN INSERTING THEN
        INSERT INTO ARCHIWUMUZYTKOWNICY
        VALUES(ARCHIWUMUZYTKOWNICY_SEQ.nextval, USER, 'INSERT', sysdate,
        :OLD.NAZWAUZYTKOWNIKA,
        :OLD.IMIE,
        :OLD.NAZWISKO,
        :OLD.HASLO,

        :NEW.NAZWAUZYTKOWNIKA,
        :NEW.IMIE,
        :NEW.NAZWISKO,
        :NEW.HASLO
        );
    WHEN UPDATING THEN
        INSERT INTO ARCHIWUMUZYTKOWNICY
        VALUES(ARCHIWUMUZYTKOWNICY_SEQ.nextval, USER, 'UPDATE', sysdate,
        :OLD.NAZWAUZYTKOWNIKA,
        :OLD.IMIE,
        :OLD.NAZWISKO,
        :OLD.HASLO,

        :NEW.NAZWAUZYTKOWNIKA,
        :NEW.IMIE,
        :NEW.NAZWISKO,
        :NEW.HASLO
        );
    WHEN DELETING THEN
        INSERT INTO ARCHIWUMUZYTKOWNICY
        VALUES(ARCHIWUMUZYTKOWNICY_SEQ.nextval, USER, 'DELETE', sysdate,
        :OLD.NAZWAUZYTKOWNIKA,
        :OLD.IMIE,
        :OLD.NAZWISKO,
        :OLD.HASLO,

        :NEW.NAZWAUZYTKOWNIKA,
        :NEW.IMIE,
        :NEW.NAZWISKO,
        :NEW.HASLO
        );
    END CASE;
END;

-- TRIGGER DOKUMENTY SZCZEGOLY --
CREATE OR REPLACE TRIGGER TRIGGER_DOKUMENTYSZCZ
AFTER UPDATE OR INSERT OR DELETE
ON DOKUMENTYSZCZEGOLY
FOR EACH ROW
DECLARE
BEGIN
    CASE
    WHEN INSERTING THEN
    INSERT INTO ARCHIWUMDOKUMENTYSZCZ
        VALUES(ARCHIWUMDOKUMENTYSZCZ_SEQ.nextval, USER, 'INSERT', sysdate,
        :OLD.IDTOWARU,
        :OLD.IDDOKUMENTU,
        :OLD.NAZWATOWARU,
        :OLD.ILOSC,
        :OLD.JM,
        :OLD.CENABRUTTO,
        :OLD.CENANETTO,
        :OLD.STAWKAVAT,
    
        :NEW.IDTOWARU,
        :NEW.IDDOKUMENTU,
        :NEW.NAZWATOWARU,
        :NEW.ILOSC,
        :NEW.JM,
        :NEW.CENABRUTTO,
        :NEW.CENANETTO,
        :NEW.STAWKAVAT
        );
    WHEN UPDATING THEN
        INSERT INTO ARCHIWUMDOKUMENTYSZCZ
        VALUES(ARCHIWUMDOKUMENTYSZCZ_SEQ.nextval, USER, 'UPDATE', sysdate,
        :OLD.IDTOWARU,
        :OLD.IDDOKUMENTU,
        :OLD.NAZWATOWARU,
        :OLD.ILOSC,
        :OLD.JM,
        :OLD.CENABRUTTO,
        :OLD.CENANETTO,
        :OLD.STAWKAVAT,
    
        :NEW.IDTOWARU,
        :NEW.IDDOKUMENTU,
        :NEW.NAZWATOWARU,
        :NEW.ILOSC,
        :NEW.JM,
        :NEW.CENABRUTTO,
        :NEW.CENANETTO,
        :NEW.STAWKAVAT
        );
    WHEN DELETING THEN
        INSERT INTO ARCHIWUMDOKUMENTYSZCZ
        VALUES(ARCHIWUMDOKUMENTYSZCZ_SEQ.nextval, USER, 'DELETE', sysdate,
        :OLD.IDTOWARU,
        :OLD.IDDOKUMENTU,
        :OLD.NAZWATOWARU,
        :OLD.ILOSC,
        :OLD.JM,
        :OLD.CENABRUTTO,
        :OLD.CENANETTO,
        :OLD.STAWKAVAT,
    
        :NEW.IDTOWARU,
        :NEW.IDDOKUMENTU,
        :NEW.NAZWATOWARU,
        :NEW.ILOSC,
        :NEW.JM,
        :NEW.CENABRUTTO,
        :NEW.CENANETTO,
        :NEW.STAWKAVAT
        );
    END CASE;
END;

-- TRIGGER DOKUMENTY --
CREATE OR REPLACE TRIGGER TRIGGER_DOKUMENTY
AFTER UPDATE OR INSERT OR DELETE
ON DOKUMENTY
FOR EACH ROW
DECLARE
BEGIN
    CASE
    WHEN INSERTING THEN
        INSERT INTO ARCHIWUMDOKUMENTY
        VALUES(ARCHIWUMDOKUMENTY_SEQ.nextval, USER, 'INSERT', sysdate,
        :OLD.NRFAKTURY,
        :OLD.TYPPLATNOSCI,
        :OLD.DATASPRZEDAZY,
        :OLD.DATAFAKTURY,
        :OLD.UWAGI,
    
        :NEW.NRFAKTURY,
        :NEW.TYPPLATNOSCI,
        :NEW.DATASPRZEDAZY,
        :NEW.DATAFAKTURY,
        :NEW.UWAGI
        );
    WHEN UPDATING THEN
        INSERT INTO ARCHIWUMDOKUMENTY
        VALUES(ARCHIWUMDOKUMENTY_SEQ.nextval, USER, 'UPDATE', sysdate,
        :OLD.NRFAKTURY,
        :OLD.TYPPLATNOSCI,
        :OLD.DATASPRZEDAZY,
        :OLD.DATAFAKTURY,
        :OLD.UWAGI,
    
        :NEW.NRFAKTURY,
        :NEW.TYPPLATNOSCI,
        :NEW.DATASPRZEDAZY,
        :NEW.DATAFAKTURY,
        :NEW.UWAGI
        );
    WHEN DELETING THEN
        INSERT INTO ARCHIWUMDOKUMENTY
        VALUES(ARCHIWUMDOKUMENTY_SEQ.nextval, USER, 'DELETE', sysdate,
        :OLD.NRFAKTURY,
        :OLD.TYPPLATNOSCI,
        :OLD.DATASPRZEDAZY,
        :OLD.DATAFAKTURY,
        :OLD.UWAGI,
    
        :NEW.NRFAKTURY,
        :NEW.TYPPLATNOSCI,
        :NEW.DATASPRZEDAZY,
        :NEW.DATAFAKTURY,
        :NEW.UWAGI
        );
    END CASE;
END;

-- WALIDACJA NIP --
CREATE OR REPLACE TRIGGER walidacja_nip
BEFORE INSERT OR UPDATE
ON kontrahenci
FOR EACH ROW

DECLARE
TYPE KOLEKCJA_NUMBER IS TABLE OF pls_integer
INDEX BY BINARY_INTEGER;

--TABLICE
WAGI KOLEKCJA_NUMBER := KOLEKCJA_NUMBER(6,5,7,2,3,4,5,6,7);
NIP KOLEKCJA_NUMBER;
SUMA KOLEKCJA_NUMBER;

--ZMIENNE
SUMA_MN NUMBER := 0;
MODULO NUMBER;
v_nip varchar2(10);
cyfra_kontrolna varchar(1);

BEGIN
    IF :new.nip IS NULL AND :new.nazwafirmy IS NOT NULL AND :new.nip <> 10 THEN
        raise_application_error(-20000,'NIP JEST PUSTY');
    ELSE
        v_nip := :new.nip;
        cyfra_kontrolna := SUBSTR(v_nip, 10, 1);
        
        FOR I IN 1 .. 9
        LOOP
            NIP(I) := SUBSTR(v_nip, I, 1);
            --DBMS_OUTPUT.PUT_LINE(NIP(I));
            SUMA(I) := NIP(I) * WAGI(I);
            
            SUMA_MN := SUMA_MN + SUMA(I);
            --DBMS_OUTPUT.PUT_LINE(SUMA_MN);
        END LOOP;
        --DBMS_OUTPUT.PUT_LINE(SUMA_MN);
        MODULO := MOD(SUMA_MN,11);
        --DBMS_OUTPUT.PUT_LINE(MODULO);
        
        IF MODULO != cyfra_kontrolna THEN
            raise_application_error(-20001,'NIEPOPRAWNY NIP');
        END IF;
    END IF;
END;

-- WALIDACJA IBAN --
CREATE OR REPLACE TRIGGER walidacja_iban
BEFORE INSERT OR UPDATE
ON kontrahenci
FOR EACH ROW

DECLARE
--ZMIENNE
v_nrkonta number;
v_nrkonta2 number;
v_nrkonta3 number;
v_cyfra_kontrolna number;
v_pl number := 2521;
MODULO number;

BEGIN
    IF LENGTH(:new.nrkonta) != 26 THEN
        raise_application_error(-20002,'BLEDNA ILOSC CYFR');
    ELSE
        v_nrkonta := :new.nrkonta;

        v_cyfra_kontrolna := substr(v_nrkonta,1,2);
        v_nrkonta2 := substr(v_nrkonta,3,26);
        v_nrkonta3 := concat(concat(v_nrkonta2,v_pl),v_cyfra_kontrolna);
        
        MODULO := MOD(v_nrkonta3,97);
        IF MODULO != 1 THEN
            raise_application_error(-20003,'BLEDNY NUMER KONTA BANKOWEGO');
        END IF;
    END IF;
END;

-- WALIDACJA PESEL --
CREATE OR REPLACE TRIGGER walidacja_pesel
BEFORE INSERT OR UPDATE
ON kontrahenci
FOR EACH ROW

DECLARE
TYPE KOLEKCJA_NUMBER IS TABLE OF pls_integer
INDEX BY BINARY_INTEGER;

--TABLICE
WAGI KOLEKCJA_NUMBER := KOLEKCJA_NUMBER(1,3,7,9,1,3,7,9,1,3);
PESEL KOLEKCJA_NUMBER;
SUMA KOLEKCJA_NUMBER;

--ZMIENNE
SUMA_MN NUMBER := 0;
MODULO NUMBER;
MODULO2 NUMBER;
v_pesel varchar2(11);
cyfra_kontrolna varchar(1);

BEGIN
    IF :new.pesel IS NULL AND :new.nip IS NULL THEN
        raise_application_error(-20004,'BRAK DANYCH');
    ELSE
        v_pesel := to_char(:new.pesel,'fm00000000000');
        cyfra_kontrolna := SUBSTR(v_pesel, 11, 1);
        
        FOR I IN 1 .. 10
        LOOP
            PESEL(I) := SUBSTR(v_pesel, I, 1);
            SUMA(I) := PESEL(I) * WAGI(I);
            SUMA_MN := SUMA_MN + SUMA(I);
        END LOOP;
        
        MODULO := MOD(SUMA_MN,10);
        MODULO2 := 10 - MODULO;
        
        IF MODULO2 != cyfra_kontrolna THEN
            IF MODULO2 != 10 THEN
                raise_application_error(-20005,'NIEPOPRAWNY PESEL');
            END IF;
        END IF;
    END IF;
END;

-- WALIDACJA EMAIL --
CREATE OR REPLACE TRIGGER walidacja_email
BEFORE INSERT OR UPDATE
ON kontrahenci
FOR EACH ROW

BEGIN
    IF NOT REGEXP_LIKE (:new.email,'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$') THEN
        raise_application_error(-20006,'NIEPOPRAWNY EMAIL');
    END IF;
END;

-- FAKTURA SPRAWDZANIE POPRAWNEJ DATY --
CREATE OR REPLACE TRIGGER faktura_data
BEFORE INSERT OR UPDATE
ON dokumenty
FOR EACH ROW
DECLARE
BEGIN
    IF :new.datafaktury <> sysdate THEN
        raise_application_error(-20008,'BLEDNA DATA');
    END IF;
END;

--insert into dokumenty
--values(1,11800,51,1050,'gotowka','22/12/24','22/12/24','');