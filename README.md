# 📊 Progetto Big Data - Analisi dei Dati e Database Multi-paradigma

<div align="center">

**Esame di Analisi dei Dati e Big Data**  
*Università del Salento - Corso di Laurea in Data Science per le Scienze Umane e Sociali*

</div>

---

## 👤 Informazioni Studente

| Campo | Valore |
|-------|--------|
| **Nome** | Giuseppe De Giorgi |
| **Matricola** | 20114491 |
| **Anno Accademico** | 2025/2026 |

---

## 📝 Descrizione Generale

Questo progetto implementa **tre tipologie di database differenti** (relazionale, grafo, document-oriented) per dimostrare la comprensione pratica dei diversi paradigmi di gestione dati e delle loro applicazioni in contesti reali.

L'architettura del progetto utilizza **Docker** per la containerizzazione dei servizi database (eseguito direttamente in WSL), **Python** per l'automazione e l'esecuzione delle query, e **WSL (Windows Subsystem for Linux)** come ambiente di sviluppo.

### 🎯 Obiettivi del Progetto

1. **Implementare tre database con paradigmi differenti**
   - SQL relazionale (SQLite)
   - NoSQL a grafo (Neo4j)
   - NoSQL document-oriented (Elasticsearch)

2. **Automatizzare setup e popolamento database**
   - Script Python per creazione schema
   - Popolamento automatico con dataset realistici

3. **Eseguire query analitiche avanzate**
   - Query SQL su relazioni complesse
   - Query Cypher per pattern matching su grafi
   - Query Elasticsearch con ricerca full-text e aggregazioni

4. **Documentare e visualizzare l'architettura**
   - Diagrammi ER, grafi e schema documenti
   - Guide dettagliate di esecuzione
   - Analisi dei risultati

---

## 🗂️ Struttura del Progetto

```
unisalento-big-data-GDG-exam/
│
├── 📁 docker/                          # Configurazione Docker Compose
│   └── docker-compose.yml              # Servizi: Neo4j, Elasticsearch, Kibana
│
├── 📁 relazionale/                     # Database SQL - Libreria Ebook
│   ├── database/                       # Database SQLite generato
│   ├── sql/
│   │   ├── ddl/schema.sql             # Schema tabelle
│   │   ├── dml/insert_data.sql        # 93 ebook, 30 utenti, 90 acquisti
│   │   └── query/queries.sql          # Query SQL di analisi
│   ├── python/
│   │   ├── setup.py                   # Setup automatizzato database
│   │   └── queries.py                 # Esecuzione query Python
│   ├── diagrammi/
│   │   └── er-relazionale.png         # Diagramma 
│   │   └── ER.png                     # Diagramma ER
│   └── how_to_run.md                  # Guida esecuzione
│
├── 📁 grafo/                           # Database Neo4j - Rete Podcast
│   ├── cypher/
│   │   ├── 01_create_nodes.cypher     # Creazione nodi
│   │   ├── 02_create_relationships.cypher  # Creazione relazioni
│   │   └── 03_queries.cypher          # Query Cypher
│   ├── python/
│   │   ├── setup.py                   # Setup automatizzato grafo
│   │   └── neo4j_queries.py           # Esecuzione query Python
│   ├── diagrammi/
│   │   └── diagramma-grafo.jpg        # Visualizzazione grafo
│   ├── results/
│   │   ├── result_discussion.md       # Analisi risultati
│   │   └── screenshots/               # Screenshot risultati query
│   └── how_to_run.md                  # Guida esecuzione
│
├── 📁 elasticsearch/                   # Database Elasticsearch - E-commerce
│   ├── data/
│   │   └── orders.json                # 50 ordini negozio elettronica
│   ├── python/
│   │   ├── setup.py                   # Setup automatizzato indice
│   │   └── queries.py                 # Query Elasticsearch
│   ├── diagrammi/
│   │   └── diagramma-elasticsearch.jpg  # Schema documenti
│   └── how_to_run.md                  # Guida esecuzione
│
├── 📁 .venv/                           # Virtual environment Python
└── README.md                           # Questa guida
```

---

## 🏗️ Database Implementati

### 1️⃣ Database Relazionale - Libreria Ebook

**Tecnologia:** SQLite  
**Scenario:** Casa editrice con libreria digitale di ebook

#### 📋 Traccia Progettuale

