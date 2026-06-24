from elasticsearch import Elasticsearch
import json
from pathlib import Path

# =========================
# CONNESSIONE
# =========================
es = Elasticsearch(
    hosts=["http://localhost:9200"],
    request_timeout=30
)

INDEX_NAME = "orders"

BASE_DIR = Path(__file__).resolve().parent.parent
DATA_FILE = BASE_DIR / "data" / "orders.json"


# =========================
# CREAZIONE INDICE
# =========================
def create_index():
    try:
        es.indices.delete(index=INDEX_NAME)
        print(f"Indice '{INDEX_NAME}' esistente eliminato")
    except Exception:
        print(f"Indice '{INDEX_NAME}' non esistente (verrà creato)")

    es.indices.create(
        index=INDEX_NAME,
        settings={
            "number_of_shards": 1,
            "number_of_replicas": 0
        },
        mappings={
            "properties": {
                "order_id": {"type": "keyword"},
                "date": {"type": "date"},
                "total": {"type": "float"},

                "customer": {
                    "properties": {
                        "email": {"type": "keyword"},
                        "city": {"type": "text"}
                    }
                },

                "products": {
                    "type": "nested",
                    "properties": {
                        "name": {"type": "text"},
                        "description": {"type": "text"},
                        "category": {"type": "keyword"},
                        "quantity": {"type": "integer"}
                    }
                }
            }
        }
    )

    print("Index creato correttamente")


# =========================
# INSERIMENTO DATI
# =========================
def insert_data():

    with open(DATA_FILE, "r", encoding="utf-8") as f:
        orders = json.load(f)

    for o in orders:
        es.index(index=INDEX_NAME, document=o)

    print(f"{len(orders)} ordini inseriti")


# =========================
# MAIN
# =========================
if __name__ == "__main__":
    try:
        print("Verifico connessione a Elasticsearch...")
        info = es.info()
        print(f"✓ Connesso a Elasticsearch {info['version']['number']}")
        print(f"  Cluster: {info['cluster_name']}\n")

        create_index()
        insert_data()

        print("\n✓ SETUP COMPLETATO CON SUCCESSO")

    except Exception as e:
        print(f"\n✗ ERRORE: {type(e).__name__}")
        print(f"  Messaggio: {e}")
        import sys
        sys.exit(1)