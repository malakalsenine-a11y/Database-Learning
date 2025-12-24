--Day 2 – JOIN + Aggregation + Analysis--
--Part 4: JOIN + Aggregation--

--1. Course title + instructor name + enrollments.--
Select * from Courses;
Select * from Instructors;
Select * from Enrollments;
SELECT 
 C.Title AS CourseTitle,
 I.FullName AS InstructorName,
 COUNT(E.StudentID) AS TotalEnrollments
FROM Courses C
JOIN Instructors I
ON C.InstructorID = I.InstructorID
LEFT JOIN Enrollments E
ON C.CourseID = E.CourseID
GROUP BY C.Title, I.FullName;


--2. Category name + total courses + average price.--
SELECT 
CAT.CategoryName,
COUNT(C.CourseID) AS TotalCourses,
AVG(C.Price) AS AveragePrice
FROM Categories CAT
LEFT JOIN Courses C
ON CAT.CategoryID = C.CategoryID
GROUP BY CAT.CategoryName;
--3. Instructor name + average course rating.--
SELECT 
I.FullName AS InstructorName,
AVG(E.Rating) AS AverageRating
FROM Instructors I
JOIN Courses C
ON I.InstructorID = C.InstructorID
LEFT JOIN Enrollments E
ON C.CourseID = E.CourseID
GROUP BY I.FullName;

--4. Student name + total courses enrolled.--
SELECT * FROM Students;
SELECT * FROM Courses;
SELECT * FROM Enrollments;

SELECT
S.FullName  AS StudentName,
COUNT(E.CourseID)  AS CoursesEnrolled
from Students s
JOIN Enrollments E
ON S.StudentID = E.StudentID
GROUP BY S.FullName


--5. Category name + total enrollments.--
SELECT 
CAT.CategoryName,
COUNT(E.StudentID) AS TotalEnrollments
FROM Categories CAT
LEFT JOIN Courses C
ON CAT.CategoryID = C.CategoryID
LEFT JOIN Enrollments E
ON C.CourseID = E.CourseID
GROUP BY CAT.CategoryName;

--6. Instructor name + total revenue.--
SELECT 
I.FullName AS InstructorName,
SUM(C.Price) AS TotalRevenue
FROM Instructors I
JOIN Courses C
ON I.InstructorID = C.InstructorID
JOIN Enrollments E
ON C.CourseID = E.CourseID
GROUP BY I.FullName;

--7. Course title + % of students completed 100%.--
SELECT 
C.Title AS CourseTitle,
(SUM(CASE WHEN E.CompletionPercent = 100 THEN 1 ELSE 0 END) * 100.0 / COUNT(E.StudentID)) AS PercentCompleted100
FROM Courses C
LEFT JOIN Enrollments E
ON C.CourseID = E.CourseID
GROUP BY C.Title;

--Part 5: HAVING Practice--
--1. Courses with more than 2 enrollments.--
SELECT 
C.Title AS CourseTitle,
COUNT(E.StudentID) AS TotalEnrollments
FROM Courses C
JOIN Enrollments E
ON C.CourseID = E.CourseID
GROUP BY C.Title
HAVING COUNT(E.StudentID) > 2;

--2. Instructors with average rating above 4.--
SELECT 
I.FullName AS InstructorName,
AVG(E.Rating) AS AverageRating
FROM Instructors I
JOIN Courses C
ON I.InstructorID = C.InstructorID
JOIN Enrollments E
ON C.CourseID = E.CourseID
GROUP BY I.FullName
HAVING AVG(E.Rating) > 4;

--3. Courses with average completion below 60%.--
SELECT 
C.Title AS CourseTitle,
AVG(E.CompletionPercent) AS AverageCompletion
FROM Courses C
LEFT JOIN Enrollments E
ON C.CourseID = E.CourseID
GROUP BY C.Title
HAVING AVG(E.CompletionPercent) < 60;

