-- I can't drop a database that's currently in use.So we use master.
USE master;
GO
-- This closes all connections and drops the database cleanly
ALTER DATABASE AIRLINE SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE AIRLINE;
GO

-- Create a fresh AIRLINE 
CREATE DATABASE AIRLINE;
GO
-- Switch to the new AIRLINE
USE AIRLINE;
GO


-- Airport Table
CREATE TABLE Airport
(
    Airport_code CHAR(3) PRIMARY KEY,
    A_name VARCHAR(100),
    city VARCHAR(100),
    A_state VARCHAR(50),
    allow_landing CHAR(1) CHECK (allow_landing IN ('Y', 'N'))
);

-- Airplane Type Table
CREATE TABLE Airplane_Type 
(
    AType_name VARCHAR(50) PRIMARY KEY,
    max_seats INT,
    company VARCHAR(100)
);

-- Airplane Table
CREATE TABLE Airplane 
(
    Airplane_id INT PRIMARY KEY,
    AType_name VARCHAR(50),
    total_number_of_seats INT,
    FOREIGN KEY (AType_name) REFERENCES Airplane_Type(AType_name)
);

-- Fare Table
CREATE TABLE Fare
(
    Code VARCHAR(10) PRIMARY KEY,  
    amount DECIMAL(10, 2)
);


-- Flight Table
CREATE TABLE Flight
(
    flight_no INT PRIMARY KEY,
    airline VARCHAR(100),
    weekdays VARCHAR(50),
    restrictions TEXT,
    Fare_code VARCHAR(10),
    FOREIGN KEY (Fare_code) REFERENCES Fare(Code)
);

-- Flight Leg Table
CREATE TABLE flight_Leg 
(
    flight_no INT,
    leg_no INT,
    PRIMARY KEY (flight_no, leg_no),
    FOREIGN KEY (flight_no) REFERENCES Flight(Flight_no)
);


-- Departure Table
CREATE TABLE Depart
(
    flight_no INT,
    leg_no INT,
    Airport_code CHAR(3),
    scheduled_dep_time TIME,
    PRIMARY KEY (flight_no, leg_no, Airport_code),
    FOREIGN KEY (flight_no, leg_no) REFERENCES flight_Leg(Flight_no, leg_no),
    FOREIGN KEY (Airport_code) REFERENCES Airport(Airport_code)
);

-- Arrive Table 
CREATE TABLE Arrive 
(
    flight_no INT,
    leg_no INT,
    Airport_code CHAR(3),
    scheduled_arr_time TIME,
    PRIMARY KEY (flight_no, leg_no, Airport_code),
    FOREIGN KEY (flight_no, leg_no) REFERENCES Flight_Leg(flight_no, leg_no),
    FOREIGN KEY (Airport_code) REFERENCES Airport(Airport_code)
);


-- Leg Instance Table 
CREATE TABLE Leg_Instance 
(
    flight_no INT,
    leg_no INT,
    flight_date DATE,
    departure_time TIME,
    arrival_time TIME,
    number_of_available_seats INT,
    Airplane_id INT,
    PRIMARY KEY (flight_no, leg_no, flight_date),
    FOREIGN KEY (flight_no, leg_no) REFERENCES Flight_Leg(flight_no, leg_no),
    FOREIGN KEY (Airplane_id) REFERENCES Airplane(Airplane_id)
);


-- Customer Table
CREATE TABLE Customer
(
    customer_id INT PRIMARY KEY,
    c_name VARCHAR(100),
    phone VARCHAR(20)
);

-- Seat Reservation Table
CREATE TABLE Seat_Reservation
(
    flight_no INT,
    leg_no INT,
    flight_date DATE,
    seat_number VARCHAR(10),
    customer_id INT,
    PRIMARY KEY (flight_no, leg_no, flight_date, seat_number),
    FOREIGN KEY (flight_no, leg_no, flight_date) REFERENCES Leg_Instance (flight_no, leg_no, flight_date),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);


-- Insert data into Airport table
INSERT INTO Airport (Airport_code, A_name, city, A_state, allow_landing)
VALUES 
('DXB', 'Dubai International Airport', 'Dubai', 'Dubai', 'Y'),
('AUH', 'Abu Dhabi International Airport', 'Abu Dhabi', 'Abu Dhabi', 'Y'),
('RUH', 'King Khalid International Airport', 'Riyadh', 'Riyadh', 'Y'),
('JED', 'King Abdulaziz International Airport', 'Jeddah', 'Makkah', 'Y'),
('DOH', 'Hamad International Airport', 'Doha', 'Doha', 'Y'),
('CAI', 'Cairo International Airport', 'Cairo', 'Cairo', 'Y'),
('BEY', 'Rafic Hariri International Airport', 'Beirut', 'Beirut', 'Y'),
('AMM', 'Queen Alia International Airport', 'Amman', 'Amman', 'Y'),
('BAH', 'Bahrain International Airport', 'Manama', 'Manama', 'Y'),
('KWI', 'Kuwait International Airport', 'Kuwait City', 'Kuwait', 'Y'),
('MCT', 'Muscat International Airport', 'Muscat', 'Muscat', 'Y'),
('MED', 'Prince Mohammad bin Abdulaziz Airport', 'Medina', 'Medina', 'Y'),
('TLV', 'Ben Gurion Airport', 'Tel Aviv', 'Tel Aviv', 'N'); -- Example of restricted airport

-- Insert data into Airplane_Type table
INSERT INTO Airplane_Type (AType_name, max_seats, company)
VALUES
('A111', 853, 'Airbus'),
('B222', 550, 'Boeing'),
('A333', 240, 'Airbus'),
('B444', 420, 'Boeing'),
('A555', 440, 'Airbus'),
('C111', 114, 'Embraer');

