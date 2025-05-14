-- I can't drop a database that's currently in use. So we use master.
USE master;
GO
-- This closes all connections and drops the database cleanly
ALTER DATABASE UNIVERSITY SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE UNIVERSITY;
GO
-- Create a fresh UNIVERSITY 
CREATE DATABASE UNIVERSITY;
GO
-- Switch to the new UNIVERSITY
USE UNIVERSITY;
GO

-- Faculty Table
CREATE TABLE Faculty 
(
    F_id INT PRIMARY KEY,
    F_Name VARCHAR(100),
    Mobile_No VARCHAR(15),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2)
);

-- Student Table
CREATE TABLE Student
(
    S_id INT PRIMARY KEY,
    Fname VARCHAR(50),
    Lname VARCHAR(50),
    Phone_no VARCHAR(15),
    DOB DATE
);

-- Subject Table
CREATE TABLE Subject 
(
    Subject_id INT PRIMARY KEY,
    Subject_Name VARCHAR(100)
);

-- Hostel Table
CREATE TABLE Hostel
(
    Hostel_id INT PRIMARY KEY,
    Hostel_Name VARCHAR(100),
    No_Of_Seat INT,
    H_Address VARCHAR(200),
    City VARCHAR(50),
    H_State VARCHAR(50),
    Pin_Code VARCHAR(10)
);

-- Course Table
CREATE TABLE Course
(
    Course_id INT PRIMARY KEY,
    Course_Name VARCHAR(100),
    Duration VARCHAR(50)
);

-- Department Table
CREATE TABLE Department 
(
    Department_id INT PRIMARY KEY,
    D_Name VARCHAR(100)
);

-- Exams Table
CREATE TABLE Exams 
(
    Exam_Code INT PRIMARY KEY,
    E_Date DATE,
    E_Time TIME,
    Room VARCHAR(20),
    Department_id INT,
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id)
);

-- Faculty teaches Subject
CREATE TABLE Teach 
(
    F_id INT,
    Subject_id INT,
    PRIMARY KEY (F_id, Subject_id),
    FOREIGN KEY (F_id) REFERENCES Faculty(F_id),
    FOREIGN KEY (Subject_id) REFERENCES Subject(Subject_id)
);

-- Faculty handles Subject
CREATE TABLE Handle_Subject
(
    F_id INT,
    Subject_id INT,
    PRIMARY KEY (F_id, Subject_id),
    FOREIGN KEY (F_id) REFERENCES Faculty(F_id),
    FOREIGN KEY (Subject_id) REFERENCES Subject(Subject_id)
);

-- Student takes Subject
CREATE TABLE Take_Subject 
(
    S_id INT,
    Subject_id INT,
    PRIMARY KEY (S_id, Subject_id),
    FOREIGN KEY (S_id) REFERENCES Student(S_id),
    FOREIGN KEY (Subject_id) REFERENCES Subject(Subject_id)
);

-- Student lives in Hostel
CREATE TABLE Live 
(
    S_id INT PRIMARY KEY,
    Hostel_id INT,
    FOREIGN KEY (S_id) REFERENCES Student(S_id),
    FOREIGN KEY (Hostel_id) REFERENCES Hostel(Hostel_id)
);

-- Student enrolls in Course
CREATE TABLE Enroll
(
    S_id INT,
    Course_id INT,
    PRIMARY KEY (S_id, Course_id),
    FOREIGN KEY (S_id) REFERENCES Student(S_id),
    FOREIGN KEY (Course_id) REFERENCES Course(Course_id)
);

-- Course handled by Department
CREATE TABLE Handle_Course
(
    Course_id INT,
    Department_id INT,
    PRIMARY KEY (Course_id, Department_id),
    FOREIGN KEY (Course_id) REFERENCES Course(Course_id),
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id)
);

-- Student belongs to Department
CREATE TABLE Student_Department 
(
    S_id INT PRIMARY KEY,
    Department_id INT,
    FOREIGN KEY (S_id) REFERENCES Student(S_id),
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id)
);

-- Department conducts Exams
CREATE TABLE Conduct 
(
    Department_id INT,
    Exam_Code INT,
    PRIMARY KEY (Department_id, Exam_Code),
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id),
    FOREIGN KEY (Exam_Code) REFERENCES Exams(Exam_Code)
);

USE UNIVERSITY;
GO

-- Insert data into Department table
INSERT INTO Department (Department_id, D_Name) VALUES
(1, 'Computer Science'),
(2, 'Engineering'),
(3, 'Medicine'),
(4, 'Islamic Studies'),
(5, 'Business Administration');

-- Insert data into Faculty table (Arab names)
INSERT INTO Faculty (F_id, F_Name, Mobile_No, Department, Salary) VALUES
(101, 'Dr. Ahmed', '+966501234567', 'Computer Science', 25000.00),
(102, 'Dr. Fatima', '+966502345678', 'Engineering', 28000.00),
(103, 'Dr. Khalid', '+966503456789', 'Medicine', 35000.00),
(104, 'Dr. Aisha', '+966504567890', 'Islamic Studies', 22000.00),
(105, 'Dr. Omar', '+966505678901', 'Business Administration', 30000.00);

