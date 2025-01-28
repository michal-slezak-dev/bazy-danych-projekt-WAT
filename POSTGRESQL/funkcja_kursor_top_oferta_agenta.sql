CREATE OR REPLACE FUNCTION fn_top_oferta_agenta(p_id_agenta INTEGER)
RETURNS INTEGER AS $$
DECLARE
    c_oferty CURSOR FOR 
        SELECT id_oferty
        FROM oferta
        WHERE id_osoby = p_id_agenta 
        AND id_statusu_oferty IN (
            SELECT id_statusu_oferty 
            FROM status_oferty 
            WHERE status_oferty = 'aktywna'
        );

    -- zmienne do zapisu outputa kursora
    v_id_oferty INTEGER;
    v_liczba_wizyt INTEGER;
    v_max_wizyty INTEGER DEFAULT 0;
    v_top_oferta INTEGER DEFAULT NULL;
BEGIN
    -- otwieram kursor
    OPEN c_oferty;

    -- pobieram kolejne wiersze z kursora
    LOOP
        FETCH c_oferty INTO v_id_oferty;
        EXIT WHEN NOT FOUND;  -- jeśli brak więcej rekordów, wychodzimy

        -- zliczam wizyty dla danej oferty w poprzednim miesiącu
        SELECT COUNT(id_wizyty) INTO v_liczba_wizyt
        FROM wizyta
        WHERE id_oferty = v_id_oferty
          AND data_wizyty BETWEEN (CURRENT_DATE - INTERVAL '1 month') 
                              AND (CURRENT_DATE - INTERVAL '1 day');

        -- sprawdzam, czy jest to oferta z największą liczbą wizyt
        IF v_liczba_wizyt > v_max_wizyty THEN
            v_max_wizyty := v_liczba_wizyt;
            v_top_oferta := v_id_oferty;
        END IF;
    END LOOP;

    -- zamykam kursor
    CLOSE c_oferty;
    
    -- zwracam id oferty z największą liczbą wizyt
    RETURN v_top_oferta;
END;
$$ LANGUAGE plpgsql;

-- SELECT fn_top_oferta_agenta(1) AS top_oferta_id;
