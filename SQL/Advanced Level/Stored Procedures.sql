select *
from employee_salary
where salary >= 50000;

create procedure large_sal()
select *
from employee_salary
where salary >= 50000;

call large_sal();

DELIMITER $$
create procedure large_sal3()
begin
	select *
	from employee_salary
	where salary >= 50000;
	select *
	from employee_salary
	where salary >= 10000;
end $$ 
DELIMITER ;

call large_sal3();

DELIMITER $$
create procedure large_sal4(id int)
begin
	select salary
	from employee_salary
    where employee_id = id;
end $$ 
DELIMITER ;

call large_sal4(1);