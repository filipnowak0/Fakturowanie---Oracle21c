-- 01_TOWARY - ZMIANA CENY TOWARU BRUTTO I NETTO --
EXEC zmiana_cen_towaru; 

-- 02_TOWARY - ZAOKRAGLANIE PRECYZJI --
EXEC zaokraglanie_precyzji;

-- 03_TOWARY - PODWYZKA LUB OBNIZKA CEN TOWAROW --
EXEC zmiana_cen('podwyzka',30);
EXEC zmiana_cen('obnizka',30);
-- 04_TOWARY - USUWANIE TOWARU KTORY NIE BYL DODANY DO DOKUMENTU --
-- ???

-- 01_FAKTURA - SUMOWANIE WARTOSCI POZYCJI FAKTURY --
EXEC suma_wartosci(1);

-- 02_FAKTURA - WYSWIETLANIE FAKTUR NA DANYM OKRESIE --
EXEC daty_faktura('15/11/22','28/11/22');

-- 03_FAKTURA - EKSPORT DO CSV --
EXEC exportcsv_raport('22/12/10', '22/12/24');

BEGIN
    exportcsv_raport('22/12/10','22/12/15');
END;

-- 04_FAKTURA - PODLICZENIE OKRESOWE --
EXEC podliczenie_okresowe(11600, '11/12/22', '22/12/22');

-- 05_FAKTURA - (status: zaplacona/niezaplacona (DATY) ) --
EXEC status_faktura;

-- 01_KONTRAHENCI - ZLCIZ DOKUMENTY --
EXEC zlicz_dokumenty;

-- 01_UZYTKOWNICY - HASHOWANIE HASLA --
EXEC encrypt_password;

-- 02_UZYTKOWNICY - CZAS PRACY UZYTKOWNIKOW --
EXEC czas_pracy(51,'22/12/11 00:00:00,0','22/12/12 00:00:00,0');

-- 03_UZYTKOWNICY - ZLICZ DOKUMENTY --
EXEC zlicz_dok_uzytkownika;