CREATE FUNCTION fn_przychody_z_transakcji (
    p_miesiac INTEGER
) RETURNS DECIMAL(15, 2)
BEGIN
    -- deklaruje kursor
    DECLARE c_transakcje CURSOR FOR
    SELECT transakcja.kwota_prowizji
    FROM transakcja
    WHERE YEAR(transakcja.data_transakcji) = YEAR(CURRENT DATE) AND MONTH(transakcja.data_transakcji) = p_miesiac;

    -- zmienne dla outputu kursora i wyniku końcowego
    DECLARE v_kwota DECIMAL(15, 2);
    DECLARE v_przychody DECIMAL(15, 2) DEFAULT 0;

    -- otwieram kursor
    OPEN c_transakcje;

    petla: LOOP
        -- iteracja po kursorze wiersz po wierszu
        FETCH NEXT c_transakcje INTO v_kwota;
        if SQLCODE <> 0 THEN   -- jesli pobral wiersz z bledem
            LEAVE petla;
        END IF;

        SET v_przychody = v_przychody + v_kwota;
    END LOOP;

    -- zamykam kursor
    CLOSE c_transakcje;
    DEALLOCATE c_transakcje;

    RETURN v_przychody;
END;

-- SELECT fn_przychody_z_transakcji(1) AS przychody;
