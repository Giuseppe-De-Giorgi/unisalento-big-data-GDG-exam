"""
Script per il setup di Elasticsearch - Progetto Big Data

PREREQUISITI:
1. Avviare i container Docker:
   docker-compose -f docker/docker-compose.yml up -d

2. Installare la dipendenza Python (con virtual environment attivato):
   pip install elasticsearch
   (Versione consigliata: 9.x)

3. Verificare che Elasticsearch sia attivo:
   curl http://localhost:9200

ESECUZIONE:
   python elasticsearch/python/setup.py
"""

from elasticsearch import Elasticsearch

# =========================
# CONNESSIONE
# =========================
es = Elasticsearch(
    hosts=["http://localhost:9200"],
    request_timeout=30
)

INDEX_NAME = "orders"


# =========================
# CREAZIONE INDICE
# =========================
def create_index():
    # Prova a eliminare l'indice se esiste (ignora errori se non esiste)
    try:
        es.indices.delete(index=INDEX_NAME)
        print(f"Indice '{INDEX_NAME}' esistente eliminato")
    except Exception:
        print(f"Indice '{INDEX_NAME}' non esistente (verrà creato)")

    # Crea il nuovo indice
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

    orders = [
        {
            "order_id": "1",
            "date": "2025-01-10",
            "total": 1200,
            "customer": {"email": "luca@mail.com", "city": "Napoli"},
            "products": [
                {"name": "Samsung TV", "category": "TV", "quantity": 1},
                {"name": "HDMI Cable", "category": "accessori", "quantity": 2}
            ]
        },
        {
            "order_id": "2",
            "date": "2025-01-11",
            "total": 800,
            "customer": {"email": "mario@mail.com", "city": "Roma"},
            "products": [
                {"name": "iPhone", "category": "smartphone", "quantity": 1}
            ]
        },
        {
            "order_id": "3",
            "date": "2025-01-15",
            "total": 1500,
            "customer": {"email": "luca@mail.com",
                "city": "Napoli"
            },
            "products": [
                {
                    "name": "LG TV",
                    "category": "TV",
                    "quantity": 2
                },
                {
                    "name": "Mouse Logitech",
                    "category": "accessori",
                    "quantity": 1
                }
            ]
        }
    ]

    for o in orders:
        es.index(index=INDEX_NAME, document=o)

    print("Dati inseriti")


# =========================
# MAIN
# =========================
if __name__ == "__main__":
    try:
        # Test connessione
        print("Verifico connessione a Elasticsearch...")
        info = es.info()
        print(f"✓ Connesso a Elasticsearch {info['version']['number']}")
        print(f"  Cluster: {info['cluster_name']}\n")
        
        # Esegui setup
        create_index()
        insert_data()
        print("\n✓ SETUP COMPLETATO CON SUCCESSO")
        
    except Exception as e:
        print(f"\n✗ ERRORE: {type(e).__name__}")
        print(f"  Messaggio: {e}")
        print("\nVerifica che:")
        print("  1. Docker sia avviato: docker ps | grep elasticsearch")
        print("  2. Elasticsearch sia raggiungibile: curl http://localhost:9200")
        import sys
        sys.exit(1)
