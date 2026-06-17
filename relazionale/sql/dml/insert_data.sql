-- =====================================================
-- EBOOK LIBRARY DATABASE
-- SCRIPT DI POPOLAMENTO DATI
-- =====================================================
--
-- Questo script:
-- 1. Svuota le tabelle
-- 2. Inserisce dati di esempio
--
-- Database: SQLite
-- =====================================================


-- =====================================================
-- PULIZIA DATI ESISTENTI
-- =====================================================

DELETE FROM dettaglio_acquisto;
DELETE FROM acquisto;
DELETE FROM ebook;
DELETE FROM collana;
DELETE FROM utente;

-- =====================================================
-- COLLANE
-- =====================================================
-- Raccolte editoriali a cui possono appartenere gli ebook.

INSERT INTO collana (nome, descrizione, casa_editrice)
VALUES
('Fantascienza Moderna', 'Romanzi e racconti di fantascienza contemporanea', 'Mondadori'),
('Business & Innovazione', 'Libri dedicati a startup, management e innovazione', 'Egea'),
('Classici Digitali', 'Grandi classici della letteratura in formato digitale', 'Feltrinelli');


-- =====================================================
-- UTENTI
-- =====================================================
-- Utenti registrati alla piattaforma.

INSERT INTO utente (nome, cognome, email, paese_residenza)
VALUES
('Mario', 'Rossi', 'mario.rossi@email.it', 'Italia'),
('Giulia', 'Bianchi', 'giulia.bianchi@email.it', 'Italia'),
('Luca', 'Verdi', 'luca.verdi@email.it', 'Francia'),
('Anna', 'Neri', 'anna.neri@email.it', 'Germania'),
('Paolo', 'Gallo', 'paolo.gallo@email.it', 'Spagna');


-- =====================================================
-- EBOOK
-- =====================================================
-- Catalogo degli ebook disponibili sulla piattaforma.

INSERT INTO ebook
(titolo, autore, genere, prezzo, anno_pubblicazione, collana_id)
VALUES
('Introduzione all''Intelligenza Artificiale', 'Marco Ferri', 'Tecnologia', 19.99, 2023, 2),

('Startup di Successo', 'Laura Greco', 'Business', 14.99, 2022, 2),

('Viaggio su Marte', 'Giuseppe Blu', 'Fantascienza', 9.99, 2021, 1),

('Ritorno alla Terra', 'Giuseppe Blu', 'Fantascienza', 11.99, 2022, 1),

('I Promessi Sposi', 'Alessandro Manzoni', 'Classico', 4.99, 1840, 3),

('Divina Commedia', 'Dante Alighieri', 'Classico', 5.99, 1321, 3),

('Cloud Computing Essentials', 'Andrea Russo', 'Tecnologia', 21.99, 2024, 2),

('La Galassia Perduta', 'Elena Serra', 'Fantascienza', 12.99, 2020, 1);


-- =====================================================
-- ACQUISTI
-- =====================================================
-- Ogni record rappresenta un acquisto effettuato
-- da un utente della piattaforma.

INSERT INTO acquisto
(utente_id, data_acquisto, modalita_pagamento, importo_totale)
VALUES
(1, '2025-05-01', 'Carta di Credito', 29.98),

(2, '2025-05-03', 'PayPal', 26.98),

(3, '2025-05-04', 'Carta di Credito', 10.98),

(1, '2025-05-10', 'PayPal', 21.99),

(4, '2025-05-12', 'Carta di Credito', 22.98),

(5, '2025-05-15', 'Bonifico', 26.98);


-- =====================================================
-- DETTAGLIO ACQUISTO
-- =====================================================
-- Associazione tra acquisti ed ebook.
-- Un acquisto può contenere più ebook.

INSERT INTO dettaglio_acquisto
(acquisto_id, ebook_id, prezzo_unitario)
VALUES

-- Acquisto #1
(1, 1, 19.99),
(1, 3, 9.99),

-- Acquisto #2
(2, 2, 14.99),
(2, 4, 11.99),

-- Acquisto #3
(3, 5, 4.99),
(3, 6, 5.99),

-- Acquisto #4
(4, 7, 21.99),

-- Acquisto #5
(5, 3, 9.99),
(5, 8, 12.99),

-- Acquisto #6
(6, 2, 14.99),
(6, 4, 11.99);