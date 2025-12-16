create database Bank
use Bank;

CREATE TABLE Branch (
    branch_id INT PRIMARY KEY,
    address NVARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL
);

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    name NVARCHAR(50) NOT NULL,
    address NVARCHAR(100),
    phone VARCHAR(15),
    date_of_birth DATE
);

CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    name NVARCHAR(50) NOT NULL,
    position NVARCHAR(30),
    branch_id INT NOT NULL,
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

CREATE TABLE Account (
    account_no INT PRIMARY KEY,
    customer_id INT NOT NULL,
    balance DECIMAL(10,2),
    account_type NVARCHAR(20),
    date_created DATE,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE Transaction_Table (
    transaction_id INT PRIMARY KEY,
    account_no INT NOT NULL,
    transaction_date DATE,
    amount DECIMAL(10,2),
    transaction_type NVARCHAR(20),
    FOREIGN KEY (account_no) REFERENCES Account(account_no)
);

CREATE TABLE Loan (
    loan_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    employee_id INT NOT NULL,
    loan_type NVARCHAR(30),
    amount DECIMAL(10,2),
    issue_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Employee_Customer (
    employee_id INT,
    customer_id INT,
    action_type NVARCHAR(30),
    PRIMARY KEY (employee_id, customer_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);
INSERT INTO Branch (branch_id, address, phone)
VALUES
(1, 'Muscat – Al Khuwair', '+96824560001'),
(2, 'Salalah – City Center', '+96823230002');
select * from Branch;

INSERT INTO Customer (customer_id, name, address, phone, date_of_birth)
VALUES
(101, 'Ahmed Al-Balushi', 'Muscat', '+96891234567', '1990-05-12'),
(102, 'Sara Al-Hinai', 'Salalah', '+96891230002', '1995-08-20');
select * from Customer;

INSERT INTO Employee (employee_id, name, position, branch_id)
VALUES
(201, 'Khalid Al-Sinani', 'Account Officer', 1),
(202, 'Fatma Al-Harthy', 'Loan Officer', 2);
select * from Employee;

INSERT INTO Account (account_no, customer_id, balance, account_type, date_created)
VALUES
(3001, 101, 5000.00, 'Savings', '2022-01-10'),
(3002, 101, 2500.00, 'Checking', '2023-03-15'),
(3003, 102, 8000.00, 'Savings', '2021-07-20');
select * from Account;

INSERT INTO Transaction_Table (transaction_id, account_no, transaction_date, amount, transaction_type)
VALUES
(4001, 3001, '2024-01-05', 500.00, 'Deposit'),
(4002, 3001, '2024-02-01', 200.00, 'Withdrawal'),
(4003, 3003, '2024-03-10', 1000.00, 'Transfer');
select * from  Transaction_Table;

INSERT INTO Loan (loan_id, customer_id, employee_id, loan_type, amount, issue_date)
VALUES
(5001, 101, 202, 'Personal Loan', 10000.00, '2023-06-01'),
(5002, 102, 202, 'Car Loan', 15000.00, '2024-02-15');
select * from Loan;

INSERT INTO Employee_Customer (employee_id, customer_id, action_type)
VALUES
(201, 101, 'Open Account'),
(202, 101, 'Process Loan'),
(202, 102, 'Process Loan');
select * from Employee_Customer;