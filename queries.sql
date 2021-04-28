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