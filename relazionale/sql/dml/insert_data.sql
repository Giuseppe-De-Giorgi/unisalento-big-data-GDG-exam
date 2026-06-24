-- =====================================================
-- EBOOK LIBRARY DATABASE
-- SCRIPT DI POPOLAMENTO DATI - DATASET ESTESO
-- =====================================================
--
-- Questo script:
-- 1. Svuota le tabelle esistenti
-- 2. Inserisce un dataset completo e realistico
--
-- STATISTICHE DATASET:
-- - 10 Collane editoriali
-- - 30 Utenti da 11 paesi europei
-- - 105 Ebook (50 con collana, 55 senza collana)
-- - 91 Acquisti distribuiti nel tempo (gen-mag 2025)
-- - ~220 Dettagli acquisto (libri acquistati)
--
-- CARATTERISTICHE:
-- - Utenti che effettuano acquisti multipli
-- - Varietà di generi letterari (tecnologia, fantasy, classici, ecc.)
-- - Alcuni ebook NON appartengono a collane
-- - Modalità di pagamento varie (Carta, PayPal, Bonifico)
-- - Prezzi realistici da €3.99 a €24.99
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
('Classici Digitali', 'Grandi classici della letteratura in formato digitale', 'Feltrinelli'),
('Gialli e Thriller', 'Racconti polizieschi e thriller mozzafiato', 'Einaudi'),
('Romanzi Storici', 'Storie ambientate in epoche passate', 'Bompiani'),
('Sviluppo Personale', 'Guide per crescita personale e professionale', 'ROI Edizioni'),
('Fantasy Epico', 'Mondi fantastici e avventure epiche', 'Salani'),
('Scienza e Natura', 'Divulgazione scientifica accessibile', 'Cortina'),
('Cucina Italiana', 'Ricette e tradizioni culinarie', 'Slow Food'),
('Poesia Contemporanea', 'Poesie di autori moderni', 'Guanda');


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
('Paolo', 'Gallo', 'paolo.gallo@email.it', 'Spagna'),
('Francesca', 'Romano', 'francesca.romano@email.it', 'Italia'),
('Alessandro', 'Ferrari', 'alessandro.ferrari@email.it', 'Italia'),
('Elena', 'Ricci', 'elena.ricci@email.it', 'Svizzera'),
('Marco', 'Marino', 'marco.marino@email.it', 'Italia'),
('Silvia', 'Colombo', 'silvia.colombo@email.it', 'Belgio'),
('Roberto', 'Esposito', 'roberto.esposito@email.it', 'Italia'),
('Chiara', 'Bruno', 'chiara.bruno@email.it', 'Austria'),
('Davide', 'De Luca', 'davide.deluca@email.it', 'Francia'),
('Valentina', 'Costa', 'valentina.costa@email.it', 'Italia'),
('Stefano', 'Moretti', 'stefano.moretti@email.it', 'Regno Unito'),
('Laura', 'Fontana', 'laura.fontana@email.it', 'Italia'),
('Andrea', 'Caruso', 'andrea.caruso@email.it', 'Olanda'),
('Martina', 'Greco', 'martina.greco@email.it', 'Italia'),
('Simone', 'Conti', 'simone.conti@email.it', 'Portogallo'),
('Federica', 'Serra', 'federica.serra@email.it', 'Italia'),
('Matteo', 'Barbieri', 'matteo.barbieri@email.it', 'Danimarca'),
('Sofia', 'Rinaldi', 'sofia.rinaldi@email.it', 'Italia'),
('Lorenzo', 'Ferrara', 'lorenzo.ferrara@email.it', 'Svezia'),
('Giorgia', 'Leone', 'giorgia.leone@email.it', 'Italia'),
('Nicola', 'Marchetti', 'nicola.marchetti@email.it', 'Norvegia'),
('Alessia', 'Vitale', 'alessia.vitale@email.it', 'Italia'),
('Fabio', 'Santoro', 'fabio.santoro@email.it', 'Finlandia'),
('Elisa', 'Pellegrini', 'elisa.pellegrini@email.it', 'Italia'),
('Riccardo', 'Marini', 'riccardo.marini@email.it', 'Polonia'),
('Benedetta', 'Sanna', 'benedetta.sanna@email.it', 'Italia');


-- =====================================================
-- EBOOK
-- =====================================================
-- Catalogo degli ebook disponibili sulla piattaforma.
-- Alcuni ebook NON appartengono a nessuna collana (collana_id = NULL).

INSERT INTO ebook
(titolo, autore, genere, prezzo, anno_pubblicazione, collana_id)
VALUES
-- TECNOLOGIA E BUSINESS (collana 2)
('Introduzione all''Intelligenza Artificiale', 'Marco Ferri', 'Tecnologia', 19.99, 2023, 2),
('Startup di Successo', 'Laura Greco', 'Business', 14.99, 2022, 2),
('Cloud Computing Essentials', 'Andrea Russo', 'Tecnologia', 21.99, 2024, 2),
('Blockchain per Tutti', 'Stefano Mancini', 'Tecnologia', 18.50, 2023, 2),
('Marketing Digitale Avanzato', 'Chiara Fontana', 'Business', 16.99, 2024, 2),

