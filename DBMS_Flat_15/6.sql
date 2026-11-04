-- 6. Create MARKS table
CREATE TABLE MARKS (
    Regno INT PRIMARY KEY,
    Name VARCHAR(20),
    Dept VARCHAR(20),
    S1 INT,
    S2 INT,
    S3 INT
);

INSERT INTO MARKS VALUES (1, 'Alice', 'IT', 80, 85, 90);
INSERT INTO MARKS VALUES (2, 'Bob', 'CSE', 70, 75, 80);
INSERT INTO MARKS VALUES (3, 'Charlie', 'ECE', 95, 90, 85);

-- a) Add a column Total and update it with the sum of 3 subject marks
ALTER TABLE MARKS ADD Total INT;
UPDATE MARKS SET Total = S1 + S2 + S3;

-- b) Find the second maximum total in the table
SELECT MAX(Total) FROM MARKS 
WHERE Total < (SELECT MAX(Total) FROM MARKS);

-- c) Display the name of the student with maximum total
SELECT Name FROM MARKS 
WHERE Total = (SELECT MAX(Total) FROM MARKS);

-- d) PL/SQL program to display report sheet using cursors
SET SERVEROUTPUT ON;
DECLARE
    -- Cursor grabs all data from the table
    CURSOR c_marks IS SELECT * FROM MARKS;
BEGIN
    -- FOR loop automatically opens, fetches, and closes the cursor
    FOR r IN c_marks LOOP
        DBMS_OUTPUT.PUT_LINE(r.Regno || ' | ' || r.Name || ' | Total: ' || r.Total);
    END LOOP;
END;
/