--4. Categories with more than 1 course.--
SELECT 
CAT.CategoryName,
COUNT(C.CourseID) AS TotalCourses
FROM Categories CAT
JOIN Courses C
ON CAT.CategoryID = C.CategoryID
GROUP BY CAT.CategoryName
HAVING COUNT(C.CourseID) > 1;

--5. Students enrolled in at least 2 courses.--
SELECT 
S.FullName AS StudentName,
COUNT(E.CourseID) AS TotalEnrollments
FROM Students S
JOIN Enrollments E
ON S.StudentID = E.StudentID
GROUP BY S.FullName
HAVING COUNT(E.CourseID) >= 2;

--Part 6: Analytical Thinking--
--Answer using SQL + short explanation:--

--1. Best performing course.--
SELECT 
C.Title AS CourseTitle,
AVG(E.Rating) AS AvgRating,
AVG(E.CompletionPercent) AS AvgCompletion
FROM Courses C
JOIN Enrollments E
ON C.CourseID = E.CourseID
GROUP BY C.Title
ORDER BY AvgRating DESC, AvgCompletion DESC
OFFSET 0 ROWS FETCH NEXT 1 ROW ONLY;
 
-- (short explanation:)--
--We calculate the average ratings and completion percentages for each course (AVG).--
--We order them from highest to lowest (ORDER BY).--
--We take only the first row, which gives us the best performing course.--


--2. Instructor to promote.--
SELECT 
I.FullName AS InstructorName,
AVG(E.Rating) AS AvgRating
FROM Instructors I
JOIN Courses C
ON I.InstructorID = C.InstructorID
JOIN Enrollments E
ON C.CourseID = E.CourseID
GROUP BY I.FullName
ORDER BY AvgRating DESC
OFFSET 0 ROWS FETCH NEXT 1 ROW ONLY;
-- (short explanation:)--
--We calculate the average rating for each instructor (AVG(E.Rating)).--
--We order from highest to lowest: the best instructor comes first.--
--We take only the first instructor for promotion.--

--3. Highest revenue category.--
SELECT 
CAT.CategoryName,
SUM(C.Price) AS TotalRevenue
FROM Categories CAT
JOIN Courses C
ON CAT.CategoryID = C.CategoryID
JOIN Enrollments E
ON C.CourseID = E.CourseID
GROUP BY CAT.CategoryName
ORDER BY TotalRevenue DESC
OFFSET 0 ROWS FETCH NEXT 1 ROW ONLY;

-- (short explanation:)--
--We calculate the revenue for each enrollment (Price × number of students).--
--We order from highest to lowest → the category with the highest revenue comes first.--

--4. Do expensive courses have better ratings?--
SELECT 
CASE 
WHEN C.Price > 30 THEN 'Expensive' 
ELSE 'Cheap' 
END AS PriceGroup,
AVG(E.Rating) AS AvgRating
FROM Courses C
JOIN Enrollments E
ON C.CourseID = E.CourseID
GROUP BY CASE 
WHEN C.Price > 30 THEN 'Expensive' 
ELSE 'Cheap' 
END;
-- (short explanation:)--
--We classify the courses by price (>30 = expensive, ≤30 = cheap).--
--We calculate the average rating for each group.--
--Comparing the results shows whether expensive courses have better ratings.--


--5. Do cheaper courses have higher completion?--
SELECT 
CASE 
WHEN C.Price <= 30 THEN 'Cheap' 
ELSE 'Expensive' 
END AS PriceGroup,
AVG(E.CompletionPercent) AS AvgCompletion
FROM Courses C
JOIN Enrollments E
ON C.CourseID = E.CourseID
GROUP BY CASE 
WHEN C.Price <= 30 THEN 'Cheap' 
ELSE 'Expensive' 
END;
-- (short explanation:)--
--We classify the courses by price.--
--We calculate the average completion percentage for each group.--
--We compare the results → to see if cheaper courses have higher completion rates.--

