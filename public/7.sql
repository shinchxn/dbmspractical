
-- Create tables
CREATE TABLE stu_details (
    reg_no INT PRIMARY KEY,
    stu_name VARCHAR(50),
    DOB DATE,
    address VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE mark_details (
    reg_no INT,
    mark1 INT,
    mark2 INT,
    mark3 INT,
    total INT,
    FOREIGN KEY (reg_no) REFERENCES stu_details(reg_no)
);

-- Insert student records
INSERT INTO stu_details VALUES
(1, 'Alice', '2005-05-15', '123 Main St', 'Chennai'),
(2, 'Bob', '2004-10-20', '456 Cross St', 'Mumbai');

-- a) Add average column
ALTER TABLE mark_details
ADD average DECIMAL(10,2);

-- b) Find months between DOB and current date
SELECT stu_name, DOB,
TIMESTAMPDIFF(MONTH, DOB, CURDATE()) AS Months
FROM stu_details;

-- c) Drop address column
ALTER TABLE stu_details
DROP COLUMN address;

-- Display table structure
DESC stu_details;
