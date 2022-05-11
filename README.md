# Analyzing the employees database
## Steps
 1.  Querying and exploring data using MySQL
 2. Exporting data and Visualizing it using Tableau  
## Dataset 
The sample employee database used in this project was crfeated  through the SQL - MySQL for Data Analytics and Business Intelligence course online. 

It contains information about employees, departments, salaries, job titles...etc 
 ![employeedb](https://user-images.githubusercontent.com/54501663/167905131-ad14a6da-8f69-4180-8c1a-e5344e87c0be.png)

## Sample queries


1. Find the average salary of the male and female
 employees in each department. 

```sql
SELECT 
    e.gender, AVG(s.salary)
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY e.gender; 
```

2.  Retrieve a list of all employees from the ‘titles’
 table who are engineers.

```sql
SELECT 
    *
FROM
    titles
WHERE
    title LIKE ('%engineer%');
```
3. A procedure that takes an employee number as a parameter and outputs the same number, as well as the number and name of the last department the employee has worked in.

```sql
delimiter $ 
create procedure working_dept (in p_emp_no int) 
begin 
SELECT 
    de.emp_no, de.dept_no, d.dept_name
FROM
    dept_emp de
        JOIN
    departments d ON de.dept_no = d.dept_no
WHERE
    de.emp_no = p_emp_no
AND de.from_date=(SELECT 
    MAX(from_date)
FROM
    dept_emp
WHERE
    emp_no = p_emp_no);
END $$
delimiter ; 
```

4. A trigger that checks if the hire date of an employee is higher than the current date and set the
hire date to equal the current date in that case. 

```sql
delimiter $
create trigger hire_date
before insert on employees
for each row 
begin 
if new.hire_date> curdate() then 
set new.hire_date =dateformat(curdate(), "%y-%m-%d");
end if; 
end $$
delimiter ;
```
5. A function that retrieves the highest salary of an employee. Apply it to employee
number 11356.

```sql
delimiter $ 
create function f_max_salary(p_emp_no int) returns INT
deterministic
begin 
declare v_highest int; 
select max(salary) into v_highest  from salaries
 where emp_no = p_emp_no
group by emp_no; 
return v_highest; 
end $$
delimiter ;
```

6. A list of employees who are managers as the same time 
```sql
SELECT 
    A.emp_no, B.manager_no
FROM
    emp_manager A
        JOIN
    emp_manager B ON A.emp_no = B.manager_no
GROUP BY emp_no
;
```
7. Assigning emp_no 110022 as a manager to all emplyees from 10001 to 10020  and emp_no 110039 as a manager to employees from 10021 to 10040
```sql
SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS dept_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no BETWEEN 10001 AND 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A 
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS dept_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no BETWEEN 10021 AND 10040
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS B; 
```
12. A function that takes as parameters the first and last name of an employee, and returns the salary from 
the newest contract of that employee.
```sql
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
```