-- FANTASCIENZA (collana 1)
('Viaggio su Marte', 'Giuseppe Blu', 'Fantascienza', 9.99, 2021, 1),
('Ritorno alla Terra', 'Giuseppe Blu', 'Fantascienza', 11.99, 2022, 1),
('La Galassia Perduta', 'Elena Serra', 'Fantascienza', 12.99, 2020, 1),
('Cronache Spaziali', 'Roberto Stella', 'Fantascienza', 13.50, 2023, 1),
('I Robot del Futuro', 'Lucia Neri', 'Fantascienza', 10.99, 2024, 1),

-- CLASSICI (collana 3)
('I Promessi Sposi', 'Alessandro Manzoni', 'Classico', 4.99, 1840, 3),
('Divina Commedia', 'Dante Alighieri', 'Classico', 5.99, 1321, 3),
('Decameron', 'Giovanni Boccaccio', 'Classico', 4.50, 1353, 3),
('Orlando Furioso', 'Ludovico Ariosto', 'Classico', 6.99, 1516, 3),
('Il Principe', 'Niccolò Machiavelli', 'Classico', 3.99, 1532, 3),

-- GIALLI E THRILLER (collana 4)
('Delitto in Via Dante', 'Massimo Gialli', 'Thriller', 11.99, 2023, 4),
('L''Assassino della Metropolitana', 'Carla Noir', 'Giallo', 12.50, 2024, 4),
('Il Segreto della Villa', 'Leonardo Crimine', 'Thriller', 10.99, 2022, 4),
('Morte a Venezia', 'Giovanna Mistero', 'Giallo', 9.99, 2023, 4),
('L''Ultimo Indizio', 'Paolo Detective', 'Thriller', 13.99, 2024, 4),

-- ROMANZI STORICI (collana 5)
('I Leoni di Sicilia', 'Stefania Auci', 'Storico', 14.99, 2019, 5),
('Il Nome della Rosa', 'Umberto Eco', 'Storico', 15.99, 1980, 5),
('La Cattedrale del Mare', 'Ildefonso Falcones', 'Storico', 13.50, 2006, 5),
('I Pilastri della Terra', 'Ken Follett', 'Storico', 16.99, 1989, 5),
('Il Medico', 'Noah Gordon', 'Storico', 12.99, 1986, 5),

-- SVILUPPO PERSONALE (collana 6)
('Le 7 Regole del Successo', 'Stephen Covey', 'Crescita Personale', 17.99, 2020, 6),
('Come Parlare in Pubblico', 'Dale Carnegie', 'Comunicazione', 14.50, 2021, 6),
('La Mente Vincente', 'Roberto Re', 'Motivazione', 16.99, 2022, 6),
('Pensiero Positivo', 'Norman Vincent Peale', 'Psicologia', 13.99, 2020, 6),
('Obiettivi e Risultati', 'Brian Tracy', 'Produttività', 15.50, 2023, 6),

-- FANTASY EPICO (collana 7)
('Il Signore degli Anelli', 'J.R.R. Tolkien', 'Fantasy', 19.99, 1954, 7),
('Il Trono di Spade', 'George R.R. Martin', 'Fantasy', 18.99, 1996, 7),
('Harry Potter e la Pietra Filosofale', 'J.K. Rowling', 'Fantasy', 12.99, 1997, 7),
('Le Cronache di Narnia', 'C.S. Lewis', 'Fantasy', 14.50, 1950, 7),
('Eragon', 'Christopher Paolini', 'Fantasy', 13.99, 2003, 7),

-- SCIENZA E NATURA (collana 8)
('L''Origine delle Specie', 'Charles Darwin', 'Scienza', 8.99, 1859, 8),
('Breve Storia del Tempo', 'Stephen Hawking', 'Fisica', 16.99, 1988, 8),
('Il Gene Egoista', 'Richard Dawkins', 'Biologia', 14.50, 1976, 8),
('Cosmo', 'Carl Sagan', 'Astronomia', 15.99, 1980, 8),
('L''Universo in un Guscio di Noce', 'Stephen Hawking', 'Fisica', 13.50, 2001, 8),

-- CUCINA ITALIANA (collana 9)
('La Scienza della Cucina', 'Pellegrino Artusi', 'Cucina', 9.99, 1891, 9),
('Ricette della Nonna', 'Maria Rossi', 'Cucina', 11.50, 2022, 9),
('Pasta Fatta in Casa', 'Giuseppe Chef', 'Cucina', 10.99, 2023, 9),
('Dolci Tradizionali', 'Anna Pasticcera', 'Cucina', 12.99, 2024, 9),
('Cucina Mediterranea', 'Carlo Cuoco', 'Cucina', 13.50, 2023, 9),

