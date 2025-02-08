CREATE DATABASE ORG; -- creates a database named org
SHOW DATABASES;
USE ORG;    --  we need to use the database before querying it 

-- CREATING A TABLE IN SQL 
CREATE TABLE Worker(
   WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,  -- By auto increment every id will get increased one by one  1 2 3 4 5 6
   FIRST_NAME VARCHAR(25),
   LAST_NAME VARCHAR(25),
   SALARY INT(15),
   JOINING_DATE DATETIME,
   DEPARTMENT VARCHAR(25)
);

SELECT * FROM Worker; -- shows the total discription of the table 
 
-- For inserting values into the table 
INSERT INTO Worker
(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT)
VALUES
(1, 'John', 'Doe', 50000, '2023-01-10', 'Finance'),
(2, 'Jane', 'Smith', 55000, '2022-03-15', 'Marketing'),
(3, 'Robert', 'Brown', 48000, '2021-07-20', 'Sales'),
(4, 'Emily', 'Davis', 60000, '2020-09-01', 'HR'),
(5, 'Michael', 'Wilson', 53000, '2022-11-22', 'Finance'),
(6, 'Linda', 'Moore', 51000, '2023-05-30', 'IT'),
(7, 'David', 'Taylor', 47000, '2021-01-15', 'Sales'),
(8, 'Sarah', 'Anderson', 62000, '2020-04-25', 'IT'),
(9, 'James', 'Thomas', 46000, '2023-08-09', 'HR'),
(10, 'Laura', 'Jackson', 55000, '2021-12-13', 'Marketing'),
(11, 'William', 'White', 49000, '2022-02-17', 'Finance'),
(12, 'Olivia', 'Harris', 56000, '2023-07-14', 'Sales'),
(13, 'Ethan', 'Martin', 54000, '2020-10-05', 'HR'),
(14, 'Ava', 'Lee', 60000, '2022-04-11', 'IT'),
(15, 'Mason', 'Perez', 52000, '2021-06-03', 'Marketing');

SELECT * From Worker; -- shows everything about the table 

-- shows everything from the table of Finance , Marketiing and Sales Department
SELECT * FROM Worker where Department = 'Finance' OR DEPARTMENT = 'Marketing' OR DEPARTMENT = 'Sales';

-- better way to do this is using IN
SELECT * FROM Worker where DEPARTMENT IN ('Finance','Marketing','Sales');

-- WILDCARD 
-- %
SELECT * FROM Worker where FIRST_NAME LIKE '%c%';	-- this will give all details of workers that hace a 'c' in their name
-- _ (underscore)  the space in _ will be replaced by only one charachter
SELECT FIRST_NAME FROM Worker where FIRST_NAME LIKE '_a%'; --  all the names of people having 'a' as 2nd alphabet in their name
SELECT FIRST_NAME FROM Worker where FIRST_NAME LIKE '__i%';  -- names of people having i as 3rd alphabet in their name

