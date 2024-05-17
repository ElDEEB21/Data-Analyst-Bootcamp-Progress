select *
from employee_demographics;

SELECT gender, AVG(age)
from employee_demographics
group by gender;

SELECT occupation, salary
from employee_salary
group by occupation,salary;

SELECT gender, AVG(age), MAX(age), MIN(age),COUNT(age)
from employee_demographics
group by gender;

SELECT *
from employee_demographics
order by first_name desc;

SELECT *
from employee_demographics
order by gender, age DESC;

SELECT *
from employee_demographics
order by 5, 4 DESC;