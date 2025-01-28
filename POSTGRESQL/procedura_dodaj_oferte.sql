CREATE OR REPLACE PROCEDURE dodaj_oferte(
    IN p_id_nieruchomosci INTEGER,
    IN p_id_agenta INTEGER,
    IN p_typ_oferty VARCHAR(8),
    IN p_cena INTEGER,
    IN p_opis TEXT,
    IN p_update CHAR(1) DEFAULT 'N' -- 'T' → aktualizacja aktywnej oferty
)
LANGUAGE plpgsql
AS $$
DECLARE
    data_aktualna_publikacji DATE;
    v_id_statusu_oferty_aktywna INTEGER;
    v_id_aktywna_oferta INTEGER;
    v_id_typu_oferty INTEGER;
    v_id_obecnego_agenta INTEGER;
BEGIN
    -- pobieram aktualną datę
    data_aktualna_publikacji := CURRENT_DATE;

    -- pobieram id typu oferty
    SELECT id_typu_oferty INTO v_id_typu_oferty
    FROM typ_oferty 
    WHERE typ_oferty.typ_oferty = p_typ_oferty;

    -- pobieram id statusu oferty 'aktywna'
    SELECT id_statusu_oferty INTO v_id_statusu_oferty_aktywna
    FROM status_oferty
    WHERE status_oferty.status_oferty = 'aktywna';

    -- sprawdzam, czy istnieje już aktywna oferta dla tej nieruchomości
    SELECT id_oferty INTO v_id_aktywna_oferta
    FROM oferta
    WHERE id_nieruchomosci = p_id_nieruchomosci 
    AND id_statusu_oferty = v_id_statusu_oferty_aktywna;

    -- sprawdzam, czy użytkownik chce zaktualizować aktywną ofertę
    IF p_update = 'T' THEN
        -- pobieram aktualnego agenta przypisanego do oferty
        SELECT id_osoby INTO v_id_obecnego_agenta
        FROM oferta 
        WHERE id_nieruchomosci = p_id_nieruchomosci;

        -- sprawdzam, czy nowy agent zgadza się z aktualnym (nie można zmieniać agenta)
        IF p_id_agenta != v_id_obecnego_agenta THEN
            RAISE EXCEPTION 'Nie możesz zaktualizować agenta przypisanego do danej oferty!';
        END IF;

        -- jeśli istnieje aktywna oferta, aktualizujemy ją
        IF v_id_aktywna_oferta IS NOT NULL THEN
            UPDATE oferta
            SET id_typu_oferty = v_id_typu_oferty,
                cena = p_cena,
                opis_oferty = p_opis,
                data_publikacji = data_aktualna_publikacji
            WHERE id_oferty = v_id_aktywna_oferta;
        ELSE
            -- jeśli nie ma aktywnej oferty, nie można jej zaktualizować
            RAISE EXCEPTION 'Aktywna oferta, którą chcesz zaktualizować, nie istnieje!';
        END IF;
    ELSE 
        -- jeśli użytkownik nie chce aktualizować, tylko dodać nową ofertę
        IF v_id_aktywna_oferta IS NOT NULL THEN
            RAISE EXCEPTION 'Istnieje już aktywna oferta dla tej nieruchomości!';
        ELSE
            INSERT INTO oferta (
                id_nieruchomosci, 
                id_osoby,
                id_statusu_oferty, 
                id_typu_oferty, 
                cena, 
                opis_oferty, 
                data_publikacji, 
                data_zakonczenia
            )
            VALUES (
                p_id_nieruchomosci,
                p_id_agenta,
                v_id_statusu_oferty_aktywna, 
                v_id_typu_oferty,
                p_cena,
                p_opis,
                data_aktualna_publikacji,
                NULL
            );       
        END IF;
    END IF;
END;
$$;
