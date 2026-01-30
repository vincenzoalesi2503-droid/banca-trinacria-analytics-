-- =============================================
-- BANCA TRINACRIA - SQL SERVER DATABASE
-- Script 02: Creazione Tabelle
-- =============================================

USE BancaTrinacria;
GO

-- =============================================
-- TABELLA: FILIALI
-- =============================================

CREATE TABLE dbo.FILIALI (
    filiale_id INT NOT NULL,
    codice_filiale VARCHAR(10) NOT NULL,
    nome_filiale VARCHAR(255) NOT NULL,
    indirizzo VARCHAR(255),
    comune VARCHAR(100),
    provincia CHAR(2),
    cap CHAR(5),
    telefono VARCHAR(20),
    email VARCHAR(255),
    tipo_filiale VARCHAR(30),
    numero_dipendenti INT,
    data_apertura DATE,
    stato VARCHAR(20) DEFAULT 'Attiva',
    created_at DATETIME2 DEFAULT GETDATE(),
    updated_at DATETIME2 DEFAULT GETDATE(),
    
    CONSTRAINT PK_Filiali PRIMARY KEY CLUSTERED (filiale_id),
    CONSTRAINT UK_Filiali_Codice UNIQUE (codice_filiale),
    CONSTRAINT CK_Filiali_Provincia CHECK (provincia IN ('PA','CT','ME','SR','TP','AG','RG','CL')),
    CONSTRAINT CK_Filiali_Stato CHECK (stato IN ('Attiva','Chiusa'))
);
GO

CREATE NONCLUSTERED INDEX IX_Filiali_Provincia ON dbo.FILIALI(provincia);
CREATE NONCLUSTERED INDEX IX_Filiali_Stato ON dbo.FILIALI(stato);
GO

-- =============================================
-- TABELLA: DIPENDENTI
-- =============================================

CREATE TABLE dbo.DIPENDENTI (
    dipendente_id INT NOT NULL,
    matricola VARCHAR(20) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    cognome VARCHAR(100) NOT NULL,
    email VARCHAR(255),
    telefono VARCHAR(20),
    filiale_id INT NOT NULL,
    ruolo VARCHAR(50) NOT NULL,
    data_assunzione DATE,
    data_cessazione DATE,
    stato VARCHAR(20) DEFAULT 'Attivo',
    created_at DATETIME2 DEFAULT GETDATE(),
    updated_at DATETIME2 DEFAULT GETDATE(),
    
    CONSTRAINT PK_Dipendenti PRIMARY KEY CLUSTERED (dipendente_id),
    CONSTRAINT UK_Dipendenti_Matricola UNIQUE (matricola),
    CONSTRAINT UK_Dipendenti_Email UNIQUE (email),
    CONSTRAINT FK_Dipendenti_Filiale FOREIGN KEY (filiale_id) REFERENCES dbo.FILIALI(filiale_id),
    CONSTRAINT CK_Dipendenti_Ruolo CHECK (ruolo IN ('Direttore','Gestore','Operatore','Cassiere')),
    CONSTRAINT CK_Dipendenti_Stato CHECK (stato IN ('Attivo','Cessato','Sospeso'))
);
GO

CREATE NONCLUSTERED INDEX IX_Dipendenti_Filiale ON dbo.DIPENDENTI(filiale_id);
CREATE NONCLUSTERED INDEX IX_Dipendenti_Ruolo ON dbo.DIPENDENTI(ruolo) WHERE ruolo = 'Gestore';
CREATE NONCLUSTERED INDEX IX_Dipendenti_Stato ON dbo.DIPENDENTI(stato);
GO

-- =============================================
-- TABELLA: CLIENTI
-- =============================================

