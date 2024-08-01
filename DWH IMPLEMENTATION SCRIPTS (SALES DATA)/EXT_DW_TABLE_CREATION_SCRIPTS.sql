USE [DW_SALES_DB]
GO

--DROP TABLE IF EXISTS CUSTOMERS;
--DROP TABLE IF EXISTS EMPLOYEES;
--DROP TABLE IF EXISTS PRODUCTS;
--DROP TABLE IF EXISTS OFFICES;
--DROP TABLE IF EXISTS ORDERS;
--DROP TABLE IF EXISTS ORDER_DETAILS;
--DROP TABLE IF EXISTS PAYMENTS;

/****** Object:  Table [dbo].[CUSTOMERS]    Script Date: 2/16/2024 12:18:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CUSTOMERS](
	[CUSTOMERNUMBER] [int] PRIMARY KEY,
	[CUSTOMERNAME] [varchar](50) NULL,
	[CONTACTLASTNAME] [varchar](50) NULL,
	[CONTACTFIRSTNAME] [varchar](50) NULL,
	[PHONE] [varchar](50) NULL,
	[ADDRESSLINE1] [varchar](50) NULL,
	[ADDRESSLINE2] [varchar](50) NULL,
	[CITY] [varchar](50) NULL,
	[STATE] [varchar](50) NULL,
	[POSTALCODE] [varchar](15) NULL,
	[COUNTRY] [varchar](50) NULL,
	[SALESREPEMPLOYEENUMBER] [int] NULL,
	[CREDITLIMIT] [numeric](10, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EMPLOYEES]    Script Date: 2/16/2024 12:18:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EMPLOYEES](
	[EMPLOYEENUMBER] [int] PRIMARY KEY,
	[LASTNAME] [varchar](50) NULL,
	[FIRSTNAME] [varchar](50) NULL,
	[EXTENSION] [varchar](10) NULL,
	[EMAIL] [varchar](100) NULL,
	[OFFICECODE] [varchar](10) NULL,
	[REPORTSTO] [int] NULL,
	[JOBTITLE] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OFFICES]    Script Date: 2/16/2024 12:18:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OFFICES](
	[ID] INT IDENTITY(1,1) PRIMARY KEY,
	[OFFICECODE] [varchar](10) NULL,
	[PHONE] [varchar](50) NULL,
	[ADDRESSLINE1] [varchar](50) NULL,
	[ADDRESSLINE2] [varchar](50) NULL,
	[CITY] [varchar](50) NULL,
	[STATE] [varchar](50) NULL,
	[POSTALCODE] [varchar](15) NULL,
	[COUNTRY] [varchar](50) NULL,
	[TERRITORY] [varchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ORDER_DETAILS]    Script Date: 2/16/2024 12:18:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ORDER_DETAILS](
	[ID] INT IDENTITY(1,1) PRIMARY KEY,
	[ORDERNUMBER] [int] NOT NULL,
	[ORDERLINENUMBER] [smallint] NULL,
	[CUSTOMERNUMBER] [int] NULL,
	[EMPLOYEENUMBER] [int] NULL,
	[OFFICECODE] [varchar](10) NULL,
	[PRODUCTCODE] [varchar](15) NULL,
	[QUANTITYORDERED] [int] NULL,
	[PRICEEACH] [numeric](10, 2) NULL,
	[PRICE] [numeric](21, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ORDERS]    Script Date: 2/16/2024 12:18:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ORDERS](
	[ORDERNUMBER] [int] PRIMARY KEY,
	[CUSTOMERNUMBER] [int] NULL,
	[EMPLOYEENUMBER] [int] NULL,
	[OFFICECODE] [varchar](10) NULL,
	[ORDERDATE] [date] NULL,
	[REQUIREDDATE] [date] NULL,
	[SHIPPEDDATE] [date] NULL,
	[STATUS] [varchar](15) NULL,
	[COMMENTS] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PAYMENTS]    Script Date: 2/16/2024 12:18:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PAYMENTS](
	[PAYMENTID] INT PRIMARY KEY,
	[CUSTOMERNUMBER] [int] NULL,
	[EMPLOYEENUMBER] [int] NULL,
	[OFFICECODE] [varchar](10) NULL,
	[CHECKNUMBER] [varchar](50) NULL,
	[PAYMENTDATE] [date] NULL,
	[AMOUNT] [numeric](10, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PRODUCTS]    Script Date: 2/16/2024 12:18:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTS](
	[ID] INT IDENTITY(1,1) PRIMARY KEY,
	[PRODUCTCODE] [varchar](15) NULL,
	[PRODUCTNAME] [varchar](70) NULL,
	[PRODUCTCATEGORY] [varchar](50) NULL,
	[PRODUCTSCALE] [varchar](10) NULL,
	[PRODUCTVENDOR] [varchar](50) NULL,
	[PRODUCTDESCRIPTION] [varchar](max) NULL,
	[QUANTITYINSTOCK] [smallint] NULL,
	[BUYPRICE] [numeric](10, 2) NULL,
	[MSRP] [numeric](10, 2) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
