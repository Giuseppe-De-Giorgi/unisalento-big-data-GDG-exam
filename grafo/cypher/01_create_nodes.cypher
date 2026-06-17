// =================================================================
// 01_CREATE_NODES.CYPHER
// Crea le entità (Autori, Podcast, Episodi, Ospiti e Argomenti)
// =================================================================

// 1. Creazione Autore
MERGE (a:Autore {nome: "Marco Rossi"})

// 2. Creazione Podcast (Categorie e lingue ben distinte)
MERGE (p1:Podcast {titolo: "Tech Talks", categoria: "Tecnologia", lingua: "IT"})
MERGE (p2:Podcast {titolo: "Sport Inside", categoria: "Sport", lingua: "IT"})

// 3. Creazione Episodi (Numeri e titoli unici)
MERGE (e1:Episodio {numero: 1, titolo: "AI e futuro", data_pubblicazione: "2025-01-10"})
MERGE (e2:Episodio {numero: 2, titolo: "Cloud e Big Data", data_pubblicazione: "2025-01-15"})
MERGE (e3:Episodio {numero: 3, titolo: "Calcio moderno", data_pubblicazione: "2025-01-20"})
MERGE (e4:Episodio {numero: 4, titolo: "Cybersecurity base", data_pubblicazione: "2025-01-25"})

// 4. Creazione Ospiti
MERGE (o1:Ospite {nome: "Luca Bianchi"})
MERGE (o2:Ospite {nome: "Sara Verdi"})

// 5. Creazione Argomenti
MERGE (arg1:Argomento {nome_argomento: "Intelligenza Artificiale"})
MERGE (arg2:Argomento {nome_argomento: "Data Science"})
MERGE (arg3:Argomento {nome_argomento: "Calcio"})
MERGE (arg4:Argomento {nome_argomento: "Sicurezza Informatica"})