Una casa editrice vuole gestire una libreria digitale di ebook. Ogni libro digitale è identificato da un codice, ha titolo, autore, genere, prezzo e anno di pubblicazione. Gli utenti registrati possono acquistare più ebook, e per ogni acquisto si vogliono memorizzare data, modalità di pagamento e importo totale. Ogni utente ha un codice, nome, cognome, email e paese di residenza. Alcuni ebook possono appartenere a una collana, e ogni collana ha nome, descrizione e casa editrice di riferimento. Il sistema deve consentire di sapere quali libri ha acquistato ciascun utente e quali collane hanno venduto di più.

**Query suggerite:**
- Elencare tutti gli ebook acquistati da un certo utente
- Calcolare il numero di acquisti effettuati per ciascuna collana

#### 📊 Implementazione

**Entità principali:**
- **Utente**: Clienti registrati (30 utenti)
- **Collana**: Raccolte editoriali (10 collane)
- **Ebook**: Catalogo libri digitali (93 ebook, 55 senza collana)
- **Acquisto**: Ordini effettuati (90 acquisti)
- **Dettaglio_Acquisto**: Prodotti per acquisto (181 dettagli)

#### 🔍 Query Implementate

1. **Ebook acquistati per utente**: Lista libri acquistati da un cliente specifico
2. **Top collane per vendite**: Classifica collane più vendute

#### 📐 Diagramma ER

Visualizza il diagramma : [`relazionale/diagrammi/er-relazionale.png`](relazionale/diagrammi/er-relazionale.png)

Visualizza il diagramma ER completo: [`relazionale/diagrammi/ER.jpg`](relazionale/diagrammi/ER.jpg)

---

### 2️⃣ Database a Grafo - Rete di Podcast

**Tecnologia:** Neo4j  
**Scenario:** Piattaforma podcast con autori, episodi e ospiti

#### 📋 Traccia Progettuale

Una piattaforma di podcast vuole costruire un grafo per rappresentare autori, podcast, episodi, ospiti e argomenti trattati. Ogni podcast ha titolo, categoria e lingua. Gli episodi appartengono a un podcast e hanno numero, titolo e data di pubblicazione. Gli autori possono condurre più podcast, mentre gli ospiti possono partecipare a più episodi anche di podcast diversi. Gli episodi trattano uno o più argomenti, come tecnologia, attualità, sport o cultura. Il sistema deve permettere di esplorare connessioni tra ospiti ricorrenti, podcast con temi simili e autori che collaborano indirettamente tramite gli stessi ospiti.

**Query suggerite:**
- Trovare tutti gli episodi in cui compare un certo ospite
- Individuare i podcast collegati tra loro perché trattano gli stessi argomenti o condividono ospiti

#### 🕸️ Implementazione

**Nodi:**
- 1 Autore (Marco Rossi)
- 2 Podcast (Tech Talks, Sport Inside)
- 4 Episodi
- 2 Ospiti (Luca Bianchi, Sara Verdi)
- 4 Argomenti

**Relazioni:**
- `CONDUCE`: Autore → Podcast
- `HA_EPISODIO`: Podcast → Episodio
- `PARTECIPA`: Ospite → Episodio
- `TRATTA`: Episodio → Argomento

#### 🔍 Query Implementate

1. **Episodi per ospite**: Trova tutti gli episodi di un ospite specifico
2. **Podcast collegati (ospiti)**: Podcast che condividono ospiti
3. **Podcast collegati (argomenti)**: Podcast con temi simili

#### 📐 Visualizzazione Grafo

Visualizza il diagramma del grafo: [`grafo/diagrammi/diagramma-grafo.jpg`](grafo/diagrammi/diagramma-grafo.jpg)

#### 📄 Documentazione Risultati

Analisi dettagliata dei risultati: [`grafo/results/result_discussion.md`](grafo/results/result_discussion.md)

---

### 3️⃣ Database Document-Oriented - E-commerce Elettronica

**Tecnologia:** Elasticsearch + Kibana  
**Scenario:** Negozio elettronica con sistema ricerca ordini

#### 📋 Traccia Progettuale

Una catena di negozi di elettronica vuole gestire un sistema di ricerca e analisi dei propri dati tramite un database NoSQL orientato ai documenti. Il sistema deve permettere di memorizzare e interrogare rapidamente informazioni relative a clienti, prodotti e ordini in modo ottimizzato. Ogni Ordine rappresenta il documento principale e contiene al suo interno tutte le informazioni correlate all'acquisto:

- **Informazioni Ordine**: Codice ordine, data ordine e totale speso
- **Informazioni Cliente**: Email e città di residenza del cliente che ha effettuato l'acquisto
- **Lista Prodotti**: Un elenco dei beni acquistati, in cui per ogni prodotto si riportano il nome, la categoria (es. TV, smartphone, laptop) e la quantità associata

