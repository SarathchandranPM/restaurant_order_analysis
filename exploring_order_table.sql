select * from order_details;

-- How many items were ordered in this range:
select count(*) from order_details;

-- Date range
select min(order_date) from order_details;
select max(order_date) from order_details;

-- How many orders within the date range
select count(distinct order_id) 'No.of orders' from order_details;

-- No.of orders per day
select order_date, count(distinct order_id) order_count
from order_details
where order_date 
between (select min(order_date) from order_details) and (select max(order_date) from order_details)
group by order_date;

-- No.of items in each order
select order_id, count(item_id) 'No.of items'
from order_details
group by order_id
order by count(item_id) desc;

-- Largest order in terms of number of items
with order_count_cte as
(
select order_id, count(item_id) count
from order_details
group by order_id
order by count(item_id) desc
)
select order_id from order_count_cte
where count = (select max(count) from order_count_cte);

-- Large orders (Orders with more than 10 items)
with large_orders_cte as
(
select order_id, count(item_id) count
from order_details
group by order_id
order by count(item_id) desc
)
select order_id from large_orders_cte
where count >= 10
order by order_id;

-- Orders having more than 10 items - Alternate:
select order_id, count(item_id) 'No.of items'
from order_details
group by order_id
having count(item_id) >=10;

-- No.of large orders
select count(*) from
(
select order_id, count(item_id) 'No.of items'
from order_details
group by order_id
having count(item_id) >= 10
) as orders_and_size;
