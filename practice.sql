SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('%jack%');


SELECT 
    *
FROM
    employees
WHERE
    first_name NOT LIKE ('%jack%');

SELECT 
    *
FROM
    salaries
WHERE
    salary BETWEEN 66000 AND 70000;

SELECT 
    *
FROM
    salaries
WHERE
    emp_no BETWEEN '10004' AND '10012';

SELECT 
    dept_name
FROM
    departments
WHERE
    dept_no BETWEEN 'd003' AND 'd006';

SELECT 
    *
FROM
    employees
WHERE
    first_name IS NOT NULL;

SELECT 
    *
FROM
    employees
WHERE
    first_name IS NULL;
SELECT 
    dept_name
FROM
    departments
WHERE
    dept_no IS NOT NULL;

/** list of emloyees hired after the 1st of january **/
SELECT 
    *
FROM
    employees
WHERE
    hire_date > '2000-01-01';

SELECT 
    *
FROM
    employees
WHERE
    gender = 'F'
        AND hire_date >= '2000-01-01';

SELECT 
    *
FROM
    salaries
WHERE
    salary > 150000;
SELECT DISTINCT
    gender
FROM
    employees;
/** Obtain a list with all different “hire dates” from the “employees” table. **/
SELECT DISTINCT
    hire_date
FROM
    employeese nb of employees in the database **/

SELECT 
    COUNT(emp_no)
FROM
    employees;

/** nb of all names***/
SELECT 
    COUNT(last_name) AS frequency
FROM
    employees;
/** nb of different distinct names***/
SELECT 
    COUNT(DISTINCT last_name)
FROM
    employees;

/**How many annual contracts with a value higher than or equal to $100,000 have been registered in the salaries table?**/

SELECT 
    COUNT(emp_no)
FROM
    salaries
WHERE
    salary >= '100000';
/**How many managers do we have in the “employees” database?**/
SELECT COUNT(*)
FROM
    dept_manager;

/** order by first name **/ 
SELECT 
    *
FROM
    employees
ORDER BY first_name DESC; 
/** order by first name and last name i.e order the employees sharing same irst name bu last name   **/ 
select * FROM employees ORDER BY first_name, last_name ; 

-- Select all data from the “employees” table, ordering it by “hire date” in descending order.
select * from employees order by hire_date DESC;
-- describe table 
DESCRIBE employees; 

-- get distinct names and the number of times they oppear frequency 
SELECT 
    first_name, COUNT(first_name) AS frequency
FROM
    employees
GROUP BY first_name
ORDER BY first_name DESC;

/** Write a query that obtains two columns. 
The first column must contain annual salaries higher than 80,000 dollars
The second column, renamed to “emps_with_same_salary”, must show the number of employees 
contracted to that salary.
Lastly, sort the output by the first column.  **/

select salary, count(emp_no) as emps_with_same_salary
from salaries 
where salary> "80000" 
group by salary 
order by salary; 
-- same query ordered by number of employees 
select salary, count(emp_no) as emps_with_same_salary
from salaries 
where salary> "80000" 
group by salary 
order by count(emp_no) DESC; 
/** getting the first names with a frequency higher than 250 **/

select first_name, count(first_name) as frequency 
from employees 
group by first_name 
having  frequency> 250
order by first_name; 


/** Select all employees whose average salary is 
higher than $120,000 per annum. **/ 

select emp_no, avg(salary) as average from salaries
group by emp_no 
having avg(salary)>"120000";

select first_name, count(first_name) from employees
group by count(first_name) ;

select emp_no, avg(salary) from salaries
group by emp_no
having AVG(salary)>"120000";
DESCRIBE employees; 
/** a list of names encountered less than 200 times
of people hired after jan 1st 1999 **/
select first_name, count(first_name) as frequency from employees
where hire_date >"1999-01-01"
group by first_name
having frequency<200 
order by frequency DESC ;

/**Select the employee numbers of all individuals who have signed 
more than 1 contract after the 1st of January 2000.**/

describe dept_emp;

