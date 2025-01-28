CREATE OR REPLACE PROCEDURE finalizuj_transakcje (
    p_id_umowy INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_status_umowy VARCHAR(12);
    v_id_agenta INTEGER;
    v_procent_prowizji NUMERIC(5, 2);
    v_prowizja_agent NUMERIC(10, 2);
    v_prowizja_biuro NUMERIC(10, 2);
    v_id_transakcji INTEGER;
    v_typ_oferty VARCHAR(8);
    v_kwota_umowy INTEGER;
    v_kwota_prowizji NUMERIC(10, 2);
BEGIN
   -- PERFORM pg_advisory_xact_lock(1); -- Opcjonalna blokada, by uniknąć kolizji w transakcjach równoległych
    
    BEGIN
        -- pobieram dane umowy, agenta, typu oferty i kwoty z umowy
        SELECT 
            status_umowy.status_umowy, 
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

        -- jeśli umowa jest już zrealizowana
        IF v_status_umowy = 'zrealizowana' THEN
			ROLLBACK; -- cofamy
            RAISE EXCEPTION 'Umowa jest już zrealizowana!';
        END IF;

        -- pobieram procent prowizji agenta
        SELECT agent.procent_prowizji
        INTO v_procent_prowizji
        FROM agent
        WHERE agent.id_osoby = v_id_agenta;

        -- obliczam całkowitą kwotę prowizji
        IF v_typ_oferty = 'sprzedaż' THEN
            v_kwota_prowizji := fn_oblicz_prowizje(v_kwota_umowy, 's');
        ELSE
            v_kwota_prowizji := fn_oblicz_prowizje(v_kwota_umowy, 'w');
        END IF;

        -- dzielę prowizję na agenta i biuro
        IF v_typ_oferty = 'sprzedaż' THEN 
            v_prowizja_agent := v_kwota_prowizji * (v_procent_prowizji / 100);
            v_prowizja_biuro := v_kwota_prowizji - v_prowizja_agent;
        ELSE 
            v_prowizja_agent := v_kwota_prowizji * (45 / 100);
            v_prowizja_biuro := v_kwota_prowizji - v_prowizja_agent;
        END IF;

        -- dodaję transakcję
        INSERT INTO transakcja (id_umowy, data_transakcji, kwota_prowizji)
        VALUES (p_id_umowy, CURRENT_DATE, v_kwota_prowizji)
        RETURNING id_transakcji INTO v_id_transakcji;

        -- dodaję prowizję do tabeli
        INSERT INTO prowizja (id_transakcji, prowizja_agenta, prowizja_biura)
        VALUES (v_id_transakcji, v_prowizja_agent, v_prowizja_biuro);

        -- zmieniam status umowy na 'zrealizowana'
        UPDATE umowa
        SET id_statusu_umowy = (
            SELECT status_umowy.id_statusu_umowy 
            FROM status_umowy 
            WHERE status_umowy.status_umowy = 'zrealizowana'
        )
        WHERE umowa.id_umowy = p_id_umowy;

        COMMIT;
    END;
END;
$$;
