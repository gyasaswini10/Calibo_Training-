
-- ### Exercise 3: Multiple JOINs
-- List all orders with customer names and the total number of items in each order. Display order ID
-- , customer name, order date, total amount, count of different items, and sum of quantities. Order by order ID.
-- **Hint:** You need to join three tables: orders, customers, and order_details.
-- **Expected columns:** order_id, customer_name, order_date, total_amount, item_count, total_quantity

select o.order_id,c.customer_name,o.order_date,o.total_amount,
count(distinct od.product_id) as item_count,
sum(od.quantity) as total_quantity
from orders o
join customers c on o.customer_id=c.customer_id
join order_details od on o.order_id=od.order_id
group by o.order_id,c.customer_name,o.order_date,o.total_amount
order by o.order_id;