CREATE MATERIALIZED VIEW mv_top_agenci_transakcje 
AS 
SELECT 
    agent.id_osoby AS id_agenta, agent.imie, agent.nazwisko, COUNT(umowa.id_umowy) AS liczba_umow_zrealizowanych, SUM(transakcja.kwota_prowizji) AS suma_prowizji
FROM umowa
JOIN oferta ON umowa.id_oferty = oferta.id_oferty
JOIN agent ON oferta.id_osoby = agent.id_osoby
JOIN status_umowy ON umowa.id_statusu_umowy = status_umowy.id_statusu_umowy
LEFT JOIN transakcja ON umowa.id_umowy = transakcja.id_umowy
WHERE status_umowy.status_umowy LIKE 'zrealizowana'
GROUP BY agent.id_osoby, agent.imie, agent.nazwisko
ORDER BY liczba_umow_zrealizowanych DESC;

-- REFRESH MATERIALIZED VIEW mv_top_agenci_transakcje;
