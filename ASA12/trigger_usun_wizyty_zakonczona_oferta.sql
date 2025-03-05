CREATE TRIGGER usun_wizyty_zakonczona_oferta
AFTER UPDATE ON oferta
REFERENCING NEW AS new_row
FOR EACH ROW
BEGIN
    DECLARE v_status_oferty_zakonczona INTEGER;
    --DECLARE v_status_umowy_zrealizowana INTEGER;

    -- pobieram id statusu oferty 'zakończona'
    SELECT status_oferty.id_statusu_oferty INTO v_status_oferty_zakonczona
    FROM status_oferty
    WHERE status_oferty.status_oferty = 'zakończona';

    -- pobieram status umowy 'zrealizowana'
    --SELECT status_umowy.id_statusu_umowy INTO v_status_umowy_zrealizowana
    --FROM status_umowy
    --WHERE status_umowy.status_umowy = 'zrealizowana';

    -- sprawdzam czy status sprawdzanej oferty to zakończona
    IF new_row.id_statusu_oferty = v_status_oferty_zakonczona THEN
        -- sprawdzam czy istnieje umowa dla tej oferty
        IF EXISTS (
            SELECT 1
            FROM umowa
            WHERE umowa.id_oferty = new_row.id_oferty
              --AND umowa.id_statusu_umowy = v_status_umowy_zrealizowana
        ) THEN
            -- usuwam przyszłe wizyty związane z tą ofertą
            DELETE FROM wizyta
            WHERE wizyta.id_oferty = new_row.id_oferty AND wizyta.data_wizyty > CURRENT DATE;
        END IF;
    END IF;
END