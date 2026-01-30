# 🏦 Banca Trinacria – Banking Data Generator

Generatore di **dati bancari fittizi ma realistici**, pensato per scopi di **portfolio**, **analisi dati**, **SQL**, **Business Intelligence** e **machine learning**.

Il progetto simula un ecosistema bancario completo, coerente con il **contesto italiano**, garantendo riproducibilità e realismo senza l’uso di dati sensibili reali.

---

## 🎯 Obiettivi del progetto

- Simulare un ambiente bancario end-to-end
- Generare dataset realistici e coerenti tra loro
- Fornire dati pronti per:
  - Analisi esplorativa (EDA)
  - Query SQL
  - Dashboard BI
  - Modelli di rischio / frodi
- Rispettare standard italiani (CF, IBAN, date, formati)

---

## 📂 Struttura del progetto

```
.
├── generate_banking_data.ipynb        # Parte 1 – Anagrafica e dati base
├── generate_banking_data_part2.ipynb  # Parte 2 – Conti, transazioni e prestiti
├── data/
│   └── csv_output/                    # CSV generati dagli script
└── README.md
```

---

## 🧩 Notebook 1 – `generate_banking_data.ipynb`

### Contenuto
Questo notebook genera i **dati master** della banca:

- Clienti
- Anagrafica personale
- Dati demografici
- Informazioni fiscali e identificative

### Caratteristiche principali

- Dati casuali ma realistici
- Seed fissati per la riproducibilità
- Coerenza logica tra età, date, professione e reddito
- Output in formato CSV

### Output principali

- `clienti.csv`
- `anagrafica_clienti.csv`
- Altri file di supporto per la Parte 2

---

## 🧩 Notebook 2 – `generate_banking_data_part2.ipynb`

> ⚠️ **Dipende dai CSV generati nella Parte 1**

### Contenuto

Questo notebook estende il modello dati con:

- Conti correnti
- Transazioni bancarie
- Prestiti
- Classificazione NPL
- Simulazione frodi

### Parametri chiave

- Periodo simulato: **2015 – 2024**
- NPL Ratio: **8%**
- Fraud Rate: **0.2%**

### Output principali

- `conti_correnti.csv`
- `transazioni.csv`
- `prestiti.csv`

---

## ⚙️ Requisiti

- Python **3.9+**
- Librerie principali:
  - `pandas`
  - `numpy`
  - `datetime`
  - `pathlib`

Installazione rapida:

```bash
pip install pandas numpy
```

---

## ▶️ Come eseguire il progetto

1. Clona il repository
2. Esegui **prima** `generate_banking_data.ipynb`
3. Verifica la creazione dei CSV nella cartella di output
4. Esegui `generate_banking_data_part2.ipynb`

> 📌 Assicurati che il path di output (`DATA_DIR`) sia corretto per il tuo ambiente

---

## 📊 Possibili utilizzi

- Query SQL avanzate
- Dashboard (Power BI / Tableau)
- Analisi comportamentale clienti
- Credit risk & NPL analysis
- Anomaly & fraud detection

---

## ⚠️ Disclaimer

Tutti i dati sono **completamente fittizi** e generati artificialmente.

Il progetto è destinato **esclusivamente a scopi didattici e dimostrativi**.

---

## 👤 Autore

**Vincenzo Alesi**  
Data Analyst

---

✨ Se vuoi, posso:
- adattare il README a uno stile più *corporate* o più *portfolio*
- aggiungere esempi di query SQL
- scrivere una sezione *Data Dictionary*