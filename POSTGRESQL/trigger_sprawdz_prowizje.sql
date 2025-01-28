CREATE OR REPLACE FUNCTION sprawdz_prowizje_fn()
RETURNS TRIGGER AS $$
DECLARE
    v_exists INTEGER;
BEGIN
    -- sprawdzam, czy istnieje powiązana transakcja
    SELECT 1 INTO v_exists
    FROM transakcja
    WHERE id_transakcji = NEW.id_transakcji;

    -- jesli nie, wyrzucam błąd
    IF v_exists IS NULL THEN 
        RAISE EXCEPTION 'Nie można dodać prowizji, ponieważ nie ma z nią powiązanej żadnej transakcji!';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER sprawdz_prowizje
BEFORE INSERT ON prowizja
FOR EACH ROW
EXECUTE FUNCTION sprawdz_prowizje_fn();


-- SELECT  event_object_table AS table_name ,trigger_name         
-- FROM information_schema.triggers  
-- GROUP BY table_name , trigger_name 
-- ORDER BY table_name ,trigger_name 