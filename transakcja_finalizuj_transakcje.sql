CREATE PROCEDURE finalizuj_transakcje (
    IN p_id_umowy INTEGER
)
BEGIN
    DECLARE v_status_umowy VARCHAR(12);
    DECLARE v_id_agenta INTEGER;
    DECLARE v_procent_prowizji NUMERIC(5, 2);
    DECLARE v_prowizja_agent NUMERIC(10, 2);
    DECLARE v_prowizja_biuro NUMERIC(10, 2);
    DECLARE v_id_transakcji INTEGER;
    DECLARE v_typ_oferty VARCHAR(8);
    DECLARE v_kwota_umowy INTEGER;
    DECLARE v_kwota_prowizji NUMERIC(10, 2);

    -- pobieram status umowy, w ramach której chcę dodać transakcje, id agenta, typ oferty oraz kwote z umowy 
    SELECT 
        status_umowy.id_statusu_umowy, 
        umowa.id_osoby AS id_agenta,
        typ_oferty.typ_oferty,
        umowa.kwota
    INTO 
        v_status_umowy, 
        v_id_agenta, 
        v_typ_oferty, 
        v_kwota_umowy
    FROM umowa
    JOIN oferta ON umowa.id_oferty = oferta.id_oferty
    JOIN typ_oferty ON oferta.id_typu_oferty = typ_oferty.id_typu_oferty
    JOIN status_umowy ON umowa.id_statusu_umowy = status_umowy.id_statusu_umowy
    WHERE umowa.id_umowy = p_id_umowy;

    IF v_status_umowy = 'zrealizowana' THEN -- nie muszę sprawdzać czy != 'podpisana', bo wszystkie umowy dodane do umowa są defaultowo podpisane
        ROLLBACK; -- cofamy
        RAISERROR 23000 'Umowa jest już zrealizowana!!!';
    END IF;

    -- pobieram procent prowizji agenta
    SELECT agent.procent_prowizji
    INTO v_procent_prowizji
    FROM agent
    WHERE agent.id_osoby = v_id_agenta;

    -- obliczam całkowitą kwotę prowizji
    IF v_typ_oferty = 'sprzedaż' THEN
        SET v_kwota_prowizji = fn_oblicz_prowizje(v_kwota_umowy, 's');
    ELSE
        SET v_kwota_prowizji = fn_oblicz_prowizje(v_kwota_umowy, 'w');
    END IF;

    -- dziele prowizję na agenta i biuro
    IF v_typ_oferty = 'sprzedaż' THEN 
        SET v_prowizja_agent = v_kwota_prowizji * (v_procent_prowizji / 100);
        SET v_prowizja_biuro = v_kwota_prowizji - v_prowizja_agent;
    ELSE 
        SET v_prowizja_agent = v_kwota_prowizji * (45 / 100);
        SET v_prowizja_biuro = v_kwota_prowizji - v_prowizja_agent;
    END IF;

    -- dodaje transakcje
    INSERT INTO transakcja (id_umowy, data_transakcji, kwota_prowizji)
    VALUES (p_id_umowy, CURRENT DATE, v_kwota_prowizji);

    SET v_id_transakcji = @@identity; -- pobranie id ostatniej transakcji, od autoincrement

    -- dodaje prowizje do tabeli
    INSERT INTO prowizja (id_transakcji, prowizja_agenta, prowizja_biura)
    VALUES (v_id_transakcji, v_prowizja_agent, v_prowizja_biuro);

    -- zmieniam staus umowy na 'zrealizowana'
    UPDATE umowa
    SET umowa.id_statusu_umowy = (SELECT status_umowy.id_statusu_umowy FROM status_umowy WHERE status_umowy.status_umowy = 'zrealizowana')
    WHERE umowa.id_umowy = p_id_umowy;

    -- zatwierdzam transakcji
    COMMIT;
END
