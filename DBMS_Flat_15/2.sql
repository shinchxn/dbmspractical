-- 2. Create tables
CREATE TABLE DEPARTMENT (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(20)
);

CREATE TABLE EMPLOYEE (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(20),
    Salary NUMBER,
    Hire_Date DATE,
    Dept_ID INT REFERENCES DEPARTMENT(Dept_ID)
);

-- a) Insert 6 employees across 3 departments
INSERT INTO DEPARTMENT VALUES (10, 'IT');
INSERT INTO DEPARTMENT VALUES (20, 'HR');
INSERT INTO DEPARTMENT VALUES (30, 'FIN');

INSERT INTO EMPLOYEE VALUES (1, 'John', 45000, '15-JAN-2023', 10);
INSERT INTO EMPLOYEE VALUES (2, 'Smith', 35000, '20-JUN-2023', 20);
INSERT INTO EMPLOYEE VALUES (3, 'Allen', 55000, '01-NOV-2022', 30);
INSERT INTO EMPLOYEE VALUES (4, 'Ward', 30000, '10-FEB-2024', 10);
INSERT INTO EMPLOYEE VALUES (5, 'Jones', 60000, '25-AUG-2021', 20);
INSERT INTO EMPLOYEE VALUES (6, 'Martin', 42000, '05-DEC-2023', 30);

-- b) Display employees earning more than ₹40,000
SELECT * FROM EMPLOYEE WHERE Salary > 40000;

-- c) Increase the salary of employees in a selected department by 10%
UPDATE EMPLOYEE SET Salary = Salary * 1.1 WHERE Dept_ID = 10;

-- d) Retrieve employees hired after a specified date
SELECT * FROM EMPLOYEE WHERE Hire_Date > '01-JAN-2023';

-- e) PL/SQL block to display the number of employees in a department
SET SERVEROUTPUT ON;
DECLARE
    v_emp_count INT;
BEGIN
    SELECT COUNT(*) INTO v_emp_count FROM EMPLOYEE WHERE Dept_ID = 10;
    DBMS_OUTPUT.PUT_LINE('Employees in Dept 10: ' || v_emp_count);
END;
/