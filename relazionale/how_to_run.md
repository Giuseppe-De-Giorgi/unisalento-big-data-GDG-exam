# How to Run - Database Relazionale (SQLite)

Questa guida spiega come avviare correttamente gli script del modulo **relazionale** da **WSL** e come verificare i risultati.

---

## Prerequisiti

- WSL attivo
- Python 3 installato in WSL
- Virtual environment `.venv` già creato nella root del progetto

---

## Struttura utile

```
relazionale/
├── database/
│   └── ebook_library.db         # File SQLite creato da setup.py
├── python/
│   ├── setup.py                 # Crea schema + inserisce dati
│   └── queries.py               # Esegue le query richieste
└── sql/
    ├── ddl/schema.sql
    └── dml/insert_data.sql
```

---

## 1. Posizionati nella root del progetto

```bash
cd /mnt/c/Project_dev/Unisalento/unisalento-big-data-GDG-exam
```

---

## 2. Attiva il virtual environment

```bash
source .venv/bin/activate
```

Dopo l'attivazione dovresti vedere `(.venv)` nel prompt.

---

## 3. Esegui il setup del database

```bash
python relazionale/python/setup.py
```

### Cosa fa `setup.py`

1. Elimina il database precedente (se esiste)
2. Crea un nuovo file SQLite in `relazionale/database/ebook_library.db`
3. Esegue lo script DDL (`schema.sql`) per creare le tabelle
4. Esegue lo script DML (`insert_data.sql`) per inserire dati di esempio

### Output atteso

```
Creazione database...
Database precedente eliminato
Schema creato
Dati inseriti

✓ SETUP COMPLETATO CON SUCCESSO
```

---

## 4. Esegui le query

```bash
python relazionale/python/queries.py
```

Lo script ti chiederà una email utente.

### Esempio input valido

```
Inserisci email utente: mario.rossi@email.it
```

### Risultato atteso

- Elenco ebook acquistati dall'utente
- Conteggio acquisti per collana

### Esempio input non presente

```
Inserisci email utente: test
```

Output atteso:

```
Nessun ebook trovato per questo utente.
```

Il riepilogo **NUMERO ACQUISTI PER COLLANA** viene comunque mostrato.

---

## 5. Verifica su DBeaver (opzionale)

Se vuoi controllare il DB da interfaccia grafica, apri in DBeaver questo file:

`C:\Project_dev\Unisalento\unisalento-big-data-GDG-exam\relazionale\database\ebook_library.db`

Poi fai **Refresh** della connessione/tabelle.

---

## Troubleshooting rapido

### Errore: `No such file or directory` su script Python

Sei probabilmente in una directory sbagliata. Torna nella root del progetto:

```bash
cd /mnt/c/Project_dev/Unisalento/unisalento-big-data-GDG-exam
```

### Nessuna tabella visibile su DBeaver

- Verifica di aver aperto il file `.db` corretto (path sopra)
- Esegui di nuovo `setup.py`
- Fai refresh in DBeaver

### Virtual environment non attivo

```bash
source .venv/bin/activate
```

---

## Sequenza minima consigliata

```bash
cd /mnt/c/Project_dev/Unisalento/unisalento-big-data-GDG-exam
source .venv/bin/activate
python relazionale/python/setup.py
python relazionale/python/queries.py
```
