-- # SQL Basics Lab - Student Workbook

-- ## Lab Overview

-- In this lab, you will practice SQL SELECT and WHERE statements using a company database. The database contains information about employees, products, and orders. Work through each exercise sequentially and write your SQL queries to solve the problems.
-- in ubuntu terminal to access mysql 
-- open ubuntu app and run
-- sudo mysql
-- password
-- it open sql shell


-- ## Database Schema

-- You will work with three tables:

-- **employees**
-- - employee_id (INT, Primary Key)
-- - first_name (VARCHAR)
-- - last_name (VARCHAR)
-- - email (VARCHAR)
-- - department (VARCHAR)
-- - job_title (VARCHAR)
-- - salary (DECIMAL)
-- - hire_date (DATE)
-- - manager_id (INT)
-- - city (VARCHAR)
-- CREATE DATABASE basicsqltable;
USE basicsqltable;
SELECT 'open ubuntu app and run sudo mysql password it open sql shell';
-- select 'sudo mysql basicsqltable < 1.sql';
drop table employees;
drop table products;
drop table orders;
-- delete from employees;


CREATE TABLE employees(
employee_id INT,
first_name VARCHAR(50),
last_name VARCHAR(50),
email VARCHAR(100),
department VARCHAR(50),
job_title VARCHAR(50),
salary DECIMAL,
hire_date DATE,
manager_id INT,
city VARCHAR(50),
PRIMARY KEY(employee_id)
);



-- **products**
-- - product_id (INT, Primary Key)
-- - product_name (VARCHAR)
-- - category (VARCHAR)
-- - price (DECIMAL)
-- - stock_quantity (INT)
-- - supplier (VARCHAR)

CREATE TABLE products(
product_id INT PRIMARY KEY,
product_name VARCHAR(100),
category VARCHAR(50),
price DECIMAL(10,2),
stock_quantity INT,
supplier VARCHAR(50)
);

-- **orders**
-- - order_id (INT, Primary Key)
-- - customer_name (VARCHAR)
-- - product_id (INT)
-- - quantity (INT)
-- - order_date (DATE)
-- - total_amount (DECIMAL)
-- - status (VARCHAR)

CREATE TABLE orders(
order_id INT PRIMARY KEY,
customer_name VARCHAR(100),
product_id INT,
quantity INT,
order_date DATE,
total_amount DECIMAL(10,2),
status VARCHAR(50)
);
SHOW TABLES;
select * from employees,products,orders;

-- ## Instructions

-- 1. Read each exercise carefully
-- 2. Write your SQL query below each exercise
-- 3. Test your query to ensure it returns the expected results
-- 4. Verify the number of rows returned matches the expected result
-- 5. Ask for help if you're stuck

-- ---

-- ## Part 1: Basic SELECT Queries

-- ### Exercise 1.1: Select All Columns
-- **Task**: Retrieve all information from the employees table.

-- **Expected Result**: 15 rows with all columns


