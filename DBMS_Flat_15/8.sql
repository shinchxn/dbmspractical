
-- Create table
CREATE TABLE EMPLOYEE (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- Insert records
INSERT INTO EMPLOYEE VALUES
(1, 'Alice', 'IT', 60000),
(2, 'Bob', 'HR', 45000),
(3, 'Charlie', 'IT', 55000);

-- a) Create STAFF as a synonym-like view
CREATE VIEW STAFF AS
SELECT * FROM EMPLOYEE;

-- b) Display employee details using STAFF
SELECT * FROM STAFF;

-- c) Create view for IT employees
CREATE VIEW IT_STAFF AS
SELECT * FROM EMPLOYEE
WHERE Department = 'IT';

-- Display IT employees
SELECT * FROM IT_STAFF;

-- d) Difference between STAFF and IT_STAFF

-- STAFF displays all employees
SELECT * FROM STAFF;

-- IT_STAFF displays only IT employees
SELECT * FROM IT_STAFF;
