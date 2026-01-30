# 🏦 Banca Trinacria – SQL Server Database

Questo repository contiene gli **script SQL Server** per la creazione e il popolamento di un **database bancario fittizio**, progettato per analisi dati, query SQL avanzate e progetti di Business Intelligence.

Il database è pensato per lavorare insieme ai dataset generati dai notebook Python del progetto *Banca Trinacria*.

---

## 🎯 Obiettivi

- Creare uno schema bancario realistico su **SQL Server**
- Importare dati simulati da file CSV
- Fornire una base solida per:
  - esercitazioni SQL
  - query analitiche
  - viste e stored procedure
  - dashboard BI

---

## 📂 File SQL inclusi

```
.
├── 01_sqlserver_create_database.sql   # Creazione database
├── 02_sqlserver_create_tables.sql     # Creazione tabelle e relazioni
├── 03_sqlserver_load_data.sql         # Caricamento dati da CSV
└── README_SQL.md
```

---

## 🧩 01 – Creazione Database

**File:** `01_sqlserver_create_database.sql`

Funzionalità:
- Creazione del database bancario
- Impostazione del contesto (`USE database`)
- Pronto per l’esecuzione su SQL Server

---

## 🧩 02 – Creazione Tabelle

**File:** `02_sqlserver_create_tables.sql`

Contenuto principale:
- Tabelle anagrafiche clienti
- Conti correnti
- Transazioni
- Prestiti
- Vincoli di integrità referenziale (PK / FK)

Lo schema è progettato per mantenere **coerenza logica** tra clienti, conti e movimenti.

---

## 🧩 03 – Caricamento Dati

**File:** `03_sqlserver_load_data.sql`

Funzionalità:
- Import dei dati da file **CSV**
- Utilizzo di `BULK INSERT` / `OPENROWSET`
- Allineamento con i file generati via Python

> ⚠️ Assicurati che i path dei file CSV siano corretti e accessibili da SQL Server

---

## ⚙️ Requisiti

- **Microsoft SQL Server** (2019 o superiore consigliato)
- **SQL Server Management Studio (SSMS)**
- File CSV già generati dal progetto Python

---

## ▶️ Ordine di esecuzione consigliato

1. Esegui `01_sqlserver_create_database.sql`
2. Esegui `02_sqlserver_create_tables.sql`
3. Verifica che i CSV siano presenti nel path corretto
4. Esegui `03_sqlserver_load_data.sql`

---

## 📊 Esempi di utilizzo

- Analisi transazioni per cliente
- Calcolo saldo medio per conto
- Analisi NPL su prestiti
- Identificazione pattern sospetti
- Creazione viste per BI

---

## ⚠️ Disclaimer

Tutti i dati caricati nel database sono **completamente fittizi**.

Il progetto è destinato esclusivamente a **scopi didattici, dimostrativi e di portfolio**.

---

## 👤 Autore

**Vincenzo Alesi**  
Data Analyst

---

✨ Estensioni possibili:
- aggiunta di **view** e **stored procedure**
- sezione *Data Dictionary*
- esempi di query SQL avanzate
- versione in inglese per GitHub internazionale