select emp_no, count(emp_no) from dept_emp
where from_date> 200-01-01
group by emp_no 
order by count(emp_no) DESC ;
-- Select the first 100 rows from the ‘dept_emp’ table.  
select * from dept_emp
limit 100; 

select count(salary) from salaries; 

-- How many departments are there in the “employees” database? Use the ‘dept_emp’ table to answer the question.
select count(distinct dept_no) from dept_emp; 
/** the total amount of money spent on salaries 
for all contracts 
starting after the 1st of January 1997? **/
select sum(salary) from salaries
where from_date>"1997-01-01";

-- max salary 
select max(salary) from salaries;
-- Which is the lowest employee number in the database?
select min(emp_no) from employees; 
-- Which is the highest employee number in the database?
select max(emp_no) from employees; 
-- average salaries 
select avg(salary) from salaries; 
/** the average annual salary paid to employees 
who started after the 1st of January 1997? **/
select avg(salary) from salaries 
where from_date>"1997-01-01";
/** Round the average amount of money spent on salaries for all contracts that s
tarted after the 1st of January
 1997 to a precision of cents **/ 
select round(avg(salary), 2) from salaries 
where from_date>"1997-01-01";
select * from departments;
alter table departments 
change column dept_name dept_name VARCHAR(255) NULL;

insert into departments(dept_no) 
values ("d010"),( "d011"); 

select * from departments
order by dept_no DESC; 
alter table departments 
add column dept_manager VARCHAR(255)
null after dept_name; 
select * from departments
order by dept_no DESC;  
commit; 
-- ifnull()
select dept_no,  ifnull(dept_name, "N/A") 
from departments;
-- coalesce

select dept_no, dept_name, coalesce(dept_name, dept_manager, "N/A")
from departments; 
/** Select the department number and name 
from the ‘departments_dup’ table 
and add a third column where you name 
the department number (‘dept_no’) as ‘dept_info’.
 If ‘dept_no’ does not have a value, use ‘dept_name’. **/
select dept_no,
dept_name, 
coalesce(dept_no, dept_name) as dept_info
from departments; 
-- drop dept_manager column 
alter table departments
drop column dept_manager;

create table if not exists departments_dup
(
dept_no CHAR(4) null,
dept_name VARCHAR (40) null

)
;
insert into departments_dup (dept_no, dept_name)
select * from departments; 

drop table if exists dept_manager_dup;
-- Create and fill in the ‘dept_manager_dup’ table
create table if not exists dept_manager_dup 
(
emp_no int(11) NOT NULL,

  dept_no char(4) NULL,

  from_date date NOT NULL,

  to_date date NULL
);

INSERT INTO dept_manager_dup
select * from dept_manager;

INSERT INTO dept_manager_dup (emp_no, from_date)

VALUES                (999904, '2017-01-01'),

                                (999905, '2017-01-01'),

                               (999906, '2017-01-01'),

                               (999907, '2017-01-01');
SET SQL_SAFE_UPDATES = 0;                               
DELETE FROM dept_manager_dup

WHERE

    dept_no = 'd001';
    
iNSERT INTO departments_dup (dept_name)

VALUES ('Public Relations');

DELETE FROM departments_dup

WHERE

    dept_no = 'd002'; 
    
select * from dept_manager_dup;

select t1.dept_no, t1.emp_no, t2.dept_name
from dept_manager_dup t1
inner join departments_dup t2 on t1.dept_no = t2.dept_no;
/** Extract a list containing information about all managers’ 
employee number, first and last name, department number, 
and hire date. **/  
select t1.emp_no, t1.first_name, t1.last_name, t1.hire_date, t2.emp_no 
from employees t1
inner join dept_manager_dup t2 on t1.emp_no= t2.emp_no;

/** left join **/
select t1.dept_no, t1.emp_no, t2.dept_name
from dept_manager_dup t1
left join departments_dup t2 on t1.dept_no = t2.dept_no;
/** change order and join all matching records from two tables 
+ dept number from left table **/ 
select t2.dept_no, t2.emp_no, t1.dept_name
from departments_dup t1
left join dept_manager_dup t2 on t2.dept_no = t1.dept_no;
/** just the records from the left that do not match **/ 
select t1.dept_no, t1.emp_no, t2.dept_name
from dept_manager_dup t1
left join departments_dup t2 on t1.dept_no = t2.dept_no
where dept_name is null;