-- POESIA CONTEMPORANEA (collana 10)
('Fiori di Marzo', 'Alda Merini', 'Poesia', 7.99, 2005, 10),
('Il Sabato del Villaggio', 'Giacomo Leopardi', 'Poesia', 6.50, 1829, 10),
('Canzoniere', 'Francesco Petrarca', 'Poesia', 5.99, 1374, 10),
('Ossi di Seppia', 'Eugenio Montale', 'Poesia', 8.50, 1925, 10),
('Myricae', 'Giovanni Pascoli', 'Poesia', 7.50, 1891, 10),

-- LIBRI SENZA COLLANA (vari generi indipendenti)
('Python per Data Science', 'Andrea Coder', 'Tecnologia', 22.99, 2024, NULL),
('JavaScript Moderno', 'Laura Dev', 'Tecnologia', 19.99, 2023, NULL),
('Machine Learning Pratico', 'Marco AI', 'Tecnologia', 24.99, 2024, NULL),
('Guida al Trading Online', 'Roberto Trader', 'Finance', 18.50, 2023, NULL),
('Criptovalute Spiegate', 'Crypto Guru', 'Finance', 15.99, 2024, NULL),
('Fotografia Digitale', 'Elena Foto', 'Arte', 17.50, 2022, NULL),
('Disegno e Pittura', 'Leonardo Arte', 'Arte', 16.99, 2023, NULL),
('Storia dell''Arte', 'Giulia Cultura', 'Arte', 19.50, 2021, NULL),
('Meditazione Zen', 'Paolo Zen', 'Benessere', 12.99, 2023, NULL),
('Yoga per Principianti', 'Sara Relax', 'Benessere', 14.50, 2024, NULL),
('Corsa e Maratona', 'Luca Runner', 'Sport', 13.99, 2023, NULL),
('Calcio Tattico', 'Mister Calcio', 'Sport', 15.50, 2024, NULL),
('Sci Alpino', 'Neve Bianca', 'Sport', 12.50, 2022, NULL),
('Giardinaggio Facile', 'Verde Pollice', 'Hobby', 11.99, 2023, NULL),
('Bonsai Arte Giapponese', 'Sakura Tree', 'Hobby', 13.50, 2024, NULL),
('Astronomia Amatoriale', 'Stella Notte', 'Scienza', 16.99, 2023, NULL),
('Chimica Organica', 'Prof. Molecola', 'Scienza', 21.50, 2022, NULL),
('Matematica Divertente', 'Numeri Felici', 'Scienza', 14.99, 2024, NULL),
('Storia Romana', 'Impero Antico', 'Storia', 17.99, 2022, NULL),
('Seconda Guerra Mondiale', 'Memoria 1945', 'Storia', 18.99, 2023, NULL),
('Il Risorgimento Italiano', 'Garibaldi Eroe', 'Storia', 15.50, 2022, NULL),
('Economia Globale', 'World Economy', 'Economia', 19.99, 2024, NULL),
('Microeconomia', 'Supply Demand', 'Economia', 21.99, 2023, NULL),
('Sociologia Moderna', 'Social Study', 'Sociologia', 16.50, 2023, NULL),
('Psicologia Cognitiva', 'Mind Power', 'Psicologia', 18.50, 2024, NULL),
('Neuroscienze Base', 'Brain Lab', 'Psicologia', 22.99, 2023, NULL),
('Filosofia Antica', 'Socrate Pensiero', 'Filosofia', 14.99, 2022, NULL),
('Etica Moderna', 'Kant Ragione', 'Filosofia', 16.99, 2023, NULL),
('Metafisica', 'Aristotele Essere', 'Filosofia', 17.50, 2021, NULL),
('Diritto Civile', 'Codice Legge', 'Diritto', 23.99, 2024, NULL),
('Diritto Penale', 'Giustizia Oggi', 'Diritto', 24.50, 2024, NULL),
('Diritto del Lavoro', 'Worker Rights', 'Diritto', 22.50, 2023, NULL),
('Architettura Sostenibile', 'Green Building', 'Architettura', 20.99, 2024, NULL),
('Design Interni', 'Home Style', 'Design', 18.99, 2023, NULL),
('Moda e Tendenze', 'Fashion Week', 'Moda', 15.99, 2024, NULL),
('Cinema Italiano', 'Fellini Dreams', 'Cinema', 17.50, 2022, NULL),
('Storia del Jazz', 'Blue Notes', 'Musica', 16.50, 2023, NULL),
('Rock Legends', 'Guitar Hero', 'Musica', 14.99, 2024, NULL),
('Opera Lirica', 'Bel Canto', 'Musica', 18.50, 2022, NULL),
('Teatro Contemporaneo', 'Stage Life', 'Teatro', 15.50, 2023, NULL),
('Letteratura Latina', 'Virgilio Eneide', 'Letteratura', 13.99, 2021, NULL),
('Letteratura Inglese', 'Shakespeare Tales', 'Letteratura', 16.99, 2022, NULL),
('Letteratura Americana', 'Hemingway Sun', 'Letteratura', 17.99, 2023, NULL);


