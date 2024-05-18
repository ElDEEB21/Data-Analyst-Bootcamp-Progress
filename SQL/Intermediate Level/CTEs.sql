with CTE_Example (gender, Avg_sal, Max_sal, Min_sal, Cnt_sal) as(
	select gender, avg(salary) avg_sal, max(salary) max_sal, min(salary) min_sal, count(salary) cnt_sal
	from employee_demographics as dem
	join employee_salary as sal
		on dem.employee_id = sal.employee_id
	group by gender
)
select *
from CTE_Example;
-- same thing
select avg(avg_sal)
from (
	select gender, avg(salary) avg_sal, max(salary) max_sal, min(salary) min_sal, count(salary) cnt_sal
	from employee_demographics as dem
	join employee_salary as sal
		on dem.employee_id = sal.employee_id
	group by gender
) as example_subquery;

with CTE_Example as (
	select gender, employee_id, birth_date
	from employee_demographics 
    where birth_date > '1985-01-01'
),
CTE_Example2 as (
	select employee_id, salary
	from employee_salary
    where salary > 50000
)
select *
from CTE_Example as ct1
join CTE_Example2 as ct2
	on ct1.employee_id = ct2.employee_id;