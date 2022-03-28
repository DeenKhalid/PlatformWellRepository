USE [master]
GO

/****** Object:  Database [PlatformWellDB]    Script Date: 28/3/2022 4:39:20 PM ******/
CREATE DATABASE [PlatformWellDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PlatformWellDB', FILENAME = N'C:\PlatformWellDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PlatformWellDB_log', FILENAME = N'C:\PlatformWellDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PlatformWellDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [PlatformWellDB] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [PlatformWellDB] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [PlatformWellDB] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [PlatformWellDB] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [PlatformWellDB] SET ARITHABORT OFF 
GO

ALTER DATABASE [PlatformWellDB] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [PlatformWellDB] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [PlatformWellDB] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [PlatformWellDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [PlatformWellDB] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [PlatformWellDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [PlatformWellDB] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [PlatformWellDB] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [PlatformWellDB] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [PlatformWellDB] SET  DISABLE_BROKER 
GO

ALTER DATABASE [PlatformWellDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [PlatformWellDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [PlatformWellDB] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [PlatformWellDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [PlatformWellDB] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [PlatformWellDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [PlatformWellDB] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [PlatformWellDB] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [PlatformWellDB] SET  MULTI_USER 
GO

ALTER DATABASE [PlatformWellDB] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [PlatformWellDB] SET DB_CHAINING OFF 
GO

ALTER DATABASE [PlatformWellDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [PlatformWellDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [PlatformWellDB] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [PlatformWellDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO

ALTER DATABASE [PlatformWellDB] SET QUERY_STORE = OFF
GO

ALTER DATABASE [PlatformWellDB] SET  READ_WRITE 
GO

USE [PlatformWellDB]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Platform](
	[Id] [int] NOT NULL,
	[UniqueName] [nvarchar](50) NULL,
	[Latitude] [decimal](9, 6) NULL,
	[Longitude] [decimal](9, 6) NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
 CONSTRAINT [PK_Platform] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Well]    Script Date: 28/3/2022 4:37:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Well](
	[Id] [int] NOT NULL,
	[PlatformId] [int] NOT NULL,
	[UniqueName] [nvarchar](50) NULL,
	[Latitude] [decimal](9, 6) NULL,
	[Longitude] [decimal](9, 6) NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
 CONSTRAINT [PK_Well] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[sp_platform]    Script Date: 28/3/2022 4:37:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_platform] 
	@id As Int,
	@uniqueName As nvarchar(50),
	@latitude As decimal(9, 6),
	@longitude As decimal(9, 6),
	@createdAt As Datetime,
	@updatedAt As Datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE [dbo].[Platform] 
	SET    
		[UniqueName] = @uniqueName,
		[Latitude] = @latitude,
		[Longitude]= @longitude,
		[CreatedAt] = @createdAt,
		[UpdatedAt] = @updatedAt
	WHERE  id = @id 

	IF @@ROWCOUNT = 0 
	BEGIN
		INSERT INTO [dbo].[Platform]
			   ([Id]
			   ,[UniqueName]
			   ,[Latitude]
			   ,[Longitude]
			   ,[CreatedAt]
			   ,[UpdatedAt])
		 VALUES
			   (@id, @uniqueName, @latitude, @longitude, @createdAt, @updatedAt)
	END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_well]    Script Date: 28/3/2022 4:37:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[sp_well] 
	@id As Int,
	@platformId As Int,
	@uniqueName As nvarchar(50),
	@latitude As decimal(9, 6),
	@longitude As decimal(9, 6),
	@createdAt As Datetime,
	@updatedAt As Datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE [dbo].[Well] 
	SET    
		[UniqueName] = @uniqueName,
		[PlatformId] = @platformId,
		[Latitude] = @latitude,
		[Longitude]= @longitude,
		[CreatedAt] = @createdAt,
		[UpdatedAt] = @updatedAt
	WHERE  id = @id 

	IF @@ROWCOUNT = 0 
	BEGIN
		INSERT INTO [dbo].[Well]
			   ([Id],
			   [PlatformId]
			   ,[UniqueName]
			   ,[Latitude]
			   ,[Longitude]
			   ,[CreatedAt]
			   ,[UpdatedAt])
		 VALUES
			   (@id, @platformId, @uniqueName, @latitude, @longitude, @createdAt, @updatedAt)
	END
END
GO
