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
# UTILITY PRINT RISULTATI
# =========================
def print_results(title, response):
    print("\n" + "=" * 70)
    print(title)
    print("=" * 70)

    total = response["hits"]["total"]["value"]
    print(f"TOTAL ORDERS FOUND: {total}")
    print("-" * 70)

    for hit in response["hits"]["hits"]:
        source = hit["_source"]
        print(
            f"Order ID: {source['order_id']} | "
            f"Total: {source['total']} | "
            f"Date: {source['date']}"
        )


# =========================
# QUERY 1 - ORDINI PER EMAIL (INPUT MANUALE)
# =========================
def query_orders_by_email():
    email = input("\nInserisci email cliente: ")

    query = {
        "query": {
            "term": {
                "customer.email": email
            }
        }
    }

    response = es.search(index=INDEX_NAME, body=query)
    print_results(f"ORDINI PER CLIENTE: {email}", response)
    return response


# =========================
# QUERY 2 - ORDINI SAMSUNG
# =========================
def query_orders_samsung():
    query = {
        "query": {
            "nested": {
                "path": "products",
                "query": {
                    "bool": {
                        "should": [
                            {
                                "match": {
                                    "products.description": "samsung"
                                }
                            },
                            {
                                "match": {
                                    "products.name": "samsung"
                                }
                            }
                        ],
                        "minimum_should_match": 1
                    }
                }
            }
        }
    }

    response = es.search(index=INDEX_NAME, body=query)
    print_results("ORDINI CON PRODOTTI SAMSUNG", response)
    return response


# =========================
# QUERY 3 - ORDINI QLED
# =========================
def query_orders_qled():
    query = {
        "query": {
            "nested": {
                "path": "products",
                "query": {
                    "bool": {
                        "should": [
                            {
                                "match": {
                                    "products.description": "qled"
                                }
                            },
                            {
                                "match": {
                                    "products.name": "qled"
                                }
                            }
                        ],
                        "minimum_should_match": 1
                    }
                }
            }
        }
    }

    response = es.search(index=INDEX_NAME, body=query)
    print_results("ORDINI CON PRODOTTI QLED", response)
    return response


# =========================
# MAIN
# =========================
if __name__ == "__main__":
    query_orders_by_email()
    query_orders_samsung()
    query_orders_qled()