-- =====================================================
-- ACQUISTI
-- =====================================================
-- Ogni record rappresenta un acquisto effettuato
-- da un utente della piattaforma.
-- NOTA: Alcuni utenti effettuano più acquisti in momenti diversi.

INSERT INTO acquisto
(utente_id, data_acquisto, modalita_pagamento, importo_totale)
VALUES
-- Mario Rossi (id=1) - acquista 5 volte
(1, '2025-01-15', 'Carta di Credito', 29.98),
(1, '2025-02-20', 'PayPal', 21.99),
(1, '2025-03-10', 'Carta di Credito', 45.98),
(1, '2025-04-05', 'PayPal', 33.48),
(1, '2025-05-12', 'Bonifico', 19.99),

-- Giulia Bianchi (id=2) - acquista 4 volte
(2, '2025-01-18', 'PayPal', 26.98),
(2, '2025-02-25', 'Carta di Credito', 31.97),
(2, '2025-03-30', 'PayPal', 22.99),
(2, '2025-05-08', 'Carta di Credito', 18.50),

-- Luca Verdi (id=3) - acquista 3 volte
(3, '2025-01-22', 'Carta di Credito', 10.98),
(3, '2025-03-15', 'PayPal', 49.97),
(3, '2025-04-28', 'Bonifico', 27.98),

-- Anna Neri (id=4) - acquista 4 volte
(4, '2025-02-01', 'Carta di Credito', 22.98),
(4, '2025-02-28', 'PayPal', 36.98),
(4, '2025-04-10', 'Carta di Credito', 19.99),
(4, '2025-05-20', 'Bonifico', 41.49),

-- Paolo Gallo (id=5) - acquista 3 volte
(5, '2025-01-25', 'Bonifico', 26.98),
(5, '2025-03-20', 'Carta di Credito', 44.97),
(5, '2025-05-05', 'PayPal', 15.99),

-- Francesca Romano (id=6) - acquista 3 volte
(6, '2025-02-05', 'Carta di Credito', 34.98),
(6, '2025-03-12', 'PayPal', 29.99),
(6, '2025-04-22', 'Bonifico', 52.47),

-- Alessandro Ferrari (id=7) - acquista 4 volte
(7, '2025-01-30', 'PayPal', 24.99),
(7, '2025-02-18', 'Carta di Credito', 38.98),
(7, '2025-03-25', 'PayPal', 31.98),
(7, '2025-05-15', 'Bonifico', 27.48),

-- Elena Ricci (id=8) - acquista 2 volte
(8, '2025-02-10', 'Carta di Credito', 41.98),
(8, '2025-04-18', 'PayPal', 35.99),

-- Marco Marino (id=9) - acquista 5 volte
(9, '2025-01-12', 'PayPal', 19.99),
(9, '2025-02-14', 'Carta di Credito', 43.98),
(9, '2025-03-08', 'Bonifico', 29.98),
(9, '2025-04-12', 'PayPal', 37.49),
(9, '2025-05-18', 'Carta di Credito', 24.99),

-- Silvia Colombo (id=10) - acquista 3 volte
(10, '2025-02-08', 'Carta di Credito', 33.98),
(10, '2025-03-22', 'PayPal', 28.49),
(10, '2025-05-02', 'Bonifico', 42.97),

-- Roberto Esposito (id=11) - acquista 2 volte
(11, '2025-01-28', 'PayPal', 31.98),
(11, '2025-04-08', 'Carta di Credito', 39.98),

-- Chiara Bruno (id=12) - acquista 4 volte
(12, '2025-02-12', 'Bonifico', 26.98),
(12, '2025-03-05', 'Carta di Credito', 34.50),
(12, '2025-04-15', 'PayPal', 29.99),
(12, '2025-05-22', 'Carta di Credito', 21.99),

-- Davide De Luca (id=13) - acquista 3 volte
(13, '2025-01-20', 'Carta di Credito', 40.98),
(13, '2025-03-18', 'PayPal', 32.98),
(13, '2025-05-10', 'Bonifico', 25.48),

-- Valentina Costa (id=14) - acquista 2 volte
(14, '2025-02-22', 'PayPal', 37.98),
(14, '2025-04-25', 'Carta di Credito', 30.99),

-- Stefano Moretti (id=15) - acquista 3 volte
(15, '2025-01-16', 'Bonifico', 28.98),
(15, '2025-03-28', 'Carta di Credito', 35.97),
(15, '2025-05-06', 'PayPal', 23.99),

-- Laura Fontana (id=16) - acquista 4 volte
(16, '2025-02-15', 'Carta di Credito', 44.98),
(16, '2025-03-10', 'PayPal', 27.99),
(16, '2025-04-20', 'Bonifico', 36.48),
(16, '2025-05-25', 'Carta di Credito', 19.50),

-- Andrea Caruso (id=17) - acquista 2 volte
(17, '2025-01-26', 'PayPal', 33.98),
(17, '2025-04-14', 'Carta di Credito', 41.97),