-- SORTING
SELECT FIRST_NAME,SALARY FROM Worker ORDER BY SALARY; -- this will sort salary in increasing order of workers
-- to sort in descending order use DESC
SELECT FIRST_NAME,SALARY FROM Worker ORDER BY SALARY DESC;
-- ASC sort in ascedning order ( this is default if we dont mention asc or desc

-- DISTINCT VALUES
SELECT DEPARTMENT FROM Worker; -- this will list all the department name of workers as multiple workers have same dept it wont be uniqur
-- if i want to display unique / distinct values of department i will use distinct keyword
SELECT DISTINCT DEPARTMENT FROM Worker; -- will give all distinct values of department

-- Data Grouping 
-- if i want to find out no. of employees working in different department Finance -> ? Marketing -> ? 
-- We will do grouping as we want count .. we will use GROUP BY keyword
-- Group By keyword is used with some aggregation functions
-- Aggregation Functions -> COUNT , SUM , AVG , MINIMUM
SELECT department , COUNT(department) from Worker group by department; -- attribues inside select and from should be same as attributes after group by

-- Finding average salary per department
SELECT department,AVG(salary) from Worker group by department;

-- minimum salary from every department
SELECT department,salary from Worker;
SELECT department,MIN(salary) from Worker group by department;
-- same thing for MAX

-- SUM of salary offered to every department
SELECT department,SUM(salary) from Worker group by department;

-- While using select we use WHERE to filter, similary
-- while using GROUP we use HAVING for filtering

-- department and count having more than two workers
SELECT department,COUNT(department) FROM Worker group by department HAVING COUNT(department) > 2;
-- aggregatiom is possible only with group by ... HAVING only works with group by

-- Constraints
-- Primary Key Constraints
     -- not null -- unique -- only one primary key
     -- its considerd a good practice to consider primary key as INT
CREATE TABLE Worker(
   WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,  -- By auto increment every id will get increased one by one  1 2 3 4 5 6
   FIRST_NAME VARCHAR(25),
   LAST_NAME VARCHAR(25),
   SALARY INT(15),
   JOINING_DATE DATETIME,
   DEPARTMENT VARCHAR(25)
);
-- in this we made worker_id as our primary key
-- Rename the table Worker to employees as we will be adding more tables in it 
ALTER TABLE Worker RENAME to Employees;
-- Foreign Key 
-- FK Refers to PK of another table 

-- Add another table with Foreign key as Primary Key of Worker
-- Now we will make a Performance table holding performance of each employee using Worker ID as foreign key in Performane table
CREATE TABLE PerformanceReviews (
    ReviewID INT PRIMARY KEY,
    Worker_ID INT,
    ReviewDate DATE,
    ReviewerID INT,
    Rating DECIMAL,
    Comments TEXT,
    FOREIGN KEY (Worker_ID) REFERENCES Workers(Worker_ID)
);
USE ORG; -- you have to use databse evrytime you restart workbench

-- Unique Constraint
-- Inside employee table i will add a attribute which has to be unique
-- for example email id of each employee has to be different
-- to add another attribute we will use ALTER TABLE 
ALTER TABLE employees
ADD COLUMN email VARCHAR(255); -- this will add a new column named email to our table employees

ALTER TABLE employees
ADD CONSTRAINT UNIQUE (email); -- this adds a unique constraint in email of employees table

desc employees; -- check in the key columnn of email it is set to unique

-- CHECK Constraint
-- by this i can add a constraint that no employee should have a salary less than 15,000
-- if i use insert command and add salary less 15,000 it will throw error

ALTER TABLE employees
ADD CONSTRAINT CHECK (SALARY > 15000); -- by this new entry cannot have salary < 15000

INSERT INTO employees
(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT,email)
VALUES(16,'JATIN','HASWANI',14000,'2022-11-22','HR',NULL);

-- this will throw the error Error Code: 3819. Check constraint 'employees_chk_1' is violated.
-- but if i do
INSERT INTO employees
(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT,email)
VALUES(16,'JATIN','HASWANI',15001,'2022-11-22','HR',NULL);
-- this worked as check constraint returns true
SELECT * FROM employees;

-- DEFAULT CONSTRAINT
-- lets say i add a new column home address inside employee table
-- the home address will be automatically set as our default value if no home address values is provided while inserting values
 ALTER TABLE employees
 ADD COLUMN home_address VARCHAR(255) DEFAULT 'Mumbai';
 -- now if i insert new value without adding home address
 
INSERT INTO employees
(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT,email)
VALUES(17,'JATIN','HASWANI',15001,'2022-11-22','HR',NULL);

SELECT * FROM employees;

-- as home address wasnt added in any of the values while inserting it got selected to 'Mumbai' By default
-- its syntax while creating a new table ->
CREATE TABLE employees(
   home_address VARCHAR(255) DEFAULT 'Mumbai'
); -- do not execute this query it is just an example

-- ALTER operations ->
 -- ALTER is used when we have alereaddy made a schema and after making it we wanted to make changes in it
 
 -- 1) Add a new column = ADD Keyword
 -- add age and dob of employees in our employees table 
ALTER TABLE employees ADD age INT NOT NULL, ADD dob DATE;
SELECT * FROM employees;

-- 2) To change datatype of an attribute = MODIFY Keyword
-- change dob from DATE to VARCHAR
ALTER TABLE employees MODIFY dob VARCHAR(255);
DESC employees; -- check in type column the type of datatype 

-- 3) To Reanme a Column = CHANGE COLUMN keyword
-- i want to rename WORKER_ID to Employee_ID Since we changed name of the table at the begining from worker to employees
ALTER TABLE employees CHANGE COLUMN WORKER_ID Employee_ID VARCHAR(255);

