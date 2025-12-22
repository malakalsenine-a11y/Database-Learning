--Airline Database – JOIN Queries--

--1. Display each flight leg's ID, schedule, and the name of the airplane assigned to it.--
select * from Flight_Leg;
select * from Airport;
select * from Leg_Instance;
SELECT * FROM Airplane;
select * from Airplane_Type;
select * from Fare;
select * from Flight_Leg;
SELECT * FROM Flight
SELECT * FROM Reservation;

SELECT fl.leg_no AS LegID, fl.scheduled_dep_time, fl.scheduled_arr_time, a.type_name AS AirplaneName
FROM Flight_Leg fl JOIN Leg_Instance li
ON fl.leg_no = li.leg_no JOIN Airplane a
ON li.airplane_id = a.airplane_id;

--2. Display all flight numbers and the names of the departure and arrival airports.--
SELECT  f.flight_no, a1.name AS DepartureAirport, a2.name AS ArrivalAirport
FROM Flight f JOIN Flight_Leg fl
ON f.flight_no = fl.flight_no JOIN Airport a1
ON fl.dep_airport = a1.airport_code JOIN Airport a2
ON fl.arr_airport = a2.airport_code;

--3. Display all reservation data with the name and phone of the customer who made each booking.--
SELECT * FROM Reservation;
SELECT reservation_id, customer_name, phone, seat_no, leg_no, leg_date
FROM Reservation;


--4. Display IDs and locations of flights departing from 'MCT' or 'DXB'.--
select * from Flight;
select * from Flight_Leg;
select * from Airport;

SELECT f.flight_no AS FlightID, a.name AS DepartureAirport
FROM Flight f JOIN Flight_Leg fl 
ON f.flight_no = fl.flight_no JOIN Airport a 
ON fl.dep_airport = a.airport_code
WHERE fl.dep_airport IN ('MCT', 'DXB');


--5. Display full data of flights whose names start with 'O'.--
select * from Flight_Leg;
SELECT * FROM Flight
WHERE airline LIKE 'O%';

--6. List customers who have bookings with total payment between 3000 and 5000.--
SELECT * from Reservation;
SELECT * from Fare;
SELECT 
    r.customer_name,
    f.amount AS TotalPayment
FROM Reservation r
JOIN Flight_Leg fl 
    ON r.leg_no = fl.leg_no
JOIN Fare f 
    ON fl.flight_no = f.flight_no
WHERE f.fare_code = 'ECO'
  AND f.amount BETWEEN 40 AND 120;


--7. Retrieve all passengers on 'Flight 110' who booked more than 2 seats.--
-- بضيف أكثر من مقعد لنفس العميل على نفس الرحلة-- 
INSERT INTO Reservation (customer_name, phone, seat_no, leg_no, leg_date)
VALUES
('Ali Al-Balushi', '+96891234567', '1B', 10, '2025-01-15'),
('Ali Al-Balushi', '+96891234567', '1C', 10, '2025-01-15'),
('Sara Al-Hinai', '+96891234568', '2A', 10, '2025-01-15'),
('Sara Al-Hinai', '+96891234568', '2B', 10, '2025-01-15');
select * from Reservation;

SELECT customer_name, COUNT(seat_no) AS SeatsBooked
FROM Reservation
WHERE leg_no = 10
GROUP BY customer_name
HAVING COUNT(seat_no) > 2;

--8. Find names of passengers whose booking was handled by agent "Youssef Hamed".--
--بضيف agent لان ما معي من قبل في جدول Reservation-- 
ALTER TABLE Reservation
ADD agent_name VARCHAR(50);

-- بضيف بيانات --
UPDATE Reservation
SET agent_name = 'Youssef Hamed'
WHERE customer_name IN ('Ali Al-Balushi', 'Sara Al-Hinai');
select * from Reservation;
SELECT customer_name
FROM Reservation
WHERE agent_name = 'Youssef Hamed';

--9. Display each passenger’s name and the flights they booked, ordered by flight date.--
SELECT r.customer_name, f.flight_no, f.airline, r.leg_date
FROM Reservation r JOIN Leg_Instance li
ON r.leg_no = li.leg_no AND r.leg_date = li.leg_date
JOIN Flight_Leg fl ON li.leg_no = fl.leg_no
JOIN Flight f
ON fl.flight_no = f.flight_no
ORDER BY r.leg_date;

--10. For each flight departing from 'MCT', display the flight number, departure time, and airline name.--
SELECT 
    f.flight_no,
    li.dep_time,
    f.airline
FROM Flight f
JOIN Flight_Leg fl
    ON f.flight_no = fl.flight_no
JOIN Leg_Instance li
    ON fl.leg_no = li.leg_no
WHERE fl.dep_airport = 'MCT';


--11. Display all staff members who are assigned as supervisors for flights.--
--ما موجود معنا Staff--
--12. Display all bookings and their related passen--
SELECT 
    reservation_id,
    customer_name,
    leg_no,
    leg_date,
    seat_no
FROM Reservation;
