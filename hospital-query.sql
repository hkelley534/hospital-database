USE hospital;

-- VIEWS
SELECT * FROM invoice_total_cost;
SELECT * FROM staff;
SELECT * FROM patient_stay;

-- 1 Shows contact information for each physician 
SELECT name AS physician_name, phone_number 
FROM contacts
WHERE id IN (SELECT physician_id FROM physicians);

-- 2 Shows every physician order that was not a success
SELECT *
FROM order_results
WHERE status NOT IN (SELECT status FROM order_results WHERE status = 'SUCCESS');

-- 3 Shows total capacity of hospital
SELECT SUM(capacity) AS total_capacity
FROM rooms;

-- 4 Shows all physician orders in November
SELECT o.physician_id, o.patient_id, c.name, o.instruction_date
FROM physician_orders AS o
JOIN contacts AS c ON o.patient_id = c.id
WHERE o.instruction_date IN (SELECT o.instruction_date FROM physician_orders AS o WHERE MONTH(o.instruction_date) = 11);

-- 5 Shows total payments from a set of specific patients
SELECT SUM(p.payment_amount) AS total_payments
FROM payments AS p JOIN invoices AS i ON p.invoice_id = i.invoice_id
JOIN patients AS pa ON pa.patient_id = i.patient_id
WHERE pa.patient_id > 12 AND pa.patient_id < 15; 

-- 6 Shows the average room price
SELECT AVG(room_fee) AS avg_room_fee
FROM rooms;

-- 7 Shows expertise for each patient's physician
SELECT c.name AS patient_name, p.physician_id, h.expertise
FROM contacts AS c
INNER JOIN patients AS p ON c.id = p.patient_id
INNER JOIN physicians AS h ON p.physician_id = h.physician_id;

-- 8 Shows room number and price for each patient
SELECT p.patient_id, p.room_number, r.room_fee
FROM patients AS p 
LEFT JOIN rooms AS r ON p.room_number = r.room_number;

-- 9 Shows all patients who stayed in October 
SELECT p.patient_id, c.name, p.date_in, p.date_out
FROM patients AS p
JOIN contacts AS c ON p.patient_id = c.id
WHERE p.date_in IN (SELECT date_in FROM patients WHERE MONTH(date_in) = 10);

-- 10 Shows all staff certification numbers
SELECT physician_id AS staff_id, certification_num
FROM physicians
UNION
SELECT nurse_id AS staff_id, certification_num
FROM nurses;

-- 11 Shows the number of rooms that cost more than 2000
SELECT COUNT(room_number)
FROM rooms
WHERE room_fee > 2000;

-- 12 Shows the total number of patients
SELECT COUNT(patient_id) AS num_patients
FROM patients;

-- 13 Shows all contacts whose phone number starts with specific digits
SELECT c.name, c.phone_number
FROM contacts AS c
WHERE LEFT(c.phone_number, 3) = 610;

-- 14 Shows all rooms with a capacity larger than 1
SELECT r.room_number, r.capacity
FROM rooms AS r
WHERE r.capacity > 1;

-- 15 Shows all payments in 2021
SELECT c.name, p.payment_amount, p.date
FROM contacts AS c
JOIN patients AS pa ON pa.patient_id = c.id
JOIN invoices AS i ON i.patient_id = pa.patient_id
JOIN payments AS p ON p.invoice_id = i.invoice_id
WHERE YEAR(date) = 2021;