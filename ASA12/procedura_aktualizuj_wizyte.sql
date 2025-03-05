CREATE PROCEDURE aktualizuj_wizyte
(
    IN p_id_wizyty INTEGER,
    IN p_data_wizyty DATE,
    IN p_godzina_wizyty TIME
)
BEGIN
    DECLARE v_id_oferty INTEGER;
    DECLARE v_id_klienta INTEGER;
    DECLARE v_id_agenta INTEGER;

    -- pobieram szczegóły dotyczące wizyty
    SELECT wizyta.id_oferty, wizyta.id_osoby INTO v_id_oferty, v_id_klienta
    FROM wizyta
    WHERE wizyta.id_wizyty = p_id_wizyty;

    -- pobieram id agenta opiekującego się daną ofertą
    SELECT oferta.id_osoby INTO v_id_agenta
    FROM oferta
    WHERE oferta.id_oferty = v_id_oferty;

    -- sprawdzam czy agent ma już jakąś wizytę zaplanowaną na ten dzień i o tej godzinie
    IF EXISTS (
        SELECT 1
        FROM wizyta
        WHERE wizyta.id_oferty IN (
            SELECT oferta.id_oferty
            FROM oferta
            WHERE oferta.id_osoby = v_id_agenta
        )
        AND wizyta.data_wizyty = p_data_wizyty AND wizyta.godzina_wizyty = p_godzina_wizyty AND wizyta.id_wizyty != p_id_wizyty
    ) THEN
        RAISERROR 23001 'Agent ma już zaplanowaną wizytę w tym dniu i o tej godzinie! Wybierz inny termin...';
        RETURN;
    END IF;

    -- sprawdzam czy klient ma już jakąś wizytę zaplanowaną na ten dzień i o tej godzinie
    IF EXISTS (
        SELECT 1
        FROM wizyta
        WHERE wizyta.id_osoby = v_id_klienta AND wizyta.data_wizyty = p_data_wizyty AND wizyta.godzina_wizyty = p_godzina_wizyty AND wizyta.id_wizyty != p_id_wizyty
    ) THEN
        RAISERROR 23002 'Klient ma już zaplanowaną wizytę w tym dniu i o tej godzinie! Wybierz inny termin...';
        RETURN;
    END IF;

    -- sprawdzam czy oferta ma już jakąś wizytę zaplanowaną na ten dzień i na tą godzinę
    IF EXISTS (
        SELECT 1
        FROM wizyta
        WHERE wizyta.id_oferty = v_id_oferty AND wizyta.data_wizyty = p_data_wizyty AND wizyta.godzina_wizyty = p_godzina_wizyty AND wizyta.id_wizyty != p_id_wizyty
    ) THEN
        RAISERROR 23003 'Oferta ma już zaplanowaną wizytę w tym dniu i o tej godzinie! Wybierz inny termin...';
        RETURN;
    END IF;

    -- aktualizuję datę i godzinę wizyty
    UPDATE wizyta
    SET wizyta.data_wizyty = p_data_wizyty,
        wizyta.godzina_wizyty = p_godzina_wizyty
    WHERE wizyta.id_wizyty = p_id_wizyty;
END