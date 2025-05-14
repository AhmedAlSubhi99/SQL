-- I can't drop a database that's currently in use. So we use master.
USE master;
GO
-- This closes all connections and drops the database cleanly
ALTER DATABASE HOTEL SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE HOTEL;
GO
-- Create a fresh HOTEL 
CREATE DATABASE HOTEL;
GO
-- Switch to the new HOTEL
USE HOTEL;
GO
-- BRANCH TABLE
CREATE TABLE BRANCH
(
  B_ID INT PRIMARY KEY,
  B_NAME NVARCHAR(10),
  B_Location NVARCHAR(100) 
);

-- STAFF TABLE
CREATE TABLE STAFF
(  
  S_ID INT PRIMARY KEY,
  S_NAME NVARCHAR(100),
  Job_Title NVARCHAR(50),
  Salary DECIMAL(10, 2) CHECK (Salary >= 600 AND Salary <= 1500),
  B_ID INT,
  FOREIGN KEY (B_ID) REFERENCES BRANCH(B_ID)
);

-- ROOMS TABLE
CREATE TABLE ROOMS 
(
  R_NUM INT PRIMARY KEY,
  R_Type VARCHAR(50),
  NIGHTLY_RATY DECIMAL(10, 2),
  B_ID INT,
  FOREIGN KEY (B_ID) REFERENCES BRANCH(B_ID)
);

-- CUSTOMER TABLE
CREATE TABLE CUSTOMER 
(
  C_ID INT PRIMARY KEY,
  C_Name VARCHAR(100),
  Email VARCHAR(100),
  Phone VARCHAR(20)
);

-- BOOKING TABLE 
CREATE TABLE BOOKING 
(
  Booking_ID INT PRIMARY KEY,
  Check_in DATE,
  Check_out DATE,
  inAvailability CHAR(1) CHECK (inAvailability IN ('Y','N')),
  C_ID INT,
  R_NUM INT,
  FOREIGN KEY (C_ID) REFERENCES CUSTOMER(C_ID),
  FOREIGN KEY (R_NUM) REFERENCES ROOMS(R_NUM)
);

-- Insert Data TO Branches
INSERT INTO BRANCH (B_ID, B_NAME, B_Location)
VALUES
(1, 'Muscat', 'Al Khuwair, Muscat'),
(2, 'Salalah', 'Haffa District, Salalah'),
(3, 'Sohar', 'Sohar Corniche');

-- Insert Data TO Staff Members
INSERT INTO STAFF (S_ID, S_NAME, Job_Title, Salary, B_ID)
VALUES
(101, 'Khalid', 'Manager', 1200.00, 1),
(102, 'Aisha', 'Reception', 800.00, 1),
(103, 'Salim', 'Manager', 1200.00, 2),
(104, 'Fatma', 'Housekeeper', 750.00, 2),
(105, 'Yousuf', 'Manager', 1200.00, 3),
(106, 'Mariam', 'DOOR OPENING', 850.00, 3);

-- Insert Data TO Rooms
INSERT INTO ROOMS (R_NUM, R_Type, NIGHTLY_RATY, B_ID)
VALUES
(101, 'Standard', 60.00, 1),
(102, 'VIP', 90.00, 1),
(201, 'Standard', 55.00, 2),
(202, 'PREMUIM', 120.00, 2),
(301, 'Standard', 50.00, 3),
(302, 'VIP', 85.00, 3);

-- Insert Data TO Customers
INSERT INTO CUSTOMER (C_ID, C_Name, Email, Phone) 
VALUES
(1001, 'Ali', 'ali@example.com', '+96891234567'),
(1002, 'Muna', 'muna@example.com', '+96892345678'),
(1003, 'Salem', 'salem@example.com', '+96893456789');

-- Insert Data TO Bookings
INSERT INTO BOOKING (Booking_ID, Check_in, Check_out, inAvailability, C_ID, R_NUM) 
VALUES
(5001, '2023-11-01', '2023-11-05', 'N', 1001, 101),
(5002, '2023-11-10', '2023-11-12', 'N', 1002, 202),
(5003, '2023-11-15', '2023-11-20', 'Y', 1003, 301);

-- Select all from BRANCH
SELECT * FROM BRANCH;

-- Select all from STAFF
SELECT * FROM STAFF;

-- Select all from ROOMS
SELECT * FROM ROOMS;

-- Select all from CUSTOMER
SELECT * FROM CUSTOMER;

-- Select all from BOOKING
SELECT * FROM BOOKING;