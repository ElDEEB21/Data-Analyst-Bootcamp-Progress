create temporary table temp_table(
	first_name varchar(50),
	last_name varchar(50),
	fav_movie varchar(50)
);

select *
from temp_table;

insert into temp_table
values('Abdo','Eldeeb','Intersteller');

select *
from temp_table;

select *
from employee_salary;

create temporary table sal_over_50k
select *
from employee_salary
where salary >= 50000;

select *
from sal_over_50k;