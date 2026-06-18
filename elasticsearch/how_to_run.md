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
3. **Inserisce dati di esempio** - Popola l'indice con 3 ordini di test

#### Struttura dell'Indice `orders`:
- **order_id** (keyword): ID univoco dell'ordine
- **date** (date): Data dell'ordine
- **total** (float): Importo totale
- **customer** (object): 
  - **email** (keyword): Email del cliente
  - **city** (text): Città del cliente
- **products** (nested array): Lista dei prodotti acquistati
  - **name** (text): Nome del prodotto
  - **category** (keyword): Categoria (TV, smartphone, accessori)
  - **quantity** (integer): Quantità acquistata

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
Dati inseriti

✓ SETUP COMPLETATO CON SUCCESSO
```

#### Cosa fa lo script:
- Elimina l'indice `orders` se esiste già (per ripartire da zero)
- Crea un nuovo indice con i mappings definiti
- Inserisce 3 documenti di esempio (ordini di clienti diversi)

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

4. Dovresti vedere **3 documenti** (i 3 ordini inseriti dallo script)

5. **Esplora i dati**:
   - Clicca su un documento per vedere tutti i campi
   - Espandi il campo `products` per vedere l'array dei prodotti
   - Nota la struttura nested dei dati

---

## 📊 Esecuzione delle Query

Una volta verificato che i dati sono presenti in Kibana, puoi tornare su WSL ed eseguire le query programmatiche.

### 7️⃣ Lancio Script Queries

Lo script `queries.py` esegue due query:

1. **Ricerca ordini per email cliente** - Trova tutti gli ordini di un cliente specifico
2. **Aggregazione categorie più vendute** - Calcola le categorie con maggiori quantità vendute

#### Esegui lo script:
```bash
python elasticsearch/python/queries.py
```

**Esempio di interazione:**
```
Inserisci email cliente: luca@mail.com

============================================================
ORDINI PER CLIENTE: luca@mail.com
============================================================

Ordine #1
ID ordine: 1
Data: 2025-01-10
Totale: 1200
----------------------------------------

Ordine #2
ID ordine: 3
Data: 2025-01-15
Totale: 1500
----------------------------------------

============================================================
CATEGORIE PIÙ VENDUTE
============================================================
TV -> quantità totale: 3
accessori -> quantità totale: 3
smartphone -> quantità totale: 1
```

#### Come funziona:

**Query 1 - Ricerca per email:**
- Utilizza una **term query** per cercare l'email esatta del cliente
- Restituisce tutti gli ordini associati a quell'email
- Mostra ID ordine, data e totale per ogni risultato

**Query 2 - Aggregazione categorie:**
- Utilizza una **nested aggregation** per accedere ai prodotti (che sono in un array nested)
- Raggruppa per categoria di prodotto
- Calcola la **somma delle quantità** per categoria
- Ordina le categorie per quantità venduta (decrescente)

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
- **Documenti**: 3 ordini di esempio


