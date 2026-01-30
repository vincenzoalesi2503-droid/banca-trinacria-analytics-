-- =============================================
-- BANCA TRINACRIA - SQL SERVER DATABASE
-- Script 03: Caricamento Dati da CSV
-- =============================================
-- Importazione tramite BULK INSERT
-- Prerequisito: CSV generati da script Python
-- =============================================

USE BancaTrinacria;
GO

-- Configurazione
SET NOCOUNT ON;
DECLARE @DataPath NVARCHAR(500) = 'C:\Users\Vincenzo\Desktop\Banca\Python\data\csv_output'; 
GO

-- =============================================
-- FASE 1: CARICAMENTO TIPO_TRANSAZIONE (Lookup)
-- =============================================

INSERT INTO dbo.TIPO_TRANSAZIONE (tipo_id, codice, descrizione, categoria, flag_commissione, importo_commissione)
VALUES
    (1, 'BON', 'Bonifico SEPA', 'Bancaria', 1, 1.50),
    (2, 'RID', 'Addebito diretto', 'Bancaria', 0, 0.00),
    (3, 'ATM', 'Prelievo bancomat', 'Bancaria', 0, 0.00),
    (4, 'POS', 'Pagamento POS', 'Commerciale', 0, 0.00),
    (5, 'F24', 'Pagamento F24', 'Bancaria', 0, 0.00),
    (6, 'MAV', 'Pagamento MAV', 'Bancaria', 1, 1.00),
    (7, 'CBL', 'Bollettino postale', 'Bancaria', 1, 2.00),
    (8, 'SDD', 'Addebito SEPA', 'Bancaria', 0, 0.00),
    (9, 'CHK', 'Assegno', 'Bancaria', 1, 1.50),
    (10, 'TRF', 'Giroconto', 'Bancaria', 0, 0.00);

-- =============================================
-- FASE 2: CARICAMENTO FILIALI
-- =============================================

DECLARE @DataPath NVARCHAR(500) = 'C:\Users\Vincenzo\Desktop\Banca\Python\data\csv_output'; 

BULK INSERT dbo.FILIALI
FROM 'C:\Users\Vincenzo\Desktop\Banca\Python\data\csv_output\filiali.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    CODEPAGE = '65001' -- UTF-8
);

-- =============================================
-- FASE 3: CARICAMENTO DIPENDENTI
-- =============================================

BULK INSERT dbo.DIPENDENTI
FROM 'C:\Users\Vincenzo\Desktop\Banca\Python\data\csv_output\dipendenti.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    CODEPAGE = '65001'
);

-- =============================================
-- FASE 4: CARICAMENTO CLIENTI
-- =============================================

BULK INSERT dbo.CLIENTI
FROM 'C:\Users\Vincenzo\Desktop\Banca\Python\data\csv_output\clienti.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    BATCHSIZE = 10000,
    CODEPAGE = '65001'
);

-- =============================================
-- FASE 5: CARICAMENTO CONTI
-- =============================================

BULK INSERT dbo.CONTI
FROM 'C:\Users\Vincenzo\Desktop\Banca\Python\data\csv_output\conti.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    BATCHSIZE = 10000,
    CODEPAGE = '65001'
);

-- =============================================
-- FASE 6: CARICAMENTO TRANSAZIONI (CHUNKED)
-- =============================================

-- Opzione A: Caricamento diretto (per < 5M record)
BULK INSERT dbo.TRANSAZIONI
FROM 'C:\Users\Vincenzo\Desktop\Banca\Python\data\csv_output\transazioni.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    BATCHSIZE = 50000,
    CODEPAGE = '65001'
);

/*
-- Opzione B: Caricamento in batch (per volumi grandi > 5M)
-- Commentare Opzione A e decommentare questa sezione se necessario

-- Disabilita indici per velocità
ALTER INDEX ALL ON dbo.TRANSAZIONI DISABLE;

-- Carica dati
BULK INSERT dbo.TRANSAZIONI
FROM 'C:\BancaTrinacria\data\csv_output\transazioni.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    BATCHSIZE = 100000,
    ERRORFILE = 'C:\BancaTrinacria\logs\transazioni_errors.log',
    CODEPAGE = '65001'
);

-- Ricostruisci indici
ALTER INDEX ALL ON dbo.TRANSAZIONI REBUILD;
*/

