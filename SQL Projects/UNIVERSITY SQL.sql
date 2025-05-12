CREATE DATABASE UNIVERSITY;
USE UNIVERSITY;

-- Faculty Table
CREATE TABLE Faculty 
(
    F_id INT PRIMARY KEY,
    Name VARCHAR(100),
    Mobile_No VARCHAR(15),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2)
);

-- Student Table
CREATE TABLE Student (
    S_id INT PRIMARY KEY,
    Fname VARCHAR(50),
    Lname VARCHAR(50),
    Phone_no VARCHAR(15),
    DOB DATE
);

-- Subject Table
CREATE TABLE Subject (
    Subject_id INT PRIMARY KEY,
    Subject_Name VARCHAR(100)
);

-- Hostel Table
CREATE TABLE Hostel (
    Hostel_id INT PRIMARY KEY,
    Hostel_Name VARCHAR(100),
    No_Of_Seat INT,
    Address VARCHAR(200),
    City VARCHAR(50),
    State VARCHAR(50),
    Pin_Code VARCHAR(10)
);

-- Course Table
CREATE TABLE Course (
    Course_id INT PRIMARY KEY,
    Course_Name VARCHAR(100),
    Duration VARCHAR(50)
);

-- Department Table
CREATE TABLE Department (
    Department_id INT PRIMARY KEY,
    D_Name VARCHAR(100)
);

-- Exams Table
CREATE TABLE Exams (
    Exam_Code INT PRIMARY KEY,
    Date DATE,
    Time TIME,
    Room VARCHAR(20),
    Department_id INT,
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id)
);

-- Faculty teaches Subject
CREATE TABLE Teach (
    F_id INT,
    Subject_id INT,
    PRIMARY KEY (F_id, Subject_id),
    FOREIGN KEY (F_id) REFERENCES Faculty(F_id),
    FOREIGN KEY (Subject_id) REFERENCES Subject(Subject_id)
);

-- Faculty handles Subject
CREATE TABLE Handle_Subject (
    F_id INT,
    Subject_id INT,
    PRIMARY KEY (F_id, Subject_id),
    FOREIGN KEY (F_id) REFERENCES Faculty(F_id),
    FOREIGN KEY (Subject_id) REFERENCES Subject(Subject_id)
);

-- Student takes Subject
CREATE TABLE Take_Subject (
    S_id INT,
    Subject_id INT,
    PRIMARY KEY (S_id, Subject_id),
    FOREIGN KEY (S_id) REFERENCES Student(S_id),
    FOREIGN KEY (Subject_id) REFERENCES Subject(Subject_id)
);

-- Student lives in Hostel
CREATE TABLE Live (
    S_id INT PRIMARY KEY,
    Hostel_id INT,
    FOREIGN KEY (S_id) REFERENCES Student(S_id),
    FOREIGN KEY (Hostel_id) REFERENCES Hostel(Hostel_id)
);

-- Student enrolls in Course
CREATE TABLE Enroll (
    S_id INT,
    Course_id INT,
    PRIMARY KEY (S_id, Course_id),
    FOREIGN KEY (S_id) REFERENCES Student(S_id),
    FOREIGN KEY (Course_id) REFERENCES Course(Course_id)
);

-- Course handled by Department
CREATE TABLE Handle_Course (
    Course_id INT,
    Department_id INT,
    PRIMARY KEY (Course_id, Department_id),
    FOREIGN KEY (Course_id) REFERENCES Course(Course_id),
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id)
);

-- Student belongs to Department
CREATE TABLE Student_Department (
    S_id INT PRIMARY KEY,
    Department_id INT,
    FOREIGN KEY (S_id) REFERENCES Student(S_id),
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id)
);

-- Department conducts Exams
CREATE TABLE Conduct (
    Department_id INT,
    Exam_Code INT,
    PRIMARY KEY (Department_id, Exam_Code),
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id),
    FOREIGN KEY (Exam_Code) REFERENCES Exams(Exam_Code)
);