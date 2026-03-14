
-- ### Exercise 15: Comprehensive Report
-- Create a comprehensive customer report for customers with completed orders.
--  Display: customer ID, customer name, country, total orders, total spent, average order value,
--  last order date, and first order date. Order by total spent in descending order.

-- **Hint:** Join customers and orders, filter for completed status, use multiple aggregate functions.
-- **Expected columns:** customer_id, customer_name, country, total_orders, total_spent, avg_order_value, last_order_date, first_order_date

select 'exercise 15' as '';
SELECT c.customer_id,
c.customer_name,
c.country,
COUNT(o.order_id) AS total_orders,
SUM(o.total_amount) AS total_spent,
AVG(o.total_amount) AS avg_order_value,
MAX(o.order_date) AS last_order_date,
MIN(o.order_date) AS first_order_date
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
WHERE o.status='Completed'
GROUP BY c.customer_id,c.customer_name,c.country
ORDER BY total_spent DESC;