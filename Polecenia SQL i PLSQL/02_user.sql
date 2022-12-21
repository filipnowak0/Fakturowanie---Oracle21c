CREATE USER [nazwa_uzytkownika] IDENTIFIED BY [haslo];

GRANT ALL PRIVILEGES TO [nazwa_uzytkownika];

grant execute on sys.dbms_crypto to [nazwa_uzytkownika]; -- z poziomu SYS --
