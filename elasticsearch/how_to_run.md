# Guida Elasticsearch - Negozio di Elettronica

Questa guida spiega passo-passo come configurare ed utilizzare Elasticsearch per il progetto del negozio di elettronica.

---

## 📚 Concetti Base

### Cos'è Elasticsearch?
Elasticsearch è un database NoSQL **document-oriented**, ottimizzato per ricerche e analisi in tempo reale.

### Cosa sono gli Indici?
Un **indice** in Elasticsearch è come una "tabella" nei database relazionali. Contiene una collezione di documenti simili tra loro. Nel nostro caso, l'indice si chiama `orders`.

### Cosa sono i Documenti?
I **documenti** sono singoli record in formato JSON memorizzati nell'indice. Ogni documento rappresenta un ordine con tutte le informazioni correlate (cliente, prodotti, totale, ecc.).

### Cosa sono i Mappings?
I **mappings** definiscono la struttura dei documenti, specificando il tipo di ogni campo (es. `text`, `keyword`, `date`, `nested`). È simile allo schema di un database relazionale.

### Struttura del Progetto Elasticsearch
```
elasticsearch/
├── data/
│   └── orders.json          # 50 ordini del negozio di elettronica
├── python/
│   ├── setup.py             # Script per creare indice e caricare dati
│   └── queries.py           # Script per eseguire query di esempio
└── how_to_run.md            # Questa guida
```

Il file **`orders.json`** contiene 50 ordini realistici di un negozio di elettronica con prodotti come TV QLED, frigoriferi SAMSUNG, microonde, smartwatch e altri dispositivi elettronici.

---

## 🚀 Procedura di Setup

### 1️⃣ Avvio dei Container Docker

Prima di tutto, assicurati che i container Docker siano avviati:

```bash
# Dalla directory principale del progetto
cd /mnt/c/Project_dev/Unisalento/unisalento-big-data-GDG-exam

# Avvia i container
docker compose up -d
```

Verifica che Elasticsearch sia attivo:
```bash
docker ps
```

Dovresti vedere un container in esecuzione sulla porta 9200.

Testa la connessione:
```bash
curl http://localhost:9200
```

Dovresti ricevere una risposta JSON con le informazioni del cluster.

---

### 2️⃣ Attivazione Virtual Environment

Attiva il virtual environment Python su WSL:

```bash
# Dalla directory principale del progetto
cd /mnt/c/Project_dev/Unisalento/unisalento-big-data-GDG-exam

# Attiva il virtual environment
source .venv/bin/activate
```

Dopo l'attivazione, dovresti vedere `(.venv)` all'inizio del prompt.

Se non hai ancora installato la libreria Python Elasticsearch, eseguila:
```bash
pip install elasticsearch
```

---

### 3️⃣ Esecuzione Setup - Creazione Indice e Inserimento Dati

Lo script `setup.py` svolge tre operazioni fondamentali:

1. **Verifica connessione** - Controlla che Elasticsearch sia raggiungibile
2. **Crea l'indice `orders`** - Definisce la struttura (mappings) dei documenti
3. **Inserisce dati** - Popola l'indice con 50 ordini caricati dal file `data/orders.json`

#### Struttura dell'Indice `orders`:
- **order_id** (keyword): ID univoco dell'ordine
- **date** (date): Data dell'ordine
- **total** (float): Importo totale
- **customer** (object): 
  - **email** (keyword): Email del cliente
  - **city** (text): Città del cliente
- **products** (nested array): Lista dei prodotti acquistati
  - **name** (text): Nome del prodotto
  - **description** (text): Descrizione dettagliata del prodotto
  - **category** (keyword): Categoria (tv, frigoriferi, audio, ecc.)
  - **quantity** (integer): Quantità acquistata

#### File Sorgente Dati:
I dati vengono caricati dal file `elasticsearch/data/orders.json` che contiene 50 ordini di un negozio di elettronica, con prodotti come TV QLED, frigoriferi SAMSUNG, e altri dispositivi elettronici.

