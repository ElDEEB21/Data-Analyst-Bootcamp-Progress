with CTE_Example as (
	select gender, avg(salary), max(salary), min(salary), count(salary)
	from employee_demographics as dem
	join employee_salary as sal
		on dem.employee_id = sal.employee_id
	group by gender
)
select *
from CTE_Exampe;