-- Insert data into Student table (Arab names)
INSERT INTO Student (S_id, Fname, Lname, Phone_no, DOB) VALUES
(1001, 'Mohammed', 'Al-SUBHI', '+966511234567', '2000-05-15'),
(1002, 'Layla', 'Al-ABRI', '+966512345678', '2001-07-22'),
(1003, 'Abdullah', 'Al-Jabri', '+966513456789', '1999-11-30'),
(1004, 'Noor', 'Al-SALMI', '+966514567890', '2000-03-18'),
(1005, 'Yousef', 'Al-ALALWI', '+966515678901', '2001-09-10');

-- Insert data into Subject table
INSERT INTO Subject (Subject_id, Subject_Name) VALUES
(501, 'Database Systems'),
(502, 'Advanced Mathematics'),
(503, 'Human Anatomy'),
(504, 'Quranic Studies'),
(505, 'Financial Accounting'),
(506, 'Programming Fundamentals'),
(507, 'Islamic History'),
(508, 'Clinical Medicine');

-- Insert data into Hostel table
INSERT INTO Hostel (Hostel_id, Hostel_Name, No_Of_Seat, H_Address, City, H_State, Pin_Code) VALUES
(201, 'Al-SUBHI Hostel', 200, 'WADI GHOUL', 'ALHAMRA', 'ALHAMRA Province', '11543'),
(202, 'Al-ABRI Hostel', 150, 'CITY CENTER', 'MUSCAT', 'ALHAIL Province', '21432'),
(203, 'IBRI Hostel', 100, 'IBRI UNIVERSITY', 'IBRI', 'IBRI Province', '31433');

-- Insert data into Course table
INSERT INTO Course (Course_id, Course_Name, Duration) VALUES
(301, 'Bachelor of Computer Science', '4 years'),
(302, 'Bachelor of Engineering', '5 years'),
(303, 'Bachelor of Medicine', '6 years'),
(304, 'Bachelor of Math', '4 years'),
(305, 'Bachelor of Business', '4 years');

-- Insert data into Exams table
INSERT INTO Exams (Exam_Code, E_Date, E_Time, Room, Department_id) VALUES
(601, '2023-12-15', '09:00:00', 'Room 101', 1),
(602, '2023-12-16', '10:30:00', 'Room 205', 2),
(603, '2023-12-17', '08:00:00', 'Room 310', 3),
(604, '2023-12-18', '11:00:00', 'Room 412', 4),
(605, '2023-12-19', '13:30:00', 'Room 105', 5);

-- Insert data into Teach table
INSERT INTO Teach (F_id, Subject_id) VALUES
(101, 501),
(101, 506),
(102, 502),
(103, 503),
(103, 508),
(104, 504),
(104, 507),
(105, 505);

-- Insert data into Handle_Subject table
INSERT INTO Handle_Subject (F_id, Subject_id) VALUES
(101, 501),
(102, 502),
(103, 503),
(104, 504),
(105, 505);

-- Insert data into Take_Subject table
INSERT INTO Take_Subject (S_id, Subject_id) VALUES
(1001, 501),
(1001, 506),
(1002, 502),
(1003, 503),
(1003, 508),
(1004, 504),
(1004, 507),
(1005, 505);

-- Insert data into Live table
INSERT INTO Live (S_id, Hostel_id) VALUES
(1001, 201),
(1002, 201),
(1003, 202),
(1004, 203),
(1005, 203);

-- Insert data into Enroll table
INSERT INTO Enroll (S_id, Course_id) VALUES
(1001, 301),
(1002, 302),
(1003, 303),
(1004, 304),
(1005, 305);

-- Insert data into Handle_Course table
INSERT INTO Handle_Course (Course_id, Department_id) VALUES
(301, 1),
(302, 2),
(303, 3),
(304, 4),
(305, 5);

-- Insert data into Student_Department table
INSERT INTO Student_Department (S_id, Department_id) VALUES
(1001, 1),
(1002, 2),
(1003, 3),
(1004, 4),
(1005, 5);

-- Insert data into Conduct table
INSERT INTO Conduct (Department_id, Exam_Code) VALUES
(1, 601),
(2, 602),
(3, 603),
(4, 604),
(5, 605);

-- Display all Departments
SELECT * FROM Department;

-- Display all Faculty
SELECT * FROM Faculty;

-- Display all Students
SELECT * FROM Student;

-- Display all Subjects
SELECT * FROM Subject;

-- Display all Hostels
SELECT * FROM Hostel;

-- Display all Courses
SELECT * FROM Course;

-- Display all Exams
SELECT * FROM Exams;

-- Display all Teaching assignments
SELECT * FROM Teach;

-- Display all Subject handling
SELECT * FROM Handle_Subject;

-- Display all Student subject enrollments
SELECT * FROM Take_Subject;

-- Display all Hostel residents
SELECT * FROM Live;

-- Display all Course enrollments
SELECT * FROM Enroll;

-- Display all Course-Department relationships
SELECT * FROM Handle_Course;

-- Display all Student-Department relationships
SELECT * FROM Student_Department;

-- Display all Exam conducting departments
SELECT * FROM Conduct;