-- this will throw error because we are renaming WORKER_ID becz it is already associated as a foreign key in another table
-- the new name does not match does not match with referenced column name in another table
-- the foreign key inside performance reviews table is still refrencing to worker_id column in employees table 

-- we will rename FIRST_NAME  column to FNAME
ALTER TABLE employees CHANGE COLUMN FIRST_NAME FNAME VARCHAR(255);
desc employees;

-- 4) To Remove a column completly from The table = DROP COLUMN Keyword
ALTER TABLE employees DROP COLUMN email;
desc employees;

-- 5) To reanme a table name = RENAME TO Keyword
ALTER TABLE employees RENAME TO Workers;
DESC Workers;

-- DML = Data Modification Language
-- 1) INSERT :- For Inserting Values into our table
INSERT INTO Workers
(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT,email) -- write all  the attribues here
VALUES(17,'JATIN','HASWANI',15001,'2022-11-22','HR',NULL);

-- another way to insert is to insert values without column names .. but we have to insert values in the same sequence as we declared columns
INSERT INTO Workers
VALUES(17,'JATIN','HASWANI',15001,'2022-11-22','HR',NULL); -- same sequence as we declared columns

-- if i have a worker whosee only three things are available i can do
INSERT INTO Workers(WORKER_ID,FNAME,age)
VALUES(18,'Praful',21);
SELECT * FROM Workers;
-- We cannot do this if any attribute is set to NOT NULL and does not have a DEFAULT value .. we will have to insert values for that attribute

-- 2) UPDATE :- For Updating Values into our table that are already inserted
UPDATE Workers SET Salary = 16000,JOINING_DATE = '2022-12-16' WHERE WORKER_ID = '18';
SELECT * FROM Workers;

-- UPDATE Multiple Rows
-- if i wanted to change Joining date of all the workers to a specific date .. in this case i will not be using WHERE Clause
UPDATE Workers SET JOINING_DATE  = '2022-01-01';
SELECT * FROM Workers;

-- i can also perform addition operation using it.. if i wanted to incrase prafuls age by 2 i will do
UPDATE Workers SET age 	= age + 2;
SELECT * FROM Workers; -- before this command prafuls age was 21 now it is 23

-- 3) DELETE
-- lets say praful is no longer working for the company i want to remove his whole data
DELETE FROM Workers WHERE WORKER_ID = 18;
SELECT * FROM Workers;

-- To Delete the whole table -> DELETE FROM Workers

-- ON DELETE CASCADE / ON DELETE NULL
-- REFRENTIAL CONSTRAINT :- 1. INSERT :- VALUE CANNOT BE INSERTED IN CHILD IF THE VALUE IS NOT LYING IN THE PARENT TABLE 
						--  2. DELETE :- VALUE CANNOT BE DELETED FROM PARENT IF VALUES IS LYING INSIDE CHILD TABLE

-- to overcome Delete Constraint we can do ON DELETE CASCADE or ON DELETE SET NULL
-- ON DELETE CASCADE :- if i am deleting from parent so the corresponding value inside child table will also get deleted
-- ON DELETE SET NULL :- if i am deleting from parent so the corresponding value inside child table value of foreign key will be set to NULL
-- for example we have WORKER_ID from Workers table linked with ReviewID of Performance table
-- if we try to delete WORKER_ID from out workers table
ALTER TABLE Workers DROP COLUMN WORKER_ID;
-- this shows error :- Error Code: 1829. Cannot drop column 'WORKER_ID': needed in a foreign key constraint 'performancereviews_ibfk_1' of table 'performancereviews'
-- to overcome this we will use ON DELETE CASCASDE
SELECT * FROM performancereviews;
-- another example is if i have data of one of the employees inside Reviews Table and if i try to delete the employee data
-- from Workers table .. the data of that employee is still insde review table connect via ReviewID foreign key
desc PerformanceReviews;
INSERT INTO PerformanceReviews
VALUES(3,15,'2022-11-02',3,8,'NONE');
SELECT * FROM performanceReviews;
-- in our performace table worker_id 15 is used .. now if we try to delete data of worker id 15 in our Workers table it will show error
-- because data of worker id 15 is already present in Performance reviews table
SELECT * FROM Workers;
DELETE FROM Workers WHERE Worker_ID = 17; -- successfull deletion
DELETE FROM Workers WHERE Worker_ID = 15; -- shows eroor
-- error message :- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`org`.`performancereviews`, CONSTRAINT `performancereviews_ibfk_1` FOREIGN KEY (`Worker_ID`) REFERENCES `workers` (`WORKER_ID`))
-- we cannot delete worker id 15 becasue its data is present in performancereviews table
-- to overcome this we will use ON DELTE CASCADE
DROP TABLE PerformanceReviews;
CREATE TABLE PerformanceReviews (
    ReviewID INT PRIMARY KEY,
    Worker_ID INT,
    ReviewDate DATE,
    ReviewerID INT,
    Rating DECIMAL,
    Comments TEXT,
    FOREIGN KEY (Worker_ID) REFERENCES Workers(Worker_ID) ON DELETE CASCADE
);
INSERT INTO PerformanceReviews
VALUES(3,15,'2022-11-02',3,8,'NONE');
SELECT * FROM PerformanceReviews;
DELETE FROM workers where WORKER_ID = 15;
-- now the data of worker id 15 is deleted from both the tables
SELECT * FROM workers;
SELECT * FROM PerformanceReviews;
-- it is prefered to include ON DELETE CASCADE while creating a table itself .. we can still add it after creating a table
-- but for that we have to drop the foreign key first

