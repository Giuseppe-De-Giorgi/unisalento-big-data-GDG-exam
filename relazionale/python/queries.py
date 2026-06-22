"""
Query SQLite - Ebook Library

Query implementate:

1. Elencare tutti gli ebook acquistati da un determinato utente
2. Calcolare il numero di acquisti effettuati per ciascuna collana

Esecuzione:

    python relazionale/python/queries.py
"""

import sqlite3
from pathlib import Path


# =====================================================
# PATH DATABASE
# =====================================================

BASE_DIR = Path(__file__).resolve().parent.parent
DB_FILE = BASE_DIR / "database" / "ebook_library.db"


# =====================================================
# QUERY 1
# Ebook acquistati da un utente
# =====================================================

def ebooks_by_email(email):

    conn = sqlite3.connect(DB_FILE)
    cursor = conn.cursor()

    sql = """
    SELECT
        e.titolo,
        e.autore,
        a.data_acquisto
    FROM utente u
    JOIN acquisto a
        ON u.id = a.utente_id
    JOIN dettaglio_acquisto da
        ON a.id = da.acquisto_id
    JOIN ebook e
        ON da.ebook_id = e.id
    WHERE u.email = ?
    ORDER BY a.data_acquisto;
    """

    cursor.execute(sql, (email,))
    results = cursor.fetchall()

    print("\n" + "=" * 60)
    print(f"EBOOK ACQUISTATI DA: {email}")
    print("=" * 60)

    if not results:
        print("Nessun ebook trovato per questo utente.")
    else:
        for titolo, autore, data in results:
            print(f"- {titolo}")
            print(f"  Autore : {autore}")
            print(f"  Data   : {data}\n")

    conn.close()


# =====================================================
# QUERY 2
# Numero acquisti per collana
# =====================================================

def purchases_by_collection():

    conn = sqlite3.connect(DB_FILE)
    cursor = conn.cursor()

    sql = """
    SELECT
        c.nome,
        COUNT(*) AS numero_acquisti
    FROM collana c
    JOIN ebook e
        ON c.id = e.collana_id
    JOIN dettaglio_acquisto da
        ON e.id = da.ebook_id
    GROUP BY c.id, c.nome
    ORDER BY numero_acquisti DESC;
    """

    cursor.execute(sql)

    results = cursor.fetchall()

    print("\n" + "=" * 60)
    print("NUMERO ACQUISTI PER COLLANA")
    print("=" * 60)

    for nome, numero in results:
        print(f"{nome}: {numero}")

    conn.close()


# =====================================================
# MAIN
# =====================================================

if __name__ == "__main__":

    email = input("Inserisci email utente: ").strip()

    ebooks_by_email(email)

    purchases_by_collection()