-- 1. Create the STUDENT table
CREATE TABLE STUDENT (
    Student_ID INT PRIMARY KEY,
    Student_Name VARCHAR(50),
    Department VARCHAR(50),
    Semester INT,
    CGPA NUMBER(4,2)
);

-- a) Insert at least 8 records
INSERT INTO STUDENT VALUES (101, 'Alice', 'IT', 3, 8.5);
INSERT INTO STUDENT VALUES (102, 'Bob', 'CSE', 3, 4.5);
INSERT INTO STUDENT VALUES (103, 'Charlie', 'IT', 5, 7.8);
INSERT INTO STUDENT VALUES (104, 'David', 'ECE', 2, 9.2);
INSERT INTO STUDENT VALUES (105, 'Eve', 'IT', 4, 9.6);
INSERT INTO STUDENT VALUES (106, 'Frank', 'MECH', 6, 4.9);
INSERT INTO STUDENT VALUES (107, 'Grace', 'CSE', 7, 8.1);
INSERT INTO STUDENT VALUES (108, 'Heidi', 'IT', 8, 9.8);

-- b) Update the CGPA of students belonging to the IT department
UPDATE STUDENT SET CGPA = CGPA + 0.1 WHERE Department = 'IT';

-- c) Delete students whose CGPA is below 5.0
DELETE FROM STUDENT WHERE CGPA < 5.0;

-- d) Display students whose CGPA is above 8.0
SELECT * FROM STUDENT WHERE CGPA > 8.0;

-- e) Write a PL/SQL program to increase the CGPA of all IT department students by 0.5, ensuring that the CGPA does not exceed 10.0.
BEGIN
    UPDATE STUDENT 
    SET CGPA = LEAST(CGPA + 0.5, 10.0) 
    WHERE Department = 'IT';
    
    COMMIT;
END;
/