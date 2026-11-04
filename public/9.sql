
-- Create table
CREATE TABLE BANK_ACCOUNT (
    AccNo INT PRIMARY KEY,
    AccName VARCHAR(50),
    Balance DECIMAL(10,2)
);

-- a) Insert two accounts
INSERT INTO BANK_ACCOUNT VALUES
(101, 'Alice', 10000),
(102, 'Bob', 5000);

-- Display initial balance
SELECT * FROM BANK_ACCOUNT;

-- Start transaction
START TRANSACTION;

-- c) Create savepoint
SAVEPOINT before_transfer;

-- b) Transfer 5000 from Alice to Bob
UPDATE BANK_ACCOUNT
SET Balance = Balance - 5000
WHERE AccNo = 101;

UPDATE BANK_ACCOUNT
SET Balance = Balance + 5000
WHERE AccNo = 102;

-- Display balance after transfer
SELECT * FROM BANK_ACCOUNT;

-- d) Rollback the transfer
ROLLBACK TO before_transfer;

-- Display balance after rollback
SELECT * FROM BANK_ACCOUNT;

-- Transfer again
UPDATE BANK_ACCOUNT
SET Balance = Balance - 5000
WHERE AccNo = 101;

UPDATE BANK_ACCOUNT
SET Balance = Balance + 5000
WHERE AccNo = 102;

-- Save changes permanently
COMMIT;

-- Display final balance
SELECT * FROM BANK_ACCOUNT;
