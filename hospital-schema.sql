DROP DATABASE IF EXISTS hospital;
CREATE DATABASE hospital;
USE hospital;

CREATE TABLE rooms (
	room_number		INT,
    capacity		INT,
    room_fee		DOUBLE,
    PRIMARY KEY (room_number)
);

CREATE TABLE contacts (
	id				INT,
	name			VARCHAR(50),
    phone_number	VARCHAR(12),
    address			VARCHAR(50),
    PRIMARY KEY (id)
);

CREATE TABLE physicians (
	physician_id		INT,
    certification_num	INT NOT NULL,
    expertise			VARCHAR(50),
    PRIMARY KEY (physician_id),
    FOREIGN KEY (physician_id) REFERENCES contacts (id)
);

CREATE TABLE nurses (
	nurse_id			INT,
	certification_num	INT NOT NULL,
    PRIMARY KEY (nurse_id),
    FOREIGN KEY (nurse_id) REFERENCES contacts (id)
);

CREATE TABLE patients (
	patient_id		INT,
    room_number		INT,
    physician_id	INT,
    nurse_id		INT,
	date_in			DATE,
    date_out		DATE,
    med_type		VARCHAR(50),
    med_amount		INT,
	PRIMARY KEY(patient_id),
    FOREIGN KEY (patient_id) REFERENCES contacts (id),
    FOREIGN KEY (room_number) REFERENCES rooms (room_number),
    FOREIGN KEY (physician_id) REFERENCES physicians (physician_id),
    FOREIGN KEY (nurse_id) REFERENCES nurses (nurse_id)
);

CREATE TABLE patient_records (
	patient_id		INT,
    record_id		INT,
    date			DATE,
    status			VARCHAR(50),
    description		VARCHAR(100),
    disease			VARCHAR(50),
	PRIMARY KEY (patient_id, record_id),
    FOREIGN KEY (patient_id) REFERENCES patients (patient_id)
);

CREATE TABLE physician_orders (
	order_id			INT,
    description			VARCHAR(100),
    order_fee			DOUBLE,
    instruction_date	DATE,
	physician_id		INT NOT NULL,
    patient_id			INT NOT NULL,
    PRIMARY KEY (order_id),
	FOREIGN KEY (physician_id) REFERENCES physicians (physician_id),
    FOREIGN KEY (patient_id) REFERENCES patients (patient_id)

);

CREATE TABLE order_results (
	patient_id		INT,
    nurse_id		INT,
    order_id		INT,
    date			DATE,
    status			VARCHAR(50),
    PRIMARY KEY (patient_id, nurse_id, order_id),
    FOREIGN KEY (patient_id) REFERENCES patients (patient_id),
    FOREIGN KEY (nurse_id) REFERENCES nurses (nurse_id),
    FOREIGN KEY (order_id) REFERENCES physician_orders (order_id)
);

CREATE TABLE invoices (
	invoice_id		INT AUTO_INCREMENT,
    patient_id		INT,
    room_number		INT,
    order_id		INT,
    PRIMARY KEY (invoice_id),
    FOREIGN KEY (patient_id) REFERENCES patients (patient_id),
    FOREIGN KEY (room_number) REFERENCES patients (room_number),
    FOREIGN KEY (order_id) REFERENCES physician_orders (order_id)
);

CREATE TABLE payments (
	invoice_id		INT,
    payment_amount	DOUBLE,
    date			DATE,
    PRIMARY KEY (invoice_id),
    FOREIGN KEY (invoice_id) REFERENCES invoices (invoice_id) 
);

-- Shows total cost for each patient's stay
CREATE VIEW invoice_total_cost AS
SELECT p.patient_id, c.name, r.room_fee, o.order_fee
FROM patients AS p LEFT JOIN contacts AS c ON p.patient_id = c.id
LEFT JOIN rooms AS r ON p.room_number = r.room_number
LEFT JOIN physician_orders AS o ON p.patient_id = o.patient_id;

-- Shows all contact information for hospital staff
CREATE VIEW staff AS
SELECT * FROM contacts
WHERE id in (SELECT physician_id FROM physicians)
UNION
SELECT * FROM contacts
WHERE id in (SELECT nurse_id FROM nurses);

-- Shows total patient stay and the date of physician's order
CREATE VIEW patient_stay AS
SELECT p.patient_id, c.name, p.date_in, o.date AS order_date, p.date_out 
FROM patients AS p LEFT JOIN contacts AS c ON p.patient_id = c.id
LEFT JOIN order_results AS o ON p.patient_id = o.patient_id;  

DELIMITER //
-- Auto increments contacts id
CREATE TRIGGER contacts_auto_inc
BEFORE INSERT ON contacts
FOR EACH ROW
IF NEW.id IS NULL THEN
	SET @last_id = (select id FROM contacts ORDER BY id DESC LIMIT 1);
	SET NEW.id = @last_id +1;
END IF; 
//

-- Automatically adds patient id and room number to invoice when inserted
CREATE TRIGGER invoice_patient_trigger
AFTER INSERT ON patients
FOR EACH ROW
INSERT INTO invoices (patient_id, room_number) VALUES (NEW.patient_id, NEW.room_number);
//

-- Automatically adds order id to invoice when inserted
CREATE TRIGGER invoice_order_trigger
AFTER INSERT ON physician_orders
FOR EACH ROW
IF (NEW.patient_id IN (SELECT patient_id FROM invoices)) THEN 
	UPDATE invoices
    SET invoices.order_id = NEW.order_id
    WHERE invoices.patient_id = NEW.patient_id;
END IF; 
//
DELIMITER ;

    