/** Join the 'employees' and the 'dept_manager' 
tables to return a subset of all the employees whose last name is Markovitch.
 See if the output contains a manager with that name.   **/ 
select e.emp_no, e.first_name, e.last_name, d.dept_no 
from employees e
left join dept_manager_dup d on e.emp_no= d.emp_no
 where e.last_name="Markovitch"; 
 
 /** left join **/
select t1.dept_no, t1.emp_no, t2.dept_name
from dept_manager_dup t1
right join departments_dup t2 on t1.dept_no = t2.dept_no;

/** old join  employees who are department manager **/ 
select t1. emp_no, t1.first_name, t1.last_name, t2.dept_no, t1.hire_date
from employees t1,
	dept_manager_dup t2
where t1. emp_no = t2.emp_no;
 
/** first names of employees whose salaries are greater
 than 145000 **/ 

select t1. emp_no, t1.first_name, t1.last_name, t2. salary
from employees t1
join salaries t2 on t1.emp_no= t2.emp_no
where salary> 145000;
/** avoide the error when selecting columns that are not in the group by clause  **/ 
select @@global.sql_mode;
set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');
/** Select the first and last name, the hire date,
 and the job title of all employees whose first name is 
“Margareta” and have the last name “Markovitch”. **/
SELECT 
    t1.first_name, t1.last_name, t1.hire_date, t2.title
FROM
    employees t1
        JOIN
    titles t2 ON t1.emp_no = t2.emp_no
WHERE
    first_name = 'Margareta'
        AND last_name = 'Markovitch';

/** Use a CROSS JOIN to return a list with all possible
 combinations between managers from the dept_manager 
 table and department number 9. **/ 
 SELECT t1.*, t2.* FROM 
 dept_manager t1
 cross join 
 departments t2
 where t2.dept_no= "d009"; 
 /** Return a list with the first 10 employees 
 with all the departments they can be assigned to. **/
 SELECT e.*, d.* from 
 employees e 
 cross join departments d
 where emp_no <= 10010
 order by emp_no
 ; 
 /** average salaries of man and women **/ 
 SELECT 
    e.gender, AVG(s.salary) AS average_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY gender; 
 /** Select all managers’ first and last name, hire date, job title, 
 start date, and department name. **/
 SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    dm.from_date,
    d.dept_name
FROM
    dept_manager dm
        JOIN
    departments d ON dm.dept_no = d.dept_no
        JOIN
    employees e ON dm.emp_no = e.emp_no
        JOIN
    titles t ON e.emp_no = t.emp_no;

/** names of all depatments and average salary paid to the managers **/
 
 SELECT 
    d.dept_name, AVG(s.salary) as average_salary
FROM
    departments d
        JOIN
    dept_manager dm ON d.dept_no = dm.dept_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no

GROUP BY dept_name;
-- having average salary > 100000

/** how many male and emale mangers are there **/ 
select e.gender, count(dm.emp_no) as nb_managers
from 
employees e 
join dept_manager dm on e.emp_no=dm.emp_no 
group by gender;

SELECT

    *

FROM

    (SELECT

        e.emp_no,

            e.first_name,

            e.last_name,

            NULL AS dept_no,

            NULL AS from_date

    FROM

        employees e

    WHERE

        last_name = 'Denis' UNION SELECT

        NULL AS emp_no,

            NULL AS first_name,

            NULL AS last_name,

            dm.dept_no,

            dm.from_date

    FROM

        dept_manager dm) as a

ORDER BY -a.emp_no DESC;

/** names of all managers in the company 
using subqueries **/
SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    e.emp_no IN (SELECT 
            dm.emp_no
        FROM
            dept_manager dm);
/** Extract the information about all department
 managers who were hired between the 1st of January 1990 and the 1st of January 1995. **/ 
SELECT 
    *
FROM
    dept_manager dm 