CREATE TABLE dbo.CLIENTI (
    cliente_id INT NOT NULL,
    codice_fiscale CHAR(16) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    cognome VARCHAR(100) NOT NULL,
    data_nascita DATE,
    genere CHAR(1),
    email VARCHAR(255),
    telefono VARCHAR(20),
    indirizzo VARCHAR(255),
    comune VARCHAR(100),
    provincia CHAR(2),
    cap CHAR(5),
    segmento VARCHAR(20) NOT NULL,
    reddito_annuo DECIMAL(12,2),
    professione VARCHAR(100),
    credit_score INT,
    stato_cliente VARCHAR(20) DEFAULT 'Attivo',
    filiale_id INT NOT NULL,
    gestore_id INT,
    data_acquisizione DATE,
    created_at DATETIME2 DEFAULT GETDATE(),
    updated_at DATETIME2 DEFAULT GETDATE(),
    
    CONSTRAINT PK_Clienti PRIMARY KEY CLUSTERED (cliente_id),
    CONSTRAINT UK_Clienti_CodiceFiscale UNIQUE (codice_fiscale),
    CONSTRAINT FK_Clienti_Filiale FOREIGN KEY (filiale_id) REFERENCES dbo.FILIALI(filiale_id),
    CONSTRAINT FK_Clienti_Gestore FOREIGN KEY (gestore_id) REFERENCES dbo.DIPENDENTI(dipendente_id),
    CONSTRAINT CK_Clienti_Genere CHECK (genere IN ('M','F','A')),
    CONSTRAINT CK_Clienti_Segmento CHECK (segmento IN ('Retail','Private','Business')),
    CONSTRAINT CK_Clienti_CreditScore CHECK (credit_score BETWEEN 300 AND 850),
    CONSTRAINT CK_Clienti_Stato CHECK (stato_cliente IN ('Attivo','Sospeso','Chiuso'))
);
GO

CREATE NONCLUSTERED INDEX IX_Clienti_CodiceFiscale ON dbo.CLIENTI(codice_fiscale);
CREATE NONCLUSTERED INDEX IX_Clienti_Filiale ON dbo.CLIENTI(filiale_id);
CREATE NONCLUSTERED INDEX IX_Clienti_Gestore ON dbo.CLIENTI(gestore_id);
CREATE NONCLUSTERED INDEX IX_Clienti_Segmento ON dbo.CLIENTI(segmento);
CREATE NONCLUSTERED INDEX IX_Clienti_CreditScore ON dbo.CLIENTI(credit_score);
CREATE NONCLUSTERED INDEX IX_Clienti_Email ON dbo.CLIENTI(email);
GO

-- =============================================
-- TABELLA: CONTI
-- =============================================

CREATE TABLE dbo.CONTI (
    conto_id INT NOT NULL,
    iban VARCHAR(27) NOT NULL,
    cliente_id INT NOT NULL,
    tipo_conto VARCHAR(20) NOT NULL,
    saldo_disponibile DECIMAL(15,2) NOT NULL DEFAULT 0,
    saldo_contabile DECIMAL(15,2) NOT NULL DEFAULT 0,
    valuta CHAR(3) DEFAULT 'EUR',
    fido_accordato DECIMAL(12,2) DEFAULT 0,
    tasso_interesse DECIMAL(5,2) DEFAULT 0,
    data_apertura DATE NOT NULL,
    data_chiusura DATE,
    stato_conto VARCHAR(20) DEFAULT 'Attivo',
    filiale_id INT NOT NULL,
    created_at DATETIME2 DEFAULT GETDATE(),
    updated_at DATETIME2 DEFAULT GETDATE(),
    
    CONSTRAINT PK_Conti PRIMARY KEY CLUSTERED (conto_id),
    CONSTRAINT UK_Conti_IBAN UNIQUE (iban),
    CONSTRAINT FK_Conti_Cliente FOREIGN KEY (cliente_id) REFERENCES dbo.CLIENTI(cliente_id),
    CONSTRAINT FK_Conti_Filiale FOREIGN KEY (filiale_id) REFERENCES dbo.FILIALI(filiale_id),
    CONSTRAINT CK_Conti_TipoConto CHECK (tipo_conto IN ('Ordinario','Premium','Business','Junior')),
    CONSTRAINT CK_Conti_Valuta CHECK (valuta = 'EUR'),
    CONSTRAINT CK_Conti_Stato CHECK (stato_conto IN ('Attivo','Dormiente','Chiuso','Bloccato'))
);
GO

