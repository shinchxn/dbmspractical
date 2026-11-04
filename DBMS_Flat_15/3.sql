
-- Create Employee table
CREATE TABLE EMPLOYEE (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- Insert records
INSERT INTO EMPLOYEE VALUES
(1, 'Alice', 'IT', 60000),
(2, 'Bob', 'HR', 40000),
(3, 'Charlie', 'IT', 75000),
(4, 'David', 'Sales', 50000),
(5, 'Eve', 'HR', 45000),
(6, 'Frank', 'Sales', 50000);

-- a) Employees earning above average salary
SELECT *
FROM EMPLOYEE
WHERE Salary > (SELECT AVG(Salary) FROM EMPLOYEE);

-- b) Employee receiving second-highest salary
SELECT *
FROM EMPLOYEE
ORDER BY Salary DESC
LIMIT 1 OFFSET 1;

-- c) Employees earning above their department average
SELECT *
FROM EMPLOYEE e1
WHERE Salary > (
    SELECT AVG(Salary)
    FROM EMPLOYEE e2
    WHERE e1.Department = e2.Department
);

-- d) Procedure to find second-highest distinct salary
DELIMITER //

CREATE PROCEDURE GetSecondHighestSalary()
BEGIN
    SELECT DISTINCT Salary
    FROM EMPLOYEE
    ORDER BY Salary DESC
    LIMIT 1 OFFSET 1;
END //

DELIMITER ;

-- Execute procedure
CALL GetSecondHighestSalary();
