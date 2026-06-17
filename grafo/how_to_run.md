# How to Run - Esecuzione Query Neo4j

Questa guida spiega come eseguire le query Neo4j del progetto utilizzando **WSL (Windows Subsystem for Linux)**.

---

## Prerequisiti

- **WSL** installato e configurato su Windows
- **Docker** installato in WSL
- **Python 3** disponibile in WSL

---

## Cos'è il Virtual Environment (.venv)?

Il **virtual environment** (o ambiente virtuale) è uno strumento Python che crea un ambiente isolato per il progetto. Questo permette di:

- **Isolare le dipendenze**: Ogni progetto ha le sue librerie senza conflitti con altri progetti
- **Gestire versioni**: Puoi usare versioni specifiche di pacchetti per ogni progetto
- **Portabilità**: Facilita la condivisione del progetto con altri sviluppatori

Nel nostro caso, il `.venv` contiene il driver **neo4j** necessario per connettersi al database Neo4j dal codice Python.

---

## Struttura del Progetto

```
grafo/
├── cypher/                    # Query Cypher per Neo4j Browser
│   ├── 01_create_nodes.cypher
│   ├── 02_create_relationships.cypher
│   └── 03_queries.cypher
├── python/                    # Script Python automatizzato
│   └── neo4j_queries.py       # Executor delle query
├── results/                   # Risultati e documentazione
└── how_to_run.md             # Questa guida
```

---

## Setup Iniziale (Prima Esecuzione)

### 1. Avvia WSL

Dal terminale PowerShell di PyCharm (o qualsiasi terminale Windows):

```bash
wsl
```

### 2. Naviga alla Directory del Progetto

```bash
cd /mnt/c/Project_dev/Unisalento/unisalento-big-data-GDG-exam
```

### 3. Avvia il Container Neo4j

```bash
cd docker
docker compose up -d
```

Questo comando:
- Avvia il container Neo4j in background (`-d` = detached mode)
- Espone le porte:
  - **7474**: Neo4j Browser (interfaccia web)
  - **7687**: Bolt protocol (per le connessioni driver)

### 4. Attendi che Neo4j sia Pronto

Aspetta circa 30-60 secondi, poi verifica lo stato:

```bash
docker compose logs neo4j
```

Cerca il messaggio: `Started.` o `Bolt enabled on 0.0.0.0:7687.`

### 5. Popola il Database (Solo la Prima Volta)

Puoi popolare il database in due modi:

#### Opzione A: Tramite Neo4j Browser (Raccomandato)

1. Apri il browser all'indirizzo: http://localhost:7474
2. Accedi con:
   - **Username**: neo4j
   - **Password**: password
3. Esegui i file Cypher nell'ordine:
   - Copia e incolla il contenuto di `01_create_nodes.cypher`
   - Esegui
   - Copia e incolla il contenuto di `02_create_relationships.cypher`
   - Esegui

#### Opzione B: Tramite cypher-shell (CLI)

```bash
docker exec -it neo4j_db cypher-shell -u neo4j -p password

# Poi copia e incolla il contenuto dei file .cypher
```

### 6. Crea il Virtual Environment Python

Torna alla root del progetto:

```bash
cd /mnt/c/Project_dev/Unisalento/unisalento-big-data-GDG-exam
```

Crea il virtual environment:

```bash
python3 -m venv .venv
```

### 7. Attiva il Virtual Environment

```bash
source .venv/bin/activate
```

Dopo l'attivazione, il prompt cambierà mostrandoti `(.venv)` all'inizio.

### 8. Installa le Dipendenze

Con il virtual environment attivo, installa il driver Neo4j:

```bash
pip install neo4j
```

---

## Esecuzione delle Query (Uso Quotidiano)

Una volta completato il setup iniziale, per eseguire le query ogni volta:

### Sequenza Completa

```bash
# 1. Entra in WSL (da PowerShell/terminale Windows)
wsl

# 2. Vai alla directory del progetto
cd /mnt/c/Project_dev/Unisalento/unisalento-big-data-GDG-exam

# 3. Verifica che il container sia in esecuzione (opzionale)
docker ps

# Se non è in esecuzione, avvialo:
# cd docker && docker compose up -d && cd ..

# 4. Attiva il virtual environment
source .venv/bin/activate

# 5. Esegui lo script delle query
python grafo/python/neo4j_queries.py
```

