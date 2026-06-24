from pathlib import Path
from neo4j import GraphDatabase


class Neo4jDatabaseSetup:

    def __init__(self, uri, user, password):
        self.driver = GraphDatabase.driver(uri, auth=(user, password))

    def close(self):
        self.driver.close()

    def clear_database(self):
        print("\n" + "=" * 80)
        print("PULIZIA DATABASE")
        print("=" * 80)

        with self.driver.session() as session:
            session.run("""
                MATCH (n)
                DETACH DELETE n
            """)

        print("Database svuotato correttamente.")

    def execute_cypher_file(self, file_path):
        print("\n" + "=" * 80)
        print(f"ESECUZIONE: {file_path.name}")
        print("=" * 80)

        with open(file_path, "r", encoding="utf-8") as file:
            content = file.read()

        # Rimuove i commenti e divide per statement
        lines = []
        for line in content.split('\n'):
            # Salta le righe di commento
            if line.strip().startswith('//'):
                continue
            lines.append(line)
        
        # Ricostruisce il contenuto senza commenti
        query_content = '\n'.join(lines)
        
        # Divide per punto e virgola (ogni statement separato)
        statements = [stmt.strip() for stmt in query_content.split(';') if stmt.strip()]
        
        with self.driver.session() as session:
            for i, statement in enumerate(statements, 1):
                if statement:
                    try:
                        session.run(statement)
                    except Exception as e:
                        print(f"Errore nello statement {i}:")
                        print(f"  {statement[:100]}...")
                        raise e

        print(f"Script eseguito correttamente ({len(statements)} statements).")

    def setup_database(self):
        self.clear_database()

        base_path = Path(__file__).resolve().parent.parent / "cypher"

        files = [
            base_path / "01_create_nodes.cypher",
            base_path / "02_create_relationships.cypher"
        ]

        for file in files:
            self.execute_cypher_file(file)


def main():
    URI = "bolt://localhost:7687"
    USER = "neo4j"
    PASSWORD = "password"

    print("\nCREAZIONE DATABASE NEO4J")

    setup = Neo4jDatabaseSetup(URI, USER, PASSWORD)

    try:
        setup.setup_database()
    finally:
        setup.close()
        print("\nDatabase creato correttamente.")
        print("Connessione chiusa.")


if __name__ == "__main__":
    main()