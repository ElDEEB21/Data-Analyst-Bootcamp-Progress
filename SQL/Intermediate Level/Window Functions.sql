select gender ,avg(salary) as avg_salary
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id = sal.employee_id
group by gender;

select concat(dem.first_name , ' ' , dem.last_name) as full_name, gender ,avg(salary) over(partition by gender) as avg_salary
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id = sal.employee_id;
    
select dem.first_name, dem.last_name, gender ,avg(salary) as avg_salary
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id = sal.employee_id
group by dem.first_name, dem.last_name, gender;

select concat(dem.first_name , ' ' , dem.last_name) as full_name, gender, salary,
SUM(salary) over(partition by gender order by dem.employee_id) as sum_salary
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id = sal.employee_id;
    
select dem.employee_id ,concat(dem.first_name , ' ' , dem.last_name) as full_name, gender, salary,
row_number() over(partition by gender order by salary desc) as row_num,
rank() over(partition by gender order by salary desc) as rank_num,
dense_rank() over(partition by gender order by salary desc) as rank_num
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id = sal.employee_id;