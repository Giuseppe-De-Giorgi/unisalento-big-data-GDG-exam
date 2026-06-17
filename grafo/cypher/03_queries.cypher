// =================================================================
// QUERIES CYBER - VERSIONE GRAFICA CORRETTA
// =================================================================


// -----------------------------------------------------------------
// QUERY 1: Episodi di un ospite (GRAFO COMPLETO)
// -----------------------------------------------------------------
MATCH (o:Ospite {nome: "Luca Bianchi"})-[r:PARTECIPA]->(e:Episodio)
RETURN o, r, e;


// -----------------------------------------------------------------
// QUERY 2A: Podcast collegati tramite ospite condiviso
// (FORZA RELAZIONI VISIBILI)
// -----------------------------------------------------------------
MATCH (o:Ospite)-[r1:PARTECIPA]->(e1:Episodio),
      (o)-[r2:PARTECIPA]->(e2:Episodio),
      (p1:Podcast)-[r3:HA_EPISODIO]->(e1),
      (p2:Podcast)-[r4:HA_EPISODIO]->(e2)
WHERE p1.titolo <> p2.titolo
AND id(p1) < id(p2)
RETURN o, r1, e1, r2, e2, p1, r3, p2, r4;


// -----------------------------------------------------------------
// QUERY 2B: Podcast collegati tramite argomenti condivisi
// (FORZA RELAZIONI VISIBILI)
// -----------------------------------------------------------------
MATCH (p1:Podcast)-[r1:HA_EPISODIO]->(e1:Episodio)-[r2:TRATTA]->(a:Argomento),
      (p2:Podcast)-[r3:HA_EPISODIO]->(e2:Episodio)-[r4:TRATTA]->(a)
WHERE p1.titolo <> p2.titolo
AND id(p1) < id(p2)
RETURN p1, r1, e1, r2, a, r3, e2, r4, p2;