CREATE NONCLUSTERED INDEX IX_Conti_IBAN ON dbo.CONTI(iban);
CREATE NONCLUSTERED INDEX IX_Conti_Cliente ON dbo.CONTI(cliente_id);
CREATE NONCLUSTERED INDEX IX_Conti_Stato ON dbo.CONTI(stato_conto);
CREATE NONCLUSTERED INDEX IX_Conti_TipoConto ON dbo.CONTI(tipo_conto);
GO

-- =============================================
-- TABELLA: TIPO_TRANSAZIONE
-- =============================================

CREATE TABLE dbo.TIPO_TRANSAZIONE (
    tipo_id INT NOT NULL,
    codice VARCHAR(10) NOT NULL,
    descrizione VARCHAR(255) NOT NULL,
    categoria VARCHAR(50),
    flag_commissione BIT DEFAULT 0,
    importo_commissione DECIMAL(8,2) DEFAULT 0,
    
    CONSTRAINT PK_TipoTransazione PRIMARY KEY CLUSTERED (tipo_id),
    CONSTRAINT UK_TipoTransazione_Codice UNIQUE (codice)
);
GO

-- =============================================
-- TABELLA: TRANSAZIONI
-- =============================================

CREATE TABLE dbo.TRANSAZIONI (
    transazione_id BIGINT NOT NULL,
    conto_id INT NOT NULL,
    tipo_transazione_id INT,
    data_transazione DATETIME2 NOT NULL,
    importo DECIMAL(15,2) NOT NULL,
    tipo_movimento VARCHAR(10) NOT NULL,
    descrizione VARCHAR(500),
    categoria VARCHAR(50),
    controparte VARCHAR(255),
    iban_controparte VARCHAR(27),
    canale VARCHAR(20),
    saldo_dopo DECIMAL(15,2),
    stato VARCHAR(20) DEFAULT 'Completata',
    flag_sospetta BIT DEFAULT 0,
    note TEXT,
    created_at DATETIME2 DEFAULT GETDATE(),
    
    CONSTRAINT PK_Transazioni PRIMARY KEY CLUSTERED (transazione_id),
    CONSTRAINT FK_Transazioni_Conto FOREIGN KEY (conto_id) REFERENCES dbo.CONTI(conto_id),
    CONSTRAINT FK_Transazioni_Tipo FOREIGN KEY (tipo_transazione_id) REFERENCES dbo.TIPO_TRANSAZIONE(tipo_id),
    CONSTRAINT CK_Transazioni_TipoMovimento CHECK (tipo_movimento IN ('Dare','Avere')),
    CONSTRAINT CK_Transazioni_Canale CHECK (canale IN ('Filiale','ATM','Online','Mobile','POS')),
    CONSTRAINT CK_Transazioni_Stato CHECK (stato IN ('Completata','Pending','Rifiutata'))
)
-- Partizionamento per data (opzionale per grandi volumi)
-- PARTITION BY RANGE (data_transazione) ...
GO

CREATE NONCLUSTERED INDEX IX_Transazioni_Conto ON dbo.TRANSAZIONI(conto_id);
CREATE NONCLUSTERED INDEX IX_Transazioni_Data ON dbo.TRANSAZIONI(data_transazione DESC);
CREATE NONCLUSTERED INDEX IX_Transazioni_Importo ON dbo.TRANSAZIONI(importo);
CREATE NONCLUSTERED INDEX IX_Transazioni_Sospette ON dbo.TRANSAZIONI(flag_sospetta) WHERE flag_sospetta = 1;
CREATE NONCLUSTERED INDEX IX_Transazioni_Categoria ON dbo.TRANSAZIONI(categoria);
CREATE NONCLUSTERED INDEX IX_Transazioni_Conto_Data ON dbo.TRANSAZIONI(conto_id, data_transazione DESC);
GO

-- =============================================
-- TABELLA: PRESTITI
-- =============================================

