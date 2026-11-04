-- 8. Create an EMPLOYEE table
CREATE TABLE EMPLOYEE (
    E_ID INT PRIMARY KEY,
    Name VARCHAR(20),
    Dept VARCHAR(20)
);

INSERT INTO EMPLOYEE VALUES (1, 'Alice', 'IT');
INSERT INTO EMPLOYEE VALUES (2, 'Bob', 'HR');

-- a) Create a synonym named STAFF for the table
CREATE SYNONYM STAFF FOR EMPLOYEE;

-- b) Retrieve employee details using the synonym
SELECT * FROM STAFF;

-- c) Create a view named IT_STAFF for IT employees
CREATE VIEW IT_STAFF AS 
SELECT * FROM EMPLOYEE WHERE Dept = 'IT';

-- d) Explain and demonstrate the difference
-- EXPLANATION:
-- A SYNONYM is just a nickname for the entire table (shows all data).
-- A VIEW is a virtual table based on a query (filters specific data).

-- DEMONSTRATION:
SELECT * FROM STAFF;    -- Shows everyone (Alice and Bob)
SELECT * FROM IT_STAFF; -- Shows ONLY IT employees (Alice)