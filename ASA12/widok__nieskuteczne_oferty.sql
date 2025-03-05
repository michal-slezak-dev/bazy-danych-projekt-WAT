CREATE VIEW v_nieskuteczne_oferty
AS
SELECT oferta.id_oferty, COUNT(wizyta.id_wizyty) AS liczba_wizyt, oferta.cena, oferta.opis_oferty
FROM oferta LEFT JOIN wizyta ON wizyta.id_oferty = oferta.id_oferty
WHERE oferta.id_statusu_oferty = (
          SELECT status_oferty.id_statusu_oferty 
          FROM status_oferty 
          WHERE status_oferty.status_oferty LIKE 'aktywna'
      ) AND wizyta.data_wizyty BETWEEN DATEADD(MONTH, -1, CURRENT DATE) AND CURRENT DATE - 1
GROUP BY oferta.id_oferty, oferta.cena, oferta.opis_oferty
ORDER BY liczba_wizyt DESC;
