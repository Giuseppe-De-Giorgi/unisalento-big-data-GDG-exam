// =================================================================
// Interrogazioni richieste dalla traccia del progetto
// =================================================================

// -----------------------------------------------------------------
// QUERY 1: Trovare tutti gli episodi in cui compare un certo ospite
// -----------------------------------------------------------------
// Questa query estrae l'ospite "Luca Bianchi", le sue relazioni e gli episodi correlati.
MATCH (o:Ospite {nome: "Luca Bianchi"})-[r:PARTECIPA]->(e:Episodio)
RETURN o, r, e;


// -----------------------------------------------------------------
// QUERY 2A: Individuare i podcast collegati perché CONDIVIDONO OSPITI
// -----------------------------------------------------------------
// Trova due podcast diversi che hanno a catalogo episodi in cui ha partecipato lo stesso ospite.
MATCH (p1:Podcast)-[r1:HA_EPISODIO]->(e1:Episodio)<-[r2:PARTECIPA]-(o:Ospite)-[r3:PARTECIPA]->(e2:Episodio)<-[r4:HA_EPISODIO]-(p2:Podcast)
WHERE p1.titolo <> p2.titolo
RETURN p1, r1, e1, r2, o, r3, e2, r4, p2;


// -----------------------------------------------------------------
// QUERY 2B: Individuare i podcast collegati perché TRATTANO STESSI ARGOMENTI
// -----------------------------------------------------------------
// Trova due podcast diversi i cui episodi convergono sullo stesso identico argomento target.
MATCH (p1:Podcast)-[r1:HA_EPISODIO]->(e1:Episodio)-[r2:TRATTA]->(arg:Argomento)<-[r3:TRATTA]-(e2:Episodio)<-[r4:HA_EPISODIO]-(p2:Podcast)
WHERE p1.titolo <> p2.titolo
RETURN p1, r1, e1, r2, arg, r3, e2, r4, p2;