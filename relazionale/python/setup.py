"""
Setup database SQLite - Ebook Library

Questo script:

1. Elimina il database esistente (se presente)
2. Crea un nuovo database SQLite
3. Esegue lo script DDL (schema.sql)
4. Esegue lo script DML (insert_data.sql)

Esecuzione:

    python relazionale/python/setup.py
"""

import sqlite3
from pathlib import Path


# =====================================================
# PATH DEL PROGETTO
# =====================================================

# Cartella principale "relazionale"
BASE_DIR = Path(__file__).resolve().parent.parent

# Database SQLite
DATABASE_DIR = BASE_DIR / "database"
DB_FILE = DATABASE_DIR / "ebook_library.db"

# Script SQL
DDL_FILE = BASE_DIR / "sql" / "ddl" / "schema.sql"
DML_FILE = BASE_DIR / "sql" / "dml" / "insert_data.sql"


# =====================================================
# CREAZIONE DATABASE
# =====================================================

def create_database():

    print("Creazione database...\n")

    # Crea la cartella database se non esiste
    DATABASE_DIR.mkdir(exist_ok=True)

    # Elimina il database precedente
    if DB_FILE.exists():
        DB_FILE.unlink()
        print("Database precedente eliminato")

    # Crea il nuovo database
    conn = sqlite3.connect(DB_FILE)

    try:

        cursor = conn.cursor()

        # ==========================================
        # Creazione struttura database
        # ==========================================
        with open(DDL_FILE, "r", encoding="utf-8") as file:
            cursor.executescript(file.read())

        print("Schema creato")

        # ==========================================
        # Inserimento dati di esempio
        # ==========================================
        with open(DML_FILE, "r", encoding="utf-8") as file:
            cursor.executescript(file.read())

        print("Dati inseriti")

        conn.commit()

        print("\n✓ SETUP COMPLETATO CON SUCCESSO")

    finally:
        conn.close()


# =====================================================
# MAIN
# =====================================================

if __name__ == "__main__":
    create_database()