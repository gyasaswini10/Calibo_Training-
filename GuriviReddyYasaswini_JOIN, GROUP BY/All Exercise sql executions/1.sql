# SQL JOIN and GROUP BY Lab - Student Exercises
## Lab Introduction
/*
-- This lab is designed to help you practice SQL JOINs and GROUP BY clauses through hands-on exercises. You will work with a company 
-- database containing information about departments, employees, customers, orders, products, and order details.
## Database Schema Overview

The database contains the following tables:

**departments**
- dept_id (Primary Key)
- dept_name
- location

**employees**
- employee_id (Primary Key)
- first_name
- last_name
- email
- hire_date
- salary
- dept_id (Foreign Key → departments)
- manager_id (Foreign Key → employees)

**customers**
- customer_id (Primary Key)
- customer_name
- email
- city
- country

**orders**
- order_id (Primary Key)
- customer_id (Foreign Key → customers)
- order_date
- total_amount
- status

**products**
- product_id (Primary Key)
- product_name
- category
- unit_price

**order_details**
- order_detail_id (Primary Key)
- order_id (Foreign Key → orders)
- product_id (Foreign Key → products)
- quantity
- unit_price

## Setup Instructions

Before starting the exercises, run the setup script provided by your trainer to create the database tables and insert sample data.

## Exercises
*/
create database if not exists caliboo_db;
use caliboo_db;


DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;


create table departments(
dept_id int primary key,
dept_name varchar(50),
location varchar(50)
);

create table employees(
employee_id int primary key,
first_name varchar(50),
last_name varchar(50),
email varchar(50),
hire_date date,
salary int,
dept_id int,
manager_id int,
foreign key(dept_id) references departments(dept_id),
foreign key(manager_id) references employees(employee_id)
);

create table customers(
customer_id int primary key,
customer_name varchar(50),
email varchar(50),
city varchar(50),
country varchar(50)
);

create table orders(
order_id int primary key,
customer_id int,
order_date date,
total_amount decimal(10,2),
status varchar(20),
foreign key(customer_id) references customers(customer_id)
);

create table products(
product_id int primary key,
product_name varchar(50),
category varchar(50),
unit_price decimal(10,2)
);

create table order_details(
order_detail_id int primary key,
order_id int,
product_id int,
quantity int,
unit_price decimal(10,2),
foreign key(order_id) references orders(order_id),
foreign key(product_id) references products(product_id)
);

insert into departments values
(1,'HR','Delhi'),
(2,'IT','Bangalore'),
(3,'Sales','Mumbai'),
(4,'Finance','Pune');

insert into employees values
(101,'Amit','Sharma','amit@gmail.com','2021-01-10',80000,2,null),
(102,'Priya','Verma','priya@gmail.com','2021-03-15',65000,2,101),
(103,'Rahul','Mehta','rahul@gmail.com','2022-02-20',72000,2,101),
(104,'Sneha','Reddy','sneha@gmail.com','2022-05-12',48000,1,101),
(105,'Kiran','Patel','kiran@gmail.com','2023-01-05',52000,1,101),
(106,'Neha','Singh','neha@gmail.com','2023-03-08',60000,1,101),
(107,'Arjun','Iyer','arjun@gmail.com','2022-06-10',90000,3,101),
(108,'Rohit','Kumar','rohit@gmail.com','2023-02-15',55000,3,107),
(109,'Pooja','Nair','pooja@gmail.com','2023-04-01',75000,4,101);

insert into customers values
(1,'Amit Sharma','amit@gmail.com','Delhi','India'),
(2,'Priya Verma','priya@gmail.com','Mumbai','India'),
(3,'Rahul Mehta','rahul@gmail.com','Ahmedabad','India'),
(4,'Sneha Reddy','sneha@gmail.com','Hyderabad','India'),
(5,'Kunal Shah','kunal@gmail.com','Surat','India');

insert into orders values
(1001,1,'2024-01-10',2500,'Completed'),
(1002,1,'2024-02-15',1800,'Completed'),
(1003,2,'2024-03-05',3200,'Pending'),
(1004,3,'2024-02-20',1500,'Completed'),
(1005,3,'2024-03-22',2100,'Completed');

insert into products values
(201,'Keyboard','Electronics',500),
(202,'Mouse','Electronics',300),
(203,'Monitor','Electronics',8000),
(204,'Notebook','Stationery',100),
(205,'Pen','Stationery',20);

insert into order_details values
(1,1001,201,2,500),
(2,1001,202,1,300),
(3,1002,201,3,500),
(4,1003,203,1,8000),
(5,1004,204,5,100),
(6,1005,201,1,500),
(7,1005,202,2,300);
