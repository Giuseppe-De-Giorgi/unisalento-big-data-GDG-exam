"""
Setup database SQLite - Ebook Library

Questo script:

1. Elimina il database esistente (se presente)
2. Crea il database
3. Esegue schema.sql
4. Esegue insert.sql

Esecuzione:

python relazionale/python/setup.py
"""

import sqlite3
from pathlib import Path


# =========================
# PATH
# =========================

BASE_DIR = Path(__file__).resolve().parent.parent

DB_FILE = BASE_DIR / "database" / "ebook_library.db"

SCHEMA_FILE = BASE_DIR / "sql" / "ddl" / "schema.sql"

INSERT_FILE = BASE_DIR / "sql" / "dml" / "insert.sql"


# =========================
# MAIN
# =========================

def create_database():

    print("Creazione database...\n")

    # elimina db esistente
    if DB_FILE.exists():
        DB_FILE.unlink()
        print("Database precedente eliminato")

    # crea nuovo db
    conn = sqlite3.connect(DB_FILE)

    try:

        cursor = conn.cursor()

        # schema
        with open(SCHEMA_FILE, "r", encoding="utf-8") as f:
            schema_sql = f.read()

        cursor.executescript(schema_sql)

        print("Schema creato")

        # dati
        with open(INSERT_FILE, "r", encoding="utf-8") as f:
            insert_sql = f.read()

        cursor.executescript(insert_sql)

        print("Dati inseriti")

        conn.commit()

        print("\nSETUP COMPLETATO")

    finally:
        conn.close()


if __name__ == "__main__":
    create_database()