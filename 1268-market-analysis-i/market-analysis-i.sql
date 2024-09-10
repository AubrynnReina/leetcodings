-- Write your PostgreSQL query statement below
select 
    u.user_id as buyer_id,
    u.join_date as join_date,
    coalesce(o.orders_in_2019, 0) as orders_in_2019
from users u
left join (
    select
        buyer_id,
        count(order_id) as orders_in_2019
    from orders
    where
        extract(year from order_date) = 2019
    group by buyer_id
) o
on u.user_id = o.buyer_id