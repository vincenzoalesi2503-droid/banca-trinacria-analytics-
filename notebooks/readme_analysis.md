# 📊 Banca Trinacria – Data Analysis Notebooks

Questa sezione del progetto contiene i **notebook di analisi dati** sviluppati a partire dal database e dai dataset del progetto *Banca Trinacria*.

I notebook sono pensati per dimostrare competenze pratiche di **EDA**, **credit risk analysis** e **customer segmentation**, con un approccio tipico da **Data Analyst / BI Analyst**.

---

## 🎯 Obiettivi

- Analizzare dati bancari realistici end-to-end
- Estrarre insight utili per il business
- Simulare casi d’uso reali del settore bancario
- Dimostrare capacità di analisi, visualizzazione e interpretazione

---

## 📂 Notebook inclusi

```
.
├── 01_exploratory_analysis.ipynb      # Analisi esplorativa dei dati
├── 02_credit_risk_analysis.ipynb      # Analisi rischio di credito
├── 03_customer_segmentation.ipynb     # Segmentazione clienti
└── README_Analysis.md
```

---

## 🧩 01 – Exploratory Data Analysis (EDA)

**File:** `01_exploratory_analysis.ipynb`

### Obiettivo
Comprendere la struttura dei dati e individuare pattern iniziali.

### Analisi svolte
- Distribuzione clienti e conti
- Analisi delle transazioni nel tempo
- Indicatori di comportamento finanziario
- Individuazione outlier e anomalie

### Output
- Statistiche descrittive
- Visualizzazioni esplorative
- Prime ipotesi di business

---

## 🧩 02 – Credit Risk Analysis

**File:** `02_credit_risk_analysis.ipynb`

### Obiettivo
Analizzare il **rischio di credito** e i prestiti non performing (NPL).

### Analisi svolte
- Distribuzione prestiti performing vs NPL
- Analisi NPL per:
  - fascia di reddito
  - età cliente
  - importo del prestito
- Indicatori di rischio

### Output
- KPI di rischio credito
- Insight per supportare decisioni di credito

---

## 🧩 03 – Customer Segmentation

**File:** `03_customer_segmentation.ipynb`

### Obiettivo
Segmentare i clienti in gruppi omogenei per comportamento e valore.

### Analisi svolte
- Feature engineering su clienti e conti
- Normalizzazione variabili
- Clustering (es. K-Means)
- Profilazione dei cluster

### Output
- Segmenti clienti interpretabili
- Profili comportamentali
- Spunti per marketing e cross-selling

---

## ⚙️ Requisiti

- Python **3.9+**
- Librerie principali:
  - `pandas`
  - `numpy`
  - `matplotlib` / `seaborn`
  - `scikit-learn`

---

## ▶️ Ordine consigliato di lettura

1. `01_exploratory_analysis.ipynb`
2. `02_credit_risk_analysis.ipynb`
3. `03_customer_segmentation.ipynb`

> 📌 I notebook assumono che i dati siano già disponibili (CSV o database SQL)

---

## 📈 Valore per il business

- Supporto decisioni di credito
- Migliore comprensione del comportamento clienti
- Identificazione segmenti ad alto valore
- Base per modelli predittivi futuri

---

## ⚠️ Disclaimer

I dati utilizzati sono **interamente fittizi** e creati a scopo dimostrativo.

---

## 👤 Autore

**Vincenzo Alesi**  
Data Analyst

---

✨ Possibili estensioni:
- modelli predittivi (default / churn)
- dashboard BI collegate ai risultati
- confronto tra cluster nel tempo

