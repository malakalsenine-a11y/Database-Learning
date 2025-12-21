--University Database – JOIN Queries--

--1. Display the department ID, name, and the full name of the faculty managing it.--

SELECT d.Did AS DepartmentID, d.Dname AS DepartmentName, f.Name AS FacultyFullName
FROM Department d JOIN Faculty f
ON d.Did = f.Department_id;

--2. Display each program's name and the name of the department offering it.--
SELECT c.Course_name AS ProgramName, d.Dname AS DepartmentName
FROM Course c JOIN Department d
ON c.Department_id = d.Did;

--3. Display the full student data and the full name of their faculty advisor.--
SELECT s.*,f.Name AS FacultyAdvisorFullName
FROM Student s LEFT JOIN Faculty f
ON s.Faculty_id = f.Fid;

--4. Display class IDs, course titles, and room locations for classes in buildings 'A' or 'B'.--
select * from Exams;
select * from Department;
select * from Course;
SELECT e.Exam_code AS ClassID, c.Course_name AS CourseTitle, e.Room AS RoomLocation
FROM Exams e JOIN Department d ON e.Department_id = d.Did JOIN Course c
ON c.Department_id = d.Did
WHERE e.Room LIKE 'A%' OR e.Room LIKE 'B%';

--5. Display full data about courses whose titles start with "N" (e.g., "Introduction to...").--
SELECT * FROM Course
WHERE Course_name LIKE 'N%';

--6. Display names of students in program ID 3 whose GPA is between 2.5 and 4.0.--
SELECT * FROM Student;
SELECT 
s.Fname + ' ' + s.Lname AS StudentName, sc.Course_id
FROM Student s JOIN Student_Course sc
ON s.S_id = sc.S_id
WHERE s.GPA BETWEEN 2.5 AND 4.0;

--7. Retrieve student names in the Engineering program who earned grades ≥ 80 in the "Database" course.--
-- لان ما معي  grades بضيف --
ALTER TABLE Student_Course
ADD Grade INT;
UPDATE Student_Course
SET Grade = 95
WHERE S_id = 1 AND Course_id = 1;

UPDATE Student_Course
SET Grade = 88
WHERE S_id = 2 AND Course_id = 2;
Select * from Student_Course;

SELECT s.Fname + ' ' + s.Lname AS StudentName, c.Course_name
FROM Student s JOIN Student_Course sc 
ON s.S_id = sc.S_id JOIN Course c
ON sc.Course_id = c.Course_id
WHERE c.Course_name LIKE '%Database%' AND sc.Grade >= 80;



--8. Find names of students who are advised by "Dr. Ahmed Hassan".--
SELECT * FROM Faculty;
SELECT * FROM Student;
SELECT s.Fname + ' ' + s.Lname AS StudentName, f.Name AS FacultyAdvisor
FROM Student s JOIN Faculty f
ON s.Faculty_id = f.Fid
WHERE f.Name = 'Sara AL-Hinai';

--9. Retrieve each student's name and the titles of courses they are enrolled in, ordered by course title.--
SELECT s.Fname + ' ' + s.Lname AS StudentName, c.Course_name
FROM Student s JOIN Student_Course sc
ON s.S_id = sc.S_id JOIN Course c
ON sc.Course_id = c.Course_id
ORDER BY c.Course_name;

--10. For each subject, retrieve the subject ID, course name, department name, and faculty name teaching the subject.--
SELECT sub.Subject_id AS ClassID, c.Course_name, d.Dname AS DepartmentName, f.Name AS FacultyName
FROM Subject sub JOIN Course c
ON sub.Course_id = c.Course_id JOIN Faculty f ON sub.F_id = f.Fid JOIN Department d
ON c.Department_id = d.Did;

--11. Display all faculty members who manage any department.--
SELECT f.Fid, f.Name, d.Dname AS DepartmentName
FROM Faculty f JOIN Department d
ON f.Department_id = d.Did;

--12. Display all students and their advisors' names, even if some students don’t have advisors yet--
SELECT s.Fname + ' ' + s.Lname AS StudentName, f.Name AS AdvisorName
FROM Student s LEFT JOIN Faculty f
ON s.Faculty_id = f.Fid;
