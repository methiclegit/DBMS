Create a Banking Management System using Customer and Account tables.
Create Customer and Account tables with suitable attributes.
Apply appropriate Primary Key and Foreign Key constraints.
Apply suitable NOT NULL, UNIQUE, DEFAULT, and CHECK constraints.
Insert at least 5 customers and 5 account records.

QUERY
Display accounts having a balance greater than a given amount.
Display accounts in descending order of their balance.
Calculate the total balance of all accounts using an aggregate function.
Find the maximum and minimum account balance.
Update the balance of a particular account.
Delete an account based on a suitable condition.
Display the final account records.

CREATE DATABASE and use 

CREATE DATABASE bank;
use bank;


create TABLES


CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Phone VARCHAR(10) UNIQUE NOT NULL,
    Email VARCHAR(100) UNIQUE,
    City VARCHAR(50) DEFAULT 'CHANDIGARH'
    Age INT CHECK (Age >= 18)
);

CREATE TABLE Account (
    Account_ID INT PRIMARY KEY,
    Customer_ID INT NOT NULL,
    Account_Type VARCHAR(20) DEFAULT 'Savings',
    Balance DECIMAL(12,2) DEFAULT 0 CHECK (Balance >= 0),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);


INSERT INTO TABLE 

INSERT INTO Customer VALUES
(1, 'Rahul Sharma', '9876543210', 'rahul@gmail.com', 'Ambala', 25),
(2, 'Priya Singh', '9876543211', 'priya@gmail.com', 'Chandigarh', 30),
(3, 'Aman Kumar', '6546546844', 'aman@gmail.com', 'Delhi', 28),
(4, 'Neha Verma', '9875543213', 'neha@gmail.com', 'Ambala', 35),
(5, 'Rohit Mehta', '9876543214', 'rohit@gmail.com', 'Patiala', 40);


INSERT INTO Account VALUES
(101, 1, 'Savings', 25000),
(102, 2, 'Current', 45000),
(103, 3, 'Savings', 15000),
(104, 4, 'Savings', 65000),
(105, 5, 'Current', 35000);

QUERY 1

SELECT * FROM Account WHERE Balance > 30000;

QUERY 2
SELECT * FROM Account ORDER BY Balance DESC;

QUERY 3
SELECT SUM(Balance) AS Total_Balance FROM Account;

QUERY 4
SELECT MAX(Balance) AS Maximum_Balance, MIN(Balance) AS Minimum_Balance FROM Account;

QUERY 4
UPDATE Account SET Balance = 50000 WHERE Account_ID = 102;

QUERY 5
DELETE FROM Account WHERE Balance < 20000;

QUERY 6
SELECT * FROM Account;
