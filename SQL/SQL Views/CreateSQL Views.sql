create database Banking_System
use [Banking System];

CREATE TABLE Customer (
CustomerID INT PRIMARY KEY,
FullName NVARCHAR(100),
Email NVARCHAR(100),
Phone NVARCHAR(15),
SSN CHAR(9)
);
CREATE TABLE Account (
AccountID INT PRIMARY KEY,
CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID),
Balance DECIMAL(10, 2),
AccountType VARCHAR(50),
Status VARCHAR(20)
);
CREATE TABLE Transactio_n (
Transactio_nID INT PRIMARY KEY,
AccountID INT FOREIGN KEY REFERENCES Account(AccountID),
Amount DECIMAL(10, 2),
Type VARCHAR(10), -- Deposit, Withdraw
Transactio_nDate DATETIME
);
CREATE TABLE Loan (
LoanID INT PRIMARY KEY,
CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID),
LoanAmount DECIMAL(12, 2),
LoanType VARCHAR(50),
Status VARCHAR(20)
);

INSERT INTO Customer (CustomerID, FullName, Email, Phone, SSN)
VALUES
(1, 'Ahmed Al-Balushi', 'ahmed@mail.com', '+96891234567', '123456789'),
(2, 'Sara Al-Hinai', 'sara@mail.com', '+96891230002', '987654321'),
(3, 'Ali Al-Harthy', 'ali@mail.com', '+96891230003', '456789123');
SELECT * FROM Customer;

INSERT INTO Account (AccountID, CustomerID, Balance, AccountType, Status)
VALUES
(101, 1, 5000.00, 'Savings', 'Active'),
(102, 1, 2500.00, 'Checking', 'Active'),
(103, 2, 8000.00, 'Savings', 'Active'),
(104, 3, 3000.00, 'Checking', 'Inactive');
SELECT * FROM Account;

INSERT INTO Transactio_n (Transactio_nID, AccountID, Amount, Type, Transactio_nDate)
VALUES
(1001, 101, 500.00, 'Deposit', '2024-01-05'),
(1002, 101, 200.00, 'Withdraw', '2024-02-01'),
(1003, 103, 1000.00, 'Deposit', '2024-03-10'),
(1004, 104, 150.00, 'Deposit', '2024-03-15');
SELECT * FROM Transactio_n;

INSERT INTO Loan (LoanID, CustomerID, LoanAmount, LoanType, Status)
VALUES
(201, 1, 10000.00, 'Personal', 'Approved'),
(202, 2, 15000.00, 'Car', 'Pending'),
(203, 3, 5000.00, 'Education', 'Approved');
SELECT * FROM Loan;