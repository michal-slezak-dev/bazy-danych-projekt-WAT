CREATE PROCEDURE dodaj_wizyte
(
    IN p_id_oferty INTEGER,
    IN p_id_klienta INTEGER,
    IN p_data_wizyty DATE,
    IN p_godzina_wizyty TIME   
)
BEGIN
    DECLARE v_id_statusu_oferty_aktywna INTEGER;
    DECLARE v_id_statusu_oferty INTEGER;
    DECLARE v_id_agenta INTEGER;

    -- pobieram id statusu oferty 'aktywna'
    SELECT status_oferty.id_statusu_oferty INTO v_id_statusu_oferty_aktywna
    FROM status_oferty
    WHERE status_oferty.status_oferty = 'aktywna';

    -- pobieram id statusu oferty, w ramach której chcemy dodać wizytę, oraz id agenta opiekującego się ofertą daną
    SELECT oferta.id_statusu_oferty, oferta.id_osoby INTO v_id_statusu_oferty, v_id_agenta
    FROM oferta
    WHERE oferta.id_oferty = p_id_oferty;
    
    -- sprawdzam czy oferta, w ramach której chcę wizytę umówić jest aktywna
    IF v_id_statusu_oferty != v_id_statusu_oferty_aktywna THEN 
        RAISERROR 23008 'Ta oferta jest zakończona!';
        RETURN;
    END IF;

    -- sprawdzam czy agent ma już jakąś wizytę zaplanowaną na ten dzień i o tej godzinie
    IF EXISTS (
        SELECT 1
        FROM wizyta
        WHERE wizyta.id_oferty IN (
            SELECT oferta.id_oferty
            FROM oferta
            WHERE oferta.id_osoby = v_id_agenta
        ) AND wizyta.data_wizyty = p_data_wizyty AND wizyta.godzina_wizyty = p_godzina_wizyty
    ) THEN 
        RAISERROR 23009 'Agent ma już zaplanowaną wizytę w tym dniu i o tej godzinie! Wybierz inny termin...';
        RETURN;
    END IF;

    -- sprawdzam czy klient ma już jakąś wizytę zaplanowaną na ten dzień i o tej godzinie
    IF EXISTS (
        SELECT 1
        FROM wizyta
        WHERE wizyta.id_osoby = p_id_klienta AND wizyta.data_wizyty = p_data_wizyty AND wizyta.godzina_wizyty = p_godzina_wizyty
    ) THEN
        RAISERROR 23010 'Klient ma już zaplanowaną wizytę w tym dniu i o tej godzinie! Wybierz inny termin...';
        RETURN;
    END IF;
    
    -- sprawdzam czy oferta ma już jakąś wizytę zaplanowaną na ten dzień i na tą godzinę
    IF EXISTS (
        SELECT 1
        FROM wizyta
        WHERE wizyta.id_oferty = p_id_oferty AND wizyta.data_wizyty = p_data_wizyty AND wizyta.godzina_wizyty = p_godzina_wizyty
    ) THEN
        RAISERROR 23011 'Oferta ma już zaplanowaną wizytę w tym dniu i o tej godzinie! Wybierz inny termin...';
        RETURN;
    END IF;

    -- dodanie wizyty do tabeli wizyta
    INSERT INTO wizyta (
        wizyta.id_oferty,
        wizyta.id_osoby,
        wizyta.data_wizyty,
        wizyta.godzina_wizyty
    ) VALUES (
        p_id_oferty,
        p_id_klienta,
        p_data_wizyty,
        p_godzina_wizyty
    );
END