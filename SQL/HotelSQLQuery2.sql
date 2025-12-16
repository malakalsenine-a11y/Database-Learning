create database Hotel
use Hotel;

CREATE TABLE Branch (
    branch_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(50) NOT NULL,
    location NVARCHAR(100) NOT NULL
);
CREATE TABLE Room (
    room_no INT,
    branch_id INT,
    type NVARCHAR(30),
    nightly_rate DECIMAL(8,2),
    PRIMARY KEY (room_no, branch_id),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(50) NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(50)
);
CREATE TABLE Booking (
    booking_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT,
    check_in DATE,
    check_out DATE,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);
CREATE TABLE Booking_Room (
    booking_id INT,
    room_no INT,
    branch_id INT,
    PRIMARY KEY (booking_id, room_no, branch_id),
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    FOREIGN KEY (room_no, branch_id) REFERENCES Room(room_no, branch_id)
);
CREATE TABLE Staff (
    staff_id INT PRIMARY KEY IDENTITY(1,1),
    branch_id INT,
    name NVARCHAR(50),
    job_title NVARCHAR(30),
    salary DECIMAL(8,2),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);
CREATE TABLE Staff_Action (
    staff_id INT,
    booking_id INT,
    role NVARCHAR(20),
    PRIMARY KEY (staff_id, booking_id),
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id),
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

INSERT INTO Branch (name, location) 
VALUES
('Muscat Main', 'Muscat, Oman'),
('Salalah Resort', 'Salalah, Oman'),
('Sohar Resort', 'Sohar, Oman');
Select * from Branch;

INSERT INTO Room (room_no, branch_id, type, nightly_rate) 
VALUES
(101, 1, 'Single', 50.00),
(102, 2, 'Double', 80.00),
(201, 5, 'Suite', 150.00);
Select * from room;

INSERT INTO Customer (name, phone, email) 
VALUES
('Khaled Al-Balushi', '+96891234567', 'Khaled@example.com'),
('Sara Al-Hinai', '+96891234568', 'sara@example.com'),
('Malak AL-Sinani', '+96896674984', 'malak@example.com' );
Select * from Customer;

INSERT INTO Booking (customer_id, check_in, check_out) 
VALUES
(1, '2025-12-20', '2025-12-25'),
(2, '2025-12-21', '2025-12-23'),
(3, '2025-12-22', '2025-12-30');
Select * from Booking;

INSERT INTO Booking_Room (booking_id, room_no, branch_id) 
VALUES
(4, 101, 1),
(5, 102, 2),
(6, 201, 5);
select * from Booking_Room;

INSERT INTO Staff (branch_id, name, job_title, salary) 
VALUES
(1, 'Hassan', 'Receptionist', 400.00),
(2, 'Fatma', 'Manager', 800.00),
(5, 'Elham', 'IT',600.00);
select * from Staff;

INSERT INTO Staff_Action (staff_id, booking_id, role) 
VALUES
(1, 4, 'check-in'),
(3, 5, 'check-out'),
(2, 6, 'check-in');
select * from Staff_Action;

