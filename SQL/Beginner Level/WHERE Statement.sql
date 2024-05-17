SELECT *
from employee_salary
where first_name = 'leslie';

SELECT *
from employee_salary
where salary >= 50000;

SELECT *
from employee_demographics
where gender = 'male';

SELECT *
from employee_demographics
where NOT gender = 'male' OR birth_date > '1985-01-01';

SELECT *
from employee_demographics
where (first_name = "leslie" AND age = 44) OR age > 55;

SELECT *
from employee_demographics
where first_name LIKE 'a___%';