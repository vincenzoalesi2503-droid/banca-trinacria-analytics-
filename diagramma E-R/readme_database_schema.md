# 🏦 Banca Trinacria – Database Schema

Questo documento descrive lo **schema relazionale del database bancario** del progetto *Banca Trinacria*.

Lo schema è stato progettato per essere:
- realistico (contesto bancario italiano)
- normalizzato
- facilmente interrogabile per analisi SQL e BI
- adatto a progetti di **data analysis, credit risk e customer analytics**

---

## 🎯 Obiettivi dello schema

- Modellare clienti, conti e prodotti bancari
- Tracciare transazioni e prestiti
- Supportare analisi di rischio e comportamento
- Garantire integrità referenziale

---

## 🧱 Entità principali

### 👤 Clienti
Contiene le informazioni anagrafiche e demografiche dei clienti.

**Concetti chiave:**
- identificazione cliente
- dati personali e fiscali
- relazione 1‑N con conti e prestiti

---

### 🏦 Conti Correnti
Rappresenta i conti bancari associati ai clienti.

**Concetti chiave:**
- IBAN
- tipo di conto
- data di apertura
- saldo

Relazione:
- **Cliente 1 → N Conti**

---

### 💳 Transazioni
Traccia tutti i movimenti bancari.

**Concetti chiave:**
- importo
- data
- categoria
- tipo di operazione

Relazione:
- **Conto 1 → N Transazioni**

---

### 💼 Prestiti
Gestisce i prestiti concessi ai clienti.

**Concetti chiave:**
- importo
- durata
- tasso di interesse
- stato del prestito (performing / NPL)

Relazione:
- **Cliente 1 → N Prestiti**

---

## 🔗 Relazioni principali

- Cliente → Conti (1:N)
- Conto → Transazioni (1:N)
- Cliente → Prestiti (1:N)

Lo schema consente analisi incrociate su:
- comportamento transazionale
- esposizione creditizia
- rischio cliente

---

## 📐 Diagramma ER (Mermaid)

Il seguente diagramma può essere renderizzato direttamente su GitHub.

```mermaid
erDiagram
    CLIENTI ||--o{ CONTI : possiede
    CONTI ||--o{ TRANSAZIONI : genera
    CLIENTI ||--o{ PRESTITI : richiede

    CLIENTI {
        int cliente_id PK
        string nome
        string cognome
        date data_nascita
        string codice_fiscale
        string professione
        float reddito_annuo
    }

    CONTI {
        int conto_id PK
        string iban
        date data_apertura
        string tipo_conto
        float saldo
        int cliente_id FK
    }

    TRANSAZIONI {
        int transazione_id PK
        date data_transazione
        float importo
        string tipo_transazione
        string categoria
        int conto_id FK
    }

    PRESTITI {
        int prestito_id PK
        float importo
        int durata_mesi
        float tasso_interesse
        string stato_prestito
        int cliente_id FK
    }
```

---

## 📊 Analisi supportate

- Saldo e flussi per cliente
- Pattern di spesa
- Analisi NPL
- Segmentazione clienti
- KPI bancari per dashboard BI

---

## ⚠️ Disclaimer

Lo schema e i dati associati sono **interamente fittizi** e creati a scopo dimostrativo.

---

## 👤 Autore

**Vincenzo Alesi**  
Data Analyst

---

✨ Possibili estensioni:
- tabelle storiche (SCD)
- scoring clienti
- viste analitiche
- materialized views per BI

