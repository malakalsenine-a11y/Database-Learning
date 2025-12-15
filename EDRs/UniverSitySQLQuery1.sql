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