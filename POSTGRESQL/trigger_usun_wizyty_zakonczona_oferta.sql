CREATE OR REPLACE FUNCTION usun_wizyty_zakonczona_oferta_fn()
RETURNS TRIGGER AS $$
DECLARE
    v_status_oferty_zakonczona INTEGER;
    v_status_umowy_zrealizowana INTEGER;
BEGIN
    -- pobieram id statusu oferty 'zakończona'
    SELECT id_statusu_oferty INTO v_status_oferty_zakonczona
    FROM status_oferty
    WHERE status_oferty = 'zakończona';

    -- pobieram status umowy 'zrealizowana'
    --SELECT id_statusu_umowy INTO v_status_umowy_zrealizowana
    --FROM status_umowy
    --WHERE status_umowy = 'zrealizowana';

    -- sprawdzam czy status sprawdzanej oferty to 'zakończona'
    IF NEW.id_statusu_oferty = v_status_oferty_zakonczona THEN
        -- sprawdzam czy istnieje umowa dla tej oferty i czy ma status 'zrealizowana'
        IF EXISTS (
            SELECT 1
            FROM umowa
            WHERE umowa.id_oferty = NEW.id_oferty
              --AND umowa.id_statusu_umowy = v_status_umowy_zrealizowana
        ) THEN
            -- usuwam przyszłe wizyty związane z tą ofertą
            DELETE FROM wizyta
            WHERE wizyta.id_oferty = NEW.id_oferty AND wizyta.data_wizyty > CURRENT_DATE;
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER usun_wizyty_zakonczona_oferta
AFTER UPDATE ON oferta
FOR EACH ROW
EXECUTE FUNCTION usun_wizyty_zakonczona_oferta_fn();
