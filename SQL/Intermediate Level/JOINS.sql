select *
from employee_demographics;

select *
from employee_salary;

select dem.employee_id, age, occupation
from employee_demographics as dem
INNER join employee_salary as sal
	on dem.employee_id = sal.employee_id ;

select *
from employee_demographics as dem
right join employee_salary as sal
	on dem.employee_id = sal.employee_id;
    
select *
from employee_salary as e1
join employee_salary as e2
	on e1.employee_id + 1 = e2.employee_id;

select e1.employee_id as emp,
e1.first_name as first_name_santa,
e1.last_name as last_name_santa,
e2.employee_id as emp,
e2.first_name as first_name_santa,
e2.last_name as last_name_santa
from employee_salary as e1
join employee_salary as e2
	on e1.employee_id + 1 = e2.employee_id;
    
select *
from employee_demographics as dem
INNER join employee_salary as sal
	on dem.employee_id = sal.employee_id 
INNER join parks_departments as pd
	on sal.dept_id = pd.department_id;

select *
from parks_departments;