
-- ### Exercise 9: Finding Unmatched Records
-- Find all products that have never been ordered. Display product ID, product name, category, and unit price. Order by product ID.

-- **Hint:** Use LEFT JOIN and check for NULL values in the joined table.

-- **Expected columns:** product_id, product_name, category, unit_price
select 'exercise 9' as '';
select p.product_id as product_id,
p.product_name as product_name,
p.category as category,
p.unit_price as unit_price
from products p
left join order_details od on p.product_id=od.product_id
where od.product_id is null
order by p.product_id;
