"""
Query SQLite - Ebook Library

Query implementate:

1. Elencare tutti gli ebook acquistati da un certo utente.
2. Calcolare il numero di acquisti effettuati per ciascuna collana.

Esecuzione:

python relazionale/python/queries.py
"""

import sqlite3
from pathlib import Path


# =========================
# PATH DATABASE
# =========================

BASE_DIR = Path(__file__).resolve().parent.parent

DB_FILE = BASE_DIR / "database" / "ebook_library.db"


# =========================
# CONNESSIONE
# =========================

conn = sqlite3.connect(DB_FILE)

cursor = conn.cursor()


# =========================
# QUERY 1
# Ebook acquistati da un utente
# =========================

def search_ebooks_by_user(email):

    print("\n" + "=" * 60)
    print(f"EBOOK ACQUISTATI DA: {email}")
    print("=" * 60)

    query = """
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
        WHERE u.email = ?
    """

    cursor.execute(query, (email,))
    results = cursor.fetchall()

    if not results:
        print("Utente non trovato o nessun acquisto presente.")
        return

    for i, row in enumerate(results, 1):
        titolo, autore, genere = row

        print(f"\nEbook #{i}")
        print(f"Titolo : {titolo}")
        print(f"Autore : {autore}")
        print(f"Genere : {genere}")
        print("-" * 40)


# =========================
# QUERY 2
# Numero acquisti per collana
# =========================

def purchases_by_collana():

    print("\n" + "=" * 60)
    print("NUMERO ACQUISTI PER COLLANA")
    print("=" * 60)

    query = """
        SELECT
            c.nome,
            COUNT(*) AS numero_acquisti
        FROM collana c
        JOIN ebook e
            ON c.id = e.collana_id
        JOIN dettaglio_acquisto da
            ON e.id = da.ebook_id
        GROUP BY c.id, c.nome
        ORDER BY numero_acquisti DESC
    """

    cursor.execute(query)

    results = cursor.fetchall()

    for nome_collana, totale in results:
        print(f"{nome_collana} -> {totale}")


# =========================
# MAIN
# =========================

if __name__ == "__main__":

    email = input("Inserisci email utente: ")

    search_ebooks_by_user(email)

    purchases_by_collana()

    conn.close()