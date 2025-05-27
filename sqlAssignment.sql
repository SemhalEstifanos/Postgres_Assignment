
CREATE SCHEMA production_platform;


CREATE TABLE production_platform.employees_table (
    employee_id INT PRIMARY KEY,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    gender VARCHAR(10),
    department VARCHAR(50),
    hireDate DATE,
    salary FLOAT
);
INSERT INTO production_platform.employees_table(employee_id, firstName, lastName, gender, department, hireDate, salary) VALUES
(1, 'John', 'Doe', 'Male', 'IT', '2018-05-01', 60000.00),
(2, 'Jane', 'Smith', 'Female', 'HR', '2019-06-15', 50000.00),
(3, 'Michael', 'Johnson', 'Male', 'Finance', '2017-03-10', 75000.00),
(4, 'Emily', 'Davis', 'Female', 'IT', '2020-11-20', 70000.00),
(5, 'Sarah', 'Brown', 'Female', 'Marketing', '2016-07-30', 45000.00),
(6, 'David', 'Wilson', 'Male', 'Sales', '2019-01-05', 55000.00),
(7, 'Chris', 'Taylor', 'Male', 'IT', '2022-02-25', 65000.00);
CREATE TABLE production_platform.product_table (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price FLOAT,
    stock INT
);
INSERT INTO production_platform.product_table (  product_id, product_name, category,  price ,  stock) VALUES
(1, 'Laptop', 'Electronics', 1200.00, 30),
(2, 'Desk', 'Furniture', 300.00, 50),
(3, 'Chair', 'Furniture', 150.00, 200),
(4, 'Smartphone', 'Electronics', 800.00, 75),
(5, 'Monitor', 'Electronics', 250.00, 40),
(6, 'Bookshelf', 'Furniture', 100.00, 20),
(7, 'Printer', 'Electronics', 200.00, 25);



CREATE TABLE production_platform.sales_table(
    sales_id INT PRIMARY KEY,
    product_id INT,
    employee_id INT,
    CONSTRAINT product_id
    FOREIGN KEY (product_id)
    REFERENCES production_platform.product_table(product_id),
    CONSTRAINT employee_id
    FOREIGN KEY (employee_id)
    REFERENCES production_platform.employees_table(employee_id),
    saleDate DATE NOT NULL,
    quantity INT,
    total FLOAT
);





INSERT INTO production_platform.sales_table  (sales_id, product_id, employee_id, saleDate, quantity, total) VALUES
(1, 1, 1, '2021-01-15', 2, 2400.00),
(2, 2, 2, '2021-03-22', 1, 300.00),
(3, 3, 3, '2021-05-10', 4, 600.00),
(4, 4, 4, '2021-07-18', 3, 2400.00),
(5, 5, 5, '2021-09-25', 2, 500.00),
(6, 6, 6, '2021-11-30', 1, 100.00),
(7, 7, 1, '2022-02-15', 1, 200.00),
(8, 1, 2, '2022-04-10', 1, 1200.00),
(9, 2, 3, '2022-06-20', 2, 600.00),
(10, 3, 4, '2022-08-05', 3, 450.00),
(11, 4, 5, '2022-10-11', 1, 800.00),
(12, 5, 6, '2022-12-29', 4, 1000.00);


-- 1
SELECT * from production_platform.employees_table;
-- 2
SELECT FirstName AS F_name FROM production_platform.employees_table;
SELECT DISTINCT Department AS Dept FROM production_platform.employees_table;
-- 4
SELECT COUNT(*) AS total_employees FROM production_platform.employees_table;
-- 5
SELECT SUM(Salary) AS total_salary FROM production_platform.employees_table;
-- 6
SELECT AVG(Salary) AS avg_salary FROM production_platform.employees_table;
-- 7
SELECT MAX(Salary) AS highest_salary FROM production_platform.employees_table;
-- 8
SELECT MIN(Salary) AS lowest_salary FROM production_platform.employees_table;
-- 9
SELECT COUNT(*) AS male_employees FROM production_platform.employees_table;
-- 10
SELECT COUNT(*) AS female_employees FROM production_platform.employees_table;

