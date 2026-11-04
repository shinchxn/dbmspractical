-- 10. Create STUDENT table
CREATE TABLE STUDENT (
    S_ID INT PRIMARY KEY,
    Name VARCHAR(20),
    Dept VARCHAR(20),
    CGPA NUMBER
);

INSERT INTO STUDENT VALUES (1, 'Alice', 'CSE', 8.5);
INSERT INTO STUDENT VALUES (2, 'Bob', 'CSE', 7.0);
INSERT INTO STUDENT VALUES (3, 'Charlie', 'IT', 9.2);

-- Parameterized cursor accepting department name
SET SERVEROUTPUT ON;
DECLARE
    -- Cursor takes p_dept as a parameter
    CURSOR c_stud(p_dept VARCHAR) IS 
        SELECT Name, CGPA FROM STUDENT 
        WHERE Dept = p_dept AND CGPA > 7.5;
BEGIN
    -- The FOR loop opens the cursor and passes 'CSE' as the argument
    FOR r IN c_stud('CSE') LOOP
        DBMS_OUTPUT.PUT_LINE(r.Name || ' - ' || r.CGPA);
    END LOOP;
END;
/