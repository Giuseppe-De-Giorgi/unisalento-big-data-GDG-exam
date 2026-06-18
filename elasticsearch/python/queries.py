"""
1. Ricerca ordini per email cliente (input dinamico)
2. Aggregazione categorie prodotti più vendute
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
# QUERY 1
# =========================
def search_orders_by_email(email):

    print("\n" + "=" * 60)
    print(f"ORDINI PER CLIENTE: {email}")
    print("=" * 60)

    query = {
        "query": {
            "term": {
                "customer.email": email
            }
        }
    }

    response = es.search(index=INDEX_NAME, **query)
    hits = response["hits"]["hits"]

    # CASO NESSUN RISULTATO
    if not hits:
        print("Nessun ordine trovato per questa email.")
        return

    for i, hit in enumerate(hits, 1):
        source = hit["_source"]

        print(f"\nOrdine #{i}")
        print(f"ID ordine: {source['order_id']}")
        print(f"Data: {source['date']}")
        print(f"Totale: {source['total']}")
        print("-" * 40)


# =========================
# QUERY 2
# =========================
def top_categories():

    print("\n" + "=" * 60)
    print("CATEGORIE PIÙ VENDUTE")
    print("=" * 60)

    query = {
        "size": 0,
        "aggs": {
            "categories": {
                "nested": {
                    "path": "products"
                },
                "aggs": {
                    "by_category": {
                        "terms": {
                            "field": "products.category",
                            "size": 10
                        },
                        "aggs": {
                            "total_quantity": {
                                "sum": {
                                    "field": "products.quantity"
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    response = es.search(index=INDEX_NAME, **query)

    buckets = response["aggregations"]["categories"]["by_category"]["buckets"]

    for b in buckets:
        print(f"{b['key']} -> quantità totale: {b['total_quantity']['value']}")


# =========================
# MAIN
# =========================
if __name__ == "__main__":

    # 👉 INPUT UTENTE DA TERMINALE
    email_input = input("\nInserisci email cliente: ").strip()

    if email_input == "":
        print("Email non valida")
    else:
        search_orders_by_email(email_input)

    top_categories()