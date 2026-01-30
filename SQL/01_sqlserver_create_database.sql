-- =============================================
-- BANCA TRINACRIA - SQL SERVER DATABASE
-- Script 01: Creazione Database e Schema
-- =============================================
-- Database operazionale OLTP
-- Target: SQL Server 2019+
-- Autore: Vincenzo Alesi - Portfolio Data Analyst
-- Data: 2025-01-26
-- =============================================

USE master;
GO

-- Drop database se esiste (solo per sviluppo)
IF DB_ID('BancaTrinacria') IS NOT NULL
BEGIN
    ALTER DATABASE BancaTrinacria SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE BancaTrinacria;
END
GO

DECLARE @DataPath NVARCHAR(260) = CAST(SERVERPROPERTY('InstanceDefaultDataPath') AS NVARCHAR(260));
DECLARE @LogPath  NVARCHAR(260) = CAST(SERVERPROPERTY('InstanceDefaultLogPath')  AS NVARCHAR(260));

DECLARE @SQL NVARCHAR(MAX) = '
CREATE DATABASE BancaTrinacria
ON PRIMARY
(
    NAME = BancaTrinacria_Data,
    FILENAME = ''' + @DataPath + 'BancaTrinacria_Data.mdf'',
    SIZE = 1GB,
    MAXSIZE = 10GB,
    FILEGROWTH = 256MB
)
LOG ON
(
    NAME = BancaTrinacria_Log,
    FILENAME = ''' + @LogPath + 'BancaTrinacria_Log.ldf'',
    SIZE = 512MB,
    MAXSIZE = 5GB,
    FILEGROWTH = 128MB
);';

EXEC (@SQL);
GO

-- Configurazione database
ALTER DATABASE BancaTrinacria SET RECOVERY FULL;
ALTER DATABASE BancaTrinacria SET PAGE_VERIFY CHECKSUM;
ALTER DATABASE BancaTrinacria COLLATE Latin1_General_100_CI_AS;
GO

USE BancaTrinacria;
GO

