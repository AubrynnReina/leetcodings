-- Write your PostgreSQL query statement below
select
    coalesce(r.id, a.id) as id,
    coalesce(r.requester_friends, 0) + coalesce(a.accepter_friends, 0) as num
from (
    select
        requester_id as id,
        count(accepter_id) as requester_friends
    from RequestAccepted
    group by requester_id
) r
full outer join (
    select
        accepter_id as id,
        count(requester_id) as accepter_friends
    from RequestAccepted
    group by accepter_id
) a
on r.id = a.id
order by num desc
limit 1
