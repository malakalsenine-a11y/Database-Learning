--Bank Database – DQL & DML Tasks--
--DQL--

--1. Display all customer records.--
SELECT *FROM Customer;

--3. Display each loan ID, amount, and type.--
SELECT loan_id, amount, loan_type
FROM Loan;

--4. Display account number and annual interest (5% of balance) as AnnualInterest.--
SELECT 
    account_no,
    balance * 0.05 AS AnnualInterest
FROM Account;

--6. List accounts with balances above 20000--

SELECT *
FROM Account
WHERE balance > 20000;

--7. Display accounts opened in 2023.--
SELECT *
FROM Account
WHERE YEAR(date_created) = 2023;

--8. Display accounts ordered by balance descending.--
SELECT *
FROM Account
ORDER BY balance DESC;

--9. Display the maximum, minimum, and average account balance.--
SELECT 
    MAX(balance) AS MaxBalance,
    MIN(balance) AS MinBalance,
    AVG(balance) AS AvgBalance
FROM Account;

--10. Display total number of customers.--
SELECT COUNT(*) AS TotalCustomers
FROM Customer;

--11. Display customers with NULL phone numbers.--
SELECT *
FROM Customer
WHERE phone IS NULL;

--DML--
--13. Insert yourself as a new customer and open an account with balance 10000--
INSERT INTO Customer (customer_id, name, address, phone, date_of_birth)
VALUES (103, 'Malak Al-Sinani', 'Muscat', '+96895591983', '2001-10-28');

INSERT INTO Account (account_no, customer_id, balance, account_type, date_created)
VALUES (3004, 103, 10000.00, 'Savings', '2025-12-16');

--14. Insert another customer with NULL phone and address.--
INSERT INTO Customer (customer_id, name, address, phone, date_of_birth)
VALUES (104, 'Sara Al-Hinai', NULL, NULL, '2002-03-15');

--15. Increase your account balance by 20%.--
UPDATE Account
SET balance = balance * 1.2
WHERE account_no = 3004;
--16. Increase balance by 5% for accounts with balance less than 5000.--
UPDATE Account
SET balance = balance * 1.05
WHERE balance < 5000;
--17. Update phone number to 'Not Provided' where phone is NULL.--
UPDATE Customer
SET phone = 'Not Provided'
WHERE phone IS NULL;