-- ```
select 'exercise 1.1';

DELETE FROM employees;

INSERT INTO employees VALUES
(1,'John','Sharma','john@company.com','IT','Dev',90000,'2020-01-10',NULL,'San Francisco'),
(2,'James','Johnson','james@company.com','IT','Dev',95000,'2019-02-12',1,'San Francisco'),
(3,'Jack','Singh','jack@company.com','IT','Lead',92000,'2019-03-15',1,'San Francisco'),
(4,'Julia','Thomas','julia@company.com','IT','Tester',72000,'2019-04-18',1,'New York'),
(5,'Nea','Gupta','neha@company.com','IT','Tester',72000,'2019-05-20',1,'Chicago'),
(6,'Rohit','Wilson','rohit@company.com','Sales','Exec',60000,'2019-06-10',NULL,'Boston'),
(7,'Pooja','Mehta','pooja@company.com','Sales','Mgr',85000,'2019-07-12',6,'Delhi'),
(8,'Suresh','Rao','suresh@company.com','Sales','Exec',55000,'2020-08-12',6,'New York'),
(9,'Kiran','Das','kiran@company.com','Marketing','Mgr',74000,'2020-09-15',NULL,'Boston'),
(10,'Ritika','Nair','ritu@company.com','Marketing','Exec',60000,'2020-10-18',9,'Chicago'),
(11,'Manoj','Iyer','manoj@company.com','HR','Mgr',58000,'2020-11-20',1,'Boston'),
(12,'Sneha','Anderson','sneha@company.com','HR','Exec',52000,'2021-01-05',11,'Delhi'),
(13,'Vikas','Jain','vikas@company.com','Finance','Acc',61000,'2021-02-10',1,'Chicago'),
(14,'Arun','Malik','tarun@company.com','Finance','Acc',60000,'2021-03-12',13,'Boston'),
(15,'Anita','Roy','anita@company.com','Finance','Rep',48000,'2021-04-15',1,'New York');


DELETE FROM products;

INSERT INTO products VALUES
(1,'USB Cable','Electronics',150,120,'TechCorp'),
(2,'Headphones','Electronics',850,40,'TechCorp'),
(3,'Keyboard','Electronics',650,30,'CableWorks'),
(4,'Mouse','Electronics',80,35,'CableWorks'),
(5,'Laptop Bag','Accessories',1200,60,'BagWorld'),
(6,'Mobile Cover','Accessories',250,45,'TechCorp'),
(7,'Charger','Electronics',90,30,'TechCorp'),
(8,'Power Bank','Electronics',1500,40,'PowerHub'),
(9,'Pen Drive','Electronics',600,20,'TechCorp'),
(10,'Notebook','Stationery',60,200,'PaperMart'),
(11,'Pen','Stationery',20,0,'PaperMart'),
(12,'Water Bottle','Accessories',300,70,'BottleCo'),
(13,'Earphones','Electronics',450,80,'CableWorks'),
(14,'Calculator','Electronics',900,10,'TechCorp'),
(15,'School Bag','Accessories',1800,22,'BagWorld');


DELETE FROM orders;

INSERT INTO orders VALUES
(1,'Amit',1,3,'2024-03-05',300,'Processing'),
(2,'Bina',2,2,'2024-03-10',250,'Shipped'),
(3,'Chetan',3,2,'2024-03-15',220,'Delivered'),
(4,'Divya',4,1,'2024-03-20',210,'Processing'),
(5,'Esha',5,2,'2024-02-12',260,'Delivered'),
(6,'Farhan',6,1,'2024-02-25',230,'Pending'),
(7,'Gopal',7,2,'2024-04-02',240,'Shipped'),
(8,'Harish',8,1,'2024-01-18',260,'Pending'),
(9,'Isha',9,1,'2024-01-22',150,'Pending'),
(10,'Jay',10,1,'2024-04-05',100,'Cancelled');

SELECT * FROM employees;

-- ---

-- ### Exercise 1.2: Select Specific Columns
-- **Task**: Retrieve only the first name, last name, and email of all employees.

-- **Expected Result**: 15 rows with 3 columns


select 'exercise 1.2' as "";
select first_name, last_name, email from employees;

-- ---

-- ### Exercise 1.3: Using Column Aliases
-- **Task**: Retrieve employee first name as "First Name", last name as "Last Name", and salary as "Annual Salary".

-- **Expected Result**: 15 rows with renamed column headers


-- ```
select 'exercise 1.3' as "";
select first_name as 'First Name', last_name as 'Last Name', salary as 'Annual Salary' from employees;
-- ---

-- ### Exercise 1.4: SELECT DISTINCT
-- **Task**: Find all unique departments in the company.

-- **Expected Result**: 5 unique departments


select 'exercise 1.4' as "";
SELECT DISTINCT department FROM employees;
-- ---

-- ### Exercise 1.5: SELECT DISTINCT with Multiple Columns
-- **Task**: Find all unique combinations of department and city.

-- **Expected Result**: Multiple unique combinations



select 'exercise 1.5' as "";
SELECT DISTINCT department,city FROM employees;
-- ---

-- ## Part 2: Expressions in SELECT

-- ### Exercise 2.1: Arithmetic Operations
-- **Task**: Calculate the monthly salary for each employee (annual salary divided by 12).

-- **Expected Result**: 15 rows showing both annual and monthly salary


SELECT 'Exercise 2.1: monthly salary'AS "";
SELECT first_name,last_name,salary,salary/12 AS monthly_salary FROM employees;

-- ---

-- ### Exercise 2.2: Multiple Calculations
-- **Task**: Display employee names with their annual salary, monthly salary, and weekly salary (annual/52).

-- **Expected Result**: 15 rows with salary broken down by different time periods

