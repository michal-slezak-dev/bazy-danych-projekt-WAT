CREATE PROCEDURE dodaj_umowe
(
    IN p_id_oferty INTEGER,
    IN p_id_klienta INTEGER,
    IN p_kwota INTEGER
)
BEGIN
DECLARE v_id_statusu_oferty_aktywna INTEGER;
DECLARE v_id_statusu_oferty INTEGER;
DECLARE v_id_statusu_umowy INTEGER;

-- pobieram najpierw id statusu oferty aktywnej
SELECT status_oferty.id_statusu_oferty INTO v_id_statusu_oferty_aktywna
FROM status_oferty
WHERE status_oferty.status_oferty = 'aktywna';

-- pobieram id statusu oferty dla danej oferty
SELECT oferta.id_statusu_oferty INTO v_id_statusu_oferty
FROM oferta 
WHERE oferta.id_oferty = p_id_oferty;

-- pobieram id statusu umowy (podpisana)
SELECT status_umowy.id_statusu_umowy INTO v_id_statusu_umowy
FROM status_umowy
WHERE status_umowy.status_umowy = 'podpisana';

-- sprawdzam czy oferta ma status aktywna
IF v_id_statusu_oferty != v_id_statusu_oferty_aktywna THEN
    RAISERROR 23007 'Ta oferta nie jest aktywna!';
    RETURN;
END IF;

-- dodaje nowa, podpisana umowe
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
    CURRENT DATE,
    p_kwota
);
END