USE [master]
GO

CREATE DATABASE [HMart]
use HMart

ALTER DATABASE [HMart] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HMart].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HMart] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HMart] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HMart] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HMart] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HMart] SET ARITHABORT OFF 
GO
ALTER DATABASE [HMart] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [HMart] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HMart] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HMart] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HMart] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HMart] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HMart] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HMart] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HMart] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HMart] SET  ENABLE_BROKER 
GO
ALTER DATABASE [HMart] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HMart] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HMart] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HMart] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HMart] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HMart] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HMart] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HMart] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [HMart] SET  MULTI_USER 
GO
ALTER DATABASE [HMart] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HMart] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HMart] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HMart] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [HMart] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [HMart] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [HMart] SET QUERY_STORE = OFF
GO
USE [HMart]
GO
/****** Object:  Table [dbo].[Cart] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[ProductID] [int] NULL,
	[UnitPrice] [nvarchar](100) NULL,
	[Discount] [nvarchar](100) NULL,
	[Quantity] [nvarchar](100) NULL,
	[TotalPrice] [decimal](18, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Manufacturer] [nvarchar](100) NULL,
	[UnitPrice] [decimal](18, 0) NULL,
	[Discount] [decimal](18, 0) NULL,
	[Quantity] [int] NULL,
	[ExpDate] [datetime] NULL,
	[ImageUrl] [nvarchar](1000) NULL,
	[Status] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderItems]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItems](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NULL,
	[ProductID] [int] NULL,
	[UnitPrice] [decimal](18, 0) NULL,
	[Discount] [decimal](18, 0) NULL,
	[Quantity] [int] NULL,
	[TotalPrice] [decimal](18, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[OrderNo] [nvarchar](100) NULL,
	[OrderTotal] [decimal](18, 0) NULL,
	[OrderStatus] [nvarchar](100) NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NULL,
	[LastName] [nvarchar](100) NULL,
	[Password] [nvarchar](100) NULL,
	[Email] [nvarchar](100) NULL,
	[Fund] [decimal](18, 0) NULL,
	[Type] [nvarchar](100) NULL,
	[Status] [int] NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[sp_AddToCart]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_AddToCart](@ID INT, @Email nvarchar(100) = null, @UnitPrice DECIMAL(18, 0) = NULL, @Discount DECIMAL(18, 0) = NULL  
,@Quantity INT  = NULL,@TotalPrice DECIMAL(18, 0)  = NULL)  
AS  
BEGIN  
        DECLARE @UserId INT;  
  DECLARE @UnitPrice_ DECIMAL(18, 0);  
  DECLARE @Discount_ DECIMAL(18, 0);  
  DECLARE @TotalPrice_ DECIMAL(18, 0);  
  SET @UserId = (SELECT TOp 1 ID FROM Users WHERE Email = @Email);  
  SET @UnitPrice_ = (SELECT  TOp 1 UnitPrice FROM Products WHERE ID = @ID);  
  SET @Discount_ = (SELECT (UnitPrice * @Quantity * Discount)/ 100 FROM Products WHERE ID = @ID);  
  SET @TotalPrice_ = (SELECT (UnitPrice * @Quantity) - @Discount_ FROM Products WHERE ID = @ID);  
    
  IF NOT EXISTS(SELECT 1 FROM Cart WHERE UserId = @UserId AND ProductID = @ID)  
  BEGIN  
   INSERT INTO Cart(UserId,ProductID,UnitPrice,Discount,Quantity,TotalPrice)  
   VALUES(@UserId,@ID,@UnitPrice_,@Discount_,@Quantity,@TotalPrice_);   
  END  
  ELSE  
  BEGIN  
   UPDATE Cart SET Quantity = (Quantity + @Quantity) WHERE UserId = @UserId AND ProductID = @ID;  
  END  
END
GO
/****** Object:  StoredProcedure [dbo].[sp_AddUpdateProduct] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_AddUpdateProduct](@ID INT = null, @Name nvarchar(100) = null, @Manufacturer nvarchar(100) = null,@UnitPrice DECIMAL(18, 0) = null
,@Discount DECIMAL(18, 0)  = null,@Quantity INT  = null,@ExpDate DATETIME  = null,@ImageUrl nvarchar(100) = null,@Status INT = null
, @Type nvarchar(100) = null)
AS
BEGIN
	IF @Type = 'Add'
	BEGIN
		INSERT INTO Products(Name,Manufacturer,UnitPrice,Discount,Quantity,ExpDate,ImageUrl,Status)
		VALUES(@Name,@Manufacturer,@UnitPrice,@Discount,@Quantity,@ExpDate,@ImageUrl,@Status)
	END
	IF @Type = 'Update'
	BEGIN
		UPDATE Products SET Name=@Name,Manufacturer=@Manufacturer,UnitPrice=@UnitPrice,Discount=@Discount,Quantity=@Quantity, ExpDate=@ExpDate,ImageUrl=@ImageUrl		
		WHERE ID = @ID;
	END
	IF @Type = 'Delete'
	BEGIN
		DELETE Products WHERE ID = @ID;
	END
	IF @Type = 'Get'
	BEGIN
		SELECT * FROM Products WHERE Status = 1;
	END
	IF @Type = 'GetByID'
	BEGIN
		SELECT * FROM Products WHERE ID = @ID;
	END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_CartList]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_CartList](@Email nvarchar(100))
AS
BEGIN
    IF @Email != 'Admin'
	BEGIN
		SELECT C.ID, M.Name, M.Manufacturer, M.UnitPrice, M.Discount, C.Quantity, C.TotalPrice, M.ImageUrl FROM Cart C 
		INNER JOIN Products M ON M.ID = C.ProductID
		INNER JOIN Users U ON U.ID = C.UserId
		WHERE U.Email =  @Email;
	END
	ELSE
	BEGIN
		SELECT M.ID, M.Name, M.Manufacturer, M.UnitPrice, M.Discount, M.Quantity, M.ImageUrl , 0 AS TotalPrice FROM Products M;
	END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_login]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_login](@Email nvarchar(100), @Password nvarchar(100))
AS
BEGIN
	SELECT * FROM Users WHERE Email = @Email AND Password = @Password AND Status = 1;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_OrderList] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_OrderList](@Type nvarchar(100), @Email nvarchar(100) = null, @ID INT)  
AS  
BEGIN  
 IF @Type = 'Admin'  
 BEGIN  
  SELECT O.ID,OrderNo,OrderTotal,OrderStatus,CONVERT(NVARCHAR,O.CreatedOn,107) AS CreatedOn  
  ,CONCAT(U.FirstName,' ',U.LastName ) AS CustomerName  
  FROM Orders O INNER JOIN Users U  
  ON U.ID = O.UserID;  
 END   
 IF @Type = 'User'  
 BEGIN  
  SELECT O.ID,OrderNo,OrderTotal,OrderStatus,CONVERT(NVARCHAR,O.CreatedOn,107) AS CreatedOn  
  ,CONCAT(U.FirstName,' ',U.LastName ) AS CustomerName  
  FROM Orders O INNER JOIN Users U  
  ON U.ID = O.UserID  
  WHERE U.Email = @Email;  
 END   
 IF @Type = 'UserItems'  
 BEGIN  
  SELECT   
  O.ID, O.OrderNo,O.OrderTotal,O.OrderStatus, M.Name AS ProductName, M.Manufacturer,M.UnitPrice,OI.Quantity,OI.TotalPrice   
  ,CONVERT(NVARCHAR,O.CreatedOn,107) AS CreatedOn ,CONCAT(U.FirstName,' ',U.LastName ) AS CustomerName  
  , M.ImageUrl  
  FROM Orders O   
  INNER JOIN Users U ON U.ID = O.UserID  
  INNER JOIN OrderItems OI ON OI.OrderID = O.ID  
  INNER JOIN Products M ON M.ID = OI.ProductID  
  WHERE O.ID = @ID;  
 END   
END
GO
/****** Object:  StoredProcedure [dbo].[sp_PlaceOrder]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_PlaceOrder](@Email nvarchar(100))
AS
BEGIN
	DECLARE @OrderNO nvarchar(100);
	DECLARE @OrderID INT;
	DECLARE @OrderTotal DECIMAL(18, 0);
	DECLARE @UserID INT;
	SET @OrderNO =	(SELECT NEWID());
	SET @UserID = (SELECT ID FROM Users WHERE Email = @Email);

	IF OBJECT_ID('tempdb..#TempOrder') IS NOT NULL DROP TABLE #TempOrder; 
	
	SELECT * INTO #TempOrder 
	FROM Cart WHERE UserId = @UserID;

	SET @OrderTotal = (SELECT SUM(TotalPrice) from #TempOrder);

	INSERT INTO Orders(UserID,OrderNo,OrderTotal,OrderStatus,CreatedOn)
	VALUES(@UserID,@OrderNO,@OrderTotal,'Pending',GETDATE());

	SET @OrderID = (SELECT ID FROM Orders WHERE OrderNo = @OrderNO);

	INSERT INTO OrderItems(OrderID,ProductID,UnitPrice,Discount,Quantity,TotalPrice)
	SELECT @OrderID, ProductID,UnitPrice,Discount,Quantity,TotalPrice FROM #TempOrder;

	DELETE FROM Cart WHERE UserId = @UserID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_register]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_register](@ID INT = NULL, @FirstName nvarchar(100) = NULL, @LastName nvarchar(100) = NULL, @Password nvarchar(100) = NULL,
@Email nvarchar(100) = NULL, @Fund DECIMAL(18, 0) = NULL, @Type nvarchar(100) = NULL, @Status INT = NULL, @ActionType nvarchar(100) = NULL)
AS
BEGIN
	IF @ActionType = 'Add'
	BEGIN
		INSERT INTO Users(FirstName,LastName,Password,Email,Fund,Type,Status,CreatedOn)
		VALUES(@FirstName,@LastName,@Password,@Email,@Fund,@Type,@Status,GETDATE())
	END
	IF @ActionType = 'Update'
	BEGIN
		UPDATE Users SET FirstName = @FirstName,LastName = @LastName,Password = @Password
		WHERE Email = @Email;
	END
	IF @ActionType = 'AddFund'
	BEGIN
		UPDATE Users SET Fund = @Fund WHERE Email = @Email;
	END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_RemoveToCart]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_RemoveToCart](@ID INT, @Email nvarchar(100) = null)    
AS    
BEGIN    
  DECLARE @UserId INT;    
  SET @UserId = (SELECT TOp 1 ID FROM Users WHERE Email = @Email);    
     
  DELETE FROM Cart WHERE UserId = @UserId AND ID = @ID;    
END
GO
/****** Object:  StoredProcedure [dbo].[sp_updateOrderStatus]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_updateOrderStatus](@OrderNo nvarchar(100) = NULL, @OrderStatus nvarchar(100) = NULL)
AS
BEGIN
	UPDATE Orders SET OrderStatus = @OrderStatus WHERE OrderNo = @OrderNo;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UserList]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_UserList]
AS
BEGIN
	SELECT ID, FirstName, LastName, Email, CASE WHEN Fund IS NULL THEN 0.00 ELSE FUND END AS FUND
	, CONVERT(NVARCHAR,CreatedOn ,107) AS OrderDate, Status, Password  FROM Users WHERE Status = 1 AND Type != 'Admin';
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_viewUser]     ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_viewUser](@ID INT = null, @Email VARCHAR(100) = null)
AS
BEGIN
	IF @ID IS NOT null AND @ID != 0
	BEGIN
		SELECT * FROM Users WHERE ID = @ID AND Status = 1;
	END
	IF @Email IS NOT null AND @Email != ''
	BEGIN
		SELECT * FROM Users WHERE Email = @Email AND Status = 1;
	END
END;
GO

USE [master]
GO
ALTER DATABASE [HMart] SET  READ_WRITE 
GO



use master
use HMart


delete from Users;
delete from Products;
delete from Cart;
delete from Orders;
delete from OrderItems;


select * from Users;
select * from Products;
select * from Cart;
select * from Orders;
select * from OrderItems;


EXEC sp_rename 'Users.createdOn', 'CreatedOn', 'COLUMN';

-- Insert into the Users table
INSERT INTO Users (FirstName, LastName, Password, Email, Fund, Type, Status, CreatedOn)
VALUES
	('admin', 'HAU', 'admin', 'admin', 0, 'admin', 1, GETDATE()),
	(N'Nguyễn Khắc', N'Hồng', '123', 'hong@email.com', 1500000, 'Users', 1, GETDATE()),
	(N'Trần Thị', 'Mai', '123', 'mai@email.com', 2000000, 'Users', 1, GETDATE()),
	(N'Lê Văn', N'Tuấn', '123', 'tuan@email.com', 1800000, 'Users', 1, GETDATE()),
	(N'Võ Thị', 'Thu', '123', 'thu@email.com', 2500000, 'Users', 1, GETDATE()),
	(N'Phạm Văn', 'Anh', '123', 'anh@email.com', 3000000, 'Users', 1, GETDATE()),
	(N'Hoàng Thị', 'Linh', '123', 'linh@email.com', 1700000, 'Users', 1, GETDATE());

-- Insert into the Products table
INSERT INTO Products (Name, Manufacturer, UnitPrice, Discount, Quantity, ExpDate, ImageUrl, Status)
VALUES
    (N'Nước khoáng Danisa', N'Danisa', 5300, 0.01, 100, '2024-04-18', 'nuoc-khoang-dasani-500ml-202312011640167868_300x300.webp', 1),
    (N'Nước tinh khiết Aquafina 355ml', N'Aquafina', 4700, 0, 50, '2026-05-03', 'nuoc-tinh-khiet-aquafina-355ml-202310301620257749.wepb', 1),
	(N'Nước tinh khiết Lama 5 lít', N'Lama', 25000, 0.2, 22, '2026-06-11', 'nuoc-tinh-khiet-lama-5-lit-202312012350111895_300x300.wepb', 1),
	(N'Trà xanh C2 hương táo 230ml', N'C2', 10000, 0.4, 40, '2026-08-20', 'tra-xanh-c2-huong-tao-230ml-202403141053394570_300x300.wepb', 1),
	(N'Trà xanh C2 hương chanh 225ml', N'C2', 10000, 0.4, 15, '2026-02-24', 'tra-xanh-c2-huong-chanh-225ml-202306230028314886_300x300.wepb', 1),
	(N'Nước trái cây Ice vị đào 460ml', N'Ice', 11000, 0.1, 60, '2026-01-29', 'nuoc-trai-cay-ice-vi-dao-490ml-202306251454352502_300x300.wepb', 1),
	(N'Nước tăng lực Sting hương dâu 330ml', N'Sting', 10500, 0.05, 100, '2026-04-09', 'nuoc-tang-luc-sting-huong-dau-330ml-202212130011449810_300x300.wepb', 1),
	(N'Nước tăng lực Sting gold 330ml', N'Sting', 10500, 0, 150, '2026-11-22', 'nuoc-tang-luc-sting-gold-320ml-202212130018561828_300x300.wepb', 1),
	(N'Nước tăng lực Redbull 250ml', N'Redbull', 13500, 0.05, 50, '2026-10-07', 'nuoc-tang-luc-redbull-250ml-202306251420429698_300x300.wepb', 1),
	(N'Nước tăng lực Monster energy Ultra Paradise', N'Monster', 23000, 0, 60, '2026-12-30', 'nuoc-tang-luc-monster-energy-ultra-paradise-lon-355ml-202306251442035467_300x300.wepb', 1),
	(N'Nước ngọt Pepsi Cola chai 1.5 lít', N'Pepsi', 20000, 0.2, 100, '2026-07-01', 'nuoc-ngot-pepsi-cola-chai-15-lit-202405131429579954.wepb', 1),
	(N'Nước ngọt Coca Cola lon 320ml', N'CocaCola', 10000, 0, 200, '2026-05-30', 'nuoc-ngot-coca-cola-lon-320ml-202306241759370763_300x300.wepb', 1),
	(N'Nước khoáng LaVie 350ml', N'LaVie', 4600, 0, 150, '2026-09-09', 'nuoc-khoang-la-vie-5-lit-202312020022154204_300x300.wepb', 1),
	(N'Nước khoáng ion Pocari Sweat chai 350ml', N'Pocari Sweat', 10000, 0.1, 130, '2026-03-18', 'nuoc-khoang-i-on-pocari-sweat-chai-350ml-202306251433052813_300x300.wepb', 1),
	(N'Nước cam ép Twister Tropicana 320ml', N'Twister', 10000, 0, 56, '2026-03-18', 'nuoc-cam-ep-twister-tropicana-320ml-202312261636564180_300x300.wepb', 1),
	(N'Bia Tiger Bạc lon 330ml', N'Tiger', 19200, 0.05, 88, '2026-02-13', 'bia-tiger-bac-330ml-202308250851259675_300x300.wepb', 1),
	(N'Bia Sài Gòn Lager lon 330ml', N'Sài Gòn', 12300, 0, 99, '2026-07-23', 'bia-sai-gon-lager-330ml-202307281717220267_300x300.wepb', 1),
	(N'6 lon nước tăng lực Warrior hương nho 325ml', N'Warrior', 66000, 0.03, 55, '2026-04-05', '6-lon-nuoc-tang-luc-warrior-huong-nho-325ml-202306251439321882_300x300.wepb', 1),
	(N'6 lon nước tăng lực Warrior hương dâu 325ml', N'Warrior', 65000, 0.03, 60, '2026-10-18', '6-lon-nuoc-tang-luc-warrior-huong-dau-325ml-202306251434391540_300x300.wepb', 1),
	(N'6 lon bia Tiger Bạc 330ml', N'Tiger', 115200, 0.05, 111, '2026-09-02', '6-lon-bia-tiger-bac-330ml-202308250851063935_300x300.wepb', 1),
	(N'6 lon nước tăng lực Sting hương dâu 320ml', N'Sting', 63000, 0.05, 20, '2026-01-15', '6-lon-nuoc-tang-luc-sting-huong-dau-320ml-202306191319508450_300x300.wepb', 1),
	(N'6 lon nước ngọt Pepsi Coca Sleek 245ml', N'Pepsi', 52000, 0.04, 15, '2026-11-09', '6-lon-nuoc-ngot-pepsi-cola-sleek-245ml-202402011350006420_300x300.wepb', 1),
	(N'6 lon nước ngọt Coca Cola 320ml', N'CocaCola', 60000, 0.04, 30, '2026-06-28', '6-lon-nuoc-ngot-coca-cola-320ml-202306241759496911_300x300.wepb', 1);
-- Insert into the Cart table 
INSERT INTO Cart (UserId, ProductID, UnitPrice, Discount, Quantity, TotalPrice)
VALUES
    (1, 1, 10.99, 0.50, 2, 19.98),
    (2, 2, 15.49, 0.25, 3, 43.98);

-- Insert into the Orders table
INSERT INTO Orders (UserID, OrderNo, OrderTotal, OrderStatus)
VALUES
    (1, 'ORD123456', 19.98, 'Pending'),
    (2, 'ORD789012', 43.98, 'Processing');

-- Insert into the OrderItems table
INSERT INTO OrderItems (OrderID, ProductID, UnitPrice, Discount, Quantity, TotalPrice)
VALUES
    (1, 1, 10.99, 0.50, 2, 19.98),
    (2, 2, 15.49, 0.25, 3, 43.98);
