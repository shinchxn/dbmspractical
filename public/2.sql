-- Clean up existing tables/procedures if you run this script multiple times
DROP PROCEDURE IF EXISTS CountEmployeesInDept;
DROP TABLE IF EXISTS EMPLOYEE;
DROP TABLE IF EXISTS DEPARTMENT;

-- 2. Create Tables
CREATE TABLE DEPARTMENT (
    DeptNo INT PRIMARY KEY,
    DeptName VARCHAR(50)
);

CREATE TABLE EMPLOYEE (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE,
    DeptNo INT,
    FOREIGN KEY (DeptNo) REFERENCES DEPARTMENT(DeptNo)
);

-- a) Insert at least 6 employees across 3 departments
INSERT INTO DEPARTMENT (DeptNo, DeptName) VALUES 
(1, 'IT'), 
(2, 'HR'), 
(3, 'Sales');

INSERT INTO EMPLOYEE (EmpID, EmpName, Salary, HireDate, DeptNo) VALUES 
(101, 'Alice', 45000, '2023-01-15', 1),
(102, 'Bob', 35000, '2023-06-20', 2),
(103, 'Charlie', 55000, '2022-11-10', 1),
(104, 'David', 42000, '2024-02-01', 3),
(105, 'Eve', 38000, '2021-08-12', 2),
(106, 'Frank', 48000, '2020-03-30', 3);

-- b) Display employees earning more than ₹40,000
SELECT 'Employees earning > 40000' AS Query_Result;
SELECT * FROM EMPLOYEE 
WHERE Salary > 40000;

-- c) Increase the salary of employees in a selected department by 10%
UPDATE EMPLOYEE 
SET Salary = Salary + (Salary * 0.10) 
WHERE DeptNo = 1;

-- d) Retrieve employees hired after a specified date (Jan 1, 2023)
SELECT 'Employees hired after 2023-01-01' AS Query_Result;
SELECT * FROM EMPLOYEE 
WHERE HireDate > '2023-01-01';

-- e) Procedure to accept a department number and display the number of employees
DELIMITER //

CREATE PROCEDURE CountEmployeesInDept (IN input_DeptNo INT)
BEGIN
    SELECT COUNT(*) AS NumberOfEmployees
    FROM EMPLOYEE
    WHERE DeptNo = input_DeptNo;
END //

DELIMITER ;

-- Test the procedure for Department 1 (IT)
SELECT 'Employee count for Department 1' AS Query_Result;
CALL CountEmployeesInDept(1);