-- Martina Greco (id=18) - acquista 3 volte
(18, '2025-02-18', 'Carta di Credito', 29.98),
(18, '2025-03-24', 'Bonifico', 38.49),
(18, '2025-05-14', 'PayPal', 26.99),

-- Simone Conti (id=19) - acquista 2 volte
(19, '2025-01-08', 'Carta di Credito', 35.98),
(19, '2025-04-02', 'PayPal', 30.98),

-- Federica Serra (id=20) - acquista 4 volte
(20, '2025-02-06', 'PayPal', 42.98),
(20, '2025-03-16', 'Carta di Credito', 31.49),
(20, '2025-04-26', 'Bonifico', 27.98),
(20, '2025-05-28', 'PayPal', 22.50),

-- Matteo Barbieri (id=21) - acquista 2 volte
(21, '2025-01-14', 'Carta di Credito', 39.98),
(21, '2025-04-06', 'PayPal', 34.99),

-- Sofia Rinaldi (id=22) - acquista 3 volte
(22, '2025-02-20', 'Bonifico', 28.98),
(22, '2025-03-26', 'Carta di Credito', 36.97),
(22, '2025-05-16', 'PayPal', 24.50),

-- Lorenzo Ferrara (id=23) - acquista 2 volte
(23, '2025-01-10', 'PayPal', 32.98),
(23, '2025-04-18', 'Carta di Credito', 29.99),

-- Giorgia Leone (id=24) - acquista 3 volte
(24, '2025-02-24', 'Carta di Credito', 45.98),
(24, '2025-03-30', 'Bonifico', 33.49),
(24, '2025-05-20', 'PayPal', 21.99),

-- Nicola Marchetti (id=25) - acquista 2 volte
(25, '2025-01-18', 'Carta di Credito', 37.98),
(25, '2025-04-22', 'PayPal', 31.99),

-- Alessia Vitale (id=26) - acquista 3 volte
(26, '2025-02-28', 'PayPal', 40.98),
(26, '2025-04-04', 'Carta di Credito', 26.98),
(26, '2025-05-24', 'Bonifico', 35.48),

-- Fabio Santoro (id=27) - acquista 2 volte
(27, '2025-01-22', 'Bonifico', 34.98),
(27, '2025-04-16', 'Carta di Credito', 29.49),

-- Elisa Pellegrini (id=28) - acquista 3 volte
(28, '2025-02-16', 'Carta di Credito', 43.98),
(28, '2025-03-20', 'PayPal', 30.49),
(28, '2025-05-12', 'Bonifico', 25.99),

-- Riccardo Marini (id=29) - acquista 2 volte
(29, '2025-01-24', 'PayPal', 36.98),
(29, '2025-04-28', 'Carta di Credito', 32.50),

-- Benedetta Sanna (id=30) - acquista 3 volte
(30, '2025-02-26', 'Carta di Credito', 38.98),
(30, '2025-03-14', 'Bonifico', 29.99),
(30, '2025-05-26', 'PayPal', 27.48);


-- =====================================================
-- DETTAGLIO ACQUISTO
-- =====================================================
-- Associazione tra acquisti ed ebook.
-- Un acquisto può contenere più ebook.
-- I prezzi sono coerenti con gli importi totali degli acquisti.

INSERT INTO dettaglio_acquisto
(acquisto_id, ebook_id, prezzo_unitario)
VALUES

-- ACQUISTI UTENTE 1 (Mario Rossi)
-- Acquisto #1 (29.98)
(1, 1, 19.99),   -- Intelligenza Artificiale
(1, 3, 9.99),    -- Viaggio su Marte

-- Acquisto #2 (21.99)
(2, 7, 21.99),   -- Cloud Computing

-- Acquisto #3 (45.98)
(3, 36, 19.99),  -- Il Signore degli Anelli
(3, 37, 18.99),  -- Il Trono di Spade
(3, 50, 7.99),   -- Fiori di Marzo

-- Acquisto #4 (33.48)
(4, 11, 4.99),   -- I Promessi Sposi
(4, 15, 4.50),   -- Decameron
(4, 24, 24.99),  -- Machine Learning Pratico

-- Acquisto #5 (19.99)
(5, 1, 19.99),   -- Intelligenza Artificiale (riacquisto)

-- ACQUISTI UTENTE 2 (Giulia Bianchi)
-- Acquisto #6 (26.98)
(6, 2, 14.99),   -- Startup di Successo
(6, 4, 11.99),   -- Ritorno alla Terra

-- Acquisto #7 (31.97)
(7, 16, 11.99),  -- Delitto in Via Dante
(7, 3, 9.99),    -- Viaggio su Marte
(8, 8, 12.99),   -- La Galassia Perduta
(8, 50, 7.99),   -- Fiori di Marzo

-- Acquisto #8 (22.99)
(9, 24, 22.99),  -- Machine Learning Pratico

-- Acquisto #9 (18.50)
(10, 6, 18.50),  -- Blockchain per Tutti

