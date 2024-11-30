select * from menu_items;

-- No.of items in the menu:
select count(*) total_items from menu_items; 

-- Least and most expensive items:
select * 
from menu_items
where price = (select max(price) from menu_items);

select * 
from menu_items
where price = (select min(price) from menu_items);

-- Items stats by Category
select 
category, count(*) count, min(price) highest, max(price) lowest, round(avg(price), 2) avg_price
from menu_items group by category;

-- Items ranked by price and ordered by category
select *, dense_rank() 
over(partition by category order by price desc) 'rank'
from menu_items;
