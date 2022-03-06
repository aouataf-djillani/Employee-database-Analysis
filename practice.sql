select * FROM employees
where first_name like ("%jack%");


select * from employees
where first_name not like ("%jack%");

select * from salaries
where salary between 66000 and 70000;

select * from salaries 
where emp_no between "10004" and "10012";

select dept_name from departments
where dept_no between "d003" and "d006";

select * from employees where first_name is not null; 

select * from employees where first_name is null; 
select  dept_name from departments
where dept_no is not null;

/** list of emloyees hired after the 1st of january **/
select * from employees
where hire_date > "2000-01-01";

select * from employees
where gender= "F" and hire_date>="2000-01-01";

select * from salaries 
where salary>150000;
select distinct gender from employees;
/** Obtain a list with all different “hire dates” from the “employees” table. **/
select distinct hire_date from employees;
/** the nb of employees in the database **/

select count(emp_no) from employees; 

/** nb of all names***/
select count(last_name) as frequency from employees; 
/** nb of different distinct names***/
select count(distinct last_name) from employees;

/**How many annual contracts with a value higher than or equal to $100,000 have been registered in the salaries table?**/

select count(emp_no) from salaries where salary >= "100000";
/**How many managers do we have in the “employees” database?**/
select count(*) from dept_manager;

/** order by first name **/ 
select * FROM employees ORDER BY first_name DESC; 
/** order by first name and last name i.e order the employees sharing same irst name bu last name   **/ 
select * FROM employees ORDER BY first_name, last_name ; 

-- Select all data from the “employees” table, ordering it by “hire date” in descending order.
select * from employees order by hire_date DESC;
-- describe table 
DESCRIBE employees; 

-- get distinct names and the number of times they oppear frequency 
select first_name, count(first_name) as frequency from employees group by first_name order by first_name DESC;

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