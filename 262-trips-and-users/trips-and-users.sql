-- My solution: the idea is straight forward
-- join the trips table with the users table twice, once for client, once for driver
-- apply filter along the join condition for optimization
-- then a little aggregation on the trip request date

select
    t.request_at as "Day",
    round(
        sum(case when (t.status = 'completed') then 0 else 1 end) * 1.0 / count(t.id)
    , 2) as "Cancellation Rate"
from trips t
join users u1
on t.client_id = u1.users_id and u1.banned = 'No' and u1.role = 'client'
join users u2
on t.driver_id = u2.users_id and u2.banned = 'No' and u2.role = 'driver'
where to_date(t.request_at, 'YYYY-MM-DD') between date '2013-10-01' and date '2013-10-03' 
group by t.request_at
