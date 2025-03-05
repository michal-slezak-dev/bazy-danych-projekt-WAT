CREATE FUNCTION fn_oblicz_prowizje (
    p_kwota_umowy DECIMAL(15, 2), -- kwota z umowy
    p_typ_oferty VARCHAR(1)      -- 's' -> sprzedaż 'w' -> wynajem
) RETURNS DECIMAL(15, 2)
BEGIN
    DECLARE v_kwota_prowizji DECIMAL(15, 2);

    -- obliczam całkowitą kwotę prowizji w zależności od typu oferty
    IF p_typ_oferty = 's' THEN
        SET v_kwota_prowizji = p_kwota_umowy * 0.08; -- 8% od ceny nieruchomości jeśli sprzedaż
    ELSEIF p_typ_oferty = 'w' THEN
        SET v_kwota_prowizji = p_kwota_umowy; -- jeden miesięczny czynsz, czyli to co na umowie
    ELSE
        RAISERROR 23013 'Typ oferty to albo s - sprzedaż, albo w - wynajem!!!';
        RETURN NULL; -- cos jakis nie ten typ co trzeba, chociaz zakladam, ze uzytkownik poprawnie go wpisze
    END IF;

    -- zwracam całą kwotę prowizji, dopiero w transakcji będę liczyć oddzielnie dla biura i oddzielnie dla agenta
    RETURN v_kwota_prowizji;
END
