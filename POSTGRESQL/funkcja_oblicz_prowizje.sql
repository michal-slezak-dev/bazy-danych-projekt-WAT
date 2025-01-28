CREATE OR REPLACE FUNCTION fn_oblicz_prowizje(
    p_kwota_umowy DECIMAL(15,2),  -- kwota z umowy
    p_typ_oferty VARCHAR(1)       -- 's' -> sprzedaż, 'w' -> wynajem
) RETURNS DECIMAL(15,2) AS $$
DECLARE
    v_kwota_prowizji DECIMAL(15,2);
BEGIN
    -- obliczam całkowitą kwotę prowizji w zależności od typu oferty
    IF p_typ_oferty = 's' THEN
        v_kwota_prowizji := p_kwota_umowy * 0.08; -- 8% od ceny nieruchomości dla sprzedaży
    ELSIF p_typ_oferty = 'w' THEN
        v_kwota_prowizji := p_kwota_umowy; -- jeden miesięczny czynsz, czyli to co na umowie
    ELSE
        RAISE EXCEPTION 'Typ oferty musi być albo s - sprzedaż, albo w - wynajem!';
    END IF;

    -- zwracam całą kwotę prowizji
    RETURN v_kwota_prowizji;
END;
$$ LANGUAGE plpgsql;

