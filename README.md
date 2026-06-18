# unisalento-big-data-GDG-exam
# Progetto Esame Analisi dei Dati e Big Data

**Studente:** Giuseppe De Giorgi  
**Matricola:** 20114491  
**Corso di Laurea:** Data Science per le Scienze Umane e Sociali

## Descrizione funzionale del progetto

Il progetto prevede la realizzazione di tre differenti tipologie di database:

1. Database relazionale – Libreria di ebook
Una casa editrice vuole gestire una libreria digitale di ebook. Ogni libro digitale è identificato da un codice, ha titolo, autore, genere, prezzo e anno di pubblicazione. Gli utenti registrati possono acquistare più ebook, e per ogni acquisto si vogliono memorizzare data, modalità di pagamento e importo totale. Ogni utente ha un codice, nome, cognome, email e paese di residenza. Alcuni ebook possono appartenere a una collana, e ogni collana ha nome, descrizione e casa editrice di riferimento. Il sistema deve consentire di sapere quali libri ha acquistato ciascun utente e quali collane hanno venduto di più.

Query suggerite:
Elencare tutti gli ebook acquistati da un certo utente.
Calcolare il numero di acquisti effettuati per ciascuna collana.
2. Database NoSQL a grafo (Neo4j) – Rete di podcast e ospiti
Una piattaforma di podcast vuole costruire un grafo per rappresentare autori, podcast, episodi, ospiti e argomenti trattati. Ogni podcast ha titolo, categoria e lingua. Gli episodi appartengono a un podcast e hanno numero, titolo e data di pubblicazione. Gli autori possono condurre più podcast, mentre gli ospiti possono partecipare a più episodi anche di podcast diversi. Gli episodi trattano uno o più argomenti, come tecnologia, attualità, sport o cultura. Il sistema deve permettere di esplorare connessioni tra ospiti ricorrenti, podcast con temi simili e autori che collaborano indirettamente tramite gli stessi ospiti.

Query suggerite:
Trovare tutti gli episodi in cui compare un certo ospite.
Individuare i podcast collegati tra loro perché trattano gli stessi argomenti o condividono ospiti.
3. Database NO-SQL Key Document (Elasticsearch) – Negozio di elettronica
Una catena di negozi di elettronica vuole gestire un sistema di ricerca e analisi dei propri dati tramite un database NoSQL orientato ai documenti. Il sistema deve permettere di memorizzare e interrogare rapidamente informazioni relative a clienti, prodotti e ordini in modo ottimizzato.
Ogni Ordine rappresenta il documento principale e contiene al suo interno tutte le informazioni correlate all'acquisto:
Informazioni Ordine: Codice ordine, data ordine e totale speso.
Informazioni Cliente: Email e città di residenza del cliente che ha effettuato l'acquisto.
Lista Prodotti: Un elenco dei beni acquistati, in cui per ogni prodotto si riportano il nome, la categoria (es. TV, smartphone, laptop) e la quantità associata.

Query suggerite:
Ricerca: Trovare tutti gli ordini effettuati da un determinato cliente (filtrato per email).
Statistica: Trovare le categorie di prodotti più vendute (calcolate in base alla quantità totale).

## Descrizione tecnica del progetto

### Prerequisiti

- Docker e Docker Compose
- Python 3.12+ (su WSL)
- Virtual environment Python attivato

### Avvio dei servizi Docker

```bash
docker-compose -f docker/docker-compose.yml up -d
```

Questo avvierà:
- **Elasticsearch** su `http://localhost:9200` 
- **Kibana** su `http://localhost:5601`
- **Neo4j** su `http://localhost:7474` (browser) e `bolt://localhost:7687`

### Setup Elasticsearch

📖 **Guida completa**: [`elasticsearch/HOW_TO_RUN.md`](elasticsearch/how_to_run.md)

**Procedura rapida:**
1. Attivare virtual environment: `source .venv/bin/activate`
2. Installare dipendenza: `pip install elasticsearch`
3. Eseguire setup: `python elasticsearch/python/setup.py`
4. Aprire Kibana http://localhost:5601 e creare Data View
5. Eseguire query: `python elasticsearch/python/queries.py`

### Setup Neo4j

Seguire le istruzioni nel file `grafo/how_to_run.md`

### Database Relazionale

Il database SQLite si trova in `relazionale/database/ebook_library.db`

