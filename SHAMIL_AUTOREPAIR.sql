USE [master]
GO
/****** Object:  Database [КП]    Script Date: 30.04.2021 20:34:47 ******/
CREATE DATABASE [КП]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'КП', FILENAME = N'C:\Users\Public\КП.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'КП_log', FILENAME = N'C:\Users\Public\КП_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [КП] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [КП].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [КП] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [КП] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [КП] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [КП] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [КП] SET ARITHABORT OFF 
GO
ALTER DATABASE [КП] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [КП] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [КП] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [КП] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [КП] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [КП] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [КП] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [КП] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [КП] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [КП] SET  ENABLE_BROKER 
GO
ALTER DATABASE [КП] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [КП] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [КП] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [КП] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [КП] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [КП] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [КП] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [КП] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [КП] SET  MULTI_USER 
GO
ALTER DATABASE [КП] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [КП] SET DB_CHAINING OFF 
GO
ALTER DATABASE [КП] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [КП] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [КП] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [КП] SET QUERY_STORE = OFF
GO
USE [КП]
GO
/****** Object:  Table [dbo].[Price_list_of_services]    Script Date: 30.04.2021 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Price_list_of_services](
	[id_service] [nvarchar](50) NOT NULL,
	[service_name] [nvarchar](35) NOT NULL,
	[PRICE] [money] NOT NULL,
 CONSTRAINT [PK_Price_list_of_services] PRIMARY KEY CLUSTERED 
(
	[id_service] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[services_rendered]    Script Date: 30.04.2021 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[services_rendered](
	[id_contract] [nvarchar](50) NOT NULL,
	[id_service] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_services_rendered_1] PRIMARY KEY CLUSTERED 
(
	[id_contract] ASC,
	[id_service] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 30.04.2021 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[id_client] [nvarchar](50) NOT NULL,
	[Surname] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Data_of_birth] [date] NOT NULL,
	[Passport] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NULL,
 CONSTRAINT [PK__Customer__6EC2B6C0C0295D33] PRIMARY KEY CLUSTERED 
(
	[id_client] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Сontracts]    Script Date: 30.04.2021 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Сontracts](
	[id_contract] [nvarchar](50) NOT NULL,
	[id_client] [nvarchar](50) NOT NULL,
	[id_car] [int] NOT NULL,
	[id_employee] [int] NOT NULL,
	[date_act] [date] NULL,
 CONSTRAINT [PK__Сontract__FF5898F8A47B26FE] PRIMARY KEY CLUSTERED 
(
	[id_contract] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[service_rended]    Script Date: 30.04.2021 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[service_rended]
AS
SELECT dbo.Сontracts.id_contract, dbo.Customers.Surname, SUM(dbo.Price_list_of_services.PRICE) AS Price
FROM     dbo.Сontracts INNER JOIN
                  dbo.services_rendered ON dbo.Сontracts.id_contract = dbo.services_rendered.id_contract INNER JOIN
                  dbo.Price_list_of_services ON dbo.services_rendered.id_service = dbo.Price_list_of_services.id_service INNER JOIN
                  dbo.Customers ON dbo.Сontracts.id_client = dbo.Customers.id_client
GROUP BY dbo.Сontracts.id_contract, dbo.Customers.Surname
GO
/****** Object:  View [dbo].[clients]    Script Date: 30.04.2021 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[clients]
AS
SELECT Surname, Name, Data_of_birth, Passport, Email
FROM     dbo.Customers
GO
/****** Object:  Table [dbo].[CAR]    Script Date: 30.04.2021 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CAR](
	[id_car] [int] NOT NULL,
	[id_brand] [nvarchar](15) NULL,
	[car_plate] [nvarchar](50) NOT NULL,
	[id_vin] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK__CAR__D54686DC1EB9E972] PRIMARY KEY CLUSTERED 
(
	[id_car] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Brands_cars]    Script Date: 30.04.2021 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brands_cars](
	[id_brand] [nvarchar](15) NOT NULL,
	[name_brand] [nvarchar](50) NULL,
 CONSTRAINT [PK_Brands_cars] PRIMARY KEY CLUSTERED 
(
	[id_brand] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[history_repair]    Script Date: 30.04.2021 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[history_repair]
AS
SELECT dbo.Brands_cars.name_brand, dbo.CAR.car_plate, dbo.Price_list_of_services.service_name, dbo.Price_list_of_services.PRICE, dbo.Customers.id_client
FROM     dbo.services_rendered INNER JOIN
                  dbo.Сontracts ON dbo.services_rendered.id_contract = dbo.Сontracts.id_contract INNER JOIN
                  dbo.Customers ON dbo.Сontracts.id_client = dbo.Customers.id_client INNER JOIN
                  dbo.Price_list_of_services ON dbo.services_rendered.id_service = dbo.Price_list_of_services.id_service INNER JOIN
                  dbo.CAR ON dbo.Сontracts.id_car = dbo.CAR.id_car INNER JOIN
                  dbo.Brands_cars ON dbo.CAR.id_brand = dbo.Brands_cars.id_brand
GO
/****** Object:  View [dbo].[cars]    Script Date: 30.04.2021 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[cars]
AS
SELECT dbo.CAR.id_car, dbo.Brands_cars.name_brand, dbo.CAR.car_plate, dbo.CAR.id_vin
FROM     dbo.Brands_cars INNER JOIN
                  dbo.CAR ON dbo.Brands_cars.id_brand = dbo.CAR.id_brand
GO
/****** Object:  View [dbo].[contract]    Script Date: 30.04.2021 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[contract]
AS
SELECT dbo.Price_list_of_services.service_name, dbo.Price_list_of_services.PRICE, dbo.Сontracts.id_contract
FROM     dbo.services_rendered INNER JOIN
                  dbo.Price_list_of_services ON dbo.services_rendered.id_service = dbo.Price_list_of_services.id_service INNER JOIN
                  dbo.Сontracts ON dbo.services_rendered.id_contract = dbo.Сontracts.id_contract
GO
/****** Object:  View [dbo].[total_service]    Script Date: 30.04.2021 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[total_service]
AS
SELECT dbo.Сontracts.id_contract, SUM(dbo.Price_list_of_services.PRICE) AS total_price
FROM     dbo.services_rendered INNER JOIN
                  dbo.Сontracts ON dbo.services_rendered.id_contract = dbo.Сontracts.id_contract INNER JOIN
                  dbo.Price_list_of_services ON dbo.services_rendered.id_service = dbo.Price_list_of_services.id_service
GROUP BY dbo.Сontracts.id_contract
GO
/****** Object:  Table [dbo].[Users]    Script Date: 30.04.2021 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[login_user] [nvarchar](50) NOT NULL,
	[password_user] [nvarchar](50) NULL,
	[id_role] [int] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[login_user] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 30.04.2021 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[id_role] [int] NOT NULL,
	[name_role] [nvarchar](30) NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[id_role] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Personnel]    Script Date: 30.04.2021 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personnel](
	[id_emloyee] [int] NOT NULL,
	[Surname] [nvarchar](10) NOT NULL,
	[Name] [nvarchar](10) NOT NULL,
	[Post] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[date_of_birth] [date] NOT NULL,
 CONSTRAINT [PK__Personne__D58ABEDDDEC3F349] PRIMARY KEY CLUSTERED 
(
	[id_emloyee] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[authorization]    Script Date: 30.04.2021 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[authorization]
AS
SELECT dbo.Users.login_user, dbo.Users.password_user, dbo.Users.id_role, dbo.Personnel.id_emloyee, dbo.Personnel.Surname, dbo.Personnel.Name
FROM     dbo.Users INNER JOIN
                  dbo.Roles ON dbo.Users.id_role = dbo.Roles.id_role INNER JOIN
                  dbo.Personnel ON dbo.Users.login_user = dbo.Personnel.Email
GO
/****** Object:  View [dbo].[authorization_clients]    Script Date: 30.04.2021 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[authorization_clients]
AS
SELECT dbo.Users.login_user, dbo.Users.password_user, dbo.Users.id_role, dbo.Customers.id_client, dbo.Customers.Surname, dbo.Customers.Name
FROM     dbo.Roles INNER JOIN
                  dbo.Users ON dbo.Roles.id_role = dbo.Users.id_role INNER JOIN
                  dbo.Customers ON dbo.Users.login_user = dbo.Customers.Email
GO
INSERT [dbo].[Brands_cars] ([id_brand], [name_brand]) VALUES (N'1', N'Toyota')
GO
INSERT [dbo].[Brands_cars] ([id_brand], [name_brand]) VALUES (N'2', N'Hammer')
GO
INSERT [dbo].[Brands_cars] ([id_brand], [name_brand]) VALUES (N'3', N'BMW')
GO
INSERT [dbo].[Brands_cars] ([id_brand], [name_brand]) VALUES (N'4', N'Rolls-Royce')
GO
INSERT [dbo].[Brands_cars] ([id_brand], [name_brand]) VALUES (N'5', N'Tesla')
GO
INSERT [dbo].[Brands_cars] ([id_brand], [name_brand]) VALUES (N'6', N'Mercedes-Benz')
GO
INSERT [dbo].[CAR] ([id_car], [id_brand], [car_plate], [id_vin]) VALUES (1, N'3', N'E883OK77', N'76544272')
GO
INSERT [dbo].[CAR] ([id_car], [id_brand], [car_plate], [id_vin]) VALUES (2, N'4', N'H990AA190', N'76326723')
GO
INSERT [dbo].[CAR] ([id_car], [id_brand], [car_plate], [id_vin]) VALUES (3, N'2', N'X444TO750', N'74646357')
GO
INSERT [dbo].[CAR] ([id_car], [id_brand], [car_plate], [id_vin]) VALUES (4, N'3', N'X234OA150', N'74646738')
GO
INSERT [dbo].[CAR] ([id_car], [id_brand], [car_plate], [id_vin]) VALUES (5, N'4', N'A777TO50', N'72166364')
GO
INSERT [dbo].[CAR] ([id_car], [id_brand], [car_plate], [id_vin]) VALUES (2021300429, N'1', N'E231AA99', N'ADSSW34234')
GO
INSERT [dbo].[Customers] ([id_client], [Surname], [Name], [Data_of_birth], [Passport], [Email]) VALUES (N'1', N'Баллаев', N'Кирилл', CAST(N'2002-08-09' AS Date), N'4582882734', N'buy@mail.ru')
GO
INSERT [dbo].[Customers] ([id_client], [Surname], [Name], [Data_of_birth], [Passport], [Email]) VALUES (N'2', N'Абдюшев', N'Артем', CAST(N'2001-08-29' AS Date), N'4563789098', NULL)
GO
INSERT [dbo].[Customers] ([id_client], [Surname], [Name], [Data_of_birth], [Passport], [Email]) VALUES (N'3', N'Колобченков', N'Максим', CAST(N'2002-10-16' AS Date), N'4574876374', NULL)
GO
INSERT [dbo].[Customers] ([id_client], [Surname], [Name], [Data_of_birth], [Passport], [Email]) VALUES (N'4', N'Федорова', N'Мария', CAST(N'2002-01-18' AS Date), N'4621274747', NULL)
GO
INSERT [dbo].[Customers] ([id_client], [Surname], [Name], [Data_of_birth], [Passport], [Email]) VALUES (N'5', N'Верёвкин', N'Сергей', CAST(N'2002-12-13' AS Date), N'4527263547', NULL)
GO
INSERT [dbo].[Personnel] ([id_emloyee], [Surname], [Name], [Post], [Email], [date_of_birth]) VALUES (1, N'Барсуков', N'Владимир', N'Слесарь', N'email@mail.ru', CAST(N'1999-03-21' AS Date))
GO
INSERT [dbo].[Personnel] ([id_emloyee], [Surname], [Name], [Post], [Email], [date_of_birth]) VALUES (2, N'Фандеев', N'Семён', N'Автоэлектрик', N'test@mail.ru', CAST(N'2001-07-26' AS Date))
GO
INSERT [dbo].[Personnel] ([id_emloyee], [Surname], [Name], [Post], [Email], [date_of_birth]) VALUES (3, N'Кочеров', N'Роман', N'Шиномонтажник', N'versus@rambler.ru', CAST(N'2002-07-12' AS Date))
GO
INSERT [dbo].[Price_list_of_services] ([id_service], [service_name], [PRICE]) VALUES (N'1', N'Шиномонтаж', 500.0000)
GO
INSERT [dbo].[Price_list_of_services] ([id_service], [service_name], [PRICE]) VALUES (N'2', N'Подкачка колёс', 250.0000)
GO
INSERT [dbo].[Price_list_of_services] ([id_service], [service_name], [PRICE]) VALUES (N'3', N'Мойка', 780.0000)
GO
INSERT [dbo].[Roles] ([id_role], [name_role]) VALUES (1, N'Администратор')
GO
INSERT [dbo].[Roles] ([id_role], [name_role]) VALUES (2, N'Покупатель')
GO
INSERT [dbo].[Roles] ([id_role], [name_role]) VALUES (3, N'Работник')
GO
INSERT [dbo].[services_rendered] ([id_contract], [id_service]) VALUES (N'2021300406', N'1')
GO
INSERT [dbo].[services_rendered] ([id_contract], [id_service]) VALUES (N'2021300406', N'2')
GO
INSERT [dbo].[services_rendered] ([id_contract], [id_service]) VALUES (N'2021300406', N'3')
GO
INSERT [dbo].[services_rendered] ([id_contract], [id_service]) VALUES (N'2021300408', N'1')
GO
INSERT [dbo].[services_rendered] ([id_contract], [id_service]) VALUES (N'2021300408', N'2')
GO
INSERT [dbo].[services_rendered] ([id_contract], [id_service]) VALUES (N'2021300408', N'3')
GO
INSERT [dbo].[services_rendered] ([id_contract], [id_service]) VALUES (N'2021300413', N'1')
GO
INSERT [dbo].[services_rendered] ([id_contract], [id_service]) VALUES (N'2021300413', N'2')
GO
INSERT [dbo].[services_rendered] ([id_contract], [id_service]) VALUES (N'2021300420', N'2')
GO
INSERT [dbo].[services_rendered] ([id_contract], [id_service]) VALUES (N'2021300420', N'3')
GO
INSERT [dbo].[services_rendered] ([id_contract], [id_service]) VALUES (N'2021300421', N'1')
GO
INSERT [dbo].[services_rendered] ([id_contract], [id_service]) VALUES (N'2021300421', N'2')
GO
INSERT [dbo].[services_rendered] ([id_contract], [id_service]) VALUES (N'2021300421', N'3')
GO
INSERT [dbo].[services_rendered] ([id_contract], [id_service]) VALUES (N'2021300423', N'1')
GO
INSERT [dbo].[services_rendered] ([id_contract], [id_service]) VALUES (N'2021300423', N'2')
GO
INSERT [dbo].[services_rendered] ([id_contract], [id_service]) VALUES (N'2021300436', N'2')
GO
INSERT [dbo].[services_rendered] ([id_contract], [id_service]) VALUES (N'2021300438', N'1')
GO
INSERT [dbo].[services_rendered] ([id_contract], [id_service]) VALUES (N'2021300438', N'2')
GO
INSERT [dbo].[services_rendered] ([id_contract], [id_service]) VALUES (N'2021300443', N'1')
GO
INSERT [dbo].[services_rendered] ([id_contract], [id_service]) VALUES (N'2021300447', N'2')
GO
INSERT [dbo].[services_rendered] ([id_contract], [id_service]) VALUES (N'A100', N'1')
GO
INSERT [dbo].[services_rendered] ([id_contract], [id_service]) VALUES (N'A100', N'2')
GO
INSERT [dbo].[Users] ([login_user], [password_user], [id_role]) VALUES (N'buy@mail.ru', N'buy', 2)
GO
INSERT [dbo].[Users] ([login_user], [password_user], [id_role]) VALUES (N'email@mail.ru', N'email', 3)
GO
INSERT [dbo].[Users] ([login_user], [password_user], [id_role]) VALUES (N'test@mail.ru', N'test', 3)
GO
INSERT [dbo].[Users] ([login_user], [password_user], [id_role]) VALUES (N'versus@rambler.ru', N'versus', 1)
GO
INSERT [dbo].[Сontracts] ([id_contract], [id_client], [id_car], [id_employee], [date_act]) VALUES (N'2021300402', N'2', 4, 1, CAST(N'2021-04-30' AS Date))
GO
INSERT [dbo].[Сontracts] ([id_contract], [id_client], [id_car], [id_employee], [date_act]) VALUES (N'2021300406', N'3', 3, 1, CAST(N'2021-04-30' AS Date))
GO
INSERT [dbo].[Сontracts] ([id_contract], [id_client], [id_car], [id_employee], [date_act]) VALUES (N'2021300408', N'4', 3, 1, CAST(N'2021-04-30' AS Date))
GO
INSERT [dbo].[Сontracts] ([id_contract], [id_client], [id_car], [id_employee], [date_act]) VALUES (N'2021300409', N'3', 2021300429, 1, CAST(N'2021-04-30' AS Date))
GO
INSERT [dbo].[Сontracts] ([id_contract], [id_client], [id_car], [id_employee], [date_act]) VALUES (N'2021300410', N'2', 3, 1, CAST(N'2021-04-30' AS Date))
GO
INSERT [dbo].[Сontracts] ([id_contract], [id_client], [id_car], [id_employee], [date_act]) VALUES (N'2021300413', N'2', 4, 1, CAST(N'2021-04-30' AS Date))
GO
INSERT [dbo].[Сontracts] ([id_contract], [id_client], [id_car], [id_employee], [date_act]) VALUES (N'2021300417', N'4', 4, 1, CAST(N'2021-04-30' AS Date))
GO
INSERT [dbo].[Сontracts] ([id_contract], [id_client], [id_car], [id_employee], [date_act]) VALUES (N'2021300418', N'2', 3, 1, CAST(N'2021-04-30' AS Date))
GO
INSERT [dbo].[Сontracts] ([id_contract], [id_client], [id_car], [id_employee], [date_act]) VALUES (N'2021300420', N'4', 3, 1, CAST(N'2021-04-30' AS Date))
GO
INSERT [dbo].[Сontracts] ([id_contract], [id_client], [id_car], [id_employee], [date_act]) VALUES (N'2021300421', N'4', 4, 1, CAST(N'2021-04-30' AS Date))
GO
INSERT [dbo].[Сontracts] ([id_contract], [id_client], [id_car], [id_employee], [date_act]) VALUES (N'2021300423', N'4', 3, 1, CAST(N'2021-04-30' AS Date))
GO
INSERT [dbo].[Сontracts] ([id_contract], [id_client], [id_car], [id_employee], [date_act]) VALUES (N'2021300425', N'4', 3, 1, CAST(N'2021-04-30' AS Date))
GO
INSERT [dbo].[Сontracts] ([id_contract], [id_client], [id_car], [id_employee], [date_act]) VALUES (N'2021300426', N'4', 2021300429, 1, CAST(N'2021-04-30' AS Date))
GO
INSERT [dbo].[Сontracts] ([id_contract], [id_client], [id_car], [id_employee], [date_act]) VALUES (N'2021300433', N'2', 4, 1, CAST(N'2021-04-30' AS Date))
GO
INSERT [dbo].[Сontracts] ([id_contract], [id_client], [id_car], [id_employee], [date_act]) VALUES (N'2021300436', N'3', 4, 1, CAST(N'2021-04-30' AS Date))
GO
INSERT [dbo].[Сontracts] ([id_contract], [id_client], [id_car], [id_employee], [date_act]) VALUES (N'2021300438', N'4', 4, 1, CAST(N'2021-04-30' AS Date))
GO
INSERT [dbo].[Сontracts] ([id_contract], [id_client], [id_car], [id_employee], [date_act]) VALUES (N'2021300443', N'4', 3, 1, CAST(N'2021-04-30' AS Date))
GO
INSERT [dbo].[Сontracts] ([id_contract], [id_client], [id_car], [id_employee], [date_act]) VALUES (N'2021300447', N'3', 4, 1, CAST(N'2021-04-30' AS Date))
GO
INSERT [dbo].[Сontracts] ([id_contract], [id_client], [id_car], [id_employee], [date_act]) VALUES (N'2021300451', N'3', 3, 1, CAST(N'2021-04-30' AS Date))
GO
INSERT [dbo].[Сontracts] ([id_contract], [id_client], [id_car], [id_employee], [date_act]) VALUES (N'A100', N'1', 3, 3, CAST(N'2021-04-28' AS Date))
GO
ALTER TABLE [dbo].[CAR]  WITH CHECK ADD  CONSTRAINT [FK_CAR_Brands_cars] FOREIGN KEY([id_brand])
REFERENCES [dbo].[Brands_cars] ([id_brand])
GO
ALTER TABLE [dbo].[CAR] CHECK CONSTRAINT [FK_CAR_Brands_cars]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Users] FOREIGN KEY([Email])
REFERENCES [dbo].[Users] ([login_user])
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Customers_Users]
GO
ALTER TABLE [dbo].[Personnel]  WITH CHECK ADD  CONSTRAINT [FK_Personnel_Users] FOREIGN KEY([Email])
REFERENCES [dbo].[Users] ([login_user])
GO
ALTER TABLE [dbo].[Personnel] CHECK CONSTRAINT [FK_Personnel_Users]
GO
ALTER TABLE [dbo].[services_rendered]  WITH CHECK ADD  CONSTRAINT [FK_services_rendered_Price_list_of_services] FOREIGN KEY([id_service])
REFERENCES [dbo].[Price_list_of_services] ([id_service])
GO
ALTER TABLE [dbo].[services_rendered] CHECK CONSTRAINT [FK_services_rendered_Price_list_of_services]
GO
ALTER TABLE [dbo].[services_rendered]  WITH CHECK ADD  CONSTRAINT [FK_services_rendered_Сontracts] FOREIGN KEY([id_contract])
REFERENCES [dbo].[Сontracts] ([id_contract])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[services_rendered] CHECK CONSTRAINT [FK_services_rendered_Сontracts]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Roles] FOREIGN KEY([id_role])
REFERENCES [dbo].[Roles] ([id_role])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Roles]
GO
ALTER TABLE [dbo].[Сontracts]  WITH CHECK ADD  CONSTRAINT [FK_Сontracts_CAR1] FOREIGN KEY([id_car])
REFERENCES [dbo].[CAR] ([id_car])
GO
ALTER TABLE [dbo].[Сontracts] CHECK CONSTRAINT [FK_Сontracts_CAR1]
GO
ALTER TABLE [dbo].[Сontracts]  WITH CHECK ADD  CONSTRAINT [FK_Сontracts_Customers] FOREIGN KEY([id_client])
REFERENCES [dbo].[Customers] ([id_client])
GO
ALTER TABLE [dbo].[Сontracts] CHECK CONSTRAINT [FK_Сontracts_Customers]
GO
ALTER TABLE [dbo].[Сontracts]  WITH CHECK ADD  CONSTRAINT [FK_Сontracts_Personnel] FOREIGN KEY([id_employee])
REFERENCES [dbo].[Personnel] ([id_emloyee])
GO
ALTER TABLE [dbo].[Сontracts] CHECK CONSTRAINT [FK_Сontracts_Personnel]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Users"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 148
               Right = 249
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Roles"
            Begin Extent = 
               Top = 167
               Left = 47
               Bottom = 286
               Right = 248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Personnel"
            Begin Extent = 
               Top = 7
               Left = 546
               Bottom = 219
               Right = 747
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'authorization'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'authorization'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Roles"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 126
               Right = 249
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Customers"
            Begin Extent = 
               Top = 6
               Left = 825
               Bottom = 169
               Right = 1026
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Users"
            Begin Extent = 
               Top = 22
               Left = 342
               Bottom = 163
               Right = 543
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'authorization_clients'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'authorization_clients'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Brands_cars"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 126
               Right = 249
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CAR"
            Begin Extent = 
               Top = 7
               Left = 297
               Bottom = 183
               Right = 498
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'cars'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'cars'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Customers"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 224
               Right = 249
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'clients'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'clients'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "services_rendered"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 138
               Right = 249
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Price_list_of_services"
            Begin Extent = 
               Top = 7
               Left = 297
               Bottom = 162
               Right = 498
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Сontracts"
            Begin Extent = 
               Top = 7
               Left = 546
               Bottom = 202
               Right = 747
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'contract'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'contract'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "services_rendered"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 126
               Right = 249
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Сontracts"
            Begin Extent = 
               Top = 7
               Left = 542
               Bottom = 188
               Right = 747
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Customers"
            Begin Extent = 
               Top = 7
               Left = 297
               Bottom = 170
               Right = 498
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Price_list_of_services"
            Begin Extent = 
               Top = 7
               Left = 795
               Bottom = 148
               Right = 996
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CAR"
            Begin Extent = 
               Top = 154
               Left = 795
               Bottom = 317
               Right = 996
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Brands_cars"
            Begin Extent = 
               Top = 126
               Left = 48
               Bottom = 257
               Right = 249
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
   ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'history_repair'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'      Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'history_repair'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'history_repair'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Сontracts"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 249
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "services_rendered"
            Begin Extent = 
               Top = 7
               Left = 297
               Bottom = 126
               Right = 498
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Price_list_of_services"
            Begin Extent = 
               Top = 7
               Left = 546
               Bottom = 148
               Right = 747
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Customers"
            Begin Extent = 
               Top = 7
               Left = 795
               Bottom = 170
               Right = 996
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1980
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'service_rended'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'  Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'service_rended'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'service_rended'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Сontracts"
            Begin Extent = 
               Top = 7
               Left = 297
               Bottom = 201
               Right = 498
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Price_list_of_services"
            Begin Extent = 
               Top = 7
               Left = 546
               Bottom = 148
               Right = 747
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "services_rendered"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 136
               Right = 251
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'total_service'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'total_service'
GO
USE [master]
GO
ALTER DATABASE [КП] SET  READ_WRITE 
GO