CREATE TABLE dbo.PRESTITI (
    prestito_id INT NOT NULL,
    codice_pratica VARCHAR(50) NOT NULL,
    cliente_id INT NOT NULL,
    tipo_prestito VARCHAR(30) NOT NULL,
    importo_erogato DECIMAL(15,2) NOT NULL,
    importo_residuo DECIMAL(15,2),
    tasso_interesse DECIMAL(5,2) NOT NULL,
    durata_mesi INT NOT NULL,
    rata_mensile DECIMAL(12,2),
    data_erogazione DATE,
    data_scadenza DATE,
    prossima_scadenza_rata DATE,
    finalita VARCHAR(100),
    garanzie TEXT,
    stato_prestito VARCHAR(20) DEFAULT 'In corso',
    classificazione VARCHAR(20) DEFAULT 'Performing',
    giorni_ritardo INT DEFAULT 0,
    filiale_id INT NOT NULL,
    created_at DATETIME2 DEFAULT GETDATE(),
    updated_at DATETIME2 DEFAULT GETDATE(),
    
    CONSTRAINT PK_Prestiti PRIMARY KEY CLUSTERED (prestito_id),
    CONSTRAINT UK_Prestiti_CodicePratica UNIQUE (codice_pratica),
    CONSTRAINT FK_Prestiti_Cliente FOREIGN KEY (cliente_id) REFERENCES dbo.CLIENTI(cliente_id),
    CONSTRAINT FK_Prestiti_Filiale FOREIGN KEY (filiale_id) REFERENCES dbo.FILIALI(filiale_id),
    CONSTRAINT CK_Prestiti_Tipo CHECK (tipo_prestito IN ('Personale','Mutuo','Auto','Aziendale')),
    CONSTRAINT CK_Prestiti_Stato CHECK (stato_prestito IN ('In corso','Estinto','Sofferenza')),
    CONSTRAINT CK_Prestiti_Classificazione CHECK (classificazione IN ('Performing','Past due','NPL'))
);
GO

CREATE NONCLUSTERED INDEX IX_Prestiti_Cliente ON dbo.PRESTITI(cliente_id);
CREATE NONCLUSTERED INDEX IX_Prestiti_Classificazione ON dbo.PRESTITI(classificazione);
CREATE NONCLUSTERED INDEX IX_Prestiti_Stato ON dbo.PRESTITI(stato_prestito);
CREATE NONCLUSTERED INDEX IX_Prestiti_DataScadenza ON dbo.PRESTITI(prossima_scadenza_rata);
CREATE NONCLUSTERED INDEX IX_Prestiti_NPL ON dbo.PRESTITI(classificazione, giorni_ritardo) WHERE classificazione = 'NPL';
GO

-- =============================================
-- TABELLA: RATE_PRESTITI
-- =============================================

CREATE TABLE dbo.RATE_PRESTITI (
    rata_id BIGINT NOT NULL IDENTITY(1,1),
    prestito_id INT NOT NULL,
    numero_rata INT NOT NULL,
    data_scadenza DATE NOT NULL,
    importo_rata DECIMAL(12,2) NOT NULL,
    quota_capitale DECIMAL(12,2) NOT NULL,
    quota_interessi DECIMAL(12,2) NOT NULL,
    data_pagamento DATE,
    importo_pagato DECIMAL(12,2),
    stato_rata VARCHAR(20) DEFAULT 'Da pagare',
    giorni_ritardo INT DEFAULT 0,
    created_at DATETIME2 DEFAULT GETDATE(),
    
    CONSTRAINT PK_RatePrestiti PRIMARY KEY CLUSTERED (rata_id),
    CONSTRAINT FK_RatePrestiti_Prestito FOREIGN KEY (prestito_id) REFERENCES dbo.PRESTITI(prestito_id) ON DELETE CASCADE,
    CONSTRAINT CK_RatePrestiti_Stato CHECK (stato_rata IN ('Da pagare','Pagata','Ritardo','Insolvente'))
);
GO

CREATE NONCLUSTERED INDEX IX_RatePrestiti_Prestito ON dbo.RATE_PRESTITI(prestito_id);
CREATE NONCLUSTERED INDEX IX_RatePrestiti_DataScadenza ON dbo.RATE_PRESTITI(data_scadenza);
CREATE NONCLUSTERED INDEX IX_RatePrestiti_Stato ON dbo.RATE_PRESTITI(stato_rata);
GO

