
-- Create STUDENT table
CREATE TABLE STUDENT (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50)
);

-- Create COURSE table
CREATE TABLE COURSE (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50)
);

-- Create ENROLLMENT table
CREATE TABLE ENROLLMENT (
    StudentID INT,
    CourseID INT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES STUDENT(StudentID),
    FOREIGN KEY (CourseID) REFERENCES COURSE(CourseID)
);

-- Insert students
INSERT INTO STUDENT VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'David');

-- Insert courses
INSERT INTO COURSE VALUES
(101, 'Math'),
(102, 'Physics'),
(103, 'Chemistry');

-- Insert enrollments
INSERT INTO ENROLLMENT VALUES
(1, 101),
(1, 102),
(1, 103),
(2, 101),
(3, 102);

-- a) INNER JOIN
SELECT s.StudentName, c.CourseName
FROM STUDENT s
INNER JOIN ENROLLMENT e
ON s.StudentID = e.StudentID
INNER JOIN COURSE c
ON e.CourseID = c.CourseID;

-- b) LEFT OUTER JOIN
SELECT s.StudentName, c.CourseName
FROM STUDENT s
LEFT JOIN ENROLLMENT e
ON s.StudentID = e.StudentID
LEFT JOIN COURSE c
ON e.CourseID = c.CourseID;

-- c) Count students in each course
SELECT c.CourseName,
       COUNT(e.StudentID) AS NumberOfStudents
FROM COURSE c
LEFT JOIN ENROLLMENT e
ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName;

-- d) Students enrolled in more than 2 courses
SELECT s.StudentName
FROM STUDENT s
JOIN ENROLLMENT e
ON s.StudentID = e.StudentID
GROUP BY s.StudentID, s.StudentName
HAVING COUNT(e.CourseID) > 2;


SET SERVEROUTPUT ON;

DECLARE
    CURSOR student_cursor IS
        SELECT s.StudentName, c.CourseName
        FROM STUDENT s
        JOIN ENROLLMENT e
        ON s.StudentID = e.StudentID
        JOIN COURSE c
        ON e.CourseID = c.CourseID;

    sname STUDENT.StudentName%TYPE;
    cname COURSE.CourseName%TYPE;

BEGIN
    OPEN student_cursor;

    LOOP
        FETCH student_cursor INTO sname, cname;

        EXIT WHEN student_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            sname || ' is enrolled in ' || cname
        );
    END LOOP;

    CLOSE student_cursor;
END;
/
