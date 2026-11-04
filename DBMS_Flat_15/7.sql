-- 7. Create tables with mapping
CREATE TABLE stu_details (
    reg_no INT PRIMARY KEY,
    stu_name VARCHAR(20),
    DOB DATE,
    address VARCHAR(30),
    city VARCHAR(20)
);

CREATE TABLE mark_details (
    reg_no INT PRIMARY KEY REFERENCES stu_details(reg_no),
    mark1 INT,
    mark2 INT,
    mark3 INT,
    total INT
);

-- Insert dummy data to test the queries
INSERT INTO stu_details VALUES (1, 'Sam', '15-MAY-2000', '123 Main St', 'NY');
INSERT INTO mark_details VALUES (1, 80, 90, 85, 255);

-- a) Alter the table mark_details to add a column average with data type as long
ALTER TABLE mark_details ADD average LONG;

-- b) Display the months between the DOB and till date
SELECT stu_name, TRUNC(MONTHS_BETWEEN(SYSDATE, DOB)) AS Months_Lived 
FROM stu_details;

-- c) Using alter command drop the column address from the table stu_details
ALTER TABLE stu_details DROP COLUMN address;