-- ACQUISTI UTENTE 3 (Luca Verdi)
-- Acquisto #10 (10.98)
(11, 11, 4.99),  -- I Promessi Sposi
(11, 12, 5.99),  -- Divina Commedia

-- Acquisto #11 (49.97)
(12, 36, 19.99), -- Il Signore degli Anelli
(12, 37, 18.99), -- Il Trono di Spade
(12, 17, 10.99), -- Il Segreto della Villa

-- Acquisto #12 (27.98)
(13, 2, 14.99),  -- Startup di Successo
(13, 9, 12.99),  -- Cronache Spaziali

-- ACQUISTI UTENTE 4 (Anna Neri)
-- Acquisto #13 (22.98)
(14, 3, 9.99),   -- Viaggio su Marte
(14, 10, 12.99), -- I Robot del Futuro

-- Acquisto #14 (36.98)
(15, 21, 14.99), -- I Leoni di Sicilia
(15, 22, 15.99), -- Il Nome della Rosa
(15, 12, 5.99),  -- Divina Commedia

-- Acquisto #15 (19.99)
(16, 36, 19.99), -- Il Signore degli Anelli

-- Acquisto #16 (41.49)
(17, 26, 17.99), -- Le 7 Regole del Successo
(17, 7, 21.99),  -- Cloud Computing
(17, 52, 6.50),  -- Il Sabato del Villaggio

-- ACQUISTI UTENTE 5 (Paolo Gallo)
-- Acquisto #17 (26.98)
(18, 22, 15.99), -- Il Nome della Rosa
(18, 17, 10.99), -- Il Segreto della Villa

-- Acquisto #18 (44.97)
(19, 24, 24.99), -- Machine Learning Pratico
(19, 36, 19.99), -- Il Signore degli Anelli

-- Acquisto #19 (15.99)
(20, 25, 15.99), -- Criptovalute Spiegate

-- ACQUISTI UTENTE 6 (Francesca Romano)
-- Acquisto #20 (34.98)
(21, 23, 22.99), -- Python per Data Science
(21, 12, 5.99),  -- Divina Commedia
(21, 50, 7.99),  -- Fiori di Marzo

-- Acquisto #21 (29.99)
(22, 27, 14.50), -- Come Parlare in Pubblico
(22, 28, 15.50), -- Obiettivi e Risultati

-- Acquisto #22 (52.47)
(23, 37, 18.99), -- Il Trono di Spade
(23, 46, 22.99), -- Neuroscienze Base
(23, 17, 10.99), -- Il Segreto della Villa

-- ACQUISTI UTENTE 7 (Alessandro Ferrari)
-- Acquisto #23 (24.99)
(24, 24, 24.99), -- Machine Learning Pratico

-- Acquisto #24 (38.98)
(25, 36, 19.99), -- Il Signore degli Anelli
(25, 37, 18.99), -- Il Trono di Spade

-- Acquisto #25 (31.98)
(26, 7, 21.99),  -- Cloud Computing
(26, 3, 9.99),   -- Viaggio su Marte

-- Acquisto #26 (27.48)
(27, 27, 14.50), -- Come Parlare in Pubblico
(27, 10, 12.99), -- I Robot del Futuro

-- ACQUISTI UTENTE 8 (Elena Ricci)
-- Acquisto #27 (41.98)
(28, 22, 15.99), -- Il Nome della Rosa
(28, 48, 14.99), -- Matematica Divertente
(28, 17, 10.99), -- Il Segreto della Villa

-- Acquisto #28 (35.99)
(29, 36, 19.99), -- Il Signore degli Anelli
(29, 34, 16.99), -- Obiettivi e Risultati

-- ACQUISTI UTENTE 9 (Marco Marino)
-- Acquisto #29 (19.99)
(30, 1, 19.99),  -- Intelligenza Artificiale

-- Acquisto #30 (43.98)
(31, 24, 24.99), -- Machine Learning Pratico
(31, 37, 18.99), -- Il Trono di Spade

-- Acquisto #31 (29.98)
(32, 7, 21.99),  -- Cloud Computing
(32, 50, 7.99),  -- Fiori di Marzo

-- Acquisto #32 (37.49)
(33, 46, 22.99), -- Neuroscienze Base
(33, 27, 14.50), -- Come Parlare in Pubblico

-- Acquisto #33 (24.99)
(34, 24, 24.99), -- Machine Learning Pratico

-- ACQUISTI UTENTE 10 (Silvia Colombo)
-- Acquisto #34 (33.98)
(35, 36, 19.99), -- Il Signore degli Anelli
(35, 2, 14.99),  -- Startup di Successo

-- Acquisto #35 (28.49)
(36, 27, 14.50), -- Come Parlare in Pubblico
(36, 18, 13.99), -- L'Ultimo Indizio

-- Acquisto #36 (42.97)
(37, 24, 24.99), -- Machine Learning Pratico
(37, 37, 18.99), -- Il Trono di Spade

