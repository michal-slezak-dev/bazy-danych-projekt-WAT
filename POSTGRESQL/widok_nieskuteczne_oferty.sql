CREATE OR REPLACE VIEW v_nieskuteczne_oferty AS
SELECT 
    oferta.id_oferty, 
    COUNT(wizyta.id_wizyty) AS liczba_wizyt, 
    oferta.cena, 
    oferta.opis_oferty
FROM 
    oferta
LEFT JOIN 
    wizyta ON wizyta.id_oferty = oferta.id_oferty
WHERE 
    oferta.id_statusu_oferty = (
        SELECT id_statusu_oferty 
        FROM status_oferty 
        WHERE status_oferty = 'aktywna'
    ) 
    AND wizyta.data_wizyty BETWEEN CURRENT_DATE - INTERVAL '1 MONTH' AND CURRENT_DATE - INTERVAL '1 DAY'
GROUP BY 
    oferta.id_oferty, oferta.cena, oferta.opis_oferty
ORDER BY 
    liczba_wizyt DESC;
