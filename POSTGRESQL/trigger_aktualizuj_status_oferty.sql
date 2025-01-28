CREATE OR REPLACE FUNCTION aktualizuj_status_oferty_fn()
RETURNS TRIGGER AS $$
DECLARE
    v_id_statusu_oferty_zakonczona INTEGER;
    v_id_statusu_umowy_podpisana INTEGER;
BEGIN
    -- pobieram id statusu oferty 'zakończona'
    SELECT id_statusu_oferty INTO v_id_statusu_oferty_zakonczona
    FROM status_oferty 
    WHERE status_oferty = 'zakończona';
    
    -- pobieram id statusu umowy 'podpisana'
    SELECT id_statusu_umowy INTO v_id_statusu_umowy_podpisana
    FROM status_umowy
    WHERE status_umowy = 'podpisana';
    
    -- jeśli mam umowę podpisaną, to zmieniam status oferty przypisanej do tej umowy na zamkniętą
    IF NEW.id_statusu_umowy = v_id_statusu_umowy_podpisana THEN 
        UPDATE oferta
        SET id_statusu_oferty = v_id_statusu_oferty_zakonczona, 
            data_zakonczenia = CURRENT_DATE
        WHERE id_oferty = NEW.id_oferty;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER aktualizuj_status_oferty
AFTER INSERT ON umowa
FOR EACH ROW
EXECUTE FUNCTION aktualizuj_status_oferty_fn();
