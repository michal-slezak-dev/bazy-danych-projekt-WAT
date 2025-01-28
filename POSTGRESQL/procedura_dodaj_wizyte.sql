CREATE OR REPLACE PROCEDURE dodaj_wizyte(
    p_id_oferty INTEGER,
    p_id_klienta INTEGER,
    p_data_wizyty DATE,
    p_godzina_wizyty TIME
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_statusu_oferty_aktywna INTEGER;
    v_id_statusu_oferty INTEGER;
    v_id_agenta INTEGER;
BEGIN
    -- pobieram id statusu oferty 'aktywna'
    SELECT id_statusu_oferty INTO v_id_statusu_oferty_aktywna
    FROM status_oferty
    WHERE status_oferty.status_oferty = 'aktywna';

    -- pobieram id statusu oferty oraz id agenta
    SELECT o.id_statusu_oferty, o.id_osoby INTO v_id_statusu_oferty, v_id_agenta
    FROM oferta o
    WHERE o.id_oferty = p_id_oferty;

    -- sprawdzam czy oferta jest aktywna
    IF v_id_statusu_oferty != v_id_statusu_oferty_aktywna THEN
        RAISE EXCEPTION 'Ta oferta jest zakończona!';
    END IF;

    -- sprawdzam czy agent ma już wizytę na ten dzień i godzinę
    IF EXISTS (
        SELECT 1
        FROM wizyta w
        WHERE w.id_oferty IN (
            SELECT o.id_oferty
            FROM oferta o
            WHERE o.id_osoby = v_id_agenta
        ) AND w.data_wizyty = p_data_wizyty AND w.godzina_wizyty = p_godzina_wizyty
    ) THEN
        RAISE EXCEPTION 'Agent ma już zaplanowaną wizytę w tym dniu i o tej godzinie! Wybierz inny termin...';
    END IF;

    -- sprawdzam czy klient ma już wizytę na ten dzień i godzinę
    IF EXISTS (
        SELECT 1
        FROM wizyta w
        WHERE w.id_osoby = p_id_klienta AND w.data_wizyty = p_data_wizyty AND w.godzina_wizyty = p_godzina_wizyty
    ) THEN
        RAISE EXCEPTION 'Klient ma już zaplanowaną wizytę w tym dniu i o tej godzinie! Wybierz inny termin...';
    END IF;

    -- sprawdzam czy oferta ma już wizytę na ten dzień i godzinę, właściwie to niepotrzebne, bo klient i agent to załatwia
    IF EXISTS (
        SELECT 1
        FROM wizyta w
        WHERE w.id_oferty = p_id_oferty AND w.data_wizyty = p_data_wizyty AND w.godzina_wizyty = p_godzina_wizyty
    ) THEN
        RAISE EXCEPTION 'Oferta ma już zaplanowaną wizytę w tym dniu i o tej godzinie! Wybierz inny termin...';
    END IF;

    -- dodaje wizyty do tabeli wizyta
    INSERT INTO wizyta (
        id_oferty,
        id_osoby,
        data_wizyty,
        godzina_wizyty
    ) VALUES (
        p_id_oferty,
        p_id_klienta,
        p_data_wizyty,
        p_godzina_wizyty
    );
END;
$$;
