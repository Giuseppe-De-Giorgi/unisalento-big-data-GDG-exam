"""
Script Python per eseguire le query Cypher sul database Neo4j
Esegue le query definite nel file 03_queries.cypher

Autore: Giuseppe De Giorgi
Progetto: Big Data - Esame Unisalento
"""

from neo4j import GraphDatabase
import json


class Neo4jQueryExecutor:
    """
    Classe per gestire la connessione e l'esecuzione delle query su Neo4j
    """
    
    def __init__(self, uri, user, password):
        """
        Inizializza la connessione al database Neo4j
        
        Args:
            uri (str): URI del database Neo4j (es. "bolt://localhost:7687")
            user (str): Username per l'autenticazione
            password (str): Password per l'autenticazione
        """
        self.driver = GraphDatabase.driver(uri, auth=(user, password))
        
    def close(self):
        """Chiude la connessione al database"""
        self.driver.close()
        
    def execute_query(self, query, query_name):
        """
        Esegue una query Cypher e stampa i risultati
        
        Args:
            query (str): Query Cypher da eseguire
            query_name (str): Nome descrittivo della query
        """
        print(f"\n{'='*80}")
        print(f"Esecuzione: {query_name}")
        print(f"{'='*80}\n")
        
        with self.driver.session() as session:
            result = session.run(query)
            records = list(result)
            
            if not records:
                print("Nessun risultato trovato.")
                return
            
            print(f"Numero di risultati: {len(records)}")
            print(f"\nRisultati:\n{'-'*80}")
            
            for i, record in enumerate(records, 1):
                print(f"\n[Risultato {i}]")
                for key in record.keys():
                    value = record[key]
                    if hasattr(value, 'items'):  # Se è un nodo o una relazione
                        print(f"  {key}: {dict(value)}")
                    else:
                        print(f"  {key}: {value}")
            
            print(f"\n{'-'*80}")
            
    def query_1_episodi_ospite(self):
        """
        QUERY 1: Trovare tutti gli episodi in cui compare un certo ospite
        Questa query estrae l'ospite "Luca Bianchi", le sue relazioni e gli episodi correlati.
        """
        query = """
        MATCH (o:Ospite {nome: "Luca Bianchi"})-[r:PARTECIPA]->(e:Episodio)
        RETURN o, r, e
        """
        self.execute_query(query, "QUERY 1 - Episodi dell'ospite Luca Bianchi")
        
    def query_2a_podcast_ospiti_condivisi(self):
        """
        QUERY 2A: Individuare i podcast collegati perché CONDIVIDONO OSPITI
        Trova due podcast diversi che hanno a catalogo episodi in cui ha partecipato lo stesso ospite.
        """
        query = """
        MATCH (p1:Podcast)-[r1:HA_EPISODIO]->(e1:Episodio)<-[r2:PARTECIPA]-(o:Ospite)
              -[r3:PARTECIPA]->(e2:Episodio)<-[r4:HA_EPISODIO]-(p2:Podcast)
        WHERE p1.titolo <> p2.titolo
        RETURN p1, r1, e1, r2, o, r3, e2, r4, p2
        """
        self.execute_query(query, "QUERY 2A - Podcast collegati per ospiti condivisi")
        
    def query_2b_podcast_argomenti_comuni(self):
        """
        QUERY 2B: Individuare i podcast collegati perché TRATTANO STESSI ARGOMENTI
        Trova due podcast diversi i cui episodi convergono sullo stesso identico argomento target.
        """
        query = """
        MATCH (p1:Podcast)-[r1:HA_EPISODIO]->(e1:Episodio)-[r2:TRATTA]->(arg:Argomento)
              <-[r3:TRATTA]-(e2:Episodio)<-[r4:HA_EPISODIO]-(p2:Podcast)
        WHERE p1.titolo <> p2.titolo
        RETURN p1, r1, e1, r2, arg, r3, e2, r4, p2
        """
        self.execute_query(query, "QUERY 2B - Podcast collegati per argomenti comuni")
        
    def execute_all_queries(self):
        """
        Esegue tutte le query in sequenza
        """
        print("\n" + "="*80)
        print(" "*20 + "ESECUZIONE QUERY NEO4J - PODCAST LIBRARY")
        print("="*80)
        
        try:
            # Query 1
            self.query_1_episodi_ospite()
            
            # Query 2A
            self.query_2a_podcast_ospiti_condivisi()
            
            # Query 2B
            self.query_2b_podcast_argomenti_comuni()
            
            print("\n" + "="*80)
            print(" "*25 + "TUTTE LE QUERY COMPLETATE!")
            print("="*80 + "\n")
            
        except Exception as e:
            print(f"\n[ERRORE] Si è verificato un errore durante l'esecuzione: {e}")


def main():
    """
    Funzione principale per eseguire lo script
    """
    # Configurazione della connessione a Neo4j
    # NOTA: Modificare questi parametri secondo la propria configurazione
    NEO4J_URI = "bolt://localhost:7687"
    NEO4J_USER = "neo4j"
    NEO4J_PASSWORD = "password"  # Modificare con la propria password
    
    print("\n" + "="*80)
    print(" "*25 + "NEO4J QUERY EXECUTOR")
    print("="*80)
    print(f"\nConnessione a Neo4j...")
    print(f"URI: {NEO4J_URI}")
    print(f"User: {NEO4J_USER}")
    
    # Creazione dell'executor e connessione al database
    try:
        executor = Neo4jQueryExecutor(NEO4J_URI, NEO4J_USER, NEO4J_PASSWORD)
        print("✓ Connessione stabilita con successo!\n")
        
        # Esecuzione di tutte le query
        executor.execute_all_queries()
        
        # Chiusura della connessione
        executor.close()
        print("Connessione chiusa.")
        
    except Exception as e:
        print(f"\n[ERRORE CONNESSIONE] Impossibile connettersi a Neo4j: {e}")
        print("\nVerificare che:")
        print("  1. Neo4j sia in esecuzione")
        print("  2. Le credenziali siano corrette")
        print("  3. L'URI sia corretto")
        print("  4. Il driver neo4j sia installato: pip install neo4j\n")


if __name__ == "__main__":
    main()

