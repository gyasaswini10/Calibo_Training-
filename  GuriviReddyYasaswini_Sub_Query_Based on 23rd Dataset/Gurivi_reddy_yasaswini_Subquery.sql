-- Exercise Number 1
-- Find the 2nd highest salaried person in the Finance department
USE employees;

select "exercise 1"  as '';
SELECT e.emp_no,e.first_name,e.last_name
FROM employees e
WHERE e.emp_no=(
SELECT emp_no FROM salaries
WHERE emp_no IN(
SELECT emp_no FROM dept_emp
WHERE dept_no=(SELECT dept_no FROM departments WHERE dept_name='Finance')
)
AND salary<(
SELECT MAX(salary) FROM salaries
WHERE emp_no IN(
SELECT emp_no FROM dept_emp
WHERE dept_no=(SELECT dept_no FROM departments WHERE dept_name='Finance')
)
)
ORDER BY salary DESC LIMIT 1
);

-- -- Exercise Number 2
-- -- Employees who worked in Production between 1998 and 2000
-- select "exercise 2"  as '';
SELECT DISTINCT e.emp_no,e.first_name,e.last_name
FROM employees e
WHERE e.emp_no IN(
  SELECT emp_no
  FROM dept_emp
  WHERE dept_no=(SELECT dept_no FROM departments WHERE dept_name='Production')
  AND from_date<='2000-12-31'
  AND to_date>='1998-01-01'
)
limit 10;


-- Exercise Number 3
-- -- 3rd highest salaried person in Production without order by


SELECT 'exercise 3' AS '';

SELECT e.emp_no,e.first_name,e.last_name
FROM employees e
WHERE e.emp_no IN(
SELECT s.emp_no
FROM salaries s
WHERE s.to_date='9999-01-01'
AND s.salary=(
SELECT MAX(salary)
FROM salaries
WHERE to_date='9999-01-01'
AND emp_no IN(
SELECT emp_no FROM dept_emp
WHERE dept_no=(SELECT dept_no FROM departments WHERE dept_name='Production')
)
AND salary<(
SELECT MAX(salary)
FROM salaries
WHERE to_date='9999-01-01'
AND emp_no IN(
SELECT emp_no FROM dept_emp
WHERE dept_no=(SELECT dept_no FROM departments WHERE dept_name='Production')
)
AND salary<(
SELECT MAX(salary)
FROM salaries
WHERE to_date='9999-01-01'
AND emp_no IN(
SELECT emp_no FROM dept_emp
WHERE dept_no=(SELECT dept_no FROM departments WHERE dept_name='Production')
)
)
)
)
);

-- -- Exercise Number 4
-- -- Employees joined per year
select "exercise 4"  as '';
SELECT YEAR(hire_date),COUNT(*)
FROM employees
GROUP BY YEAR(hire_date);

-- -- Exercise Number 5
-- -- Year with maximum employees joined without having
select "exercise 5"  as '';
SELECT YEAR(hire_date)
FROM employees
GROUP BY YEAR(hire_date)
ORDER BY COUNT(*) DESC LIMIT 1;

-- -- Exercise Number 6
-- -- Yearly total salary cost per department
select "exercise 6"  as '';
SELECT d.dept_name,YEAR(s.from_date),SUM(s.salary)
FROM salaries s
JOIN dept_emp de ON s.emp_no=de.emp_no
JOIN departments d ON de.dept_no=d.dept_no
WHERE s.from_date BETWEEN de.from_date AND de.to_date
GROUP BY d.dept_name,YEAR(s.from_date);


-- -- Exercise Number 7
-- -- Year where highest female employees joined
select "exercise 7"  as '';
SELECT YEAR(hire_date)
FROM employees
WHERE gender='F'
GROUP BY YEAR(hire_date)
ORDER BY COUNT(*) DESC LIMIT 1;

-- -- Exercise Number 8
-- -- Hire date of current Human Resources manager

select "exercise 8"  as '';
SELECT hire_date
FROM employees
WHERE emp_no=(
SELECT emp_no FROM dept_manager
WHERE dept_no=(SELECT dept_no FROM departments WHERE dept_name='Human Resources')
AND to_date='9999-01-01'
);

-- -- Exercise Number 9
-- -- Salary of current Finance manager
select "exercise 9"  as '';
SELECT salary
FROM salaries
WHERE emp_no=(
SELECT emp_no FROM dept_manager
WHERE dept_no=(SELECT dept_no FROM departments WHERE dept_name='Finance')
AND to_date='9999-01-01'
)
AND to_date='9999-01-01';

-- -- Exercise Number 10
-- -- Current department managers first name and emp_no 
select "exercise 10"  as '';
SELECT e.first_name,e.emp_no
FROM employees e
WHERE e.emp_no IN(
SELECT emp_no FROM dept_manager
WHERE to_date='9999-01-01'
);
