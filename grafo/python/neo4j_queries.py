from neo4j import GraphDatabase


class Neo4jQueryExecutor:

    def __init__(self, uri, user, password):
        self.driver = GraphDatabase.driver(uri, auth=(user, password))

    def close(self):
        self.driver.close()

    def run_query(self, title: str, query: str):
        print("\n" + "=" * 80)
        print(title)
        print("=" * 80)

        with self.driver.session() as session:
            result = session.run(query)
            records = list(result)

            print(f"Totale risultati: {len(records)}")

            if not records:
                print("Nessun risultato.")
                return

            for i, record in enumerate(records, 1):
                print(f"\nRisultato #{i}")

                for key, value in record.items():
                    print(f"{key}: {value}")

                print("-" * 40)

    def run_all(self):

        self.run_query(
            "QUERY 1 - Episodi di Luca Bianchi",
            """
            MATCH (o:Ospite {nome: "Luca Bianchi"})-[r:PARTECIPA]->(e:Episodio)
            RETURN o.nome AS ospite,
                   e.numero AS numero,
                   e.titolo AS episodio,
                   e.data_pubblicazione AS data
            """
        )

        self.run_query(
            "QUERY 2A - Podcast collegati tramite ospiti",
            """
            MATCH (o:Ospite)-[r1:PARTECIPA]->(e1:Episodio)<-[r2:HA_EPISODIO]-(p1:Podcast),
                  (o)-[r3:PARTECIPA]->(e2:Episodio)<-[r4:HA_EPISODIO]-(p2:Podcast)
            WHERE p1.titolo < p2.titolo
            RETURN p1.titolo AS podcast_1,
                   p2.titolo AS podcast_2,
                   o.nome AS ospite
            """
        )

        self.run_query(
            "QUERY 2B - Podcast collegati tramite argomenti",
            """
            MATCH (p1:Podcast)-[r1:HA_EPISODIO]->(e1:Episodio)-[r2:TRATTA]->(a:Argomento),
                  (p2:Podcast)-[r3:HA_EPISODIO]->(e2:Episodio)-[r4:TRATTA]->(a)
            WHERE p1.titolo < p2.titolo
            RETURN p1.titolo AS podcast_1,
                   p2.titolo AS podcast_2,
                   a.nome_argomento AS argomento
            """
        )


def main():
    URI = "bolt://localhost:7687"
    USER = "neo4j"
    PASSWORD = "password"

    print("\nNEO4J QUERY EXECUTOR\n")

    executor = Neo4jQueryExecutor(URI, USER, PASSWORD)

    try:
        executor.run_all()
    finally:
        executor.close()
        print("\nConnessione chiusa")


if __name__ == "__main__":
    main()