-- =============================================
-- TABELLA: CARTE
-- =============================================

CREATE TABLE dbo.CARTE (
    carta_id INT NOT NULL,
    numero_carta VARCHAR(19) NOT NULL, -- Mascherato
    conto_id INT NOT NULL,
    cliente_id INT NOT NULL,
    tipo_carta VARCHAR(20) NOT NULL,
    circuito VARCHAR(20) NOT NULL,
    data_emissione DATE,
    data_scadenza DATE,
    cvv VARCHAR(4), -- Encrypted
    plafond DECIMAL(12,2) DEFAULT 0,
    disponibile DECIMAL(12,2) DEFAULT 0,
    speso_mese_corrente DECIMAL(12,2) DEFAULT 0,
    pin_hash VARCHAR(255), -- Hashed
    stato_carta VARCHAR(20) DEFAULT 'Attiva',
    contactless BIT DEFAULT 1,
    created_at DATETIME2 DEFAULT GETDATE(),
    updated_at DATETIME2 DEFAULT GETDATE(),
    
    CONSTRAINT PK_Carte PRIMARY KEY CLUSTERED (carta_id),
    CONSTRAINT UK_Carte_Numero UNIQUE (numero_carta),
    CONSTRAINT FK_Carte_Conto FOREIGN KEY (conto_id) REFERENCES dbo.CONTI(conto_id),
    CONSTRAINT FK_Carte_Cliente FOREIGN KEY (cliente_id) REFERENCES dbo.CLIENTI(cliente_id),
    CONSTRAINT CK_Carte_Tipo CHECK (tipo_carta IN ('Debito','Credito','Prepagata')),
    CONSTRAINT CK_Carte_Circuito CHECK (circuito IN ('Visa','Mastercard','Maestro')),
    CONSTRAINT CK_Carte_Stato CHECK (stato_carta IN ('Attiva','Bloccata','Scaduta','Smarrita'))
);
GO

CREATE NONCLUSTERED INDEX IX_Carte_Conto ON dbo.CARTE(conto_id);
CREATE NONCLUSTERED INDEX IX_Carte_Cliente ON dbo.CARTE(cliente_id);
CREATE NONCLUSTERED INDEX IX_Carte_Stato ON dbo.CARTE(stato_carta);
GO

-- =============================================
-- TABELLA: PRODOTTI_INVESTIMENTO
-- =============================================

CREATE TABLE dbo.PRODOTTI_INVESTIMENTO (
    prodotto_inv_id INT NOT NULL,
    cliente_id INT NOT NULL,
    tipo_prodotto VARCHAR(30) NOT NULL,
    codice_isin VARCHAR(12),
    nome_prodotto VARCHAR(255),
    importo_investito DECIMAL(15,2) NOT NULL,
    valore_attuale DECIMAL(15,2),
    rendimento_percentuale DECIMAL(8,4),
    data_sottoscrizione DATE,
    data_scadenza DATE,
    profilo_rischio VARCHAR(20),
    stato VARCHAR(20) DEFAULT 'Attivo',
    filiale_id INT NOT NULL,
    created_at DATETIME2 DEFAULT GETDATE(),
    updated_at DATETIME2 DEFAULT GETDATE(),
    
    CONSTRAINT PK_ProdottiInvestimento PRIMARY KEY CLUSTERED (prodotto_inv_id),
    CONSTRAINT FK_ProdottiInv_Cliente FOREIGN KEY (cliente_id) REFERENCES dbo.CLIENTI(cliente_id),
    CONSTRAINT FK_ProdottiInv_Filiale FOREIGN KEY (filiale_id) REFERENCES dbo.FILIALI(filiale_id),
    CONSTRAINT CK_ProdottiInv_Tipo CHECK (tipo_prodotto IN ('Deposito','Fondi','Obbligazioni','Azioni')),
    CONSTRAINT CK_ProdottiInv_Rischio CHECK (profilo_rischio IN ('Basso','Medio','Alto')),
    CONSTRAINT CK_ProdottiInv_Stato CHECK (stato IN ('Attivo','Scaduto','Riscattato'))
);
GO

