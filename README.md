# SQL_FOR_DATA_ANALYTICS
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
2. Obtain a table containing the following three fields for all individuals whose employee number is not
greater than 10040:
- employee number
- the lowest department number among the departments where the employee has worked in (Hint: use
a subquery to retrieve this value from the 'dept_emp' table)
- assign '110022' as 'manager' to all individuals whose employee number is lower than or equal to 10020,
and '110039' to those whose number is between 10021 and 10040 inclusive.
```sql
SELECT 
    emp_no,
    MIN(dept_no),
    CASE
        WHEN emp_no <= 10020 THEN 110022
        WHEN emp_no BETWEEN 10021 AND 10040 THEN 110039
    END AS manager
FROM
    dept_emp
GROUP BY emp_no
HAVING emp_no <= 10040; 
```

3.  Retrieve a list of all employees from the ‘titles’
 table who are engineers.

```sql
SELECT 
    *
FROM
    titles
WHERE
    title LIKE ('%engineer%');
```
4. Create a procedure that asks you to insert an employee number and that will obtain an output containing
the same number, as well as the number and name of the last department the employee has worked in.

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

5. Create a trigger that checks if the hire date of an employee is higher than the current date. If true, set the
hire date to equal the current date. Format the output appropriately (YY-mm-dd).

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
6. Define a function that retrieves the largest contract salary value of an employee. Apply it to employee
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

7. Based on the previous exercise, you can now try to create a third function that also accepts a second
parameter. Let this parameter be a character sequence. Evaluate if its value is 'min' or 'max' and based on
that retrieve either the lowest or the highest salary, respectively (using the same logic and code structure
from Exercise 9). If the inserted value is any string value different from ‘min’ or ‘max’, let the function
return the difference between the highest and the lowest salary of that employee

```sql
delimiter $ 
create function f_evaluate_salary(p_emp_no int, p_value varchar(255) ) returns INT
deterministic
begin 

declare v_result int; 
select case
 when p_value = "max" then max(salary)
 when p_value = "min" then min(salary)
 else max(salary) - min(salary)
 end 

into v_result  from salaries
 where emp_no = p_emp_no 
group by emp_no;
return v_result;
end $$
delimiter ;
```

8. a list of names encountered less than 200 times of people hired after jan 1st 1999
```sql
select first_name, count(first_name) as frequency from employees
where hire_date >"1999-01-01"
group by first_name
having frequency<200 
order by frequency DESC ;
```
9. Select the first and last name, the hire date, and the job title of all employees whose first name is  “Margareta” and have the last name “Markovitch”.
```sql
SELECT 
    t1.first_name, t1.last_name, t1.hire_date, t2.title
FROM
    employees t1
        JOIN
    titles t2 ON t1.emp_no = t2.emp_no
WHERE
    first_name = 'Margareta'
        AND last_name = 'Markovitch';
```
10. get a list of employees who are managers as the same time 
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
11. assign emp_no 110022 as a manager to all emplyees from 10001 to 10020  and emp_no 110039 as a manager to employees from 10021 to 10040
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
12. Create a function called ‘emp_info’ that takes for parameters 
the first and last name of an employee, and returns the salary from 
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