-- ACQUISTI UTENTE 11 (Roberto Esposito)
-- Acquisto #37 (31.98)
(38, 7, 21.99),  -- Cloud Computing
(38, 3, 9.99),   -- Viaggio su Marte

-- Acquisto #38 (39.98)
(39, 36, 19.99), -- Il Signore degli Anelli
(39, 22, 15.99), -- Il Nome della Rosa
(39, 11, 4.99),  -- I Promessi Sposi

-- ACQUISTI UTENTE 12 (Chiara Bruno)
-- Acquisto #39 (26.98)
(40, 2, 14.99),  -- Startup di Successo
(40, 4, 11.99),  -- Ritorno alla Terra

-- Acquisto #40 (34.50)
(41, 38, 14.50), -- Le Cronache di Narnia
(41, 36, 19.99), -- Il Signore degli Anelli

-- Acquisto #41 (29.99)
(42, 28, 15.50), -- Obiettivi e Risultati
(42, 27, 14.50), -- Come Parlare in Pubblico

-- Acquisto #42 (21.99)
(43, 7, 21.99),  -- Cloud Computing

-- ACQUISTI UTENTE 13 (Davide De Luca)
-- Acquisto #43 (40.98)
(44, 36, 19.99), -- Il Signore degli Anelli
(44, 22, 15.99), -- Il Nome della Rosa
(44, 50, 7.99),  -- Fiori di Marzo

-- Acquisto #44 (32.98)
(45, 24, 22.99), -- Machine Learning Pratico
(45, 3, 9.99),   -- Viaggio su Marte

-- Acquisto #45 (25.48)
(46, 27, 14.50), -- Come Parlare in Pubblico
(46, 17, 10.99), -- Il Segreto della Villa

-- ACQUISTI UTENTE 14 (Valentina Costa)
-- Acquisto #46 (37.98)
(47, 37, 18.99), -- Il Trono di Spade
(47, 36, 19.99), -- Il Signore degli Anelli

-- Acquisto #47 (30.99)
(48, 7, 21.99),  -- Cloud Computing
(48, 3, 9.99),   -- Viaggio su Marte

-- ACQUISTI UTENTE 15 (Stefano Moretti)
-- Acquisto #48 (28.98)
(49, 2, 14.99),  -- Startup di Successo
(49, 18, 13.99), -- L'Ultimo Indizio

-- Acquisto #49 (35.97)
(50, 36, 19.99), -- Il Signore degli Anelli
(50, 34, 16.99), -- Obiettivi e Risultati

-- Acquisto #50 (23.99)
(51, 24, 23.99), -- Machine Learning Pratico

-- ACQUISTI UTENTE 16 (Laura Fontana)
-- Acquisto #51 (44.98)
(52, 24, 24.99), -- Machine Learning Pratico
(52, 36, 19.99), -- Il Signore degli Anelli

-- Acquisto #52 (27.99)
(53, 27, 14.50), -- Come Parlare in Pubblico
(53, 18, 13.99), -- L'Ultimo Indizio

-- Acquisto #53 (36.48)
(54, 22, 15.99), -- Il Nome della Rosa
(54, 46, 22.99), -- Neuroscienze Base

-- Acquisto #54 (19.50)
(55, 38, 14.50), -- Le Cronache di Narnia
(55, 11, 4.99),  -- I Promessi Sposi

-- ACQUISTI UTENTE 17 (Andrea Caruso)
-- Acquisto #55 (33.98)
(56, 36, 19.99), -- Il Signore degli Anelli
(56, 2, 14.99),  -- Startup di Successo

-- Acquisto #56 (41.97)
(57, 24, 24.99), -- Machine Learning Pratico
(57, 34, 16.99), -- Obiettivi e Risultati

-- ACQUISTI UTENTE 18 (Martina Greco)
-- Acquisto #57 (29.98)
(58, 7, 21.99),  -- Cloud Computing
(58, 50, 7.99),  -- Fiori di Marzo

-- Acquisto #58 (38.49)
(59, 37, 18.99), -- Il Trono di Spade
(59, 26, 17.99), -- Le 7 Regole del Successo
(59, 52, 6.50),  -- Il Sabato del Villaggio

-- Acquisto #59 (26.99)
(60, 27, 14.50), -- Come Parlare in Pubblico
(60, 10, 12.99), -- I Robot del Futuro

-- ACQUISTI UTENTE 19 (Simone Conti)
-- Acquisto #60 (35.98)
(61, 36, 19.99), -- Il Signore degli Anelli
(61, 22, 15.99), -- Il Nome della Rosa

-- Acquisto #61 (30.98)
(62, 7, 21.99),  -- Cloud Computing
(62, 3, 9.99),   -- Viaggio su Marte

-- ACQUISTI UTENTE 20 (Federica Serra)
-- Acquisto #62 (42.98)
(63, 24, 24.99), -- Machine Learning Pratico
(63, 37, 18.99), -- Il Trono di Spade

-- Acquisto #63 (31.49)
(64, 27, 14.50), -- Come Parlare in Pubblico
(64, 34, 16.99), -- Obiettivi e Risultati

