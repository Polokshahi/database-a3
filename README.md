# Vehicle Rental System - SQL Assignment

## Project Overview
This project demonstrates a Vehicle Rental System database implemented in PostgreSQL.  
It includes three main tables: Users, Vehicles, and Bookings, and demonstrates key SQL concepts such as `JOIN`, `EXISTS`, `WHERE`, `GROUP BY`, and `HAVING` through practical queries.

The system is designed to:
- Track users (customers and admins)
- Manage vehicles (cars, bikes, trucks)
- Record bookings and their statuses
- Allow reporting on bookings and vehicle availability



Query 1: JOIN

Requirement:
Display booking information along with Customer name and Vehicle name.

SQL Query:

SELECT
    b.booking_id,
    u.name AS customer_name,
    v.name AS vehicle_name,
    b.start_date,
    b.end_date,
    b.status
FROM bookings b
INNER JOIN users u
    ON b.user_id = u.user_id
INNER JOIN vehicles v
    ON b.vehicle_id = v.vehicle_id
ORDER BY b.booking_id;


Concept Used:
INNER JOIN

Output:

booking_id | customer_name | vehicle_name     | start_date | end_date   | status
1          | Alice         | Honda Civic      | 2023-10-01 | 2023-10-05 | completed
2          | Alice         | Honda Civic      | 2023-11-01 | 2023-11-03 | completed
3          | Charlie       | Honda Civic      | 2023-12-01 | 2023-12-02 | confirmed
4          | Alice         | Toyota Corolla   | 2023-12-10 | 2023-12-12 | pending



Query 2: EXISTS

Requirement:
Find vehicles that have never been booked.

SQL Query:

SELECT *
FROM vehicles v
WHERE NOT EXISTS (
    SELECT 1
    FROM bookings b
    WHERE b.vehicle_id = v.vehicle_id
);


Concept Used:
NOT EXISTS

Output:

vehicle_id | name        | type  | model | registration_number | rental_price | status
3          | Yamaha R15  | bike  | 2023  | GHI-789             | 30           | available
4          | Ford F-150  | truck | 2020  | JKL-012             | 100          | maintenance

Query 3: WHERE

Requirement:
Retrieve available vehicles of a specific type (e.g., cars).

SQL Query:

SELECT *
FROM vehicles
WHERE status = 'available'
  AND type = 'car';


Concept Used:
SELECT, WHERE

Output:

vehicle_id | name            | type | model | registration_number | rental_price | status
1          | Toyota Corolla  | car  | 2022  | ABC-123             | 50           | available

Query 4: GROUP BY & HAVING

Requirement:
Count total bookings for each vehicle and display only those vehicles with more than 2 bookings.

SQL Query:

SELECT
    v.name AS vehicle_name,
    COUNT(b.booking_id) AS total_bookings
FROM bookings b
INNER JOIN vehicles v
    ON b.vehicle_id = v.vehicle_id
GROUP BY v.name
HAVING COUNT(b.booking_id) > 2;


Concept Used:
GROUP BY, HAVING, COUNT

Output:

vehicle_name | total_bookings
Honda Civic  | 3