WHERE
    dm.emp_no IN (SELECT 
            e.emp_no
        FROM
            employees e
        WHERE
            e.hire_date BETWEEN '1990-01-01' AND '1995-01-01');
            
/** the entire information for all 
employees whose job title is “Assistant Engineer”. **/
SELECT 
    *
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            titles t
        WHERE
            e.emp_no = t.emmp_no
                AND t.title = 'Assistant engineer'); 
        
/** subqueries nsted in select and from :

assign emp_no 110022 as a manager to all emplyees from 10001 to 10020 
and emp_no 110039 as a manager to employees from 10021 to 10040**/ 
select A.* from 
(select e.emp_no as employee_id,de. dept_no as dept_code,
(select emp_no from dept_manager where 
emp_no= "110022") as manager_id from employees e 
join  dept_emp de on e.emp_no=de.emp_no
where e.emp_no between 10001 and 100020
group by e.emp_no) as A
union 
select B.* from 
(select emp_no as employee_id,
(select emp_no from dept_manager where 
emp_no= "110039") as manager_id from employees
where emp_no between 10001 and 100020) as B
;  



select A.* from 
/** subset A **/ 
(SELECT 
    e.emp_no AS employee_ID, min(de.dept_no) as dept_code,
    (SELECT 
            emp_no
        FROM
            dept_manager
        WHERE
            emp_no = 110022) AS manager_ID
FROM
    employees e
    join 
    dept_emp de 
    on e.emp_no = de.emp_no 

WHERE
    e.emp_no between 10001 and 10020
group by e.emp_no
ORDER BY e.emp_no) as A

/** subset B **/ 
UNION 
select B.* from 
(SELECT 
    e.emp_no AS employee_ID, min(de.dept_no) as dept_code,
    (SELECT 
            emp_no
        FROM
            dept_manager
        WHERE
            emp_no = 110039) AS manager_ID
FROM
    employees e
    join 
    dept_emp de 
    on e.emp_no = de.emp_no 

WHERE
    e.emp_no between 10021 and 10040
group by e.emp_no
ORDER BY e.emp_no) as B ; 

/** names of employees working as managers
using join  **/  
select first_name from employees e join 
dept_manager dm on e.emp_no= dm.emp_no;

/** names of employees working as managers
using subqueries **/  
select e.first_name from employees e 
where e.emp_no in (select dm.emp_no from dept_manager dm );

/** Extract the information about all department managers 
who were hired between the 1st of January 1990 and 
the 1st of January 1995. **/ 
SELECT 
    e.*
FROM
    employees e
WHERE
    e.emp_no IN (SELECT 
            dm.emp_no
        FROM
            dept_manager dm) and hire_date BETWEEN "1990-01-01" AND "1995-01-01";
    
/** Select the entire information for all employees 
whose job title is “Assistant Engineer”.  **/ 
-- using joins 
SELECT 
    e.*, t.title
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    t.title = 'Assistant engineer';

-- using subquery  with in 
select e.* from employees e where e.emp_no in 
(select t.emp_no from titles t where title = "assistant engineer" );
-- using subquery with exists 
SELECT 
    e.*
FROM
    employees e
WHERE
    EXISTS( SELECT 
            t.emp_no
        FROM
            titles t
        WHERE
            e.emp_no = t.emp_no
                AND title = 'assistant engineer'); 
/** subqueries in select **/ 
(SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_id,
            de.dept_no AS dept_code,
            (SELECT 
                    dm.emp_no
                FROM
                    dept_manager dm
                WHERE
                    dm.emp_no = 110022) AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON de.emp_no = e.emp_no
    WHERE
        e.emp_no BETWEEN 10001 AND 10020
    GROUP BY e.emp_no) AS A) 
    UNION (SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employee_id,
            de.dept_no AS dept_code,
            (SELECT 
                    dm.emp_no
                FROM
                    dept_manager dm
                WHERE
                    dm.emp_no = 110039) AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON de.emp_no = e.emp_no
    WHERE
        e.emp_no BETWEEN 10021 AND 10040
    GROUP BY e.emp_no) AS B)
    
