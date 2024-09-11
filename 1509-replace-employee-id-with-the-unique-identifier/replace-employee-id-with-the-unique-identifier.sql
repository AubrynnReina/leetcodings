-- Write your PostgreSQL query statement below
select
    euni.unique_id,
    e.name
from employees e
left outer join employeeuni euni
on e.id = euni.id
