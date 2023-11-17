USE [master]
GO

/****** Object:  Database [db_gestao_posto_combustivel]    Script Date: 14/11/2023 05:40:09 ******/
CREATE DATABASE [db_gestao_posto_combustivel]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'db_gestao_posto_combustivel', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\db_gestao_posto_combustivel.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'db_gestao_posto_combustivel_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\db_gestao_posto_combustivel_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [db_gestao_posto_combustivel].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET ARITHABORT OFF 
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET  DISABLE_BROKER 
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET RECOVERY FULL 
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET  MULTI_USER 
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET DB_CHAINING OFF 
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET QUERY_STORE = ON
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO

ALTER DATABASE [db_gestao_posto_combustivel] SET  READ_WRITE 
GO




USE [db_gestao_posto_combustivel]
GO


/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Abastecimento]') AND type in (N'U'))
	DROP TABLE [dbo].[Abastecimento]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Bomba_Combustivel]') AND type in (N'U'))
	DROP TABLE [dbo].[Bomba_Combustivel]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tanque_Combustivel]') AND type in (N'U'))
	DROP TABLE [dbo].[Tanque_Combustivel]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Imposto]') AND type in (N'U'))
	DROP TABLE [dbo].[Imposto]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tipo_Combustivel]') AND type in (N'U'))
	DROP TABLE [dbo].[Tipo_Combustivel]
GO

CREATE TABLE dbo.Tipo_Combustivel
	(
	id int NOT NULL IDENTITY (1, 1),
	nome varchar(50) NOT NULL,
	valor_litro decimal(12, 2) NOT NULL
	)  ON [PRIMARY]
GO

ALTER TABLE dbo.Tipo_Combustivel ADD CONSTRAINT
	PK_Tipo_Combustivel PRIMARY KEY CLUSTERED 
	(
	id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

ALTER TABLE dbo.Tipo_Combustivel SET (LOCK_ESCALATION = TABLE)
GO


CREATE TABLE dbo.Imposto
	(
	id int NOT NULL IDENTITY (1, 1),
	data_imposto datetime NOT NULL,
	percentual decimal(5, 2) NOT NULL,
	ativo BIT NOT NULL DEFAULT 1
	)  ON [PRIMARY]
GO

ALTER TABLE dbo.Imposto ADD CONSTRAINT
	PK_Imposto PRIMARY KEY CLUSTERED 
	(
	id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO

ALTER TABLE dbo.Imposto SET (LOCK_ESCALATION = TABLE)
GO

	
CREATE TABLE dbo.Tanque_Combustivel
	(
	id int NOT NULL IDENTITY (1, 1),
	nome varchar(50) NOT NULL,
	tipo_combustivel int NOT NULL,
	capacidade_em_litros decimal(18, 2) NOT NULL DEFAULT 0.00
	
	)  ON [PRIMARY]
GO

ALTER TABLE dbo.Tanque_Combustivel ADD CONSTRAINT
	PK_Tanque_Combustivel PRIMARY KEY CLUSTERED 
	(
	id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO

ALTER TABLE dbo.Tanque_Combustivel ADD CONSTRAINT 
	FK_TANQUE_COMBUSTIVEL_DO_TIPO_COMBUSTIVEL FOREIGN KEY(tipo_combustivel)
	REFERENCES dbo.Tipo_Combustivel (id)
	ON DELETE CASCADE
	ON UPDATE CASCADE
GO


ALTER TABLE dbo.Tanque_Combustivel SET (LOCK_ESCALATION = TABLE)
GO


CREATE TABLE dbo.Bomba_Combustivel
	(
	id int NOT NULL IDENTITY (1, 1),
	nome varchar(50) NOT NULL,
	tanque_combustivel int NOT NULL
	)  ON [PRIMARY]
GO


ALTER TABLE dbo.Bomba_Combustivel ADD CONSTRAINT
	PK_Bomba_Combustivel PRIMARY KEY CLUSTERED 
	(
	id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO

ALTER TABLE dbo.Bomba_Combustivel ADD CONSTRAINT 
	FK_BOMBA_COMBUSTIVEL_DO_TANQUE_COMBUSTIVEL FOREIGN KEY(tanque_combustivel)
	REFERENCES dbo.Tanque_Combustivel (id)
	ON DELETE CASCADE
	ON UPDATE CASCADE
GO

ALTER TABLE dbo.Bomba_Combustivel SET (LOCK_ESCALATION = TABLE)
GO


CREATE TABLE dbo.Abastecimento
	(
	id int NOT NULL IDENTITY (1, 1),
	data_abastecimento datetime NOT NULL,
	tanque_combustivel varchar(50) NOT NULL,
	bomba_combustivel varchar(50) NOT NULL,
	tipo_combustivel varchar(50) NOT NULL,
	valor_litro decimal(12, 2) NOT NULL DEFAULT 0.00,
	qtd_litro_combustivel decimal(12, 2) NOT NULL DEFAULT 0.00,
	percentual_imposto decimal(5, 2) NOT NULL DEFAULT 0.00
	)  ON [PRIMARY]
GO

ALTER TABLE dbo.Abastecimento ADD CONSTRAINT
	PK_Abastecimento PRIMARY KEY CLUSTERED 
	(
	id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO

ALTER TABLE dbo.Abastecimento SET (LOCK_ESCALATION = TABLE)
GO


INSERT INTO [dbo].[Imposto]
           ([data_imposto]
           ,[percentual]
           ,[ativo])
     VALUES
           (CURRENT_TIMESTAMP
           ,13.00
           ,1);
GO


COMMIT