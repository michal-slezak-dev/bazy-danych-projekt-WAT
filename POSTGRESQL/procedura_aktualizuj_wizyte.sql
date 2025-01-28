CREATE OR REPLACE PROCEDURE aktualizuj_wizyte(
    IN p_id_wizyty INTEGER,
    IN p_data_wizyty DATE,
    IN p_godzina_wizyty TIME
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_oferty INTEGER;
    v_id_klienta INTEGER;
    v_id_agenta INTEGER;
BEGIN
    -- pobieram szczegóły dotyczące wizyty
    SELECT w.id_oferty, w.id_osoby
    INTO v_id_oferty, v_id_klienta
    FROM wizyta w
    WHERE w.id_wizyty = p_id_wizyty;

    -- pobieram id agenta opiekującego się daną ofertą
    SELECT o.id_osoby
    INTO v_id_agenta
    FROM oferta o
    WHERE o.id_oferty = v_id_oferty;

    -- sprawdzam, czy agent ma już wizytę zaplanowaną na ten dzień i godzinę
    IF EXISTS (
        SELECT 1
        FROM wizyta w
        WHERE w.id_oferty IN (
            SELECT o.id_oferty
            FROM oferta o
            WHERE o.id_osoby = v_id_agenta
        )
        AND w.data_wizyty = p_data_wizyty
        AND w.godzina_wizyty = p_godzina_wizyty
        AND w.id_wizyty != p_id_wizyty
    ) THEN
        RAISE EXCEPTION 'Agent ma już zaplanowaną wizytę w tym dniu i o tej godzinie! Wybierz inny termin...';
    END IF;

    -- sprawdzam, czy klient ma już wizytę zaplanowaną na ten dzień i godzinę
    IF EXISTS (
        SELECT 1
        FROM wizyta w
        WHERE w.id_osoby = v_id_klienta
        AND w.data_wizyty = p_data_wizyty
        AND w.godzina_wizyty = p_godzina_wizyty
        AND w.id_wizyty != p_id_wizyty
    ) THEN
        RAISE EXCEPTION 'Klient ma już zaplanowaną wizytę w tym dniu i o tej godzinie! Wybierz inny termin...';
    END IF;

    -- sprawdzam, czy oferta ma już wizytę zaplanowaną na ten dzień i godzinę, do usunięcia, bo klient i agent to załatwia
    IF EXISTS (
        SELECT 1
        FROM wizyta w
        WHERE w.id_oferty = v_id_oferty
        AND w.data_wizyty = p_data_wizyty
        AND w.godzina_wizyty = p_godzina_wizyty
        AND w.id_wizyty != p_id_wizyty
    ) THEN
        RAISE EXCEPTION 'Oferta ma już zaplanowaną wizytę w tym dniu i o tej godzinie! Wybierz inny termin...';
    END IF;

    -- aktualizuje datę i godzinę wizyty
    UPDATE wizyta
    SET data_wizyty = p_data_wizyty,
        godzina_wizyty = p_godzina_wizyty
    WHERE id_wizyty = p_id_wizyty;
END;
$$;