### Comando Rapido (One-liner)

Se il container Docker è già in esecuzione:

```bash
wsl -e bash -c "cd /mnt/c/Project_dev/Unisalento/unisalento-big-data-GDG-exam && source .venv/bin/activate && python grafo/python/neo4j_queries.py"
```

---

## Output Atteso

Lo script esegue automaticamente 3 query e mostra i risultati nel terminale:

1. **QUERY 1 - Episodi di Luca Bianchi**: Trova tutti gli episodi in cui compare l'ospite specificato
2. **QUERY 2A - Podcast collegati tramite ospiti**: Identifica podcast che condividono gli stessi ospiti
3. **QUERY 2B - Podcast collegati tramite argomenti**: Trova podcast collegati tramite argomenti comuni

Esempio di output:

```
================================================================================
QUERY 1 - Episodi di Luca Bianchi
================================================================================
Totale risultati: 2

Risultato #1
ospite: Luca Bianchi
numero: 1
episodio: AI e futuro
data: 2025-01-10
----------------------------------------
...
```

---

## Troubleshooting

### Errore: "No connection could be made"

**Problema**: Python non riesce a connettersi a Neo4j.

**Soluzione**:
1. Verifica che il container sia in esecuzione: `docker ps`
2. Se non lo è, avvialo: `cd docker && docker compose up -d`
3. Attendi 30-60 secondi che Neo4j si avvii completamente

### Errore: "neo4j: command not found" (pip install neo4j)

**Problema**: Il pacchetto neo4j non è installato o il virtual environment non è attivo.

**Soluzione**:
1. Attiva il virtual environment: `source .venv/bin/activate`
2. Installa il pacchetto: `pip install neo4j`

### Query Restituiscono 0 Risultati

**Problema**: Il database è vuoto.

**Soluzione**:
1. Popola il database eseguendo i file `.cypher` da Neo4j Browser
2. Verifica con: `MATCH (n) RETURN count(n);` (dovrebbe restituire 13 nodi)

### Virtual Environment non si Attiva

**Problema**: Errore di permessi o path errato.

**Soluzione**:
```bash
# Verifica che .venv esista
ls -la .venv

# Ricrea il virtual environment se necessario
rm -rf .venv
python3 -m venv .venv
source .venv/bin/activate
pip install neo4j
```

---

## Fermare il Container

Quando hai finito di lavorare, puoi fermare il container:

```bash
cd /mnt/c/Project_dev/Unisalento/unisalento-big-data-GDG-exam/docker
docker compose down
```

Questo ferma e rimuove il container (i dati persistono nel volume Docker).

---

## Note Tecniche

### Connessione al Database

Lo script Python si connette a Neo4j usando:
- **URI**: `bolt://localhost:7687`
- **Username**: `neo4j`
- **Password**: `password`

Queste credenziali sono configurate nel file `docker-compose.yml`.

### Query vs Cypher Files

Ci sono due modi per eseguire le query:

| Metodo | File | Uso |
|--------|------|-----|
| **Manuale** | `03_queries.cypher` | Esecuzione interattiva da Neo4j Browser (visualizzazione grafica) |
| **Automatizzato** | `neo4j_queries.py` | Esecuzione programmatica con output testuale |

Le query sono le stesse, ma lo script Python restituisce i risultati in formato testuale, mentre il browser Neo4j mostra la visualizzazione grafica del grafo.

---

## Riepilogo Comandi Essenziali

```bash
# Setup iniziale (solo prima volta)
wsl
cd /mnt/c/Project_dev/Unisalento/unisalento-big-data-GDG-exam
python3 -m venv .venv
source .venv/bin/activate
pip install neo4j

# Avvio container (quando necessario)
cd docker && docker compose up -d && cd ..

# Esecuzione query (uso quotidiano)
source .venv/bin/activate
python grafo/python/neo4j_queries.py

# Fermata container
cd docker && docker compose down
```

---

*Guida creata per il progetto Big Data - Esame Unisalento*

