CREATE FUNCTION fn_top_oferta_agenta (
    p_id_agenta INTEGER
) RETURNS INTEGER
BEGIN 
    DECLARE c_oferty CURSOR FOR
    SELECT oferta.id_oferty
    FROM oferta
    WHERE oferta.id_osoby = p_id_agenta AND oferta.id_statusu_oferty IN (SELECT status_oferty.id_statusu_oferty FROM status_oferty WHERE status_oferty.status_oferty LIKE 'aktywna');

    -- zmienne do zapisu outputu kursora
    DECLARE v_id_oferty INTEGER;
    DECLARE v_liczba_wizyt INTEGER;
    DECLARE v_max_wizyty INTEGER DEFAULT 0;
    DECLARE v_top_oferta INTEGER;

    -- otwieram kursor
    OPEN c_oferty;

    petla: LOOP
        -- iteracja po kursorze wiersz po wierszu
        FETCH NEXT c_oferty INTO v_id_oferty;
        if SQLCODE <> 0 THEN   -- jesli pobral wiersz z bledem
            LEAVE petla;
        END IF;

        -- zliczam wizyty dla danej oferty w poprzednim miesiącu
        SELECT COUNT(wizyta.id_wizyty) INTO v_liczba_wizyt
        FROM wizyta
        WHERE wizyta.id_oferty = v_id_oferty
          AND wizyta.data_wizyty BETWEEN DATEADD(MONTH, -1, CURRENT DATE)
                                    AND CURRENT DATE - 1;

        -- sprawdzam, czy jest to oferta z największą liczbą wizyt
        IF v_liczba_wizyt > v_max_wizyty THEN
            SET v_max_wizyty = v_liczba_wizyt;
            SET v_top_oferta = v_id_oferty;
        END IF;
    END LOOP;

    -- zamykam kursor i dealokuje
    CLOSE c_oferty;
    DEALLOCATE c_oferty;
    -- zwracam id oferty z największą liczbą wizyt
    RETURN v_top_oferta;
END;

-- SELECT fn_top_oferta_agenta(1) AS top_oferta_id;
