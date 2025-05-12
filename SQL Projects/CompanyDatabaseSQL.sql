CREATE DATABASE ComapnyDatabase;

USE CompanyDatabase;

-- DEPARTMENT TABLE
CREATE TABLE DEPARTMENT 
(
    Dnumber INT PRIMARY KEY,
    Dname varchar(20) NOT NULL,
    Mgr_ssn char(9),
    Mgr_start_date date
);

-- EMPLOYEE TABLE
CREATE TABLE EMPLOYEE
(
    Ssn char(9) PRIMARY KEY,
    Fname varchar(15),
    Minit char(1),
    Lname varchar(15),
    Bdate date,
    Address varchar(100),
    Sex bit default 0,
    Salary decimal(10, 2),
    Super_ssn char(9),
    Dno int
);

-- Add foreign key from EMPLOYEE.Dno to DEPARTMENT.Dnumber
ALTER TABLE EMPLOYEE
ADD CONSTRAINT FK_Emp_Dept FOREIGN KEY (Dno) REFERENCES DEPARTMENT(Dnumber);

-- Add self-reference from EMPLOYEE.Super_ssn to EMPLOYEE.Ssn
ALTER TABLE EMPLOYEE
ADD CONSTRAINT FK_Emp_Supervisor FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE(Ssn);

-- Add foreign key from DEPARTMENT.Mgr_ssn to EMPLOYEE.Ssn
ALTER TABLE DEPARTMENT
ADD CONSTRAINT FK_Dept_Manager FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn);

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
CREATE TABLE DEPENDENT
(
    Essn char(9),
    Dependent_name varchar(20) not null,
    Sex bit default 0,
    Bdate date,
    Relationship varchar(20),
    PRIMARY KEY (Essn, Dependent_name),
    FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn)
);