#### Esegui lo script:
```bash
python elasticsearch/python/setup.py
```

**Output atteso:**
```
Verifico connessione a Elasticsearch...
✓ Connesso a Elasticsearch 9.0.0
  Cluster: docker-cluster

Indice 'orders' non esistente (verrà creato)
Index creato correttamente
50 ordini inseriti

✓ SETUP COMPLETATO CON SUCCESSO
```

#### Cosa fa lo script:
- Elimina l'indice `orders` se esiste già (per ripartire da zero)
- Crea un nuovo indice con i mappings definiti
- Legge il file `data/orders.json` 
- Inserisce tutti i 50 ordini nell'indice Elasticsearch

> **⚠️ NOTA IMPORTANTE**: Poiché il progetto **non usa volumi Docker**, se esegui `docker compose down -v`, **tutti i dati verranno persi**. Dovrai rieseguire `setup.py` per ricreare l'indice e i dati.

---

## 🔍 Verifica Dati con Kibana

Kibana è l'interfaccia grafica per visualizzare e interrogare i dati in Elasticsearch.

### 4️⃣ Accesso a Kibana

Apri il browser e vai a:
```
http://localhost:5601
```

### 5️⃣ Creazione Data View

Per visualizzare i dati, devi creare una **Data View** (vista dei dati):

1. **Apri il menu laterale** (icona hamburger in alto a sinistra)

2. **Scorri in fondo** alla sezione **Management**

3. Clicca su **Stack Management**

4. Nella sezione **Kibana**, clicca su **Data Views**

5. Clicca sul pulsante **"Create data view"**

6. **Compila i campi**:
   - **Name**: `orders`
   - **Index pattern**: `orders`
   - **Timestamp field**: Seleziona **"I don't want to use the time filter"**

7. Clicca su **"Save data view to Kibana"**

### 6️⃣ Visualizzazione in Discover

Ora puoi esplorare i dati:

1. **Apri il menu laterale** 

2. Nella sezione **Analytics**, clicca su **Discover**

3. In alto a sinistra, seleziona la data view **`orders`**

4. Dovresti vedere **50 documenti** (i 50 ordini inseriti dal file `orders.json`)

5. **Esplora i dati**:
   - Clicca su un documento per vedere tutti i campi
   - Espandi il campo `products` per vedere l'array dei prodotti
   - Nota la struttura nested dei dati

---

## 📊 Esecuzione delle Query

Una volta verificato che i dati sono presenti in Kibana, puoi tornare su WSL ed eseguire le query programmatiche.

### 7️⃣ Lancio Script Queries

Lo script `queries.py` esegue tre query:

1. **Ricerca ordini per email cliente** - Trova tutti gli ordini di un cliente specifico tramite input manuale
2. **Ricerca ordini con prodotti SAMSUNG** - Trova tutti gli ordini che contengono prodotti Samsung (case-insensitive) cercando nel campo name o description
3. **Ricerca ordini con prodotti QLED** - Trova tutti gli ordini che contengono prodotti con tecnologia QLED cercando nel campo name o description

#### Esegui lo script:
```bash
python elasticsearch/python/queries.py
```

