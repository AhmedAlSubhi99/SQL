-- I can't drop a database that's currently in use.So we use master.
USE master;
GO
-- This closes all connections and drops the database cleanly
ALTER DATABASE BANK SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE BANK;
GO
-- Create a fresh BANK 
CREATE DATABASE BANK;
GO
-- Switch to the new BANK
USE BANK;
GO

-- Branch Table
CREATE TABLE Branch 
(
    B_ID INT PRIMARY KEY,
    B_Address VARCHAR(255),
    Phone_No VARCHAR(15)
);

-- Employee Table
CREATE TABLE Employee
(
    E_ID INT PRIMARY KEY,
    E_Name VARCHAR(100),
    Position VARCHAR(50),
    B_ID INT,
    FOREIGN KEY (B_ID) REFERENCES Branch(B_ID)
);

-- Customer Table
CREATE TABLE Customer
(
    C_ID INT PRIMARY KEY,
    C_Name VARCHAR(100),
    C_Address VARCHAR(255),
    Phone_No VARCHAR(15),
    DOB DATE
);

-- Account Table
CREATE TABLE Account
(
    AccNUM INT PRIMARY KEY,
    A_Type VARCHAR(20) CHECK (A_Type IN ('Checking','Saving')),
    Date_of_Creation DATE,
    Balance DECIMAL(15, 2) CHECK (Balance >= 1 AND Balance <= 1000000),
    C_ID INT,
    FOREIGN KEY (C_ID) REFERENCES Customer(C_ID)
);

-- Transaction Table
CREATE TABLE Transaction0
(
    T_ID INT PRIMARY KEY,
    T_Type VARCHAR(20) CHECK (T_Type IN ('Deposit','Withdraw','Transfer')),
    T_Date DATE,
    Amount DECIMAL(15, 2) CHECK (Amount >= 1 AND Amount <= 1000000),
    AccNUM INT,
    FOREIGN KEY (AccNUM) REFERENCES Account(AccNUM)
);

-- Loan Table
CREATE TABLE Loan
(
    L_ID INT PRIMARY KEY,
    L_Type VARCHAR(50),
    Amount DECIMAL(15, 2) CHECK (Amount >= 1 AND Amount <= 1000000),
    Issue_Date DATE,
    C_ID INT,
    FOREIGN KEY (C_ID) REFERENCES Customer(C_ID)
);

-- Provide Table 
CREATE TABLE Provide
(
    C_ID INT,
    L_ID INT,
    PRIMARY KEY (C_ID, L_ID),
    FOREIGN KEY (C_ID) REFERENCES Customer(C_ID),
    FOREIGN KEY (L_ID) REFERENCES Loan(L_ID)
);

-- Handle Table 
CREATE TABLE Handle 
(
    E_ID INT,
    L_ID INT,
    Action_Type VARCHAR(100),
    PRIMARY KEY (E_ID, L_ID),
    FOREIGN KEY (E_ID) REFERENCES Employee(E_ID),
    FOREIGN KEY (L_ID) REFERENCES Loan(L_ID)
);

-- Assist Table 
CREATE TABLE Assist 
(
    E_ID INT,
    C_ID INT,
    PRIMARY KEY (E_ID, C_ID),
    FOREIGN KEY (E_ID) REFERENCES Employee(E_ID),
    FOREIGN KEY (C_ID) REFERENCES Customer(C_ID)
);

-- Insert data into Branch table 
INSERT INTO Branch (B_ID, B_Address, Phone_No)
VALUES
(1, 'Al Khuwair, Muscat', '+968 24488888'),
(2, 'Ruwi, Muscat', '+968 24777777'),
(3, 'Sohar', '+968 26844444'),
(4, 'Salalah', '+968 23222222'),
(5, 'Nizwa', '+968 25433333');