-- ON DELETE SET NULL :- value of foreign key will be set to null if the value inside Parent table is deleted
-- Syntax :- FOREIGN KEY (Worker_ID) REFERENCES Workers(Worker_ID) ON DELETE SET NULL

-- 4) REPLACE 
-- a) Data already present will be replaced b) Data is not present REPLACE will act as INSERT
-- Diiference with UPDATE is in UPDATE if no data is present it wil not do anything
REPLACE INTO Workers(Worker_Id,home_address,age) --  it is compuslary to include primary key to identify which values to change
VALUES(16,'Dhule',22); -- By this the existing data for worker id 16 will be overwritten by data that we are replacing with
-- as we only replaced 2 attributes .. rest attributes will be set to NULL

REPLACE INTO Workers(Worker_Id,home_adDress,age)
VALUES(19,'Pune',22); -- as no data already exists for Worker_Id 19 (19 id itself does not exists)
-- this now will act as INSERT

-- another way to do the same thing using SET
REPLACE INTO Workers SET Worker_Id = 20,home_address = 'Pune',age = 19;

CREATE DATABASE cust;
USE cust;
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(15)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

-- Insert values into customer table
INSERT INTO customer (first_name, last_name, email, phone_number) VALUES
('John', 'Doe', 'john.doe@example.com', '1234567890'),
('Jane', 'Smith', 'jane.smith@example.com', '9876543210'),
('Alice', 'Johnson', 'alice.johnson@example.com', '4567891230'),
('Bob', 'Brown', 'bob.brown@example.com', '7891234560');

-- Insert values into orders table
INSERT INTO orders (customer_id, order_date, order_amount) VALUES
(1, '2024-12-01', 250.00),
(1, '2024-12-15', 150.00),
(2, '2024-12-05', 300.00),
(3, '2024-12-10', 400.00),
(4, '2024-12-20', 500.00),
(2, '2024-12-22', 100.00);

SELECT * FROM customer;
SELECT * FROM orders;
USE cust;
-- Joins in SQL

-- 1) INNER JOIN
-- Syntax :- SELECT column-list FROM table1 INNER JOIN table2 ON condition1
SELECT customer.* ,orders.* FROM customer INNER JOIN orders ON customer.customer_id = orders.customer_id;
SELECT * FROM customer INNER JOIN orders ON customer.customer_id = orders.customer_id;
-- this selects all rows from customer and orders table that have matching customer_id
-- join together any matching rows based on some link

-- 2) OUTER JOIN
-- a) LEFT JOIN 
-- Returns a resulting table that has all the data from left table and matched data from right table
SELECT customer.*,orders.* FROM customer LEFT JOIN orders ON customer.customer_id = orders.customer_id;


-- b) RIGHT JOIN 
-- Returns a resulting table that has all the data from right table and matched data from left table
SELECT customer.*,orders.* FROM customer RIGHT JOIN orders ON customer.customer_id = orders.customer_id;