; 
/**Starting your code with “DROP TABLE”, 
create a table called “emp_manager” (emp_no – integer of 11, 
not null; dept_no – CHAR of 4, null; 
manager_no – integer of 11, not null) **/ 

Drop table if exists emp_manager; 
create table if not exists emp_manager ( emp_no int(11) not null,
    dept_no char(4) null, manager_no int(11) not null); 
//*
Fill emp_manager with data about employees, the number of the department they are working in, and their managers.

Your query skeleton must be:

Insert INTO emp_manager SELECT

U.*

FROM

                 (A)

UNION (B) UNION (C) UNION (D) AS U;

A and B should be the same subsets used in the last lecture (SQL Subqueries Nested in SELECT and FROM). In other words, assign employee number 110022 as a manager to all employees from 10001 to 10020 (this must be subset A), and employee number 110039 as a manager to all employees from 10021 to 10040 (this must be subset B).

Use the structure of subset A to create subset C, where you must assign employee number 110039 as a manager to employee 110022.

Following the same logic, create subset D. Here you must do the opposite - assign employee 110022 as a manager to employee 110039.

Your output must contain 42 rows. 

 **/
insert into emp_manager
select U.* from 

(select A.*
from 
(SELECT 
        e.emp_no AS employee_id,
            de.dept_no AS dept_code,
            (SELECT 
                    dm.emp_no
                FROM
                    dept_manager dm
                WHERE
                    dm.emp_no = 110022) AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON de.emp_no = e.emp_no
    WHERE
        e.emp_no BETWEEN 10001 AND 10020
    GROUP BY e.emp_no) AS A
    union 
    
select B.* from 
    
(SELECT 
        e.emp_no AS employee_id,
            de.dept_no AS dept_code,
            (SELECT 
                    dm.emp_no
                FROM
                    dept_manager dm
                WHERE
                    dm.emp_no = 110039) AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON de.emp_no = e.emp_no
    WHERE
        e.emp_no BETWEEN 10021 AND 10040
    GROUP BY e.emp_no) AS B
    union 
    select C.* from 
(SELECT 
        e.emp_no AS employee_id,
            de.dept_no AS dept_code,
            (SELECT 
                    dm.emp_no
                FROM
                    dept_manager dm
                WHERE
                    dm.emp_no = 110039) AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON de.emp_no = e.emp_no
    WHERE
        e.emp_no=110022
    ) AS C 
    union 
select D.* from    
(SELECT 
        e.emp_no AS employee_id,
            de.dept_no AS dept_code,
            (SELECT 
                    dm.emp_no
                FROM
                    dept_manager dm
                WHERE
                    dm.emp_no = 110022) AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON de.emp_no = e.emp_no
    WHERE
        e.emp_no=110039
    ) AS D ) as U; 
/** self join
get employees who are managers as the same time 
 **/ 

select * from emp_manager;


SELECT 
    A.emp_no, B.manager_no
FROM
    emp_manager A
       JOIN
    emp_manager B ON A.emp_no = B.manager_no
    group by emp_no
    ;
    
/** views **/ 
/** employee numbers registered in the dept_em more than one **/ 
select * from dept_emp; 
select emp_no, count(emp_no) from dept_emp
group by emp_no
having count(emp_no)>1;
/** Create a view that will extract the average salary of all managers 
registered in the database. Round this value to the nearest cent. **/ 

 CREATE OR REPLACE VIEW v_manager_avg_salary AS
    SELECT 
        ROUND(AVG(s.salary), 2)
    FROM
        salaries s
            JOIN
        emp_manager em ON s.emp_no = em.emp_no;  
        
/** stored procedures **/ 

-- start by droping any existing procedure of the same name 
drop procedure if exists select_employees;  
-- create procedure to get all employees
delimiter $$ 
create procedure select_employees()
begin 
select * from employees
LIMIT 1000;
end $$
delimiter ; 
call select_employees;
-- create procedure for the average salary 
Drop procedure if exists average_salary;
delimiter $$ 
create procedure average_salary()
begin 
select avg(salary) from salaries; 
end $$
delimiter ; 
-- procedure with input parameter

