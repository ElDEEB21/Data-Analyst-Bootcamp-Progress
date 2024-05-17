select *
from employee_demographics
order by age DESC
limit 2,1;

select gender, AVG(age) AS avg_age
from employee_demographics
group by gender
having avg_age > 40;