--11
SELECT COUNT(employee_id) AS employees_hired_in_2020
FROM production_platform.employees_table
WHERE EXTRACT (YEAR FROM hireDate) = 2020
GROUP BY(hireDate);


-- 12
SELECT AVG(Salary) AS  IT_AvgSalary
FROM production_platform.employees_table
WHERE department= 'IT';

-- 13
SELECT Department, COUNT(*) AS EmployeeCount
FROM production_platform.employees_table
Group BY Department;

-- 14
SELECT Department, SUM(Salary) AS TotalDptSalary
FROM production_platform.employees_table
GROUP BY Department

-- 15
SELECT Department, MAX(Salary) AS Max_Salary
FROM production_platform.employees_table
GROUP BY  department;

-- 16
SELECT Department, MIN(Salary) AS Min_Salary
FROM production_platform.employees_table
GROUP BY Department ;

--17
SELECT Gender, COUNT (*) AS Employee_Count
FROM production_platform.employees_table
GROUP BY Gender;

--18
SELECT Gender, AVG(Salary) AS Average_Salary
FROM production_platform.employees_table
GROUP BY Gender;

--19
SELECT *
FROM production_platform.employees_table
ORDER BY Salary DESC
LIMIT 5;

--20
SELECT count(DISTINCT FirstName) AS UniqueFirstNames
FROM production_platform.employees_table;


--21
SELECT firstName, total
  FROM production_platform.employees_table  et
  JOIN production_platform.sales_table  st ON
  et.employee_id = st.employee_id;
-- 22
SELECT * FROM production_platform.employees_table
ORDER BY hireDate
LIMIT 10;

-- 23
SELECT *
FROM production_platform.employees_table
WHERE employee_id NOT IN (SELECT employee_id FROM production_platform.sales_table);


-- 24
SELECT et.firstName, COUNT(total) AS total_sales
FROM production_platform.employees_table et
JOIN production_platform.sales_table st ON
et.employee_id = st.employee_id
GROUP BY firstName;

--25
SELECT et.employee_id, et.firstName, et.lastName, SUM(st.total) AS total_sales_have
FROM production_platform.sales_table st
JOIN production_platform.employees_table et ON st.employee_id = et.employee_id
GROUP BY et.employee_id, et.firstName, et.lastName
ORDER BY total_sales_have DESC
LIMIT 1;


-- 26

SELECT et.department, AVG(st.quantity) AS avg_quantity_sold
FROM production_platform.sales_table st
JOIN production_platform.employees_table et ON st.employee_id = et.employee_id
GROUP BY et.department;


-- 27
SELECT et.employee_id, et.firstName, SUM(st.total) AS total_sales_2021
FROM production_platform.sales_table st
JOIN production_platform.sales_table  et ON st.employee_id = et.employee_id
WHERE EXTRACT(YEAR FROM st.sales_date) = 2021
GROUP BY et.employee_id, et.firstName, et.lastname;
-- 28
SELECT et.employee_id, et.firstName, et.lastName, SUM(st.quantity) AS total_quantity_sold
FROM production_platform.sales_table st
JOIN production_platform.employees_table  et ON st.employee_id = et.employee_id
GROUP BY et.employee_id, et.firstName, et.lastName
ORDER BY total_quantity_sold DESC
LIMIT 3;
-- 29. 
Select the total quantity of products sold by each department.
SELECT et.department, SUM(st.quantity) AS total_quantity_sold
FROM production_platform.sales_table st
JOIN production_platform.employees_table et ON st.employee_id = et.employee_id
GROUP BY et.department;
-- 30. 
SELECT p.category, SUM(s.total) AS total_revenue
FROM production_platform.sales_table st
JOIN production_platform.products p ON s.product_id = p.product_id
GROUP BY p.category;