CREATE NONCLUSTERED INDEX IX_ProdottiInv_Cliente ON dbo.PRODOTTI_INVESTIMENTO(cliente_id);
CREATE NONCLUSTERED INDEX IX_ProdottiInv_Tipo ON dbo.PRODOTTI_INVESTIMENTO(tipo_prodotto);
GO

-- =============================================
-- TABELLA: ALERT_FRODI
-- =============================================

CREATE TABLE dbo.ALERT_FRODI (
    alert_id BIGINT NOT NULL IDENTITY(1,1),
    transazione_id BIGINT,
    cliente_id INT NOT NULL,
    data_alert DATETIME2 DEFAULT GETDATE(),
    tipo_alert VARCHAR(50) NOT NULL,
    livello_rischio VARCHAR(20) NOT NULL,
    descrizione TEXT,
    verificato BIT DEFAULT 0,
    esito_verifica VARCHAR(30),
    operatore_id INT,
    data_verifica DATETIME2,
    note TEXT,
    created_at DATETIME2 DEFAULT GETDATE(),
    
    CONSTRAINT PK_AlertFrodi PRIMARY KEY CLUSTERED (alert_id),
    CONSTRAINT FK_AlertFrodi_Transazione FOREIGN KEY (transazione_id) REFERENCES dbo.TRANSAZIONI(transazione_id),
    CONSTRAINT FK_AlertFrodi_Cliente FOREIGN KEY (cliente_id) REFERENCES dbo.CLIENTI(cliente_id),
    CONSTRAINT FK_AlertFrodi_Operatore FOREIGN KEY (operatore_id) REFERENCES dbo.DIPENDENTI(dipendente_id),
    CONSTRAINT CK_AlertFrodi_Tipo CHECK (tipo_alert IN ('Importo anomalo','Frequenza','Geografico','Pattern')),
    CONSTRAINT CK_AlertFrodi_Livello CHECK (livello_rischio IN ('Basso','Medio','Alto','Critico')),
    CONSTRAINT CK_AlertFrodi_Esito CHECK (esito_verifica IN ('Falso positivo','Confermato','In analisi') OR esito_verifica IS NULL)
);
GO

CREATE NONCLUSTERED INDEX IX_AlertFrodi_Cliente ON dbo.ALERT_FRODI(cliente_id);
CREATE NONCLUSTERED INDEX IX_AlertFrodi_DataAlert ON dbo.ALERT_FRODI(data_alert DESC);
CREATE NONCLUSTERED INDEX IX_AlertFrodi_Verificato ON dbo.ALERT_FRODI(verificato) WHERE verificato = 0;
GO

-- =============================================
-- TABELLA: AUDIT_LOG
-- =============================================

CREATE TABLE dbo.AUDIT_LOG (
    log_id BIGINT NOT NULL IDENTITY(1,1),
    tabella_riferimento VARCHAR(100) NOT NULL,
    record_id INT NOT NULL,
    operazione VARCHAR(10) NOT NULL,
    utente_id INT,
    data_operazione DATETIME2 DEFAULT GETDATE(),
    valori_precedenti NVARCHAR(MAX), -- JSON
    valori_nuovi NVARCHAR(MAX), -- JSON
    ip_address VARCHAR(45),
    
    CONSTRAINT PK_AuditLog PRIMARY KEY CLUSTERED (log_id),
    CONSTRAINT CK_AuditLog_Operazione CHECK (operazione IN ('INSERT','UPDATE','DELETE'))
);
GO

CREATE NONCLUSTERED INDEX IX_AuditLog_Tabella ON dbo.AUDIT_LOG(tabella_riferimento);
CREATE NONCLUSTERED INDEX IX_AuditLog_Data ON dbo.AUDIT_LOG(data_operazione DESC);
CREATE NONCLUSTERED INDEX IX_AuditLog_Utente ON dbo.AUDIT_LOG(utente_id);

