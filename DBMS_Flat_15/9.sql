-- 9. Create BANK_ACCOUNT table
CREATE TABLE BANK_ACCOUNT (
    Acc_No INT PRIMARY KEY,
    Name VARCHAR(20),
    Balance NUMBER
);

-- a) Insert two account records
INSERT INTO BANK_ACCOUNT VALUES (1, 'Alice', 20000);
INSERT INTO BANK_ACCOUNT VALUES (2, 'Bob', 10000);
COMMIT; -- Save initial state

-- c) Use SAVEPOINT before the transfer
SAVEPOINT before_transfer;

-- b) Transfer ₹5,000 from Alice (1) to Bob (2)
UPDATE BANK_ACCOUNT SET Balance = Balance - 5000 WHERE Acc_No = 1;
UPDATE BANK_ACCOUNT SET Balance = Balance + 5000 WHERE Acc_No = 2;

-- d) Demonstrate COMMIT and ROLLBACK
-- If an error occurred, we would undo the transfer like this:
-- ROLLBACK TO before_transfer;

-- Since the transfer is successful, we save the changes permanently:
COMMIT;