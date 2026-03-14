select "exercise 3"  as '';

-- -- 3rd highest salaried person in Production without order by

SELECT 'exercise 3' AS '';
use employees;
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
SELECT e.emp_no,e.first_name,e.last_name
FROM employees e
JOIN salaries s ON e.emp_no=s.emp_no
WHERE s.to_date='9999-01-01'
AND s.emp_no IN(
 SELECT emp_no FROM dept_emp
 WHERE dept_no=(SELECT dept_no FROM departments WHERE dept_name='Production')
)
AND 2=(
 SELECT COUNT(DISTINCT s2.salary)
 FROM salaries s2
 WHERE s2.salary>s.salary
 AND s2.to_date='9999-01-01'
);