**Query suggerite:**
- **Ricerca**: Trovare tutti gli ordini effettuati da un determinato cliente (filtrato per email)
- **Statistica**: Trovare tutti gli ordini che contengono prodotti Samsung, indipendentemente da maiuscole/minuscole, cercando nel campo della descrizione dell'ordine. Trovare tutti gli ordini che contengono prodotti QLED, cercando nel campo della descrizione dell'ordine

#### 📄 Implementazione

**Indice:** `orders`

**Campi principali:**
- `order_id` (keyword)
- `date` (date)
- `total` (float)
- `customer` (object): email, city
- `products` (nested): name, description, category, quantity

#### 🔍 Query Implementate

1. **Ricerca per email**: Ordini di un cliente specifico (term query)
2. **Prodotti SAMSUNG**: Full-text search case-insensitive (15 risultati)
3. **Prodotti QLED**: Ricerca TV con tecnologia QLED (19 risultati)

#### 📐 Schema Documenti

Visualizza lo schema Elasticsearch: [`elasticsearch/diagrammi/diagramma-elasticsearch.jpg`](elasticsearch/diagrammi/diagramma-elasticsearch.jpg)

---

## 🛠️ Tecnologie Utilizzate

### Database
- **SQLite 3**: Database relazionale embedded
- **Neo4j 5.x**: Database a grafo
- **Elasticsearch 8.x**: Motore ricerca e analytics
- **Kibana 8.x**: Visualizzazione dati Elasticsearch

### Sviluppo
- **Python 3.12**: Linguaggio principale
- **Docker & Docker Compose**: Containerizzazione servizi
- **WSL (Ubuntu)**: Ambiente Linux su Windows

### Librerie Python
```
neo4j          # Driver Neo4j
elasticsearch  # Client Elasticsearch
sqlite3        # Built-in SQLite
```

---

## 🚀 Setup e Installazione

### Prerequisiti

- **Windows 10/11** con WSL2 attivato
- **Docker** installato direttamente in WSL (senza Docker Desktop)
- **Python 3.12+** installato in WSL

### 1. Clone Repository

```bash
# All'interno di WSL
git clone https://github.com/Giuseppe-De-Giorgi/unisalento-big-data-GDG-exam.git
cd unisalento-big-data-GDG-exam
```

### 2. Installazione Docker in WSL

Se Docker non è già installato in WSL, esegui:

```bash
# Aggiorna i pacchetti
sudo apt update && sudo apt upgrade -y

# Installa Docker
sudo apt install docker.io docker-compose -y

# Avvia il servizio Docker
sudo service docker start

# Aggiungi il tuo utente al gruppo docker (opzionale, per evitare sudo)
sudo usermod -aG docker $USER
# Riavvia WSL per applicare le modifiche
```

### 3. Avvia Servizi Docker

```bash
# Dalla root del progetto, avvia i container
cd docker
sudo docker compose up -d
# oppure senza sudo se hai configurato il gruppo docker
```

Questo avvia:
- **Neo4j** su `localhost:7474` (browser) e `localhost:7687` (bolt)
- **Elasticsearch** su `localhost:9200`
- **Kibana** su `localhost:5601`

### 4. Setup Virtual Environment Python

```bash
# Torna alla root del progetto
cd ..

# Crea e attiva virtual environment
python3 -m venv .venv
source .venv/bin/activate

# Installa le dipendenze Python
pip install neo4j elasticsearch
```

---

## ▶️ Esecuzione dei Moduli

Ogni modulo (relazionale, grafo, elasticsearch) dispone di una guida dettagliata `how_to_run.md` con istruzioni complete per setup ed esecuzione.

### 📘 Database Relazionale (SQLite)

Il database SQLite implementa una libreria digitale di ebook con utenti, collane e acquisti.

**Per istruzioni dettagliate su setup ed esecuzione:**  
📖 [`relazionale/how_to_run.md`](relazionale/how_to_run.md)

---

### 🕸️ Database Grafo (Neo4j)

Il database a grafo Neo4j modella una rete di podcast con autori, episodi, ospiti e argomenti.

**Per istruzioni dettagliate su setup ed esecuzione:**  
📖 [`grafo/how_to_run.md`](grafo/how_to_run.md)

---

### 🔍 Database Elasticsearch

Elasticsearch gestisce un sistema di ricerca e analisi ordini per un e-commerce di elettronica.

**Per istruzioni dettagliate su setup ed esecuzione:**  
📖 [`elasticsearch/how_to_run.md`](elasticsearch/how_to_run.md)

