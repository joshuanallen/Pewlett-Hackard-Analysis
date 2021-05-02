SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- At a glance, we can tell we're searching for the first and last names of employees born between January 1, 1952, and December 31, 1955. 
-- Let's break the code down into its components, though, so we can really understand what it's doing:

-- 1. The SELECT statement is more specific this time. Instead of an asterisk to indicate that we want all of the records, 
-- we're requesting only the first and last names of the employees.
-- 2. FROM employees tells SQL in which of the six tables to look.
-- 3. The WHERE clause brings up even more specifics. We want SQL to look in the birth_date column for anyone born between January 1, 1952,
-- and December 31, 1955.


-- Isolate employees born in 1952

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

-- Skill Drill 7.3.1
-- Create 3 queries searching for employees born in 1953, 1954, 1955:

-- 1953
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

-- 1954
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

-- 1955
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Find employees born in 1952-1955 AND hired between 1985-1988
-- Use () Tuple format for syntax: They basically place each condition in a group,
-- and Postgres looks for the first group first, then looks inside the second group to deliver the second condition

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Count above results using COUNT function
-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Create New Tables for exporting new datasets
SELECT first_name, last_name
-- new table created (retirement_info)
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- look at newly created table
SELECT * FROM retirement_info;


-- To separate retiring employees by department we'll need to join the employees table with the dept_emp table through the emp_no column

-- First need to remove created table to add column for emp_no so other tables can be joined
DROP TABLE retirement_info;

-- Recreate retirement_info table
-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;


-- Use Inner Join for Departments and dept-manager Tables

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;
-- This code tells Postgres the following:
-- The SELECT statement selects only the columns we want to view from each table.
-- The FROM statement points to the first table to be joined, Departments (Table 1).
-- INNER JOIN points to the second table to be joined, dept_manager (Table 2).
-- ON departments.dept_no = managers.dept_no; indicates where Postgres should look for matches.


--  Use Left Join to Capture retirement-info Table

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
	retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
-- This time, use a LEFT JOIN to include every row of the first table (retirement_info). This also tells Postgres which table is second, or on the right side (dept_emp).
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;


-- Use Aliases for Code Readability
-- Refactored above code for aliasing
-- Joining retirement_info and dept_emp tables
SELECT ri.emp_no,
    ri.first_name,
	ri.last_name,
    de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;


-- Updated INNER JOIN code above with aliasing

-- Using the same alias method and syntax as before, rename departments to "d" and dept_manager to "dm."
-- Joining departments and dept_manager tables
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments AS d
INNER JOIN dept_manager AS dm
ON d.dept_no = dm.dept_no;


-- Use Left Join for retirement_info and dept_emp tables

-- Now that we have a list of all retirement-eligible employees, it's important to make sure that they are actually still employed with PH.
-- To do so, we're going to perform another join, this time between the retirement_info and dept_emp tables.
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
	de.to_date
-- create new table of current employees
INTO current_emp
-- add JOIN statement with aliases
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
-- Add filter condition for those currently working (to_date = 9999-01-01)
WHERE de.to_date = ('9999-01-01');


-- Use Count, Group By, and Order By

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;
-- A few things to note:
-- The COUNT function was used on the employee numbers.
-- Aliases were assigned to both tables.
-- GROUP BY was added to the SELECT statement.

-- We added COUNT() to the SELECT statement because we wanted a total number of employees. 
-- We couldn't actually use the SUM() function because the employee numbers would simply be added, which would leave us with one really large and useless number.

-- Bobby's boss asked for a list of how many employees per department were leaving, 
--  so the only columns we really needed for this list were the employee number and the department number.

-- We used a LEFT JOIN in this query because we wanted all employee numbers from Table 1 to be included in the returned data. 
-- Also, if any employee numbers weren't assigned a department number, that would be made apparent.

-- The ON portion of the query tells Postgres which columns we're using to match the data. 
-- Both tables have an emp_no column, so we're using that to match the records from both tables.

-- ORDER BY does exactly as it reads: It puts the data output in order for us.
-- GROUP BY is the magic clause that gives us the number of employees retiring from each department.


-- Skill Drill 7.3.4
-- Update the above code block to create a new table, then export it as a CSV.
-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO current_emp_dept_count
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- check data before exporting
SELECT * FROM current_emp_dept_count;


-- Generate more lists

-- List 1: Employee Information
-- A list of employees containing their unique employee number, their last name, first name, gender, and salary
SELECT e.emp_no,
    e.first_name,
	e.last_name,
    e.gender,
    s.salary,
    de.to_date
INTO emp_info
-- First join
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
-- Second join
-- Resource: https://www.postgresqltutorial.com/postgresql-inner-join/
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
-- Apply Filters
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');


-- List 2: Management
-- A list of managers for each department, including the department number, name, and the manager's employee number, last name, first name, and the starting and ending employment dates
-- We can see that the information we need is in three tables: Departments, Managers, and Employees. Remember, we're still using our filtered Employees table, current_emp, for this query.
-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);


-- List 3: Department Retirees
-- An updated current_emp list that includes everything it currently has, but also the employee's departments
-- The final list needs only to have the departments added to the current_emp table.
SELECT ce.emp_no,
	   ce.first_name,
	   ce.last_name,
	   d.dept_name
-- INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

-- Create a Tailored List
-- Skill Drill 7.3.6a
-- Create a query that will return only the information relevant to the Sales team. The requested list includes:
-- Employee numbers
-- Employee first name
-- Employee last name
-- Employee department name
SELECT ce.emp_no,
	   ce.first_name,
	   ce.last_name,
	   d.dept_name
-- INTO sales_dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
-- Apply Filters
WHERE d.dept_name = 'Sales';


-- Skill Drill 7.3.6b
SELECT ce.emp_no,
	   ce.first_name,
	   ce.last_name,
	   d.dept_name
-- INTO sales_dev_dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
-- Apply Filters
-- IN function can replace mulitple OR conditions
-- Resource: https://www.techonthenet.com/postgresql/in.php
WHERE d.dept_name IN ('Sales', 'Development');


SELECT COUNT(emp_no) 
FROM employees;