/** create a procedure that takes emp_no as parameter  and returns details: first name last name and salary **/ 
drop procedure if exists employees_salaries; 
delimiter $$ 
create procedure employees_salaries( in employee_no integer)
begin 
	select e.first_name, e.last_name, s.salary
    from employees e 
    join salaries s
    on e.emp_no=s.emp_no
    where e.emp_no= employee_no;
end $$
delimiter ;

call employees_salaries(10001);

/** procedure for average salary that take emp nb as input **/

delimiter $$
create procedure average_salary_per_employee (in employee_nb int )
begin 
select e.emp_no, e.first_name, e.last_name, avg(s.salary) as average_salary  from employees e join 
salaries s on e.emp_no= s.emp_no
where e.emp_no=employee_nb
group by emp_no;
end $$
delimiter ;

-- procedure with output 
/** Create a procedure called ‘emp_info’ that uses as parameters the first 
and the last name of an individual, and returns their employee number. **/
drop procedure if exists emp_info;
delimiter $$ 
create procedure emp_info(in p_first varchar(255), in p_last varchar(255), out p_nb int) 
begin
select emp_no into p_nb from employees where 
first_name=p_first and last_name=p_last;
end $$ 
delimiter ; 
-- ----------------------------------------------------------------------------------
-- variables 
/** Create a variable, called ‘v_emp_no’, 
where you will store the output of the procedure you created in the last exercise.

Call the same procedure, inserting the values ‘Aruna’ and ‘Journel’ as a first and last name respectively.

Finally, select the obtained output. **/

SET @v_emp_no = 0;
CALL emp_info('Aruna', 'Journel', @v_emp_no);
SELECT @v_emp_no;
-- ---------------------------------------------------------------------------------
-- functions 
delimiter $$
create function f_emp_avg_salary( p_emp_no integer) returns decimal(10,2)
deterministic no sql 0reads sql data 
begin 
declare v_avg_salary decimal(10,2);
SELECT 
    AVG(s.salary)
INTO v_avg_salary FROM
    salaries s
WHERE
    s.emp_no = p_emp_no;
return  v-avg_salary; 
end $$ 
delimiter ; 

/** Create a function called ‘emp_info’ that takes for parameters 
the first and last name of an employee, and returns the salary from 
the newest contract of that employee.

Hint: In the BEGIN-END block of this program, you need to declare and
 use two variables – v_max_from_date that will be of the DATE type, and v_salary, 
 that will be of the DECIMAL (10,2) type.

Finally, select this function. **/

-- solution 
DELIMITER $$


CREATE FUNCTION emp_info(p_first_name varchar(255), p_last_name varchar(255)) RETURNS decimal(10,2)

DETERMINISTIC NO SQL READS SQL DATA

BEGIN


	DECLARE v_max_from_date date;


    DECLARE v_salary decimal(10,2);
SELECT

    s.salary

INTO v_salary FROM

    salaries s

        JOIN

    employees e  ON e.emp_no = s.emp_no
                                                                                                                                                              
WHERE

    e.first_name = p_first_name

        AND e.last_name = p_last_name

        AND s.from_date = v_max_from_date;

       

                RETURN v_salary;


END$$


DELIMITER ;
-- call function 
SELECT EMP_INFO('Aruna', 'Journel');
-- ----------------------------------------------------------------
-- global variables: max_connections and max_join_size 

set GLOBAL max_connections = 100;
-- -----------------------------------------------------------------------
-- triggers

/** create atrigger: check if hire date >currentdate 
if true hire date = current  (yy-mm-dd) **/

commit; 
delimiter $$ 
create trigger ch_hire_date
before insert on employees 
for each row 
begin 
if new.hire_date > sysdate() then 
set new.hire_date = date_format(sysdate(), "%d-%m-%y"); 
end if; 
end $$
delimiter ; 
/** check if it works **/ 
INSERT employees VALUES ('999904', '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01');   

SELECT  

    *  

FROM  

    employees

ORDER BY emp_no DESC; 


