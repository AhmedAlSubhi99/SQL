-- I can't drop a database that's currently in use.So we use master.
USE master;
GO
-- This closes all connections and drops the database cleanly
ALTER DATABASE ComapnyDatabase SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE ComapnyDatabase;
GO
-- Create a fresh ComapnyDatabase 
CREATE DATABASE ComapnyDatabase;
GO
-- Switch to the new ComapnyDatabase
USE ComapnyDatabase;
GO


-- DEPARTMENT TABLE
CREATE TABLE DEPARTMENT
(
    Dnumber INT PRIMARY KEY,
    Dname varchar(50) NOT NULL,
    Mgr_ssn INT,
    Mgr_start_date date
);

-- EMPLOYEE TABLE
CREATE TABLE EMPLOYEE
(
    Ssn CHAR(9) PRIMARY KEY,
    Fname VARCHAR(50),
    Minit CHAR(1),
    Lname VARCHAR(50),
    Bdate DATE,
    E_Address VARCHAR(100),
    Sex BIT DEFAULT 0,
    Salary DECIMAL(10, 2),
    Super_ssn CHAR(9),
    Dno int,
	FOREIGN KEY (Dno) REFERENCES DEPARTMENT(Dnumber),
	FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE(Ssn)
);

-- DEPT_LOCATIONS TABLE
CREATE TABLE DEPT_LOCATIONS 
(
    Dnumber int,
    Dlocation varchar(50),
    PRIMARY KEY (Dnumber, Dlocation),
    FOREIGN KEY (Dnumber) REFERENCES DEPARTMENT(Dnumber)
);

-- PROJECT TABLE
CREATE TABLE PROJECT
(
    Pnumber int PRIMARY KEY,
    Pname varchar(30),
    Plocation varchar(50),
    Dnum int,
    FOREIGN KEY (Dnum) REFERENCES DEPARTMENT(Dnumber)
);


-- WORKS_ON TABLE
CREATE TABLE WORKS_ON
(
    Essn char(9),
    Pno int,
    Hours decimal(4,1),
    PRIMARY KEY (Essn, Pno),
    FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn),
    FOREIGN KEY (Pno) REFERENCES PROJECT(Pnumber)
);


-- DEPENDENT TABLE
CREATE TABLE DEPENDENTS
(
    Essn char(9),
    Dependent_name varchar(20) not null,
    Sex bit default 0,
    Bdate date,
    Relationship varchar(20),
    PRIMARY KEY (Essn, Dependent_name),
    FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn)
);

-- Add self-reference from EMPLOYEE.Super_ssn to EMPLOYEE.Ssn
--ALTER TABLE EMPLOYEE
--ADD CONSTRAINT FK_Emp_Supervisor FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE(Ssn);

-- Add foreign key from DEPARTMENT.Mgr_ssn to EMPLOYEE.Ssn
--ALTER TABLE DEPARTMENT
--ADD CONSTRAINT FK_Dept_Manager FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn);

-- First insert employees with NULL department values (to avoid foreign key constraint issues)
INSERT INTO EMPLOYEE (Ssn, Fname, Minit, Lname, Bdate, E_Address, Sex, Salary, Super_ssn, Dno)
VALUES 
    ('1', 'AHMED', 'H', 'ALSUBHI', '2000-01-01', 'ALHAMRA', 1, 10000.00, NULL, NULL),
    ('2', 'ALI', 'S', 'ALABRI', '1998-09-05', 'BAHLA', 1, 540.00, NULL, NULL),
    ('3', 'LUNA', 'M', 'JOHN', '1995-03-04', 'USA', 0, 1200.00, NULL, NULL),
    ('4', 'MOHAMMED', 'M', 'ALSALMI', '1995-07-04', 'MUSCAT', 1, 1300.00, NULL, NULL),
    ('5', 'SARA', 'T', 'ALADWI', '1999-03-25', 'IZKI', 0, 650.00, NULL, NULL),
    ('6', 'TARIQ', 'R', 'ALALWI', '1999-06-03', 'NIZWA', 1, 1200.00, NULL, NULL),
    ('7', 'MONA', 'Y', 'ALJABRI', '2001-08-23', 'MUSCAT', 0, 750.00, NULL, NULL);

-- Insert departments with managers from our employee pool
INSERT INTO DEPARTMENT (Dnumber, Dname, Mgr_ssn, Mgr_start_date)
VALUES 
    (1, 'Research', '3', '2020-05-22'),     -- LUNA manages Research
    (2, 'Administration', '4', '2019-01-01'),  -- MOHAMMED manages Administration
    (3, 'Software', '1', '2020-02-15'),     -- AHMED manages Software
    (4, 'Hardware', '6', '2021-03-01');     -- TARIQ manages Hardware

-- Set up supervisor relationships
UPDATE EMPLOYEE
SET Super_ssn = '1'  -- AHMED is the supervisor
WHERE Ssn IN ('2', '5');  -- ALI and SARA report to AHMED

