
-- Create EMPLOYEE table
CREATE TABLE EMPLOYEE (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- Insert 6 records
INSERT INTO EMPLOYEE VALUES
(1, 'Alice', 'IT', 60000),
(2, 'Bob', 'HR', 40000),
(3, 'Charlie', 'IT', 75000),
(4, 'David', 'Sales', 50000),
(5, 'Eve', 'HR', 45000),
(6, 'Frank', 'Sales', 50000);

-- a) Employees earning more than average salary
SELECT *
FROM EMPLOYEE
WHERE Salary > (SELECT AVG(Salary) FROM EMPLOYEE);

-- b) Employee receiving second-highest distinct salary
SELECT *
FROM EMPLOYEE
WHERE Salary = (
    SELECT MAX(Salary)
    FROM EMPLOYEE
    WHERE Salary < (
        SELECT MAX(Salary) FROM EMPLOYEE
    )
);

-- c) Employees earning more than department average
SELECT *
FROM EMPLOYEE e1
WHERE Salary > (
    SELECT AVG(Salary)
    FROM EMPLOYEE e2
    WHERE e1.Department = e2.Department
);

-- d) Procedure to find second-highest distinct salary

DECLARE
    second_salary NUMBER;
BEGIN
    SELECT MAX(Salary)
    INTO second_salary
    FROM EMPLOYEE
    WHERE Salary < (SELECT MAX(Salary) FROM EMPLOYEE);

    DBMS_OUTPUT.PUT_LINE(
        'Second Highest Salary: ' || second_salary
    );
END;
/
