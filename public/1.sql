-- Create table
CREATE TABLE STUDENT (
    Student_ID INT PRIMARY KEY,
    Student_Name VARCHAR(50),
    Department VARCHAR(30),
    Semester INT,
    CGPA DECIMAL(3,2)
);

-- a) Insert 8 records
INSERT INTO STUDENT VALUES
(1, 'Alice', 'IT', 3, 8.5),
(2, 'Bob', 'CSE', 3, 7.5),
(3, 'Charlie', 'IT', 4, 9.0),
(4, 'David', 'ECE', 3, 4.5),
(5, 'Emma', 'IT', 5, 6.5),
(6, 'Frank', 'CSE', 4, 8.2),
(7, 'Grace', 'ECE', 2, 5.5),
(8, 'Henry', 'IT', 6, 9.5);

-- b) Update CGPA of IT students
UPDATE STUDENT
SET CGPA = CGPA + 0.5
WHERE Department = 'IT';

-- c) Delete students with CGPA below 5
DELETE FROM STUDENT
WHERE CGPA < 5.0;

-- d) Display students with CGPA above 8
SELECT * FROM STUDENT
WHERE CGPA > 8.0;

-- e) Increase IT students' CGPA by 0.5,
-- without exceeding 10
UPDATE STUDENT
SET CGPA = LEAST(CGPA + 0.5, 10.0)
WHERE Department = 'IT';