**Esempio di output:**
```
Inserisci email cliente: mario.rossi@mail.com

======================================================================
ORDINI PER CLIENTE: mario.rossi@mail.com
======================================================================
TOTAL ORDERS FOUND: 1
----------------------------------------------------------------------
Order ID: 1 | Total: 1200 | Date: 2025-01-01

======================================================================
ORDINI CON PRODOTTI SAMSUNG
======================================================================
TOTAL ORDERS FOUND: 15
----------------------------------------------------------------------
Order ID: 3 | Total: 450 | Date: 2025-01-03
Order ID: 21 | Total: 920 | Date: 2025-01-21
Order ID: 14 | Total: 890 | Date: 2025-01-14
Order ID: 31 | Total: 880 | Date: 2025-01-31
Order ID: 35 | Total: 920 | Date: 2025-02-04
Order ID: 39 | Total: 1050 | Date: 2025-02-08
Order ID: 46 | Total: 870 | Date: 2025-02-15
Order ID: 16 | Total: 1400 | Date: 2025-01-16
Order ID: 49 | Total: 930 | Date: 2025-02-18
Order ID: 26 | Total: 810 | Date: 2025-01-26

======================================================================
ORDINI CON PRODOTTI QLED
======================================================================
TOTAL ORDERS FOUND: 19
----------------------------------------------------------------------
Order ID: 27 | Total: 1150 | Date: 2025-01-27
Order ID: 29 | Total: 1450 | Date: 2025-01-29
Order ID: 37 | Total: 1350 | Date: 2025-02-06
Order ID: 9 | Total: 1350 | Date: 2025-01-09
Order ID: 16 | Total: 1400 | Date: 2025-01-16
Order ID: 34 | Total: 1100 | Date: 2025-02-03
Order ID: 40 | Total: 1200 | Date: 2025-02-09
Order ID: 47 | Total: 1400 | Date: 2025-02-16
Order ID: 24 | Total: 1300 | Date: 2025-01-24
Order ID: 32 | Total: 1200 | Date: 2025-02-01
```

> **Nota**: Puoi provare con diverse email presenti nel dataset come `anna.ferrari@mail.com`, `giovanni.bianchi@mail.com`, `laura.conti@mail.com`, ecc.

#### Come funziona:

**Query 1 - Ricerca per email:**
- Utilizza una **term query** per cercare l'email esatta del cliente
- Restituisce tutti gli ordini associati a quell'email
- Mostra ID ordine, totale e data per ogni risultato

**Query 2 - Ricerca ordini SAMSUNG:**
- Utilizza una **nested query** per accedere ai prodotti (che sono in un array nested)
- Utilizza **bool query** con **should** (OR logico) per cercare "samsung" sia nel campo `name` che `description`
- La ricerca è **case-insensitive** grazie all'uso di `match` query
- Mostra tutti gli ordini che contengono almeno un prodotto Samsung

**Query 3 - Ricerca ordini QLED:**
- Utilizza una **nested query** per accedere ai prodotti
- Utilizza **bool query** con **should** per cercare "qled" sia nel campo `name` che `description`
- La ricerca è **case-insensitive**
- Mostra tutti gli ordini che contengono almeno un prodotto con tecnologia QLED

#### Risultati:
- **15 ordini** contengono prodotti SAMSUNG (frigoriferi, microonde, TV)
- **19 ordini** contengono prodotti QLED (televisori con tecnologia Quantum Dot)
- L'**ordine 16** compare in entrambe le liste perché contiene un "Televisore QLED Samsung"

---

## 🔄 Riavvio del Progetto

Se hai eseguito `docker compose down -v` o riavviato il sistema:

```bash
# 1. Avvia i container posizionandosi nella directory /docker
docker compose up -d

# 2. Attendi circa 30 secondi che Elasticsearch si avvii

# 3. Attiva virtual environment
source .venv/bin/activate

# 4. Ricrea indice e dati (poiché non ci sono volumi persistenti)
python elasticsearch/python/setup.py

# 5. Riconfigura la Data View in Kibana (se necessario)

# 6. Esegui le query
python elasticsearch/python/queries.py
```

---

## 📝 Note Finali

- **Nessun volume Docker**: I dati vengono persi ad ogni `docker compose down -v`
- **Port 9200**: Elasticsearch API
- **Port 5601**: Kibana UI
- **Indice**: `orders`
- **Documenti**: 50 ordini caricati da `data/orders.json`
- **Query implementate**: 
  - Ricerca ordini per email cliente (input manuale)
  - Ricerca ordini con prodotti SAMSUNG (15 risultati)
  - Ricerca ordini con prodotti QLED (19 risultati)


