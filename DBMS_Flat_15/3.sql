-- 3. Create the EMPLOYEE table
CREATE TABLE EMPLOYEE (
    Emp_ID INT PRIMARY KEY,
    Name VARCHAR(20),
    Department VARCHAR(20),
    Salary NUMBER
);

INSERT INTO EMPLOYEE VALUES (1, 'Alice', 'IT', 60000);
INSERT INTO EMPLOYEE VALUES (2, 'Bob', 'HR', 40000);
INSERT INTO EMPLOYEE VALUES (3, 'Charlie', 'IT', 80000);
INSERT INTO EMPLOYEE VALUES (4, 'David', 'FIN', 75000);
INSERT INTO EMPLOYEE VALUES (5, 'Eve', 'HR', 45000);

-- a) Display employees earning more than the overall average salary
SELECT * FROM EMPLOYEE 
WHERE Salary > (SELECT AVG(Salary) FROM EMPLOYEE);

-- b) Find the employee receiving the second-highest salary
SELECT * FROM EMPLOYEE 
WHERE Salary = (SELECT MAX(Salary) FROM EMPLOYEE WHERE Salary < (SELECT MAX(Salary) FROM EMPLOYEE));

-- c) Display employees earning more than their department's average salary
SELECT * FROM EMPLOYEE e1 
WHERE Salary > (SELECT AVG(Salary) FROM EMPLOYEE e2 WHERE e1.Department = e2.Department);

-- d) PL/SQL block to find and display the second-highest distinct salary
SET SERVEROUTPUT ON;
DECLARE
    v_sec_sal NUMBER;
BEGIN
    SELECT MAX(Salary) INTO v_sec_sal 
    FROM EMPLOYEE 
    WHERE Salary < (SELECT MAX(Salary) FROM EMPLOYEE);
    
    DBMS_OUTPUT.PUT_LINE('2nd Highest Salary: ' || v_sec_sal);
END;
/