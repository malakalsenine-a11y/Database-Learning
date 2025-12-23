create database University
use University;

create table Department(
Did int primary key identity (1,1),
Dname nvarchar (20) not null
);

CREATE TABLE Faculty (
    Fid INT PRIMARY KEY identity (1,1),
    Name VARCHAR(50),
    Mobile_no VARCHAR(15),
    Salary DECIMAL(8,2),
    Department_id INT,
    FOREIGN KEY (Department_id) REFERENCES Department(Did)
);
CREATE TABLE Hostel (
    Hid INT PRIMARY KEY,
    Hostel_name VARCHAR(50),
    City nVARCHAR(30),
    State nVARCHAR(30),
    Address nVARCHAR(100),
    Pin_code VARCHAR(10),
    No_of_seats INT
);

CREATE TABLE Student (
    S_id INT PRIMARY KEY identity(1,1),
    Fname NVARCHAR(30),
    Lname NVARCHAR(30),
    Phone_no VARCHAR(15),
    DOB DATE,
    Department_id INT,
    Hostel_id INT,
	Faculty_id INT,
    FOREIGN KEY (Department_id) REFERENCES Department(Did),
    FOREIGN KEY (Hostel_id) REFERENCES Hostel(Hid)

);
CREATE TABLE Course (
    Course_id INT PRIMARY KEY identity(1,1),
    Course_name VARCHAR(50),
    Duration VARCHAR(20),
    Department_id INT,
    FOREIGN KEY (Department_id) REFERENCES Department(Did)
);
CREATE TABLE Subject (
    Subject_id INT PRIMARY KEY identity(1,1),
    Subject_name VARCHAR(50),
    Course_id INT,
    F_id INT,
    FOREIGN KEY (F_id) REFERENCES Faculty(Fid)
);

CREATE TABLE Exams (
    Exam_code INT PRIMARY KEY,
    Exam_date DATE,
    Exam_time TIME,
    Room VARCHAR(20),
    Department_id INT,
    FOREIGN KEY (Department_id) REFERENCES Department(Did)
);

ALTER TABLE Student
ADD CONSTRAINT FK_Student_Faculty
FOREIGN KEY (Faculty_id)
REFERENCES Faculty(Fid);

--جدول علاقات M to M--

CREATE TABLE Student_Course ( 
    S_id INT,
    Course_id INT,
    PRIMARY KEY (S_id, Course_id),
    FOREIGN KEY (S_id) REFERENCES Student(S_id),
    FOREIGN KEY (Course_id) REFERENCES Course(Course_id)
);

CREATE TABLE Student_Subject (
    S_id INT,
    Subject_id INT,
    PRIMARY KEY (S_id, Subject_id),
    FOREIGN KEY (S_id) REFERENCES Student(S_id),
    FOREIGN KEY (Subject_id) REFERENCES Subject(Subject_id)
);

CREATE TABLE Student_Exam (
    S_id INT,
    Exam_code INT,
    PRIMARY KEY (S_id, Exam_code),
    FOREIGN KEY (S_id) REFERENCES Student(S_id),
    FOREIGN KEY (Exam_code) REFERENCES Exams(Exam_code)
);

ALTER TABLE Department
ALTER COLUMN Dname NVARCHAR(50) NOT NULL;

INSERT INTO Department (Dname)
VALUES 
('Computer Science'),
('Information Technology'),
('Business Administration');
select * from Department;

INSERT INTO Faculty (Name, Mobile_no, Salary, Department_id)
VALUES
('Ali Al-Balushi', '+96891234567', 1200.00, 3),
('Sara Al-Hinai', '+96891234568', 1300.00, 4),
('Malak Al-Sinani', '+96895591983', 1500.00, 5);
SELECT * from Faculty;

INSERT INTO Hostel (Hid, Hostel_name, City, State, Address, Pin_code, No_of_seats)
VALUES
(1, 'Al-Suwaiq Hostel', 'Suwaiq', 'Suwaiq', 'Street 1', '112233', 50),
(2, 'Khoula Hostel', 'Muscat', 'Muscat', 'Street 2', '445566', 40);
select * from Hostel;

INSERT INTO Student (Fname, Lname, Phone_no, DOB, Department_id, Hostel_id, Faculty_id)
VALUES
('Malak', 'Al-Sinani', '+96895591983', '2001-10-28', 5, 1, 4),
('Sara', 'Al-Hinai', '+96891230002', '2002-03-15', 4, 2, 3);
select * from Student;

INSERT INTO Course (Course_name, Duration, Department_id)
VALUES
('Database Systems', '9 months', 3),
('Network', '4 months', 4);
select * from Course;

INSERT INTO Subject (Subject_name, Course_id, F_id)
VALUES
('SQL Basics', 1, 2),
('Advanced Networking', 2, 3);
select * from Subject;

