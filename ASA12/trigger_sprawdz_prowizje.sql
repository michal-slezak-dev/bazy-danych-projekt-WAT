CREATE TRIGGER sprawdz_prowizje
BEFORE INSERT ON prowizja
REFERENCING NEW AS new_prowizja
FOR EACH ROW
BEGIN
    -- sprawdzam czy istnieje powiązana z prowizją transakcja, jeśli nie to NIE MOŻNA DODAĆ PROWIZJI!
    IF NOT EXISTS (
        SELECT 1
        FROM transakcja
        WHERE transakcja.id_transakcji = new_prowizja.id_transakcji
    )   THEN 
        RAISERROR 23000 'Nie można dodać prowizji, ponieważ nie ma z nią powiązanej żadnej transakcji!';
    END IF;
END