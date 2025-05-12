-- CREATE DATABASE BANK;

USE BANK;

-- Branch Table
CREATE TABLE Branch 
(
    B_ID INT PRIMARY KEY,
    Address VARCHAR(255),
    Phone_No VARCHAR(15)
);

-- Employee Table
CREATE TABLE Employee
(
    E_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Position VARCHAR(50),
    B_ID INT,
    FOREIGN KEY (B_ID) REFERENCES Branch(B_ID)
);

-- Customer Table
CREATE TABLE Customer
(
    C_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(255),
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
    Date DATE,
    Amount DECIMAL(15, 2) CHECK (Amount >= 1 AND Amount <= 1000000),
    AccNUM INT,
    FOREIGN KEY (AccNUM) REFERENCES Account(AccNUM)
);

-- Loan Table
CREATE TABLE Loan
(
    L_ID INT PRIMARY KEY,
    Type VARCHAR(50),
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