INSERT INTO Exams(Exam_code, Exam_date, Exam_time, Room, Department_id)
VALUES
(101, '2025-12-10', '09:00', 'Room A', 3),
(102, '2024-01-21', '10:00', 'Room B', 4);
select * from Exams;
   
   INSERT INTO Student_Course (S_id, Course_id)
VALUES
(1, 1),
(2, 2);
select * from Student_Course;

INSERT INTO Student_Subject (S_id, Subject_id)
VALUES
(1, 1),
(2, 2);
SELECT * FROM Student_Subject;

INSERT INTO Student_Exam (S_id, Exam_code)
VALUES
(1, 101),
(2, 102);
select * from Student_Exam;
-- اضافة الاشياء المطلوبة في المهام--
ALTER TABLE Student
ADD GPA DECIMAL(3,2),
    Enrollment_date DATE,
    Status NVARCHAR(20);

ALTER TABLE Course
ADD Credits INT;

EXEC sp_columns Student;

-- بيانات الطالب--
UPDATE Student
SET GPA = 3.7,
    Enrollment_date = '2021-09-01',
    Status = 'Active'
WHERE S_id = 1;

UPDATE Course
set Credits = 3
where Course_id = 1;

--University Database – DQL & DML Task--
--DQL--
-- Q1: Display all student records.--
SELECT * 
FROM Student;
-- Q2: Display each student's full name, enrollment date, and current status.--
SELECT 
    Fname + ' ' + Lname AS Full_Name,
    Enrollment_date,
    Status
FROM Student;
-- Q3: Display each course title and credits.--
SELECT 
    Course_name AS Course_Title,
    Credits
FROM Course;
-- Q4: Display each student’s full name and GPA as GPA Score.--
SELECT 
    Fname + ' ' + Lname AS Full_Name,
    GPA AS [GPA Score]
FROM Student;

-- Q5: List student IDs and names of students with GPA greater than 3.5--
SELECT 
    S_id,
    Fname + ' ' + Lname AS Full_Name
FROM Student
WHERE GPA > 3.5;

-- Q6: List students who enrolled before 2022--
SELECT 
    S_id,
    Fname + ' ' + Lname AS Full_Name,
    Enrollment_date
FROM Student
WHERE Enrollment_date < '2022-01-01';

-- Q7: Display students with GPA between 3.0 and 3.5.
SELECT 
    S_id,
    Fname + ' ' + Lname AS Full_Name,
    GPA
FROM Student
WHERE GPA BETWEEN 3.0 AND 3.5;

--Q8: Display students ordered by GPA descending--
SELECT 
    S_id,
    Fname + ' ' + Lname AS Full_Name,
    GPA
FROM Student
ORDER BY GPA DESC;
--Q9: Display the maximum, minimum, and average GPA--
SELECT 
    MAX(GPA) AS Max_GPA,
    MIN(GPA) AS Min_GPA,
    AVG(GPA) AS Avg_GPA
FROM Student;

--Q10: Display total number of students--
SELECT COUNT(*) AS Total_Students
FROM Student;
--Q11: Display students whose names end with 'a'--
SELECT 
    S_id,
    Fname + ' ' + Lname AS Full_Name
FROM Student
WHERE Fname LIKE '%a';
--Q12: Display students with NULL advisor--
SELECT 
    S_id,
    Fname + ' ' + Lname AS Full_Name
FROM Student
WHERE Faculty_id IS NULL;
--Q13:Display students enrolled in 2021--
SELECT 
    S_id,
    Fname + ' ' + Lname AS Full_Name,
    Enrollment_date
FROM Student
WHERE YEAR(Enrollment_date) = 2021;

-- DML--
--Q14: Insert your data as a new student (Student ID = 300045, Program ID = 2, GPA = 3.6).--
SET IDENTITY_INSERT Student ON;
INSERT INTO Student (S_id, Fname, Lname, Department_id, GPA)
VALUES (300045, 'Rayan', 'SALIM', 3, 3.6);
SET IDENTITY_INSERT Student OFF;

--Q15:  Insert another student (your friend) with GPA and advisor set to NULL --
INSERT INTO Student (Fname, Lname, Department_id, GPA, Faculty_id)
VALUES ('Sara', 'Al-Hinai', 5, NULL, NULL);

--Q16:  Increase your GPA by 0.2.--
UPDATE Student
SET GPA = GPA + 0.2
WHERE S_id = 300045;

--Q17: Set GPA to 2.0 for students with GPA below 2.0--
UPDATE Student
SET GPA = 2.0
WHERE GPA < 2.0;

--Q18: Increase GPA by 0.1 for students enrolled before 2020--
UPDATE Student
SET GPA = GPA + 0.1
WHERE Enrollment_date < '2022-01-01';

--Q19: Delete students with status 'Inactive'.--
DELETE FROM Student
WHERE Status = 'Inactive';





