-- CREATE DATABASE AIRLINE;
USE AIRLINE;
-- Airport Table
CREATE TABLE Airport
(
    Airport_code CHAR(3) PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(50),
    allow_landing CHAR(1) CHECK (allow_landing IN ('Y', 'N'))
);

-- Airplane Type Table
CREATE TABLE Airplane_Type 
(
    Type_name VARCHAR(50) PRIMARY KEY,
    max_seats INT,
    company VARCHAR(100)
);

-- Airplane Table
CREATE TABLE Airplane 
(
    Airplane_id INT PRIMARY KEY,
    Type_name VARCHAR(50),
    total_number_of_seats INT,
    FOREIGN KEY (Type_name) REFERENCES Airplane_Type(Type_name)
);

-- Fare Table
CREATE TABLE Fare 
(
    Code CHAR(3) PRIMARY KEY,
    Amount DECIMAL(10,2)
);

-- Flight Table
CREATE TABLE Flight
(
    flight_no INT PRIMARY KEY,
    airline VARCHAR(100),
    weekdays VARCHAR(50),
    restrictions TEXT,
    Fare_code CHAR(3),
    FOREIGN KEY (Fare_code) REFERENCES Fare(Code)
);

-- Flight Leg Table
CREATE TABLE Flight_Leg 
(
    leg_no INT PRIMARY KEY,
    flight_no INT,
    FOREIGN KEY (flight_no) REFERENCES Flight(flight_no)
);

-- Departure Table
CREATE TABLE Depart
(
    leg_no INT,
    Airport_code CHAR(3),
    scheduled_dep_time TIME,
    PRIMARY KEY (leg_no, Airport_code),
    FOREIGN KEY (leg_no) REFERENCES Flight_Leg(leg_no),
    FOREIGN KEY (Airport_code) REFERENCES Airport(Airport_code)
);

-- Arrive Table 
CREATE TABLE Arrive
(
    leg_no INT,
    Airport_code CHAR(3),
    scheduled_arr_time TIME,
    PRIMARY KEY (leg_no, Airport_code),
    FOREIGN KEY (leg_no) REFERENCES Flight_Leg(leg_no),
    FOREIGN KEY (Airport_code) REFERENCES Airport(Airport_code)
);

-- Leg Instance Table 
CREATE TABLE Leg_Instance
(
    leg_no INT,
    flight_date DATE,
    departure_time TIME,
    arrival_time TIME,
    number_of_available_seats INT,
    Airplane_id INT,
    PRIMARY KEY (leg_no, flight_date),
    FOREIGN KEY (leg_no) REFERENCES Flight_Leg(leg_no),
    FOREIGN KEY (Airplane_id) REFERENCES Airplane(Airplane_id)
);

-- Customer Table
CREATE TABLE Customer
(
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(20)
);

-- Seat Reservation Table
CREATE TABLE Seat_Reservation 
(
    leg_no INT,
    flight_date DATE,
    seat_number VARCHAR(10),
    customer_id INT,
    PRIMARY KEY (leg_no, flight_date, seat_number),
    FOREIGN KEY (leg_no, flight_date) REFERENCES Leg_Instance(leg_no, flight_date),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);
