# Script Python per Query Neo4j

## Descrizione

Questo script Python (`neo4j_queries.py`) esegue automaticamente le query Cypher definite nel file `../cypher/03_queries.cypher` sul database Neo4j.

## Query Implementate

Lo script esegue tre query principali:

1. **Query 1**: Trova tutti gli episodi in cui compare l'ospite "Luca Bianchi"
2. **Query 2A**: Individua i podcast collegati perché condividono ospiti
3. **Query 2B**: Individua i podcast collegati perché trattano gli stessi argomenti

## Prerequisiti

### 1. Installare Neo4j

Assicurarsi di avere Neo4j installato e in esecuzione:
- Download: https://neo4j.com/download/
- Assicurarsi che il servizio Neo4j sia attivo (default su `bolt://localhost:7687`)

### 2. Caricare i Dati

Prima di eseguire lo script, assicurarsi di aver creato il database eseguendo gli script Cypher:
1. `../cypher/01_create_nodes.cypher` - Crea i nodi
2. `../cypher/02_create_relationships.cypher` - Crea le relazioni

### 3. Installare Python

- Python 3.8 o superiore
- pip (gestore pacchetti Python)

## Installazione

### 1. Installare le dipendenze

```powershell
pip install -r requirements.txt
```

oppure manualmente:

```powershell
pip install neo4j
```

### 2. Configurare le Credenziali

Aprire il file `neo4j_queries.py` e modificare le seguenti variabili nella funzione `main()`:

```python
NEO4J_URI = "bolt://localhost:7687"  # URI del database
NEO4J_USER = "neo4j"                 # Username
NEO4J_PASSWORD = "password"          # Modificare con la propria password
```

## Esecuzione

Eseguire lo script dalla cartella `python`:

```powershell
python neo4j_queries.py
```

## Output Atteso

Lo script produrrà un output strutturato con:
- Conferma della connessione a Neo4j
- Risultati di ogni query con dettagli sui nodi e relazioni trovate
- Numero di risultati per ogni query
- Messaggio di completamento

Esempio di output:

```
================================================================================
                    NEO4J QUERY EXECUTOR
================================================================================

Connessione a Neo4j...
URI: bolt://localhost:7687
User: neo4j
✓ Connessione stabilita con successo!

================================================================================
                ESECUZIONE QUERY NEO4J - PODCAST LIBRARY
================================================================================

================================================================================
Esecuzione: QUERY 1 - Episodi dell'ospite Luca Bianchi
================================================================================

Numero di risultati: 2
...
```

## Struttura del Codice

### Classe `Neo4jQueryExecutor`

Gestisce la connessione e l'esecuzione delle query:

- `__init__(uri, user, password)`: Inizializza la connessione
- `close()`: Chiude la connessione
- `execute_query(query, query_name)`: Esegue una query generica
- `query_1_episodi_ospite()`: Esegue la Query 1
- `query_2a_podcast_ospiti_condivisi()`: Esegue la Query 2A
- `query_2b_podcast_argomenti_comuni()`: Esegue la Query 2B
- `execute_all_queries()`: Esegue tutte le query in sequenza

### Funzione `main()`

Punto di ingresso dello script che:
1. Configura i parametri di connessione
2. Crea l'istanza di `Neo4jQueryExecutor`
3. Esegue tutte le query
4. Chiude la connessione

## Risoluzione Problemi

### Errore di Connessione

Se si riceve un errore di connessione, verificare:

1. **Neo4j è in esecuzione?**
   - Aprire Neo4j Desktop o verificare il servizio
   
2. **Credenziali corrette?**
   - Verificare username e password
   
3. **URI corretto?**
   - Default: `bolt://localhost:7687`
   - Verificare la porta configurata in Neo4j

4. **Driver installato?**
   ```powershell
   pip install neo4j
   ```

### Nessun Risultato

Se le query non restituiscono risultati:
- Verificare che i dati siano stati caricati con gli script Cypher
- Controllare che i nomi dei nodi corrispondano (es. "Luca Bianchi")

## Note

- Lo script utilizza il driver ufficiale Neo4j per Python
- Le query sono identiche a quelle nel file `03_queries.cypher`
- È possibile modificare i parametri delle query nella classe `Neo4jQueryExecutor`

## Autore

Giuseppe De Giorgi  
Progetto Big Data - Esame Unisalento

## Licenza

Progetto didattico per l'esame di Big Data

