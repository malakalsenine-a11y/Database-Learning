-- Core Aggregation Practice--
--Part 1: Warm-Up--

--1. Display all courses with prices.--
select * from Courses;
Select Title, Price
From Courses;

--2. Display all students with join dates.--
Select * from Students;
Select FullName, JoinDate
From Students;

--3. Show all enrollments with completion percent and rating.--
Select * from Enrollments;
Select EnrollmentID, CompletionPercent, rating
From Enrollments;

--4.Count instructors who joined in 2023.--
Select * from Instructors;

SELECT COUNT(*) AS NInstructors2023
FROM Instructors
WHERE YEAR(JoinDate) = 2023;

--5. Count students who joined in April 2023.--
Select * from Students;

SELECT COUNT(*) AS NumStudentsApril2023
FROM Students
WHERE YEAR(JoinDate) = 2023
  AND MONTH(JoinDate) = 4;

--Part 2: Beginner Aggregation--
--1. Count total number of students.--
Select * from Students;

SELECT COUNT(*) AS TotalStudents
FROM Students;

--2. Count total number of enrollments.--
Select * from Enrollments;

Select COUNT (*) AS TotalEnrollment
from Enrollments;

--3. Find average rating per course.--
Select * from Courses;
SELECT CourseID, AVG(Rating) AS AvgRating
FROM Enrollments
GROUP BY CourseID;

--4. Count courses per instructor.--
SELECT InstructorID, COUNT(*) AS NumCourses
FROM Courses
GROUP BY InstructorID;

--5. Count courses per category.--
SELECT CategoryID, COUNT(*) AS NumCourses
FROM Courses
GROUP BY CategoryID;

--6. Count students enrolled in each course.--
SELECT CourseID, COUNT(StudentID) AS NumStudents
FROM Enrollments
GROUP BY CourseID;

--7. Find average course price per category.--
SELECT CategoryID, AVG(Price) AS AvgPrice
FROM Courses
GROUP BY CategoryID;

--8. Find maximum course price.--
SELECT MAX(Price) AS MaxPrice
FROM Courses;

--9. Find min, max, and average rating per course.--
SELECT 
    CourseID, 
    MIN(Rating) AS MinRating,
    MAX(Rating) AS MaxRating,
    AVG(Rating) AS AvgRating
FROM Enrollments
GROUP BY CourseID;

--10. Count how many students gave rating = 5--
SELECT COUNT(*) AS NumStudentsRating5
FROM Enrollments
WHERE Rating = 5;

--Part 3: Extended Beginner Practice--

--11. Count enrollments per month.--
SELECT 
    YEAR(EnrollDate) AS Year,
    MONTH(EnrollDate) AS Month,
    COUNT(*) AS NumEnrollments
FROM Enrollments
GROUP BY YEAR(EnrollDate), MONTH(EnrollDate)
ORDER BY Year, Month;

--12. Find average course price overall.--
SELECT AVG(Price) AS AvgCoursePrice
FROM Courses;

--13. Count students per join month.--
SELECT 
    YEAR(JoinDate) AS Year,
    MONTH(JoinDate) AS Month,
    COUNT(*) AS NumStudents
FROM Students
GROUP BY YEAR(JoinDate), MONTH(JoinDate)
ORDER BY Year, Month;

--14. Count ratings per value (1–5).--
SELECT 
    Rating,
    COUNT(*) AS NumRatings
FROM Enrollments
GROUP BY Rating
ORDER BY Rating;

--15. Find courses that never received rating = 5.--
SELECT CourseID, Title
FROM Courses
WHERE CourseID NOT IN (
    SELECT CourseID
    FROM Enrollments
    WHERE Rating = 5
);

--16. Count courses priced above 30.--
Select * from Courses;
SELECT COUNT(*) AS NumCoursesAbove30
FROM Courses
WHERE Price > 30;

--17. Find average completion percentage.--

SELECT AVG(CompletionPercent) AS AvgCompletion
FROM Enrollments;

--18. Find course with lowest average rating.--
SELECT TOP 1 
    CourseID,
    AVG(Rating) AS AvgRating
FROM Enrollments
GROUP BY CourseID
ORDER BY AVG(Rating) ASC;

--Reflection (End of Day 1)--

Answer briefly:
• What was easiest?

The easiest part was using simple aggregation functions like COUNT() and AVG() to get totals and averages.

• What was hardest?

The hardest part was understanding how GROUP BY works with multiple calculations, like finding the lowest or highest average per course.

• What does GROUP BY do in your own words?

GROUP BY groups rows that have the same value in a column so that we can calculate totals, averages, or other aggregates for each group.
بعد ما يتاثر ب WHERE بس يتاثر ب  HAVING.