-- Insert data into Airplane table
INSERT INTO Airplane (Airplane_id, AType_name, total_number_of_seats)
VALUES
(101, 'A111', 853),
(102, 'B222', 550),
(103, 'A111', 240),
(104, 'B444', 420),
(105, 'A555', 440),
(106, 'C111', 114),
(107, 'A333', 240),
(108, 'B444', 550);

-- Insert data into Fare table
INSERT INTO Fare (Code, Amount)
VALUES
('ECO', 300.00),
('BUS', 600.00),
('FAM', 1200.00),
('PRIM', 200.00),
('VIP', 1500.00);

-- Insert data into Flight table 
INSERT INTO Flight (flight_no, airline, weekdays, restrictions, Fare_code)
VALUES
(1001, 'Emirates', '1234567', 'No pets allowed', 'ECO'),
(1002, 'Qatar Airways', '1234567', 'No smoking', 'BUS'),
(1003, 'Saudia', '123456', 'No drinks', 'FAM'),
(1004, 'Etihad', '234567', 'No noise', 'PRIM'),
(1005, 'EgyptAir', '134567', 'No smoking', 'VIP'),
(1006, 'Royal Jordanian', '1234567', 'No electronic devices', 'ECO'),
(1007, 'Middle East Airlines', '24567', 'No food from outside', 'BUS');

-- Insert data into Flight_Leg table
INSERT INTO Flight_Leg (leg_no, flight_no)
VALUES
(1, 1001),
(2, 1001),
(3, 1002),
(4, 1003),
(5, 1004),
(6, 1005),
(7, 1006),
(8, 1007);

-- Insert data into Depart table
INSERT INTO Depart (flight_no, leg_no, Airport_code, scheduled_dep_time)
VALUES
(1001, 1, 'DXB', '08:00:00'),
(1001,2, 'AUH', '10:30:00'),
(1002,3, 'DOH', '12:15:00'),
(1003,4, 'RUH', '14:45:00'),
(1004,5, 'AUH', '16:20:00'),
(1005,6, 'CAI', '18:30:00'),
(1006,7, 'AMM', '20:15:00'),
(1007,8, 'BEY', '22:00:00');

-- Insert data into Arrive table
INSERT INTO Arrive (flight_no, leg_no, Airport_code, scheduled_arr_time)
VALUES
(1001, 1, 'AUH', '09:30:00'),
(1001, 2, 'DOH', '12:00:00'),
(1002, 3, 'RUH', '14:30:00'),
(1003, 4, 'JED', '16:15:00'),
(1004, 5, 'DXB', '18:10:00'),
(1005, 6, 'JED', '20:45:00'),
(1006, 7, 'BEY', '22:30:00'),
(1007, 8, 'CAI', '23:45:00');

-- Insert data into Leg_Instance table
INSERT INTO Leg_Instance (flight_no, leg_no, flight_date, departure_time, arrival_time, number_of_available_seats, Airplane_id)
VALUES
(1001, 1, '2023-12-01', '08:05:00', '09:35:00', 120, 101),
(1001, 2, '2023-12-01', '10:35:00', '12:05:00', 85, 102),
(1002, 3, '2023-12-02', '12:20:00', '14:35:00', 200, 103),
(1003, 4, '2023-12-02', '14:50:00', '16:20:00', 50, 104),
(1004, 5, '2023-12-03', '16:25:00', '18:15:00', 300, 105),
(1005, 6, '2023-12-03', '18:35:00', '20:50:00', 75, 106),
(1006, 7, '2023-12-04', '20:20:00', '22:35:00', 180, 107),
(1007, 8, '2023-12-04', '22:05:00', '23:50:00', 90, 108);

-- Insert data into Customer table 
INSERT INTO Customer (customer_id, c_name, phone)
VALUES
(10001, 'Ahmed', '+96890123456'),
(10002, 'Fatima', '+971502345678'),
(10003, 'Mohammed', '+966503456789'),
(10004, 'Layla', '+966504567890'),
(10005, 'Omar', '+974505678901'),
(10006, 'Aisha', '+974506789012'),
(10007, 'Youssef', '+968007890123'),
(10008, 'Nour', '+991008901234');

-- Insert data into Seat_Reservation table
INSERT INTO Seat_Reservation (flight_no,leg_no, flight_date, seat_number, customer_id)
VALUES
(1001,1, '2023-12-01', 'A12', 10001),
(1001,1, '2023-12-01', 'B05', 10002),
(1001,2, '2023-12-01', 'C08', 10003),
(1002,3, '2023-12-02', 'D15', 10004),
(1003,4, '2023-12-02', 'E20', 10005),
(1004,5, '2023-12-03', 'F03', 10006),
(1005,6, '2023-12-03', 'G11', 10007),
(1006,7, '2023-12-04', 'H09', 10008),
(1007,8, '2023-12-04', 'J07', 10001);

-- DISPLAY ALL Airports
SELECT * FROM Airport

-- DISPLAY ALL Airplane_Type
SELECT * FROM Airplane_Type

-- DISPLAY ALL Airplanes
SELECT * FROM Airplane

-- DISPLAY ALL Flights
SELECT * FROM Flight

-- DISPLAY ALL Flight Leg
SELECT * FROM Flight_Leg

-- DISPLAY ALL Fares
SELECT * FROM Fare

-- DISPLAY ALL Leg Instance
SELECT * FROM Leg_Instance

-- DISPLAY ALL Depart Airports
SELECT * FROM Depart

-- DISPLAY ALL Arrive Airports
SELECT * FROM Arrive

-- DISPLAY ALL Customer
SELECT * FROM Customer

-- DISPLAY ALL Seat Reservation
SELECT * FROM Seat_Reservation





