CREATE PROCEDURE "dodaj_oferte" 
(
    IN p_id_nieruchomosci INTEGER,
    in p_id_agenta INTEGER,
    IN p_typ_oferty VARCHAR(8),
    IN p_cena INTEGER,
    IN p_opis LONG VARCHAR,
    IN p_update VARCHAR(1) DEFAULT 'N'  -- T --> aktualizacja aktywnej oferty
)
BEGIN
DECLARE data_aktualna_publikacji DATE;
DECLARE status_oferty VARCHAR(10);
DECLARE v_id_statusu_oferty_aktywna INTEGER;
DECLARE v_id_aktywna_oferta INTEGER;
DECLARE v_id_typu_oferty INTEGER;
DECLARE v_id_obecnego_agenta INTEGER;

SET data_aktualna_publikacji = CURRENT DATE;
SET status_oferty = 'aktywna';

-- pobieram id typu oferty w zależności od tego czy to sprzedaż czy wynajem
SELECT id_typu_oferty INTO v_id_typu_oferty
FROM typ_oferty WHERE typ_oferty.typ_oferty LIKE p_typ_oferty;

-- najpierw pobieram id statusów ofert dla danej nieruchomości
SELECT id_statusu_oferty INTO v_id_statusu_oferty_aktywna
FROM status_oferty
WHERE status_oferty = 'aktywna';

-- sprawdzam czy istnieje już aktywna oferta dla danej nieruchomości, jeśli istnieje to będę mieć v_id_aktywna_oferta not null a jeśli nie to null
SELECT oferta.id_oferty INTO v_id_aktywna_oferta
FROM oferta
WHERE oferta.id_nieruchomosci = p_id_nieruchomosci AND oferta.id_statusu_oferty = v_id_statusu_oferty_aktywna;

-- najpierw sprawdzam czy chce update zrobic aktywnej oferty czy dodac nowa po prostu
IF p_update = 'T' THEN
    
    -- jeśli będę chciał aktualizować ofertę to nie mogę zmienić agenta, więc potrzebuje mieć id aktualnego do porównania
    SELECT oferta.id_osoby INTO v_id_obecnego_agenta
    FROM oferta WHERE oferta.id_nieruchomosci = p_id_nieruchomosci;
    
    IF p_id_agenta != v_id_obecnego_agenta THEN
        RAISERROR 23004 'Nie możesz zaktualizować agenta przypisanego do danej oferty!';
    END IF;    

    IF v_id_aktywna_oferta IS NOT NULL THEN -- sprawdzenie czy mam w ogóle aktywną ofertę do aktualizacji
        UPDATE oferta
        SET oferta.id_typu_oferty = v_id_typu_oferty,
        oferta.cena = p_cena,
        oferta.opis_oferty = p_opis,
        oferta.data_publikacji = data_aktualna_publikacji
        WHERE oferta.id_oferty = v_id_aktywna_oferta;
    ELSE -- nie ma aktywnej oferty, więc nie ma co aktualizować, więc daje error i info o tym
        --SIGNAL SQLSTATE '45000' SET MESSAGE TEXT 'Aktywna oferta, którą chcesz zaktualizować nie istnieje!';
        RAISERROR 23005 'Aktywna oferta, którą chcesz zaktualizować nie istnieje!';
    END IF;
ELSE -- jeśli nie chcemy aktualizować tylko dodać nową ofertę
    IF v_id_aktywna_oferta IS NOT NULL THEN -- jeśli istnieje już aktywna oferta dla tej nieruchomości to nie mogę jej dodać!
        --SIGNAL SQLSTATE '45000' SET MESSAGE TEXT 'Istnieje już aktywna oferta dla tej nieruchomości!';
        RAISERROR 23006 'Istnieje już aktywna oferta dla tej nieruchomości!';
    ELSE -- jeśli nie istnieje aktywna oferta dla danej nieruchomości to chce ją dodać, dlatego id statusu ustawiam na 1
        INSERT INTO oferta (
            oferta.id_nieruchomosci, 
            oferta.id_osoby,
            oferta.id_statusu_oferty, 
            oferta.id_typu_oferty, 
            oferta.cena, 
            oferta.opis_oferty, 
            oferta.data_publikacji, 
            oferta.data_zakonczenia
        )
        VALUES (
            p_id_nieruchomosci,
            p_id_agenta,
            1,
            v_id_typu_oferty,
            p_cena,
            p_opis,
            data_aktualna_publikacji,
            NULL
        );       
    END IF;
END IF;
END