CREATE OR REPLACE PROCEDURE dodaj_umowe(
    p_id_oferty INTEGER,
    p_id_klienta INTEGER,
    p_kwota INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_statusu_oferty_aktywna INTEGER;
    v_id_statusu_oferty INTEGER;
    v_id_statusu_umowy INTEGER;
BEGIN
    -- pobieram najpierw id statusu oferty "aktywna"
    SELECT id_statusu_oferty INTO v_id_statusu_oferty_aktywna
    FROM status_oferty
    WHERE status_oferty = 'aktywna';

    -- pobieram id statusu oferty dla danej oferty
    SELECT id_statusu_oferty INTO v_id_statusu_oferty
    FROM oferta
    WHERE id_oferty = p_id_oferty;

    -- pobieram id statusu umowy "podpisana"
    SELECT id_statusu_umowy INTO v_id_statusu_umowy
    FROM status_umowy
    WHERE status_umowy = 'podpisana';

    -- sprawdzam, czy oferta ma status "aktywna"
    IF v_id_statusu_oferty != v_id_statusu_oferty_aktywna THEN
        RAISE EXCEPTION 'Ta oferta nie jest aktywna!';
    END IF;

    -- dodaje nową, podpisaną umowę
    INSERT INTO umowa (
        id_oferty,
        id_osoby,
        id_statusu_umowy,
        data_podpisania,
        kwota
    )
    VALUES (
        p_id_oferty,
        p_id_klienta,
        v_id_statusu_umowy,
        CURRENT_DATE,
        p_kwota
    );
END;
$$;
