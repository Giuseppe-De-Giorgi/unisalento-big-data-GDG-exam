PRAGMA foreign_keys = ON;

-- =========================
-- DROP TABLES
-- =========================
DROP TABLE IF EXISTS dettaglio_acquisto;
DROP TABLE IF EXISTS acquisto;
DROP TABLE IF EXISTS ebook;
DROP TABLE IF EXISTS collana;
DROP TABLE IF EXISTS utente;

-- =========================
-- UTENTE
-- =========================
CREATE TABLE utente (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    cognome TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    paese_residenza TEXT NOT NULL
);

-- =========================
-- COLLANA
-- =========================
CREATE TABLE collana (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    descrizione TEXT,
    casa_editrice TEXT NOT NULL
);

-- =========================
-- EBOOK
-- =========================
CREATE TABLE ebook (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    titolo TEXT NOT NULL,
    autore TEXT NOT NULL,
    genere TEXT NOT NULL,
    prezzo REAL NOT NULL CHECK (prezzo >= 0),
    anno_pubblicazione INTEGER NOT NULL,
    collana_id INTEGER,
    FOREIGN KEY (collana_id) REFERENCES collana(id) ON DELETE SET NULL
);

-- =========================
-- ACQUISTO
-- =========================
CREATE TABLE acquisto (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    utente_id INTEGER NOT NULL,
    data_acquisto TEXT NOT NULL,
    modalita_pagamento TEXT NOT NULL,
    importo_totale REAL NOT NULL CHECK (importo_totale >= 0),
    FOREIGN KEY (utente_id) REFERENCES utente(id) ON DELETE CASCADE
);

-- =========================
-- DETTAGLIO ACQUISTO
-- =========================
CREATE TABLE dettaglio_acquisto (
    acquisto_id INTEGER NOT NULL,
    ebook_id INTEGER NOT NULL,
    prezzo_unitario REAL NOT NULL CHECK (prezzo_unitario >= 0),
    PRIMARY KEY (acquisto_id, ebook_id),
    FOREIGN KEY (acquisto_id) REFERENCES acquisto(id) ON DELETE CASCADE,
    FOREIGN KEY (ebook_id) REFERENCES ebook(id) ON DELETE CASCADE
);