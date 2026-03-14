
-- ### Exercise 10: Advanced Multi-Table Analysis
-- For each country, show the total number of orders, total revenue, and average order value. Only include countries that have orders. Display country, total orders, customer count, total revenue, and average order value. Order by total revenue in descending order.

-- **Hint:** Join customers and orders, group by country, and use HAVING to exclude countries with no orders.
-- **Expected columns:** country, total_orders, customer_count, total_revenue, avg_order_value
SELECT c.country,
COUNT(o.order_id) AS total_orders,
COUNT(DISTINCT c.customer_id) AS customer_count,
SUM(o.total_amount) AS total_revenue,
AVG(o.total_amount) AS avg_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.country
HAVING COUNT(o.order_id) > 0
ORDER BY total_revenue DESC;
