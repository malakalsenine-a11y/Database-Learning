 

 create table Employees(
SSN INT IDENTITY(1,1) PRIMARY KEY,
FirstName varchar(20) not null,
LastName varchar(30) not null,
Gender varchar(20) not null,
Superid INT,
Birthday date,
FOREIGN KEY (Superid) REFERENCES Employees(SSN)
);


 insert into Employees(SSN,FirstName,LastName,Gender,Superid,Birthday)
 values 
 (1,'Ahmad', 'Saif', 'Male',1,'2016-2-18'),
(2,'Malak', 'Hassan', 'Female', 1, '2001-03-12'),
(3,'Khaled', 'Nasser', 'Male', 2, '2018-11-20'),
(4,'Aisha', 'Khalid', 'Female', 3, '1995-07-18');

select * from Employees

CREATE TABLE Department(
    DepartmentNumber INT PRIMARY KEY,
    DepartmentName VARCHAR(40) NOT NULL,
    Hiredate DATE,
    SSN INT,
    FOREIGN KEY (SSN) REFERENCES Employees(SSN)
);


insert into Department(DepartmentNumber,DepartmentName,Hiredate,SSN)
values
(6,'HR','1-1-2024',1),
(7,'IT','2-2-2022',2),
(8,'Finance','3-3-2023',3),
(9,'Business','4-4-2024',4);


select * from Department;


insert into DepartmentTlocation(Location,DNum)
VALUES 
('HR Room',6),
('Sohar',7),
('Nizwa',8),
('AL-Suwaiq',9);

select * from DepartmentTlocation;

insert into Project(ProjectNumber,Location,City,PName,DNum)
values
(1,'HR Room','Muscat','ProjectA',6),
(2,'IT Room','Sohar','ProjectB',7),
(3,'Finance','Nizwa','ProjectC',8),
(4,'Business','AL-Suwaiq','ProjectD',9);

select * from Project;

insert into EmplProject(SSN,ProjectNumber,Hours)
values
(1,1,5),
(2,2,4),
(3,3,6),
(4,4,8);

select * from Employees;

insert into Dependent(DependentName,Gender,BirthDate,SSN)
values
('Sara','Female','28010-2001',1),
('Omar','Male', '12-12-2012',2),
('Laila','Female','3-3-2013',3),
('Mona','Female','6-7-2000,4',4);

sELECT * FROM Dependent;