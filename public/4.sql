
-- Create tables
CREATE TABLE STUDENT (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50)
);

CREATE TABLE COURSE (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50)
);

CREATE TABLE ENROLLMENT (
    StudentID INT,
    CourseID INT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES STUDENT(StudentID),
    FOREIGN KEY (CourseID) REFERENCES COURSE(CourseID)
);

-- Insert records
INSERT INTO STUDENT VALUES
(1, 'Alice'), (2, 'Bob'),
(3, 'Charlie'), (4, 'David');

INSERT INTO COURSE VALUES
(101, 'Math'), (102, 'Physics'),
(103, 'Chemistry');

INSERT INTO ENROLLMENT VALUES
(1, 101), (1, 102), (1, 103),
(2, 101), (3, 102);

-- a) Display students with their courses
SELECT s.StudentName, c.CourseName
FROM STUDENT s
JOIN ENROLLMENT e ON s.StudentID = e.StudentID
JOIN COURSE c ON e.CourseID = c.CourseID;

-- b) Display all students, including those without courses
SELECT s.StudentName, c.CourseName
FROM STUDENT s
LEFT JOIN ENROLLMENT e ON s.StudentID = e.StudentID
LEFT JOIN COURSE c ON e.CourseID = c.CourseID;

-- c) Count students in each course
SELECT c.CourseName, COUNT(e.StudentID) AS NumberOfStudents
FROM COURSE c
LEFT JOIN ENROLLMENT e ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName;

-- d) Students enrolled in more than two courses
SELECT s.StudentName
FROM STUDENT s
JOIN ENROLLMENT e ON s.StudentID = e.StudentID
GROUP BY s.StudentID, s.StudentName
HAVING COUNT(e.CourseID) > 2;

-- e) Cursor to display student and course names
DELIMITER //

CREATE PROCEDURE DisplayStudentCourses()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE sname VARCHAR(50);
    DECLARE cname VARCHAR(50);

    DECLARE cur CURSOR FOR
        SELECT s.StudentName, c.CourseName
        FROM STUDENT s
        JOIN ENROLLMENT e ON s.StudentID = e.StudentID
        JOIN COURSE c ON e.CourseID = c.CourseID;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO sname, cname;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        SELECT CONCAT(sname, ' is enrolled in ', cname) AS Record;
    END LOOP;

    CLOSE cur;
END //

DELIMITER ;

-- Execute procedure
CALL DisplayStudentCourses();
