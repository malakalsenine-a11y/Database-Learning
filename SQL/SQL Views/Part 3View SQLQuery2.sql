--Show only customer name, phone, and account status (hide sensitive info like SSN or balance)--

CREATE VIEW CustomerServiceView AS
SELECT
c.FullName AS CustomerName,
c.Phone,
a.Status AS AccountStatus
FROM Customer c
JOIN Account a
ON c.CustomerID = a.CustomerID;

SELECT * FROM CustomerServiceView;
--Show account ID, balance, and account type.--

CREATE VIEW FinanceDepartmentView AS
SELECT
    AccountID,
    Balance,
    AccountType
FROM Account;

SELECT * FROM FinanceDepartmentView;

--Show loan details but hide full customer information. Only include CustomerID--

CREATE VIEW LoanOfficerView AS
SELECT
    LoanID,
    CustomerID,
    LoanAmount,
    LoanType,
    Status
FROM Loan;

SELECT * FROM LoanOfficerView;

-- Show only recent transactions (last 30 days) with account ID and amount --

CREATE VIEW TransactionSummaryView AS
SELECT
    AccountID,
    Amount,
    Transactio_nDate
FROM Transactio_n
WHERE Transactio_nDate >= DATEADD(DAY, -30, GETDATE());

SELECT * FROM TransactionSummaryView;