DECLARE @TransCount BIGINT = (SELECT COUNT(*) FROM dbo.TRANSAZIONI);

-- =============================================
-- FASE 7: CARICAMENTO PRESTITI
-- =============================================

BULK INSERT dbo.PRESTITI
FROM 'C:\Users\Vincenzo\Desktop\Banca\Python\data\csv_output\prestiti.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    BATCHSIZE = 5000,
    CODEPAGE = '65001'
);


-- =============================================
-- FASE 8: AGGIORNAMENTO STATISTICHE
-- =============================================

UPDATE STATISTICS dbo.FILIALI WITH FULLSCAN;
UPDATE STATISTICS dbo.DIPENDENTI WITH FULLSCAN;
UPDATE STATISTICS dbo.CLIENTI WITH FULLSCAN;
UPDATE STATISTICS dbo.CONTI WITH FULLSCAN;
UPDATE STATISTICS dbo.TRANSAZIONI WITH FULLSCAN;
UPDATE STATISTICS dbo.PRESTITI WITH FULLSCAN;

-- =============================================
-- FASE 9: RIEPILOGO CARICAMENTO
-- =============================================

WITH Spazio AS (
    SELECT 
        OBJECT_NAME(object_id) AS Tabella,
        SUM(used_page_count) * 8 / 1024.0 AS SpazioMB
    FROM sys.dm_db_partition_stats
    WHERE object_id IN (
        OBJECT_ID('dbo.FILIALI'),
        OBJECT_ID('dbo.DIPENDENTI'),
        OBJECT_ID('dbo.CLIENTI'),
        OBJECT_ID('dbo.CONTI'),
        OBJECT_ID('dbo.TRANSAZIONI'),
        OBJECT_ID('dbo.PRESTITI')
    )
    GROUP BY object_id
),
RecordCount AS (
    SELECT 'FILIALI' AS Tabella, COUNT(*) AS Record FROM dbo.FILIALI
    UNION ALL SELECT 'DIPENDENTI', COUNT(*) FROM dbo.DIPENDENTI
    UNION ALL SELECT 'CLIENTI', COUNT(*) FROM dbo.CLIENTI
    UNION ALL SELECT 'CONTI', COUNT(*) FROM dbo.CONTI
    UNION ALL SELECT 'TRANSAZIONI', COUNT(*) FROM dbo.TRANSAZIONI
    UNION ALL SELECT 'PRESTITI', COUNT(*) FROM dbo.PRESTITI
)
SELECT 
    r.Tabella,
    r.Record,
    CAST(ROUND(s.SpazioMB, 2) AS NUMERIC(36,2)) AS SpazioMB
FROM RecordCount r
JOIN Spazio s ON s.Tabella = r.Tabella
ORDER BY 
    CASE r.Tabella
        WHEN 'FILIALI' THEN 1
        WHEN 'DIPENDENTI' THEN 2
        WHEN 'CLIENTI' THEN 3
        WHEN 'CONTI' THEN 4
        WHEN 'TRANSAZIONI' THEN 5
        WHEN 'PRESTITI' THEN 6
    END;
GO

-- Statistiche NPL
SELECT 
    classificazione,
    COUNT(*) AS NumPrestiti,
    CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM dbo.PRESTITI) AS DECIMAL(5,2)) AS Percentuale
FROM dbo.PRESTITI
GROUP BY classificazione
ORDER BY classificazione;
GO

-- Top 5 filiali per numero clienti

SELECT TOP 5
    f.nome_filiale,
    f.provincia,
    COUNT(c.cliente_id) AS NumClienti
FROM dbo.FILIALI f
LEFT JOIN dbo.CLIENTI c ON f.filiale_id = c.filiale_id
GROUP BY f.nome_filiale, f.provincia
ORDER BY NumClienti DESC;
GO