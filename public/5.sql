
-- Create table
CREATE TABLE EMPLOYEE (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    Designation VARCHAR(50)
);

-- Insert records
INSERT INTO EMPLOYEE VALUES
(1, 'Alice', 'IT', 60000, 'Developer'),
(2, 'Bob', 'HR', 45000, 'Recruiter'),
(3, 'Charlie', 'IT', 48000, 'Tester'),
(4, 'David', 'IT', 75000, 'Manager');

-- a) Create view for IT employees
CREATE VIEW IT_Employees AS
SELECT * FROM EMPLOYEE
WHERE Department = 'IT';

-- b) Employees earning more than 50000
SELECT * FROM IT_Employees
WHERE Salary > 50000;

-- c) Update employee designation
UPDATE IT_Employees
SET Designation = 'Senior Developer'
WHERE EmpID = 1;

-- Display updated records
SELECT * FROM IT_Employees;

-- d) Procedure to display employee details
DELIMITER //

CREATE PROCEDURE GetEmployeeDetails(IN id INT)
BEGIN
    DECLARE name VARCHAR(50);
    DECLARE dept VARCHAR(50);
    DECLARE sal DECIMAL(10,2);
    DECLARE desig VARCHAR(50);

    SELECT EmpName, Department, Salary, Designation
    INTO name, dept, sal, desig
    FROM EMPLOYEE
    WHERE EmpID = id;

    SELECT name AS EmployeeName,
           dept AS Department,
           sal AS Salary,
           desig AS Designation;
END //

DELIMITER ;

-- Execute procedure
CALL GetEmployeeDetails(1);
