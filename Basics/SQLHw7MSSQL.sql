--Problem 1 - Your task is to create a table in SQL Server with 10 000 000 entries (date + text). Search in the table by date range. Check the speed (without caching).

USE [master]
GO
CREATE DATABASE [SimpleDatabase]
GO
ALTER DATABASE [SimpleDatabase] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SimpleDatabase].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SimpleDatabase] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SimpleDatabase] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SimpleDatabase] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SimpleDatabase] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SimpleDatabase] SET ARITHABORT OFF 
GO
ALTER DATABASE [SimpleDatabase] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SimpleDatabase] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SimpleDatabase] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SimpleDatabase] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SimpleDatabase] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SimpleDatabase] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SimpleDatabase] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SimpleDatabase] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SimpleDatabase] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SimpleDatabase] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SimpleDatabase] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SimpleDatabase] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SimpleDatabase] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SimpleDatabase] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SimpleDatabase] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SimpleDatabase] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SimpleDatabase] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SimpleDatabase] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SimpleDatabase] SET  MULTI_USER 
GO
ALTER DATABASE [SimpleDatabase] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SimpleDatabase] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SimpleDatabase] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SimpleDatabase] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [SimpleDatabase] SET DELAYED_DURABILITY = DISABLED 
GO
USE [SimpleDatabase]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Logs](
    [LogId] [int] IDENTITY(1,1) NOT NULL,
    [Message] nvarchar(300) NOT NULL,
    [PublishDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Logs] PRIMARY KEY CLUSTERED 
(
    [LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
USE [master]
GO
ALTER DATABASE [SimpleDatabase] SET  READ_WRITE 
GO


--Insert Data
SET NOCOUNT ON
DECLARE @RowCount int = 10000000 

WHILE @RowCount > 0
BEGIN
    DECLARE @Message nvarchar(100);
    SET @Message = 'Message ' + CONVERT(nvarchar(100), @RowCount) + ': ' + CONVERT(nvarchar(100), newid())
    
    DECLARE @Date datetime;
    SET @Date = DATEADD(month, CONVERT(varbinary, newid()) % (50 * 12), getdate())

    INSERT INTO Logs([Message], PublishDate)
    VALUES(@Message, @Date)
    SET @RowCount = @RowCount - 1
END
SET NOCOUNT OFF

--Search

CHECKPOINT; DBCC DROPCLEANBUFFERS; -- Empty the SQL Server cache

SELECT * FROM Logs
WHERE PublishDate > '31-Dec-1998' and PublishDate < '1-Jan-2012'

--Problem 2 - Your task is to add an index to speed-up the search by date. Test the search speed (after cleaning the cache

CREATE INDEX IDX_Logs_PublishDate ON Logs(PublishDate)

CHECKPOINT; DBCC DROPCLEANBUFFERS; -- Empty the SQL Server cache

SELECT * FROM Logs
WHERE PublishDate > '31-Dec-1998' and PublishDate < '1-Jan-2012'

-- DROP INDEX IDX_Logs_PublishDate ON Logs
