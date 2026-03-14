
-- ### Exercise 13: Complex Filtering
-- Find the top 3 products by revenue. Display product ID, product name, category, total quantity 
-- sold, total revenue, and times ordered. Order by total revenue in descending order and limit to 3 results.

-- **Hint:** Calculate revenue as quantity × unit_price, use ORDER BY and LIMIT.
-- **Expected columns:** product_id, product_name, category, total_quantity, total_revenue, times_ordered
select 'exercise 13' as '';
select p.product_id as product_id,
p.product_name as product_name,
p.category as category,
sum(od.quantity) as total_quantity,
sum(od.quantity*od.unit_price) as total_revenue,
count(distinct od.order_id) as times_ordered
from products p
join order_details od on p.product_id=od.product_id
group by p.product_id,p.product_name,p.category
order by total_revenue desc
limit 3;