
-- Create STUDENT table
CREATE TABLE STUDENT (
    StudentID INT PRIMARY KEY,
    Name VARCHAR2(50),
    Department VARCHAR2(50),
    CGPA NUMBER(3,2)
);

-- Insert records
INSERT INTO STUDENT VALUES (1, 'Alice', 'CSE', 8.5);
INSERT INTO STUDENT VALUES (2, 'Bob', 'IT', 7.2);
INSERT INTO STUDENT VALUES (3, 'Charlie', 'CSE', 9.1);
INSERT INTO STUDENT VALUES (4, 'David', 'IT', 8.0);
INSERT INTO STUDENT VALUES (5, 'Eve', 'ECE', 8.5);

-- Enable output
SET SERVEROUTPUT ON;

-- Parameterized cursor
DECLARE
    CURSOR cur(dept VARCHAR2) IS
        SELECT StudentID, Name, CGPA
        FROM STUDENT
        WHERE Department = dept
        AND CGPA > 7.5;

    sid STUDENT.StudentID%TYPE;
    sname STUDENT.Name%TYPE;
    cg STUDENT.CGPA%TYPE;

BEGIN
    OPEN cur('CSE');

    LOOP
        FETCH cur INTO sid, sname, cg;

        EXIT WHEN cur%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            sid || ' ' || sname || ' ' || cg
        );
    END LOOP;

    CLOSE cur;
END;
/
