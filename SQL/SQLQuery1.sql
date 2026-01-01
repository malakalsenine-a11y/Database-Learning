--Section 1: Complex Queries with Joins--
--1. Library Book Inventory Report--
SELECT 
    L.Name AS Library_Name,
    COUNT(B.Book_ID) AS Total_Books,
    SUM(CASE WHEN B.IsAvailable = 1 THEN 1 ELSE 0 END) AS Available_Books,
    SUM(CASE WHEN B.IsAvailable = 0 THEN 1 ELSE 0 END) AS Books_On_Loan
FROM Library L
LEFT JOIN Book B            --استخدمنا LEFT JOIN لضمان ظهور كل المكتبات حتى لو ما فيها كتب.--
    ON L.Library_ID = B.Library_ID
GROUP BY L.Name;

--2. Active Borrowers Analysis--

SELECT 
    M.Full_Name AS Member_Name,
    M.Email,
    B.Title AS Book_Title,
    L.Loan_Date,
    L.Due_Date,
    L.Status
FROM Loan L
JOIN Member M
    ON L.Member_ID = M.Member_ID
JOIN Book B
    ON L.Book_ID = B.Book_ID
WHERE L.Status IN ('Issued', 'Overdue');

--3. Overdue Loans with Member Details--
SELECT
    M.Full_Name AS Member_Name,
    M.Phone_Number,
    B.Title AS Book_Title,
    Lb.Name AS Library_Name,
    DATEDIFF(DAY, L.Due_Date, GETDATE()) AS Days_Overdue,
    ISNULL(SUM(F.Amount), 0) AS Total_Fine_Paid
FROM Loan L
JOIN Member M
    ON L.Member_ID = M.Member_ID
JOIN Book B
    ON L.Book_ID = B.Book_ID
JOIN Library Lb
    ON B.Library_ID = Lb.Library_ID
LEFT JOIN Fine_Payment F
    ON L.Loan_ID = F.Loan_ID
WHERE L.Status = 'Overdue'
GROUP BY
    M.Full_Name,
    M.Phone_Number,
    B.Title,
    Lb.Name,
    L.Due_Date;

--4. Staff Performance Overview--
SELECT
    L.Name AS Library_Name,
    S.Full_Name AS Staff_Name,
    S.Position,
    COUNT(B.Book_ID) AS Total_Books_Managed
FROM Library L
JOIN Staff S
    ON L.Library_ID = S.Library_ID
LEFT JOIN Book B
    ON L.Library_ID = B.Library_ID
GROUP BY
    L.Name,
    S.Full_Name,
    S.Position;

--5. Book Popularity Report--
SELECT 
    B.Title,
    B.ISBN,
    B.Genre,
    COUNT(L.Loan_ID) AS TotalLoans,
    AVG(CAST(R.Rating AS FLOAT)) AS AvgRating  --CAST(R.Rating AS FLOAT) لضمان دقة حساب المتوسط.--
FROM Book B
 JOIN Loan L ON B.Book_ID = L.Book_ID
LEFT JOIN Review R ON B.Book_ID = R.Book_ID    --استخدمنا LEFT JOIN مع Review لأن بعض الكتب قد لا يكون لها تقييم.--
GROUP BY B.Title, B.ISBN, B.Genre
HAVING COUNT(L.Loan_ID) >= 3;                 --HAVING COUNT(L.Loan_ID) >= 3 يضمن عرض الكتب المستعارة 3 مرات أو أكثر.--

--6. Member Reading History--
SELECT 
    M.Full_Name AS MemberName,
    B.Title AS BookTitle,
    L.Loan_Date,
    L.Due_Date,
    L.Return_Date,
    R.Rating,
    R.Comments
FROM Member M
LEFT JOIN Loan L ON M.Member_ID = L.Member_ID
LEFT JOIN Book B ON L.Book_ID = B.Book_ID          --LEFT JOIN لضمان ظهور جميع الأعضاء حتى لو ما استعارة كتب.--
LEFT JOIN Review R ON M.Member_ID = R.Member_ID AND B.Book_ID = R.Book_ID
ORDER BY M.Full_Name, L.Loan_Date;

--7. Revenue Analysis by Genre--

SELECT 
    B.Genre,
    COUNT(L.Loan_ID) AS TotalLoans,
    ISNULL(SUM(F.Amount), 0) AS TotalFineCollected,    --ISNULL لضمان أن القيم الفارغة تتحول إلى 0.--
    CASE WHEN COUNT(L.Loan_ID) > 0 THEN ISNULL(SUM(F.Amount), 0) * 1.0 / COUNT(L.Loan_ID) ELSE 0 END AS AvgFinePerLoan
