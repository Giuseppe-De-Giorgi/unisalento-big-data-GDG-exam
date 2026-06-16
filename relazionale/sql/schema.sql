-- =====================================================
-- EBOOK DATABASE - RELAZIONALE SCHEMA
-- =====================================================

-- DROP TABLES (ordine corretto per vincoli FK)
DROP TABLE IF EXISTS dettaglio_acquisto;
DROP TABLE IF EXISTS acquisto;
DROP TABLE IF EXISTS ebook;
DROP TABLE IF EXISTS collana;
DROP TABLE IF EXISTS utente;

-- =====================================================
-- TABELLA UTENTE
-- =====================================================
CREATE TABLE utente (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cognome VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    paese_residenza VARCHAR(100) NOT NULL
);

-- =====================================================
-- TABELLA COLLANA
-- =====================================================
CREATE TABLE collana (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    descrizione TEXT,
    casa_editrice VARCHAR(150) NOT NULL
);

-- =====================================================
-- TABELLA EBOOK
-- =====================================================
CREATE TABLE ebook (
    id SERIAL PRIMARY KEY,
    codice VARCHAR(50) UNIQUE NOT NULL,
    titolo VARCHAR(255) NOT NULL,
    autore VARCHAR(150) NOT NULL,
    genere VARCHAR(100) NOT NULL,
    prezzo DECIMAL(10,2) NOT NULL CHECK (prezzo >= 0),
    anno_pubblicazione INT NOT NULL,

    collana_id INT,
    CONSTRAINT fk_collana
        FOREIGN KEY (collana_id)
        REFERENCES collana(id)
        ON DELETE SET NULL
);

-- =====================================================
-- TABELLA ACQUISTO
-- =====================================================
CREATE TABLE acquisto (
    id SERIAL PRIMARY KEY,

    utente_id INT NOT NULL,
    data_acquisto TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modalita_pagamento VARCHAR(50) NOT NULL,
    importo_totale DECIMAL(10,2) NOT NULL CHECK (importo_totale >= 0),

    CONSTRAINT fk_utente
        FOREIGN KEY (utente_id)
        REFERENCES utente(id)
        ON DELETE CASCADE
);

-- =====================================================
-- TABELLA DETTAGLIO ACQUISTO (N:N)
-- =====================================================
CREATE TABLE dettaglio_acquisto (
    acquisto_id INT NOT NULL,
    ebook_id INT NOT NULL,
    prezzo_unitario DECIMAL(10,2) NOT NULL CHECK (prezzo_unitario >= 0),

    PRIMARY KEY (acquisto_id, ebook_id),

    CONSTRAINT fk_acquisto
        FOREIGN KEY (acquisto_id)
        REFERENCES acquisto(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_ebook
        FOREIGN KEY (ebook_id)
        REFERENCES ebook(id)
        ON DELETE CASCADE
);