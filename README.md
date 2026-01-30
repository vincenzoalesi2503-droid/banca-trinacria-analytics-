# Banca Trinacria - Banking Analytics Portfolio

> Progetto completo di data analytics bancario: generazione dati, database SQL Server, analisi Python e Machine Learning

---

##  Cosa Troverai

-  **50.000 clienti** con dati italiani realistici (IBAN, Codice Fiscale)
-  **Database SQL Server** completo (12 tabelle normalizzate)
-  **100.000+ transazioni** (scalabile a milioni)
-  **3 Jupyter Notebooks** con analisi complete
-  **Machine Learning** per predizione NPL (85% accuracy)
-  **Customer Segmentation** con K-Means clustering

##  Quick Start

### 1. Scarica e Installa

```bash
# Clona il repository
git clone https://github.com/[username]/banca-trinacria-analytics.git
cd banca-trinacria-analytics

# Installa dipendenze Python
pip install -r requirements.txt
```

### 2. Genera i Dati (2 minuti)

```bash
cd scripts
python generate_data.py
```

Output: CSV con 50K clienti, 75K conti, 100K transazioni, 15K prestiti

### 3. Carica in SQL Server (5 minuti)

Apri `scripts/database.sql` in SQL Server e esegui tutto.

### 4. Analizza con Python

```bash
cd notebooks
jupyter notebook
```

Apri i 3 notebook in ordine.

---

##  Struttura 

```
banca-trinacria-analytics/
│
├── README.md                    # Questo file
├── requirements.txt             # Dipendenze Python
│
├── scripts/
│   ├── generate_data.py         # Genera tutti i dati CSV
│   └── database.sql             # Crea e carica database
│
├── notebooks/
│   ├── 1_Analisi_Esplorativa.ipynb
│   ├── 2_Credit_Risk_ML.ipynb
│   └── 3_Customer_Segmentation.ipynb
│
├── data/
│   └── (CSV generati automaticamente)
│
└── docs/
    └── Guida_Completa.pdf       # Documentazione estesa
```

---

##  Risultati Chiave

### Credit Risk Analysis
- **NPL Ratio**: 8.0% (in linea con target bancario italiano)
- **Modello ML**: Random Forest con 85% accuracy
- **Early Warning**: Identifica prestiti a rischio con anticipo

### Customer Insights
- **Segmentazione**: 4 cluster (High Value, Core, Low Activity, High Risk)
- **RFM Analysis**: Champions generano 40% del valore
- **Digital Adoption**: 65% transazioni online/mobile

### Fraud Detection
- **Detection Rate**: 0.2% transazioni sospette
- **Pattern Analysis**: Importi anomali e frequenze sospette

---

##  Tecnologie

| Categoria | Tool |
|-----------|------|
| **Database** | SQL Server |
| **Analisi** | Python, Pandas, NumPy |
| **Machine Learning** | Scikit-learn, Random Forest |
| **Visualization** | Matplotlib, Seaborn |
| **Notebook** | Jupyter |

---

##  Dataset Scalabile

Il progetto è pensato per crescere:

| Clienti | Transazioni | Tempo Generazione | DB Size |
|---------|-------------|-------------------|---------|
| 50K | 100K | 1 min | ~100MB |
| 50K | 1M | 3 min | ~650MB |
| 50K | 10M | 30 min | ~5GB |

Modifica `NUM_TRANSAZIONI` in `generate_data.py` per scalare.

---

##  Documentazione

Guida completa in `docs/Guida_Completa.pdf` con:
- Setup dettagliato
- Spiegazione codice
- Interpretazione risultati
- Best practices

---

##  Autore

**Vincenzo Alesi** - Data Analyst

📧 Email: vincenzoalesi2503@gmail.com  
💼 LinkedIn: https://www.linkedin.com/in/vincenzo-alesi/
📍 Sicilia, Italia

---

##  Licenza

MIT License - Progetto portfolio open source

---

##  Support

Se trovi utile questo progetto, lascia una stella! ⭐

Il dataset è completamente fittizio e generato per scopi dimostrativi.

---

**Versione**: 1.0 | **Status**:  Production Ready