-- Insert data into Employee table
INSERT INTO Employee (E_ID, E_Name, Position, B_ID)
VALUES
(101, 'Khalid', 'Branch Manager', 1),
(102, 'Salim', 'Loan Officer', 1),
(103, 'Aisha', 'Teller', 1),
(104, 'Mohammed', 'Branch Manager', 2),
(105, 'Fatma', 'Customer Service', 2),
(106, 'Yousuf ', 'Loan Officer', 3),
(107, 'Mariam', 'Teller', 3),
(108, 'Hamad', 'Branch Manager', 4),
(109, 'Noor', 'Customer Service', 5),
(110, 'Abdullah', 'Teller', 5);

-- Insert data into Customer table 
INSERT INTO Customer (C_ID, C_Name, C_Address, Phone_No, DOB) 
VALUES
(1001, 'Ali', 'Muscat', '+968 91234567', '1985-03-15'),
(1002, 'Muna', 'Muscat', '+968 92345678', '1990-07-22'),
(1003, 'Salem', 'Sohar', '+968 93456789', '1978-11-30'),
(1004, 'Amina', 'Salalah ', '+968 94567890', '1982-05-18'),
(1005, 'Khamis', 'Nizwa', '+968 95678901', '1995-09-10');

-- Insert data into Account table 
INSERT INTO Account (AccNUM, A_Type, Date_of_Creation, Balance, C_ID) 
VALUES
(50001, 'Checking', '2020-01-15', 12500.00, 1001),
(50002, 'Saving', '2019-05-22', 87500.00, 1001),
(50003, 'Checking', '2021-03-10', 32000.00, 1002),
(50004, 'Saving', '2022-07-18', 150000.00, 1003),
(50005, 'Checking', '2020-11-30', 4500.00, 1004),
(50006, 'Saving', '2021-09-05', 75000.00, 1005);

-- Insert data into Transaction0 table 
INSERT INTO Transaction0 (T_ID, T_Type, T_Date, Amount, AccNUM)
VALUES
(7001, 'Deposit', '2023-05-01', 500.00, 50001),
(7002, 'Withdraw', '2023-05-02', 200.00, 50001),
(7003, 'Deposit', '2023-05-03', 1000.00, 50003),
(7004, 'Transfer', '2023-05-04', 1500.00, 50004),
(7005, 'Withdraw', '2023-05-05', 300.00, 50005),
(7006, 'Deposit', '2023-05-06', 2500.00, 50002); 

-- Insert data into Loan table (in Omani Rials)
INSERT INTO Loan (L_ID, L_Type, Amount, Issue_Date, C_ID) VALUES
(9001, 'Personal Loan', 10000.00, '2022-01-10', 1001),
(9002, 'Car Loan', 25000.00, '2021-11-15', 1003),
(9003, 'Home Loan', 150000.00, '2020-05-20', 1005);

-- Insert data into Provide table
INSERT INTO Provide (C_ID, L_ID) 
VALUES
(1001, 9001),
(1003, 9002),
(1005, 9003);

-- Insert data into Handle table
INSERT INTO Handle (E_ID, L_ID, Action_Type) 
VALUES
(102, 9001, 'Loan Approval'),
(106, 9002, 'Loan Disbursement'),
(102, 9003, 'Loan Approval');

-- Insert data into Assist table
INSERT INTO Assist (E_ID, C_ID) VALUES
(103, 1001),
(105, 1002),
(107, 1003),
(109, 1004),
(110, 1005);

-- Select all Branches
SELECT * FROM Branch;

-- Select all Employees
SELECT * FROM Employee;

-- Select all Customers
SELECT * FROM Customer;

-- Select all Accounts
SELECT * FROM Account;

-- Select all Transactions
SELECT * FROM Transaction0;

-- Select all Loans
SELECT * FROM Loan;

-- Select all Provide relationship
SELECT * FROM Provide;

-- Select all Handle relationship
SELECT * FROM Handle;

-- Select all Assist relationship
SELECT * FROM Assist;

