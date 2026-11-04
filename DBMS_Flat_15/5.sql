-- 5. Create EMPLOYEE table
CREATE TABLE EMPLOYEE (
    E_ID INT PRIMARY KEY,
    Name VARCHAR(20),
    Dept VARCHAR(20),
    Salary NUMBER,
    Desig VARCHAR(20)
);

INSERT INTO EMPLOYEE VALUES (1, 'John', 'IT', 60000, 'Dev');
INSERT INTO EMPLOYEE VALUES (2, 'Mary', 'HR', 45000, 'Manager');
INSERT INTO EMPLOYEE VALUES (3, 'Steve', 'IT', 45000, 'Tester');

-- a) Create a view displaying only IT employees
CREATE VIEW IT_EMP AS 
SELECT * FROM EMPLOYEE WHERE Dept = 'IT';

-- b) Retrieve employees through the view with salary > 50,000
SELECT * FROM IT_EMP WHERE Salary > 50000;

-- c) Update an employee's designation through the view
UPDATE IT_EMP SET Desig = 'Lead Dev' WHERE E_ID = 1;

-- d) PL/SQL block to accept ID and display details using SELECT INTO
SET SERVEROUTPUT ON;
DECLARE
    v_eid INT := 1; -- Hardcoded for instant execution
    v_name VARCHAR(20);
    v_dept VARCHAR(20);
    v_sal NUMBER;
    v_desig VARCHAR(20);
BEGIN
    SELECT Name, Dept, Salary, Desig 
    INTO v_name, v_dept, v_sal, v_desig 
    FROM EMPLOYEE 
    WHERE E_ID = v_eid;
    
    DBMS_OUTPUT.PUT_LINE(v_name || ' | ' || v_dept || ' | ' || v_sal || ' | ' || v_desig);
END;
/