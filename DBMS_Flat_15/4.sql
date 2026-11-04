-- 4. Create Tables
CREATE TABLE STUDENT (
    S_ID INT PRIMARY KEY,
    S_Name VARCHAR(20)
);

CREATE TABLE COURSE (
    C_ID INT PRIMARY KEY,
    C_Name VARCHAR(20)
);

CREATE TABLE ENROLLMENT (
    S_ID INT REFERENCES STUDENT(S_ID),
    C_ID INT REFERENCES COURSE(C_ID),
    PRIMARY KEY (S_ID, C_ID)
);

-- Insert Data 
INSERT INTO STUDENT VALUES (1, 'Alice');
INSERT INTO STUDENT VALUES (2, 'Bob');
INSERT INTO STUDENT VALUES (3, 'Charlie'); -- Charlie will have no courses

INSERT INTO COURSE VALUES (10, 'DBMS');
INSERT INTO COURSE VALUES (20, 'OS');
INSERT INTO COURSE VALUES (30, 'JAVA');

-- Alice takes 3 courses (to test condition 'd')
INSERT INTO ENROLLMENT VALUES (1, 10);
INSERT INTO ENROLLMENT VALUES (1, 20);
INSERT INTO ENROLLMENT VALUES (1, 30);
-- Bob takes 1 course
INSERT INTO ENROLLMENT VALUES (2, 10);

-- a) Display student names with their enrolled course names (Inner Join)
SELECT S.S_Name, C.C_Name 
FROM STUDENT S 
JOIN ENROLLMENT E ON S.S_ID = E.S_ID 
JOIN COURSE C ON E.C_ID = C.C_ID;

-- b) Display all students, even those not enrolled (Outer Join)
SELECT S.S_Name, C.C_Name 
FROM STUDENT S 
LEFT JOIN ENROLLMENT E ON S.S_ID = E.S_ID 
LEFT JOIN COURSE C ON E.C_ID = C.C_ID;

-- c) Display courses with the number of enrolled students
SELECT C.C_Name, COUNT(E.S_ID) AS Total_Students
FROM COURSE C 
LEFT JOIN ENROLLMENT E ON C.C_ID = E.C_ID 
GROUP BY C.C_Name;

-- d) Retrieve students enrolled in more than two courses
SELECT S.S_Name 
FROM STUDENT S 
JOIN ENROLLMENT E ON S.S_ID = E.S_ID 
GROUP BY S.S_ID, S.S_Name 
HAVING COUNT(E.C_ID) > 2;

-- e) PL/SQL program using an explicit cursor
SET SERVEROUTPUT ON;
DECLARE
    -- Declare the explicit cursor
    CURSOR c_enroll IS 
        SELECT S.S_Name, C.C_Name 
        FROM STUDENT S 
        JOIN ENROLLMENT E ON S.S_ID = E.S_ID 
        JOIN COURSE C ON E.C_ID = C.C_ID;
BEGIN
    -- The FOR loop automatically opens, fetches, and closes the cursor
    FOR rec IN c_enroll LOOP
        DBMS_OUTPUT.PUT_LINE(rec.S_Name || ' - ' || rec.C_Name);
    END LOOP;
END;
/