SELECT 'Exercise 2.2:' AS "";
SELECT first_name,last_name,salary,salary/12 AS monthly_salary,salary/52 AS weekly_salary FROM employees;
-- ```

-- ---

-- ### Exercise 2.3: String Concatenation
-- **Task**: Create a full name by combining first name and last name with a space in between.

-- **Hint**: Use the appropriate concatenation method for your database (|| for PostgreSQL/Oracle, CONCAT for MySQL)

-- **Expected Result**: 15 rows with combined full names
select 'Exercise 2.3:' AS "";
select concat(first_name,' ',last_name) as full_name from employees;


-- ## Part 3: WHERE Clause - Basic Filtering

-- ### Exercise 3.1: Equality Condition
-- **Task**: Find all employees who work in the IT department.

-- **Expected Result**: 5 employees

select 'Exercise 3.1:'AS "";
select * from employees where department='IT';

-- ### Exercise 3.2: Numeric Comparison
-- **Task**: Find all employees with a salary greater than 70000.

-- **Expected Result**: 8 employees(9 employees (based on current dataset))
select 'Exercise 3.2:' AS "";
select * from employees where salary>70000;
-- ---

-- ### Exercise 3.3: Not Equal To
-- **Task**: Find all employees who are NOT in the Sales department.

-- **Expected Result**: 10 employees
select 'Exercise 3.3:' AS "";
select * from employees where department<>'Sales';


-- ### Exercise 3.4: Less Than or Equal To
-- **Task**: Find all employees with a salary of 60000 or less.

-- **Expected Result**: 7 employees

select 'Exercise 3.4:' AS "";
select * from employees where salary<=60000;
-- ## Part 4: Logical Operators

-- ### Exercise 4.1: AND Operator
-- **Task**: Find all employees in the IT department who earn more than 85000.

-- **Expected Result**: 3 employees

select 'Exercise 4.1:'AS "";
select * from employees where department='IT' and salary>85000;
-- ### Exercise 4.2: OR Operator
-- **Task**: Find all employees who work in either Sales or Marketing departments.

-- **Expected Result**: 8 employees
select 'Exercise 4.2:' AS "";
select * from employees where department='Sales' or department='Marketing';



-- ### Exercise 4.3: Combining AND and OR
-- **Task**: Find employees in Sales or Marketing departments who earn more than 60000.

-- **Hint**: Use parentheses to group the OR conditions

-- **Expected Result**: 2 employees
select 'Exercise 4.3:' AS "";
select * from employees where (department='Sales' or department='Marketing') and salary>60000;
-- ### Exercise 4.4: NOT Operator
-- **Task**: Find all employees who are NOT in IT or HR departments.

-- **Expected Result**: 8 employees

select 'Exercise 4.4:' AS "";

select * from employees where  department<>'IT' and department<>'HR';
select 'Exercise 4.4:' AS "";

select "can also be wriiten as" AS "";
select * from employees where not(department='IT' or department='HR');
-- ## Part 5: Special WHERE Conditions

-- ### Exercise 5.1: BETWEEN Operator
-- **Task**: Find all employees with salaries between 55000 and 75000 (inclusive).

-- **Expected Result**: 9 employees

select 'Exercise 5.1:' AS "";
select * from employees where salary between 55000 and 75000;
select 'Exercise 5.1:' AS "";
select 'can also be written as' AS "";
select * from employees where salary>=55000 and salary<=75000;


-- ### Exercise 5.2: IN Operator
-- **Task**: Find all employees located in New York, Chicago, or Boston.

-- **Expected Result**: 9 employees

select 'Exercise 5.2:' AS "";
select * from employees where city in('New York','Chicago','Boston');

-- ### Exercise 5.3: LIKE with % Wildcard
-- **Task**: Find all employees whose first name starts with 'J'.

-- **Expected Result**: 4 employees
select 'Exercise 5.3:' AS "";
select * from employees where first_name like 'J%';

-- ### Exercise 5.4: LIKE with Multiple Patterns
-- **Task**: Find all employees whose last name ends with 'son'.

-- **Expected Result**: 3 employees

select 'Exercise 5.4:' AS "";
select * from employees where last_name like '%son';

-- ### Exercise 5.5: LIKE with _ Wildcard
-- **Task**: Find all employees whose first name is exactly 4 letters long.

-- **Hint**: Use four underscore characters

-- **Expected Result**: 3 employees

select 'Exercise 5.5:' AS "";
select * from employees where first_name like '____';

-- ### Exercise 5.6: IS NULL
-- **Task**: Find all employees who have no manager (manager_id is NULL).

-- **Hint**: Do not use = with NULL

-- **Expected Result**: 3 employees
select 'Exercise 5.6:' AS "";
select * from employees where manager_id is null;

-- ### Exercise 5.7: IS NOT NULL
-- **Task**: Find all employees who have a manager.

-- **Expected Result**: 12 employees

select 'Exercise 5.7:' AS "";
select * from employees where manager_id is not null;





























-- ## Part 6: Working with Products Table

-- ### Exercise 6.1: Low Stock Alert
-- **Task**: Find all products with stock quantity less than 50.

-- **Expected Result**: 8 products
select 'Exercise 6.1:' as "";
select * from products where stock_quantity<50;



-- ### Exercise 6.2: Out of Stock
-- **Task**: Find all products that are completely out of stock (stock quantity equals 0).

-- **Expected Result**: 1 product
select 'Exercise 6.2:' as "";
select * from products where stock_quantity=0;




-- ### Exercise 6.3: Price Range
-- **Task**: Find all products priced between 20 and 100 dollars.

-- **Expected Result**: 7 products

select 'Exercise 6.3:' as "";
select * from products where price between 20 and 100;
select 'can also be written as' as "";
select * from products where price>=20 and price<=100;

-- ### Exercise 6.4: Specific Categories
-- **Task**: Find all products in Electronics or Accessories categories.

-- **Expected Result**: 13 products
select 'Exercise 6.4:' as "";
select * from products where category in('Electronics','Accessories');


-- ### Exercise 6.5: Supplier Search
-- **Task**: Find all products supplied by TechCorp.

-- **Expected Result**: 6 products

select 'Exercise 6.5:' as "";
select * from products where supplier='TechCorp';



























-- ## Part 7: Working with Orders Table

-- ### Exercise 7.1: Recent Orders
-- **Task**: Find all orders placed in March 2024.
-- **Hint**: Use BETWEEN with dates in 'YYYY-MM-DD' forma
-- **Expected Result**: 4 orders
select 'Exercise 7.1:' as "";
select * from orders where order_date between '2024-03-01' and '2024-03-31';

-- ### Exercise 7.2: High Value Orders
-- **Task**: Find all orders with a total amount greater than 200.

-- **Expected Result**: 8 orders

select 'Exercise 7.2:' as "";
select * from orders where total_amount>200;

-- ---

-- ### Exercise 7.3: Order Status
-- **Task**: Find all orders that are currently being processed or shipped.

-- **Expected Result**: 4 orders
select 'Exercise 7.3:' as "";
select * from orders where status='Processing' or status='Shipped';

-- ### Exercise 7.4: Cancelled Orders
-- **Task**: Find all cancelled orders.

-- **Expected Result**: 1 order

select 'Exercise 7.4:' as "";
select * from orders where status='Cancelled';


-- ## Part 8: Complex Queries

-- ### Exercise 8.1: Department Analysis
-- **Task**: Find all IT employees in San Francisco who earn more than 80000.

-- **Expected Result**: 3 employees

select 'Exercise 8.1:' as "";
select * from employees where department='IT' and city='San Francisco' and salary>80000;

-- ### Exercise 8.2: Hiring Date Range
-- **Task**: Find all employees hired between January 1, 2020 and December 31, 2021.

-- **Expected Result**: 9 employees
select 'Exercise 8.2:' as "";
select * from employees where hire_date between '2020-01-01' and '2021-12-31';

-- ### Exercise 8.3: Email Domain Search
-- **Task**: Find all employees whose email contains 'company.com'.

-- **Expected Result**: 15 employees (all employees)
select 'Exercise 8.3:' as "";
select * from employees where email like '%company.com%';


-- ### Exercise 8.4: Product Inventory Alert
-- **Task**: Find all Electronics products that either have zero stock or less than 30 units, and price above 50.

-- **Hint**: Use parentheses to group the OR condition for stock

-- **Expected Result**: 2 products
select 'Exercise 8.4:' as "";

select * from products where category='Electronics' and (stock_quantity=0 or stock_quantity<30) and price>50;



-- ---

-- ### Exercise 8.5: Multi-Condition Order Search
-- **Task**: Find all delivered orders from February or March 2024 with total amount over 150.

-- **Expected Result**: 2 orders
select 'Exercise 8.5:' as "";
select * from orders where status='Delivered' and order_date between '2024-02-01' and '2024-03-31' and total_amount>150;



-- ## Part 9: Challenge Exercises

-- ### Challenge 9.1: Salary Band Analysis
-- **Task**: Categorize employees into salary bands. Find all employees earning between 50000-60000 and label them as 'Entry Level'.

-- **Hint**: Use a string literal in SELECT to add the label

-- **Expected Result**: Employees in entry level salary band
select 'Challenge 9.1:' as "";
select first_name,last_name,salary,'Entry Level' as level from employees where salary between 50000 and 60000;


-- ### Challenge 9.2: Name Pattern Search
-- **Task**: Find employees whose first name contains 'ar' OR last name starts with 'W' OR 'T'.

-- **Expected Result**: 3 employees

select 'Challenge 9.2:' as "";
select * from employees where first_name like '%ar%' or last_name like 'W%' or last_name like 'T%';


-- ---

-- ### Challenge 9.3: Product Reorder List
-- **Task**: Create a reorder list for products that are:
-- - In stock (quantity > 0)
-- - Low stock (quantity < 50)
-- - Price under 100
-- - From specific suppliers (TechCorp or CableWorks)

-- **Expected Result**: Products matching all criteria

select 'Challenge 9.3:' as "";
select * from products where stock_quantity>0 and stock_quantity<50 and price<100 and (supplier='TechCorp' or supplier='CableWorks');


-- ---

-- ### Challenge 9.4: Employee Location and Department
-- **Task**: Find employees who:
-- - Work in Sales, Marketing, or HR
-- - Are located in cities that start with 'C' or 'B'
-- - Have a salary not equal to 54000 or 52000

-- **Expected Result**: 4 employees
select 'Challenge 9.4:' as "";
select * from employees where (department='Sales' or department='Marketing' or department='HR') and (city like 'C%' or city like 'B%') and salary<>54000 and salary<>52000;


-- ### Challenge 9.5: Order Investigation
-- **Task**: Find orders where:
-- - Customer name starts with a letter between 'A' and 'H'
-- - Order date is NOT in January 2024
-- - Status is NOT cancelled
-- - Quantity ordered is between 2 and 6

-- **Hint**: Use string comparison for customer name filter

-- **Expected Result**: 5 orders

select 'Challenge 9.5:' as "";
select * from orders where customer_name>='A' and customer_name<='H' and order_date not between '2024-01-01' and '2024-01-31' and status<>'Cancelled' and quantity between 2 and 6;
-- ---

-- ## Self-Assessment Checklist

-- After completing the lab, check off each skill you feel confident with:

-- - [ ] Writing basic SELECT statements
-- - [ ] Selecting specific columns
-- - [ ] Using column aliases
-- - [ ] Using SELECT DISTINCT
-- - [ ] Performing arithmetic operations in SELECT
-- - [ ] Concatenating strings
-- - [ ] Using WHERE clause with comparison operators
-- - [ ] Using AND, OR, NOT logical operators
-- - [ ] Using BETWEEN operator
-- - [ ] Using IN operator
-- - [ ] Using LIKE operator with wildcards
-- - [ ] Using IS NULL and IS NOT NULL
-- - [ ] Combining multiple conditions with proper parentheses
-- - [ ] Writing complex queries with multiple tables
-- - [ ] Troubleshooting SQL syntax errors

-- ## Tips for Success

-- 1. **Test incrementally**: Start with simple queries and add complexity gradually
-- 2. **Check row counts**: Verify your results match the expected number of rows
-- 3. **Use proper formatting**: Indent your queries for better readability
-- 4. **Remember quotes**: Text values need single quotes, numbers don't
-- 5. **NULL is special**: Use IS NULL, not = NULL
-- 6. **Parentheses matter**: Use them to control logic in complex conditions
-- 7. **LIKE is case-sensitive**: Depending on your database configuration
-- 8. **Ask questions**: If you're stuck, ask your instructor for guidance

-- ## Common Mistakes to Avoid

-- 1. Forgetting quotes around text values
-- 2. Using = instead of IS NULL
-- 3. Missing parentheses in complex conditions
-- 4. Incorrect wildcard usage (% vs _)
-- 5. Wrong date format
-- 6. Confusing AND/OR precedence

-- ## Notes Section

-- Use this space to write down important points, questions, or observations:

-- ---

-- ---

-- ---

-- ---

-- ---