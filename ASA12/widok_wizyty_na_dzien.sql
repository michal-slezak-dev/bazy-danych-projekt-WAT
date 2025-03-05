CREATE VIEW v_wizyty_na_dzien AS
SELECT wizyta.data_wizyty AS data_wizyty, wizyta.godzina_wizyty AS godzina_wizyty, MAX(klient.id_osoby) AS id_klienta, MAX(klient.imie) || ' ' || MAX(klient.nazwisko) AS klient, MAX(agent.imie) || ' ' || MAX(agent.nazwisko) AS agent, MAX(nieruchomosc.id_nieruchomosci) AS id_nieruchomosci, MAX(nieruchomosc.miejscowosc) || ' ' || MAX(nieruchomosc.ulica) || ' ' || MAX(nieruchomosc.nr_ulicy) || ' ' || nieruchomosc.nr_mieszkania AS adres_nieruchomosci, MAX(oferta.cena) AS cena_oferty, MAX(oferta.opis_oferty) AS opis_oferty
FROM wizyta JOIN klient ON wizyta.id_osoby = klient.id_osoby JOIN oferta ON wizyta.id_oferty = oferta.id_oferty JOIN agent ON oferta.id_osoby = agent.id_osoby JOIN nieruchomosc ON oferta.id_nieruchomosci = nieruchomosc.id_nieruchomosci
WHERE wizyta.data_wizyty = CURRENT DATE
GROUP BY wizyta.data_wizyty, wizyta.godzina_wizyty, nieruchomosc.nr_mieszkania
ORDER BY wizyta.godzina_wizyty;