---

## 📊 Dataset e Statistiche

| Database | Entità | Record Totali | Caratteristiche |
|----------|--------|---------------|-----------------|
| **SQLite** | 5 tabelle | ~330 record | 93 ebook, utenti con acquisti multipli |
| **Neo4j** | 5 tipi nodi | 13 nodi, ~15 relazioni | Grafo didattico semplice |
| **Elasticsearch** | 1 indice | 50 documenti | Ordini realistici e-commerce |

---

## 🧪 Esempi di Query

### SQL - Top 5 Collane

```sql
SELECT 
    c.nome AS collana,
    COUNT(DISTINCT da.acquisto_id) AS numero_acquisti
FROM collana c
JOIN ebook e ON c.id = e.collana_id
JOIN dettaglio_acquisto da ON e.id = da.ebook_id
GROUP BY c.id
ORDER BY numero_acquisti DESC
LIMIT 5;
```

### Cypher - Podcast Collegati

```cypher
MATCH (p1:Podcast)-[:HA_EPISODIO]->(e:Episodio)<-[:PARTECIPA]-(o:Ospite)
MATCH (o)-[:PARTECIPA]->(e2:Episodio)<-[:HA_EPISODIO]-(p2:Podcast)
WHERE p1 <> p2
RETURN DISTINCT p1.titolo, p2.titolo, o.nome
```

### Elasticsearch - Ricerca SAMSUNG

```json
{
  "query": {
    "nested": {
      "path": "products",
      "query": {
        "bool": {
          "should": [
            { "match": { "products.description": "samsung" } },
            { "match": { "products.name": "samsung" } }
          ]
        }
      }
    }
  }
}
```

---

## 📚 Documentazione Aggiuntiva

### Guide Tecniche
- 📄 [`relazionale/how_to_run.md`](relazionale/how_to_run.md) - Setup e query SQLite
- 📄 [`grafo/how_to_run.md`](grafo/how_to_run.md) - Setup e query Neo4j
- 📄 [`elasticsearch/how_to_run.md`](elasticsearch/how_to_run.md) - Setup e query Elasticsearch

### Analisi Risultati (solo per il database a grafo per visualizzazione immediata grafica)
- 📊 [`grafo/results/result_discussion.md`](grafo/results/result_discussion.md) - Analisi grafo podcast
- 🖼️ [`grafo/results/screenshots/`](grafo/results/screenshots/) - Screenshot query Neo4j

### Diagrammi
- 🗺️ **ER Relazionale**: `relazionale/diagrammi/er-relazionale.png`
- 🕸️ **Grafo Neo4j**: `grafo/diagrammi/diagramma-grafo.jpg`
- 📄 **Schema Elasticsearch**: `elasticsearch/diagrammi/diagramma-elasticsearch.jpg`

---

## 🔧 Troubleshooting

### Docker non si avvia
```bash
# Verifica che il servizio Docker sia in esecuzione in WSL
sudo service docker status

# Se non è in esecuzione, avvialo
sudo service docker start

# Verifica i container attivi
docker ps
# oppure con sudo se necessario
sudo docker ps

# Riavvia i servizi
cd docker
sudo docker compose down
sudo docker compose up -d
```

### Errori di connessione Python
```bash
# Verifica virtual environment
source .venv/bin/activate
pip list | grep -E "neo4j|elasticsearch"

# Reinstalla dipendenze se necessario
pip install --upgrade neo4j elasticsearch
```

### Database vuoto
```bash
# Riesegui setup per ogni modulo
python relazionale/python/setup.py
python grafo/python/setup.py
python elasticsearch/python/setup.py
```

---


## 🎓 Conclusioni

Questo progetto dimostra l'applicazione pratica di tre paradigmi di database differenti su casi d'uso realistici:

✅ **SQL Relazionale** per dati strutturati con relazioni complesse  
✅ **Grafo Neo4j** per analisi di reti e connessioni  
✅ **Elasticsearch** per ricerca full-text e analytics real-time  

Ogni soluzione è stata implementata con:
- Script di setup automatizzato
- Dataset realistici e consistenti
- Query analitiche significative
- Documentazione completa e diagrammi

---

## 👨‍💻 Autore

**Giuseppe De Giorgi**  
Matricola: 20114491  
Università del Salento  
Data Science per le Scienze Umane e Sociali

---

## 📄 Licenza

Progetto sviluppato per fini didattici - Anno Accademico 2025/2026

---

<div align="center">

**Realizzato con** ❤️ **per l'esame di Big Data**

*Università del Salento - 2026*

</div>
