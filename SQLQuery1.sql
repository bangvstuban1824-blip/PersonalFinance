USE PersonalFinanceDB;
GO


CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Username NVARCHAR(50) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    Email NVARCHAR(100),
    Phone NVARCHAR(20),
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE Accounts (
    AccountID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    AccountName NVARCHAR(100) NOT NULL,
    Balance DECIMAL(18,2) DEFAULT 0,
    Currency NVARCHAR(10) DEFAULT 'VND',
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL,
    Type NVARCHAR(20) CHECK (Type IN ('Thu nhập', 'Chi tiêu'))
);

CREATE TABLE Transactions (
    TransactionID INT IDENTITY(1,1) PRIMARY KEY,
    AccountID INT NOT NULL,
    CategoryID INT NOT NULL,
    Amount DECIMAL(18,2) NOT NULL,
    TransactionDate DATETIME DEFAULT GETDATE(),
    Note NVARCHAR(255),
    Type NVARCHAR(20) CHECK (Type IN ('Thu', 'Chi')),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE Budgets (
    BudgetID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    CategoryID INT NOT NULL,
    AmountLimit DECIMAL(18,2) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);


INSERT INTO Users (FullName, Username, PasswordHash, Email, Phone)
VALUES (N'Nguyễn Văn A', 'nva', '123456', 'a@gmail.com', '0123456789');

INSERT INTO Accounts (UserID, AccountName, Balance)
VALUES (1, N'Ví chính', 5000000);

INSERT INTO Categories (CategoryName, Type)
VALUES (N'Ăn uống', N'Chi tiêu');

INSERT INTO Transactions (AccountID, CategoryID, Amount, Type, Note)
VALUES (1, 1, 50000, N'Chi', N'Uống cà phê');




DELETE FROM Budgets;
DELETE FROM Transactions;
DELETE FROM Accounts;
DELETE FROM Categories;
DELETE FROM Users;

DBCC CHECKIDENT ('Users', RESEED, 0);
DBCC CHECKIDENT ('Accounts', RESEED, 0);
DBCC CHECKIDENT ('Categories', RESEED, 0);
DBCC CHECKIDENT ('Transactions', RESEED, 0);
DBCC CHECKIDENT ('Budgets', RESEED, 0);
GO


INSERT INTO Users (FullName, Username, PasswordHash, Email, Phone)
VALUES 
(N'Nguyễn Văn A', 'nva1', '123456', 'a@gmail.com', '0901234567'),
(N'Trần Thị B', 'ttb1', 'abcdef', 'b@gmail.com', '0912345678');

INSERT INTO Accounts (UserID, AccountName, Balance, Currency)
VALUES
(1, N'Ví chính', 5000000, 'VND'),
(1, N'Thẻ ATM', 2000000, 'VND'),
(2, N'Ví chính', 3000000, 'VND');

INSERT INTO Categories (CategoryName, Type)
VALUES
(N'Lương', N'Thu nhập'),
(N'Ăn uống', N'Chi tiêu'),
(N'Đi lại', N'Chi tiêu'),
(N'Học tập', N'Chi tiêu'),
(N'Giải trí', N'Chi tiêu');

INSERT INTO Transactions (AccountID, CategoryID, Amount, TransactionDate, Note, Type)
VALUES
(1, 1, 10000000, '2025-09-01', N'Lương tháng 9', N'Thu'),
(1, 2, 150000, '2025-09-02', N'Ăn trưa', N'Chi'),
(1, 3, 50000, '2025-09-02', N'Xe bus', N'Chi'),
(2, 5, 200000, '2025-09-03', N'Xem phim', N'Chi');

INSERT INTO Budgets (UserID, CategoryID, AmountLimit, StartDate, EndDate)
VALUES
(1, 2, 2000000, '2025-09-01', '2025-09-30'), 
(1, 3, 500000, '2025-09-01', '2025-09-30'), 
(1, 5, 1000000, '2025-09-01', '2025-09-30'); 


SELECT * FROM Users;
SELECT * FROM Accounts;
SELECT * FROM Categories;
SELECT * FROM Transactions;
SELECT * FROM Budgets;