FROM Book B
LEFT JOIN Loan L ON B.Book_ID = L.Book_ID 
LEFT JOIN Fine_Payment F ON L.Loan_ID = F.Loan_ID  --LEFT JOIN لضمان ظهور كل الأنواع حتى لو لم يكن لها قروض أو غرامات.
GROUP BY B.Genre;  --التجميع يتم حسب نوع الكتاب لحساب الإجماليات لكل نوع.--

--Section 2: Aggregate Functions and Grouping--
--Write queries using aggregate functions and GROUP BY:--

--8. Monthly Loan Statistics--
--Generate a report showing the number of loans issued per month for the current year. Include month name, total loans, total returned, and total still issued/overdue.--
SELECT
      DATENAME(Month, Loan_Date) AS Month_Name,  --اسم الشهر--
      COUNT(*) AS Total_Loans,   -- اجمالي القروض--
      COUNT(CASE WHEN Status = 'Returned' THEN 1 END) AS Total_Returned,   --القروض التي تم ارجاعها --
      COUNT(CASE WHEN Status IN ('Issued', 'Overdue') THEN 1 END) AS Total_Issued_Overdue    --القروض المفتوحة او اللي متاخرة--
FROM Loan
WHERE YEAR(Loan_Date) = YEAR(GETDATE())  -- فقط قروض العام الحالي
GROUP BY MONTH(Loan_Date), DATENAME(MONTH, Loan_Date)  -- تجميع حسب رقم الشهر واسم الشهر
ORDER BY MONTH(Loan_Date);  -- ترتيب من يناير إلى ديسمبر

--9. Member Engagement Metrics--
--For each member, calculate: total books borrowed, total books currently on loan, total fines paid, and average rating they give in reviews. Only include members who have borrowed at least one book--

SELECT 
    M.Full_Name AS Member_Name,
    COUNT(L.Loan_ID) AS Total_Books_Borrowed,  -- إجمالي القروض
    COUNT(CASE WHEN L.Status IN ('Issued','Overdue') THEN 1 END) AS Total_Current_Loans,  -- القروض الحالية
    ISNULL(SUM(F.Amount), 0) AS Total_Fines_Paid,  -- مجموع الغرامات المدفوعة
    ISNULL(AVG(R.Rating), 0) AS Avg_Review_Rating  -- متوسط التقييمات
FROM Member M
JOIN Loan L ON M.Member_ID = L.Member_ID
LEFT JOIN Fine_Payment F ON L.Loan_ID = F.Loan_ID
LEFT JOIN Review R ON L.Book_ID = R.Book_ID AND M.Member_ID = R.Member_ID
GROUP BY M.Full_Name
HAVING COUNT(L.Loan_ID) >= 1  -- شرط: العضو استعار كتابًا واحدًا على الأقل
ORDER BY M.Full_Name;

--10. Library Performance Comparison--
--Compare libraries by showing: library name, total books owned, total active members (members with at least one loan), total revenue from fines, and average books per member.--

SELECT
    L.Name AS Library_Name,
    COUNT(B.Book_ID) AS Total_Books_Owned,  -- إجمالي الكتب
    COUNT(DISTINCT CASE WHEN Loan.Loan_ID IS NOT NULL THEN Loan.Member_ID END) AS Total_Active_Members,  -- الأعضاء النشطين
    ISNULL(SUM(F.Amount),0) AS Total_Fines_Revenue,  -- مجموع الغرامات
    CASE 
        WHEN COUNT(DISTINCT CASE WHEN Loan.Loan_ID IS NOT NULL THEN Loan.Member_ID END) = 0 
        THEN 0
        ELSE CAST(COUNT(B.Book_ID) AS DECIMAL(10,2)) 
             / COUNT(DISTINCT CASE WHEN Loan.Loan_ID IS NOT NULL THEN Loan.Member_ID END)
    END AS Avg_Books_Per_Member  -- متوسط الكتب لكل عضو
FROM Library L
LEFT JOIN Book B ON L.Library_ID = B.Library_ID
LEFT JOIN Loan Loan ON B.Book_ID = Loan.Book_ID
LEFT JOIN Fine_Payment F ON Loan.Loan_ID = F.Loan_ID
GROUP BY L.Name
ORDER BY L.Name;

--11. High-Value Books Analysis--
--Identify books priced above the average book price in their genre. Show book title,genre, price, genre average price, and difference from average.--
-- حساب الكتب الأغلى من متوسط سعر النوع باستخدام CTE
WITH BookWithAvg AS (
    SELECT
        B.Title,
        B.Genre,
        B.Price,
        AVG(B.Price) OVER (PARTITION BY B.Genre) AS Genre_Avg_Price
    FROM Book B
)
SELECT
    Title AS Book_Title,
    Genre,
    Price,
    Genre_Avg_Price,
    Price - Genre_Avg_Price AS Difference_From_Avg
