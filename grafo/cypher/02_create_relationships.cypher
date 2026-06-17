// =================================================================
// 02_CREATE_RELATIONSHIPS.CYPHER (VERSIONE CORRETTA)
// Collega i nodi esistenti creando le relazioni del grafo
// =================================================================

// 1. RECUPERO DI TUTTI I NODI ESISTENTI
MATCH (a:Autore {nome: "Marco Rossi"})
MATCH (p1:Podcast {titolo: "Tech Talks"})
MATCH (p2:Podcast {titolo: "Sport Inside"})
MATCH (e1:Episodio {numero: 1})
MATCH (e2:Episodio {numero: 2})
MATCH (e3:Episodio {numero: 3})
MATCH (e4:Episodio {numero: 4})
MATCH (o1:Ospite {nome: "Luca Bianchi"})
MATCH (o2:Ospite {nome: "Sara Verdi"})
MATCH (arg1:Argomento {nome_argomento: "Intelligenza Artificiale"})
MATCH (arg2:Argomento {nome_argomento: "Data Science"})
MATCH (arg3:Argomento {nome_argomento: "Calcio"})
MATCH (arg4:Argomento {nome_argomento: "Sicurezza Informatica"})

// 2. CREAZIONE DELLE RELAZIONI
// Collegamento Autore -> Podcast
MERGE (a)-[:CONDUCE]->(p1)
MERGE (a)-[:CONDUCE]->(p2)

// Collegamento Podcast -> Episodi
MERGE (p1)-[:HA_EPISODIO]->(e1)
MERGE (p1)-[:HA_EPISODIO]->(e2)
MERGE (p1)-[:HA_EPISODIO]->(e4)
MERGE (p2)-[:HA_EPISODIO]->(e3)

// Collegamento Ospiti -> Episodi
MERGE (o1)-[:PARTECIPA]->(e1)
MERGE (o1)-[:PARTECIPA]->(e3) // Luca Bianchi partecipa sia a Tech Talks (Ep. 1) che a Sport Inside (Ep. 3)
MERGE (o2)-[:PARTECIPA]->(e2)

// Collegamento Episodi -> Argomenti
MERGE (e1)-[:TRATTA]->(arg1)
MERGE (e2)-[:TRATTA]->(arg2)
MERGE (e3)-[:TRATTA]->(arg3)
MERGE (e4)-[:TRATTA]->(arg4)

// Collegamento per Tema Simile (L'episodio 3 di Sport tratta anche Data Science)
MERGE (e3)-[:TRATTA]->(arg2);