UPDATE EMPLOYEE
SET Super_ssn = '3'  -- LUNA is the supervisor
WHERE Ssn = '4';  -- MOHAMMED reports to LUNA

UPDATE EMPLOYEE
SET Super_ssn = '6'  -- TARIQ is the supervisor
WHERE Ssn = '7';  -- MONA reports to TARIQ

-- Now assign employees to departments
UPDATE EMPLOYEE 
SET Dno = 3  -- Software department
WHERE Ssn IN ('1', '2', '5');  -- AHMED, ALI, and SARA work in Software

UPDATE EMPLOYEE 
SET Dno = 1  -- Research department
WHERE Ssn = '3';  -- LUNA works in Research

UPDATE EMPLOYEE 
SET Dno = 2  -- Administration department
WHERE Ssn = '4';  -- MOHAMMED works in Administration

UPDATE EMPLOYEE 
SET Dno = 4  -- Hardware department
WHERE Ssn IN ('6', '7');  -- TARIQ and MONA work in Hardware

-- Insert data into DEPT_LOCATIONS table
INSERT INTO DEPT_LOCATIONS (Dnumber, Dlocation)
VALUES 
    (1, 'MUSCAT'),        -- Research department in MUSCAT
    (1, 'SOHAR'),         -- Research department also in SOHAR
    (2, 'NIZWA'),         -- Administration department in NIZWA
    (3, 'SALALAH'),       -- Software department in SALALAH
    (3, 'MUSCAT'),        -- Software department also in MUSCAT
    (4, 'SUR'),           -- Hardware department in SUR
    (4, 'IBRI');          -- Hardware department also in IBRI

-- Insert data into PROJECT table
INSERT INTO PROJECT (Pnumber, Pname, Plocation, Dnum)
VALUES 
    (1, 'Database Development', 'MUSCAT', 3),      -- Software department project
    (2, 'Network Infrastructure', 'NIZWA', 2),     -- Administration department project
    (3, 'AI Research', 'SOHAR', 1),                -- Research department project
    (4, 'Mobile App', 'SALALAH', 3),               -- Software department project
    (5, 'Server Hardware', 'SUR', 4),              -- Hardware department project
    (6, 'IoT Devices', 'IBRI', 4),                 -- Hardware department project
    (7, 'Data Analysis', 'MUSCAT', 1);             -- Research department project

-- Insert data into WORKS_ON table
INSERT INTO WORKS_ON (Essn, Pno, Hours)
VALUES 
    ('1', 1, 20.0),   -- AHMED works on Database Development for 20 hours
    ('1', 4, 10.0),   -- AHMED also works on Mobile App for 10 hours
    ('2', 1, 30.0),   -- ALI works on Database Development for 30 hours
    ('3', 3, 15.0),   -- LUNA works on AI Research for 15 hours
    ('3', 7, 25.0),   -- LUNA also works on Data Analysis for 25 hours
    ('4', 2, 40.0),   -- MOHAMMED works on Network Infrastructure for 40 hours
    ('5', 1, 10.0),   -- SARA works on Database Development for 10 hours
    ('5', 4, 20.0),   -- SARA also works on Mobile App for 20 hours
    ('6', 5, 25.0),   -- TARIQ works on Server Hardware for 25 hours
    ('6', 6, 15.0),   -- TARIQ also works on IoT Devices for 15 hours
    ('7', 5, 30.0),   -- MONA works on Server Hardware for 30 hours
    ('7', 6, 10.0);   -- MONA also works on IoT Devices for 10 hours

-- Insert data into DEPENDENT table
INSERT INTO DEPENDENTS(Essn, Dependent_name, Sex, Bdate, Relationship)
VALUES 
    ('1', 'Fatima', 0, '2010-05-15', 'Daughter'),     -- AHMED's daughter
    ('7', 'Omar', 1, '2015-08-20', 'Son'),           -- MONA's son
    ('3', 'Mark', 1, '2012-03-10', 'Daughter'),      -- LUNA's daughter
    ('4', 'Salim', 1, '2018-11-05', 'Son'),          -- MOHAMMED's son
    ('2', 'Layla', 0, '2016-04-12', 'Daughter'),      -- ALI's daughter
    ('6', 'Nasser', 1, '2014-09-25', 'Son');         -- TARIQ's son


-- Basic display of all EMPLOYEES
SELECT * FROM EMPLOYEE;

-- Basic display of all DEPARTMENT
SELECT * FROM DEPARTMENT;

-- Basic display of all LOCATION DEPARTMENT
SELECT * FROM  DEPT_LOCATIONS;

-- Basic display of all PROJECT
SELECT * FROM PROJECT;

-- Basic display of all WORK ON
SELECT * FROM WORKS_ON;

-- Basic display of all DEPENDENTS
SELECT * FROM DEPENDENTS;