-- 3) FULL JOIN
-- Returns a resulting table that contains all data when there is a match on left or right table data
-- mysql does not have a inbuilt keyword for FULL JOIN
SELECT * FROM customer LEFT JOIN orders ON customer.customer_id = orders.customer_id 
UNION
SELECT * FROM customer RIGHT JOIN orders ON customer.customer_id = orders.customer_id;

-- 4) SELF JOIN
-- Step 1: Create the Employees table


CREATE TABLE workers (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50) NOT NULL,
    ManagerID INT NULL
);

-- Step 2: Insert sample data
INSERT INTO workers (EmployeeID, EmployeeName, ManagerID) VALUES
(1, 'Alice', NULL),   -- Alice has no manager
(2, 'Bob', 1),        -- Bob's manager is Alice
(3, 'Charlie', 1),    -- Charlie's manager is Alice
(4, 'David', 2),      -- David's manager is Bob
(5, 'Eve', 2);        -- Eve's manager is Bob

-- now i want to replace manager id with first and last name of manager
-- we will use SELF JOIN for it

-- SET operations
-- for applying set operations on tables those tables should have same type and same no. of columns
-- SET operations are applied on rows
CREATE TABLE employees (
    employee_id INT,
    name VARCHAR(100),
    department VARCHAR(50)
);

INSERT INTO employees (employee_id, name, department)
VALUES
(1, 'John Doe', 'HR'),
(2, 'Jane Smith', 'IT'),
(3, 'Emily Davis', 'Finance'),
(4, 'Michael Brown', 'HR'),
(5, 'Sarah Johnson', 'Marketing');

CREATE TABLE contractors (
    contractor_id INT,
    name VARCHAR(100),
    department VARCHAR(50)
);

INSERT INTO contractors (contractor_id, name, department)
VALUES
(1, 'John Doe', 'HR'),
(2, 'David Wilson', 'IT'),
(3, 'Emily Davis', 'Finance'),
(4, 'Daniel Clark', 'Marketing');

-- 1) UNION	 
-- combines results of two or more select statements
-- in order to join two select statements together they need the same number of columns
SELECT * FROM employees union SELECT * FROM contractors;
SELECT name,department AS "department/lastname" FROM employees UNION SELECT first_name,last_name from customer;

-- 2) INTERSECTION
-- there is no inbuilt keyword for intersection in sql
 
-- Sub Queries in SQL
USE cust;
SELECT * FROM customer;
SELECT * FROM customer where customer_id IN (SELECT customer_id FROM customer WHERE first_name = 'Alice');

-- creating tables and inserting values for learning sub-queries
CREATE TABLE Employee (
    id INT PRIMARY KEY,
    fname VARCHAR(50),
    lname VARCHAR(50),
    Age INT,
    emailID VARCHAR(100) UNIQUE,
    PhoneNo VARCHAR(20),
    City VARCHAR(50)
);

CREATE TABLE Client (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    emailID VARCHAR(100) UNIQUE,
    PhoneNo VARCHAR(20),
    City VARCHAR(50),
    empID INT,
    FOREIGN KEY (empID) REFERENCES Employee(id)
);

CREATE TABLE Project (
    id INT PRIMARY KEY,
    empID INT,
    name VARCHAR(50),
    startdate DATE,
    clientID INT,
    FOREIGN KEY (empID) REFERENCES Employee(id),
    FOREIGN KEY (clientID) REFERENCES Client(id)
);
-- Insert values into Employee table
INSERT INTO Employee (id, fname, lname, Age, emailID, PhoneNo, City) VALUES
(1, 'Aman', 'Proto', 32, 'aman@gmail.com', '898', 'Delhi'),
(2, 'Yagya', 'Narayan', 44, 'yagya@gmail.com', '222', 'Palam'),
(3, 'Rahul', 'BD', 22, 'rahul@gmail.com', '444', 'Kolkata'),
(4, 'Jatin', 'Hermit', 31, 'jatin@gmail.com', '666', 'Raipur'),
(5, 'PK', 'Pandey', 21, 'pk@gmail.com', '555', 'Jaipur');

