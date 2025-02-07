CREATE TRIGGER aktualizuj_status_oferty
AFTER INSERT ON umowa
REFERENCING NEW AS new_row
FOR EACH ROW
BEGIN
    DECLARE v_id_statusu_oferty_zakonczona INTEGER;
    DECLARE v_id_statusu_umowy_podpisana INTEGER;

    -- pobieram id statusu oferty 'zakończona'
    SELECT status_oferty.id_statusu_oferty INTO v_id_statusu_oferty_zakonczona
    FROM status_oferty 
    WHERE status_oferty.status_oferty LIKE 'zakończona';
    
    -- pobieram id statusu umowy 'podpisana'
    SELECT status_umowy.id_statusu_umowy INTO v_id_statusu_umowy_podpisana
    FROM status_umowy
    WHERE status_umowy.status_umowy LIKE 'podpisana';
    
    -- jeśli mam umowę podpisana, to zmieniam status oferty przypisanej do tej umowy na zakonczona
    IF new_row.id_statusu_umowy = v_id_statusu_umowy_podpisana THEN 
        UPDATE oferta
        SET oferta.id_statusu_oferty = v_id_statusu_oferty_zakonczona, 
            oferta.data_zakonczenia = CURRENT DATE
        WHERE oferta.id_oferty = new_row.id_oferty;
    END IF;
END;
