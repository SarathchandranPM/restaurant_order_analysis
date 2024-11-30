select * from order_details;
select * from menu_items;

-- Joining two tables:
select * 
from order_details od left join menu_items mi
on od.item_id = mi.menu_item_id;

-- Items and the number of orders
select mi.item_name item, mi.category, count(mi.item_name) order_count
from order_details od left join menu_items mi
on od.item_id = mi.menu_item_id
group by item_name, mi.category
order by 3 desc;

-- Most and least ordered items
with order_count_cte(item, order_count) as
(
select mi.item_name, count(mi.item_name)
from order_details od left join menu_items mi
on od.item_id = mi.menu_item_id
group by item_name
)
select item, order_count 
from order_count_cte
where order_count = (select max(order_count) from order_count_cte);

-- Above query simplified:
SELECT item_name, COUNT(od.item_id) AS order_count
FROM order_details od
INNER JOIN menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY item_name
ORDER BY order_count DESC
LIMIT 1;

SELECT item_name, COUNT(od.item_id) AS order_count
FROM order_details od
INNER JOIN menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY item_name
ORDER BY order_count ASC
LIMIT 1;