-- Acquisto #64 (27.98)
(65, 2, 14.99),  -- Startup di Successo
(65, 10, 12.99), -- I Robot del Futuro

-- Acquisto #65 (22.50)
(66, 47, 14.99), -- Filosofia Antica
(66, 50, 7.99),  -- Fiori di Marzo

-- ACQUISTI UTENTE 21 (Matteo Barbieri)
-- Acquisto #66 (39.98)
(67, 36, 19.99), -- Il Signore degli Anelli
(67, 22, 15.99), -- Il Nome della Rosa
(67, 11, 4.99),  -- I Promessi Sposi

-- Acquisto #67 (34.99)
(68, 7, 21.99),  -- Cloud Computing
(68, 18, 13.99), -- L'Ultimo Indizio

-- ACQUISTI UTENTE 22 (Sofia Rinaldi)
-- Acquisto #68 (28.98)
(69, 2, 14.99),  -- Startup di Successo
(69, 18, 13.99), -- L'Ultimo Indizio

-- Acquisto #69 (36.97)
(70, 36, 19.99), -- Il Signore degli Anelli
(70, 34, 16.99), -- Obiettivi e Risultati

-- Acquisto #70 (24.50)
(71, 24, 24.99), -- Machine Learning Pratico

-- ACQUISTI UTENTE 23 (Lorenzo Ferrara)
-- Acquisto #71 (32.98)
(72, 7, 21.99),  -- Cloud Computing
(72, 17, 10.99), -- Il Segreto della Villa

-- Acquisto #72 (29.99)
(73, 27, 14.50), -- Come Parlare in Pubblico
(73, 28, 15.50), -- Obiettivi e Risultati

-- ACQUISTI UTENTE 24 (Giorgia Leone)
-- Acquisto #73 (45.98)
(74, 24, 24.99), -- Machine Learning Pratico
(74, 22, 15.99), -- Il Nome della Rosa
(74, 50, 7.99),  -- Fiori di Marzo

-- Acquisto #74 (33.49)
(75, 37, 18.99), -- Il Trono di Spade
(75, 27, 14.50), -- Come Parlare in Pubblico

-- Acquisto #75 (21.99)
(76, 7, 21.99),  -- Cloud Computing

-- ACQUISTI UTENTE 25 (Nicola Marchetti)
-- Acquisto #76 (37.98)
(77, 36, 19.99), -- Il Signore degli Anelli
(77, 37, 18.99), -- Il Trono di Spade

-- Acquisto #77 (31.99)
(78, 7, 21.99),  -- Cloud Computing
(78, 3, 9.99),   -- Viaggio su Marte

-- ACQUISTI UTENTE 26 (Alessia Vitale)
-- Acquisto #78 (40.98)
(79, 24, 24.99), -- Machine Learning Pratico
(79, 22, 15.99), -- Il Nome della Rosa

-- Acquisto #79 (26.98)
(80, 2, 14.99),  -- Startup di Successo
(80, 4, 11.99),  -- Ritorno alla Terra

-- Acquisto #80 (35.48)
(81, 46, 22.99), -- Neuroscienze Base
(81, 10, 12.99), -- I Robot del Futuro

-- ACQUISTI UTENTE 27 (Fabio Santoro)
-- Acquisto #81 (34.98)
(82, 36, 19.99), -- Il Signore degli Anelli
(82, 2, 14.99),  -- Startup di Successo

-- Acquisto #82 (29.49)
(83, 27, 14.50), -- Come Parlare in Pubblico
(83, 2, 14.99),  -- Startup di Successo

-- ACQUISTI UTENTE 28 (Elisa Pellegrini)
-- Acquisto #83 (43.98)
(84, 24, 24.99), -- Machine Learning Pratico
(84, 36, 19.99), -- Il Signore degli Anelli

-- Acquisto #84 (30.49)
(85, 27, 14.50), -- Come Parlare in Pubblico
(85, 34, 16.99), -- Obiettivi e Risultati

-- Acquisto #85 (25.99)
(86, 25, 15.99), -- Criptovalute Spiegate
(86, 3, 9.99),   -- Viaggio su Marte

-- ACQUISTI UTENTE 29 (Riccardo Marini)
-- Acquisto #86 (36.98)
(87, 36, 19.99), -- Il Signore degli Anelli
(87, 34, 16.99), -- Obiettivi e Risultati

-- Acquisto #87 (32.50)
(88, 7, 21.99),  -- Cloud Computing
(88, 17, 10.99), -- Il Segreto della Villa

-- ACQUISTI UTENTE 30 (Benedetta Sanna)
-- Acquisto #88 (38.98)
(89, 37, 18.99), -- Il Trono di Spade
(89, 22, 15.99), -- Il Nome della Rosa
(89, 11, 4.99),  -- I Promessi Sposi

-- Acquisto #89 (29.99)
(90, 27, 14.50), -- Come Parlare in Pubblico
(90, 28, 15.50); -- Obiettivi e Risultati

