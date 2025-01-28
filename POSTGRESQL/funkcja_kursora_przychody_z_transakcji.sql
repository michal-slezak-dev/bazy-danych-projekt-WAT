CREATE OR REPLACE FUNCTION fn_przychody_z_transakcji(p_miesiac INTEGER)
RETURNS DECIMAL(15,2) AS $$
DECLARE
    c_transakcje CURSOR FOR 
        SELECT kwota_prowizji
        FROM transakcja
        WHERE EXTRACT(YEAR FROM data_transakcji) = EXTRACT(YEAR FROM CURRENT_DATE)
        AND EXTRACT(MONTH FROM data_transakcji) = p_miesiac;

    -- zmienne dla outputu kursora i wyniku końcowego
    v_kwota DECIMAL(15,2);
    v_przychody DECIMAL(15,2) DEFAULT 0;
BEGIN
    OPEN c_transakcje;

    -- pobieram kolejne wartości kursora
    LOOP
        FETCH c_transakcje INTO v_kwota;
        EXIT WHEN NOT FOUND;  -- jesli brak kolejnych rekordów, wychodzimy

        -- dodaje kwotę do przychodu
        v_przychody := v_przychody + v_kwota;
    END LOOP;

    -- zamykam kursor
    CLOSE c_transakcje;

    -- zwracam całkowity przychód
    RETURN v_przychody;
END;
$$ LANGUAGE plpgsql;

-- SELECT fn_przychody_z_transakcji(1) AS przychody;
