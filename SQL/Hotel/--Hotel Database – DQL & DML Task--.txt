--Hotel Database – DQL & DML Task--
--DQL--

--1. Display all guest records.--
SELECT * FROM Customer;
--2. Display each guest’s name, contact number, and proof ID type.--
SELECT name, phone, email AS proof_id_type
FROM Customer;
--3. Display all bookings with booking date, status, and total cost.--
ALTER TABLE Booking
ADD status NVARCHAR(20) DEFAULT 'Active',
    total_cost DECIMAL(8,2) DEFAULT 0;

SELECT booking_id, check_in, check_out, status, total_cost
FROM Booking;
--4. Display each room number and its price per night as NightlyRate.--l
SELECT room_no, branch_id, nightly_rate AS NightlyRate
FROM Room;

--5. List rooms priced above 1000 per night.--
SELECT room_no, branch_id, nightly_rate
FROM Room
WHERE nightly_rate > 1000;
--6. Display staff members working as 'Receptionist'.--
SELECT staff_id, name, job_title, branch_id
FROM Staff
WHERE job_title = 'Receptionist';

--7. Display bookings made in 2024.--
SELECT booking_id, customer_id, check_in, check_out
FROM Booking
WHERE YEAR(check_in) = 2024;

--8. Display bookings ordered by total cost descending.--
SELECT booking_id, customer_id, total_cost
FROM Booking
ORDER BY total_cost DESC;

--9. Display the maximum, minimum, and average room price.--
SELECT MAX(nightly_rate) AS MaxRate,
       MIN(nightly_rate) AS MinRate,
       AVG(nightly_rate) AS AvgRate
FROM Room;

--10. Display total number of rooms.--
SELECT COUNT(*) AS TotalRooms
FROM Room;

--11. Display guests whose names start with 'M'.--
SELECT name, phone, email
FROM Customer
WHERE name LIKE 'M%';

--12. Display rooms priced between 800 and 1500--
SELECT room_no, branch_id, nightly_rate
FROM Room
WHERE nightly_rate BETWEEN 800 AND 1500;


--DML--
--13. Insert yourself as a guest (Guest ID = 9011).--
SET IDENTITY_INSERT Customer ON;

INSERT INTO Customer (customer_id, name, phone, email)
VALUES (9011, 'Malak Al-Sinani', '+9689XXXXXXX', 'malak@email.com');

SET IDENTITY_INSERT Customer OFF;

--14. Create a booking for room 205.--
INSERT INTO Booking (customer_id, check_in, check_out)
VALUES (9011, '2025-01-10', '2025-01-15');
INSERT INTO Booking_Room (booking_id, room_no, branch_id)
VALUES (4, 102, 2);

--15. Insert another guest with NULL contact and proof details.--
INSERT INTO Customer (name, phone, email)
VALUES ('Sara Guest', NULL, NULL);

--16. Update your booking status to 'Confirmed'.--
UPDATE Booking
SET status = 'Confirmed'
WHERE customer_id = 9011;

--17. Increase room prices by 10% for luxury rooms.--
UPDATE Room
SET nightly_rate = nightly_rate * 1.10
WHERE type = 'Suite';

--18. Update booking status to 'Completed' where checkout date is before today.--
UPDATE Booking
SET status = 'Completed'
WHERE check_out < GETDATE();

--19. Delete bookings with status 'Cancelled'--
DELETE FROM Booking
WHERE status = 'Cancelled';