-- Insert values into Client table
INSERT INTO Client (id, first_name, last_name, age, emailID, PhoneNo, City, empID) VALUES
(1, 'Mac', 'Rogers', 47, 'mac@hotmail.com', '333', 'Kolkata', 3),
(2, 'Max', 'Poirier', 27, 'max@gmail.com', '222', 'Kolkata', 3),
(3, 'Peter', 'Jain', 24, 'peter@abc.com', '111', 'Delhi', 1),
(4, 'Sushant', 'Aggarwal', 23, 'sushant@yahoo.com', '45454', 'Hyderabad', 5),
(5, 'Pratap', 'Singh', 36, 'p@xyz.com', '77767', 'Mumbai', 2);

-- Insert values into Project table
INSERT INTO Project (id, empID, name, startdate, clientID) VALUES
(1, 1, 'A', '2021-04-21', 3),
(2, 2, 'B', '2021-03-12', 1),
(3, 3, 'C', '2021-01-16', 5),
(4, 3, 'D', '2021-04-27', 2),
(5, 5, 'E', '2021-05-01', 4);

-- 1) WHERE Clause in same table
-- 	Suppose i want all details of employees whose age is > 30
SELECT age from employee where age > 30; -- this gave me ages only .. there are 3 ages > 30 .. 32,44,31
-- now i want all the deatils of these ages 
SELECT * FROM employee where age in (SELECT age from employee where age > 30);
-- inner query gave me ages .. outer query gave me all details of those ages 

-- if i want details of employees who are working on more than one project .. emp_id 3 is working on 2 projects C & D
-- in project table emp_id has values 1 2 3 3 5 .. as count of 3 is 2 .. it is working on 
-- first we will extract those employee id whose count in project is >= 2
-- by using group by .. we will groups corresponding to each id -> {1},{2},{3,3},{4}
SELECT * FROM employee where id in (
SELECT empID from project group by empID having count(empID) > 1);
-- inner query gave value 3 .. outer query gave all details of id = 1

-- if i want details of employees having age > avg(age)
SELECT avg(age) from Employee; -- gave me avg age  = 30
select * from Employee where age > (select avg(age) from Employee); 
-- inner query gave me 30 as output .. now outer query will give me details of all employees > 30
-- inner query will give me avg age of all the employees 

-- 2) FROM Clause
-- after FROM keyword .. there should be a table
-- select max age from people having first name containing letter 'a'
SELECT * FROM Employee where fname like '%a%'; -- this will give me table of employees where fname of employees contain 'a'
-- now i want details of a person whose age is maximum among  all the employees having 'a' in their first name

select max(age) from (select * from Employee where fname like '%a%');
-- this gave error Error Code: 1248. Every derived table must have its own alias
-- whatever query we run inside FROM we call that derived tables  
-- in our example inner query is returning a table .. called as derived table we have ALIAS it
select max(age) from (select * from Employee where fname like '%a%') AS temp;

-- CORELATED SUBQUERY :- 
-- lets say i want to find 3rd oldest employee

-- Functions in sql
-- COUNT :-
SELECT COUNT(order_amount) FROM orders; -- will return no. of rows that have order_amount in them
-- the column name will show COUNT(order_amount) as column name we can use alias to rename it
SELECT COUNT(order_amount) AS "total number of orders" FROM orders; -- column name will be "total number of orders"

-- MAX
-- lets say i wanted to find out highest order amount
SELECT MAX(order_amount) AS "max amount from one transaction" from orders;
-- same thing for minimum MIN(order_amount)
-- AVG
SELECT AVG(order_amount) AS "Average Order" from orders;
-- SUM :- Sum of a Column
SELECT SUM(order_amount) AS "Sum of transactions today" from orders;
SELECT * FROM customer;
-- CONCAT :-
-- lets say i wanted first name and last name together in one single column
SELECT CONCAT(first_name," ",last_name) AS full_name FROM customer;

-- VIEWS in SQL :- 
SELECT * FROM Employee;
-- Creating a view
CREATE VIEW custom_view AS SELECT Fname,age FROM Employee; -- by this our custom_view will only have Fname and age
--  VIEWING FROM VIEW
SELECT * FROM custom_view; -- only Fname and age will be shown in custom_view

-- ALTERING THE View
-- now i want my custom_view to only Fname,age and lname .. we want additional lname attribute in custom_view
-- we can change our custom_view using ALTER attribute
ALTER VIEW custom_view AS SELECT fname,lname,age FROM Employee; -- by this lname got added in our custom_view

-- DROPING THE VIEW
DROP VIEW IF EXISTS custom_view; -- will drop the view if it exists in our DB .. if it doesnt exist then will do nothing
