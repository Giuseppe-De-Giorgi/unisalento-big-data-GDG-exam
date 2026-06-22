-- =====================================================
-- QUERY 1
-- Elencare tutti gli ebook acquistati da un certo utente
-- =====================================================

SELECT
e.titolo,
e.autore,
e.genere
FROM utente u
JOIN acquisto a
ON u.id = a.utente_id
JOIN dettaglio_acquisto da
ON a.id = da.acquisto_id
JOIN ebook e
ON da.ebook_id = e.id
WHERE u.email = 'mario.rossi@email.it';
-- =====================================================
-- QUERY 2
-- Calcolare il numero di acquisti effettuati per ciascuna collana
-- =====================================================

SELECT
c.nome AS collana,
COUNT(*) AS numero_acquisti
FROM collana c
JOIN ebook e
ON c.id = e.collana_id
JOIN dettaglio_acquisto da
ON e.id = da.ebook_id
GROUP BY c.id, c.nome
ORDER BY numero_acquisti DESC;