FROM BookWithAvg
WHERE Price > Genre_Avg_Price
ORDER BY Genre, Price DESC; -- ترتيب حسب النوع ثم السعر من الأعلى

--12. Payment Pattern Analysis--
--Group payments by payment method and show: payment method, number of transactions, total amount collected, average payment amount, and percentage of total revenue--
SELECT
    Method AS Payment_Method,  --يعرض طرق الدفع--
    COUNT(Payment_ID) AS Number_of_Transactions, -- يحسب عدد عمليات الدفع لكل الطرق--
    SUM(Amount) AS Total_Amount_Collected, --يجمع كل المبالغ المدفوعة لكل الطرق--
    AVG(Amount) AS Average_Payment_Amount, -- يحسب متوسط قيمة الدفع لكل الطرق--
    ROUND(
        (SUM(Amount) * 100.0) / SUM(SUM(Amount)) OVER (),
        2
    ) AS Percentage_of_Total_Revenue
FROM Fine_Payment
GROUP BY Method;

--Section 3: Views Creation--
--13. vw_CurrentLoans--
--A view that shows all currently active loans (status 'Issued' or 'Overdue') with member details, book details, loan information, and calculated days until due (or days overdue).--

CREATE VIEW vw_CurrentLoans
AS
SELECT
    M.Full_Name        AS Member_Name,
    M.Email,
    M.Phone_Number,

    B.Title            AS Book_Title,
    B.ISBN,
    B.Genre,

    L.Loan_Date,
    L.Due_Date,
    L.Status,

    CASE
        WHEN L.Status = 'Issued'
            THEN DATEDIFF(DAY, GETDATE(), L.Due_Date)
        WHEN L.Status = 'Overdue'
            THEN DATEDIFF(DAY, L.Due_Date, GETDATE())
    END AS Days_Remaining_Or_Overdue

FROM Loan L
JOIN Member M
    ON L.Member_ID = M.Member_ID
JOIN Book B
    ON L.Book_ID = B.Book_ID
WHERE L.Status IN ('Issued', 'Overdue');


SELECT * FROM vw_CurrentLoans;

--14. vw_LibraryStatistics--
--A comprehensive view showing library-level statistics including total books, available books, total members, active loans, total staff, and total revenue from fines.--
CREATE VIEW vw_LibraryStatistics
AS
SELECT
    L.Name AS Library_Name,

    COUNT(DISTINCT B.Book_ID) AS Total_Books,

    SUM(CASE WHEN B.IsAvailable = 1 THEN 1 ELSE 0 END) AS Available_Books,

    COUNT(DISTINCT M.Member_ID) AS Total_Members,

    COUNT(DISTINCT CASE 
        WHEN Lo.Status IN ('Issued', 'Overdue') 
        THEN Lo.Loan_ID 
    END) AS Active_Loans,

    COUNT(DISTINCT S.Staff_ID) AS Total_Staff,

    ISNULL(SUM(F.Amount), 0) AS Total_Fine_Revenue

FROM Library L
LEFT JOIN Book B
    ON L.Library_ID = B.Library_ID
LEFT JOIN Staff S
    ON L.Library_ID = S.Library_ID
LEFT JOIN Loan Lo
    ON B.Book_ID = Lo.Book_ID
LEFT JOIN Member M
    ON Lo.Member_ID = M.Member_ID
LEFT JOIN Fine_Payment F
    ON Lo.Loan_ID = F.Loan_ID

GROUP BY L.Name;
SELECT * FROM vw_LibraryStatistics;

--15. vw_BookDetailsWithReviews--
--A view combining book information with aggregated review data (average rating, total reviews, latest review date) and current availability status.--
CREATE VIEW vw_BookDetailsWithReviews
AS
SELECT
    B.Book_ID,
    B.Title,
    B.ISBN,
    B.Genre,
    B.Price,
    B.IsAvailable AS Current_Availability,

    AVG(R.Rating)        AS Average_Rating,
    COUNT(R.Review_ID)  AS Total_Reviews,
    MAX(R.Review_Date)  AS Latest_Review_Date

FROM Book B
LEFT JOIN Review R
    ON B.Book_ID = R.Book_ID

GROUP BY
    B.Book_ID,
    B.Title,
    B.ISBN,
    B.Genre,
    B.Price,
    B.IsAvailable;
	SELECT * FROM vw_BookDetailsWithReviews;
