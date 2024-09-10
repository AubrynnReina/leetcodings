-- Write your PostgreSQL query statement below
select 
    d.name as Department,
    e.name as Employee,
    e.salary as Salary
from (
    select
        departmentId,
        name,
        salary
    from employee e
    where (salary, departmentId) in (
        select
            max(salary),
            departmentId
        from employee
        group by departmentId
    )
) e
join department d
on e.departmentId = d.id