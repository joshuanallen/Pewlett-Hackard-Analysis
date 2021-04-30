-- Deliverable 1: The Number of Retiring Employees by Title

-- 1. Retrieve the emp_no, first_name, and last_name columns from the Employees table.
SELECT e.emp_no,
	e.first_name,
	e.last_name,
-- 2. Retrieve the title, from_date, and to_date columns from the Titles table.
	tl.title,
	tl.from_date,
	tl.to_date

-- 3. Create a new table using the INTO clause.
INTO retirement_titles

-- 4. Join both tables on the primary key.
FROM employees AS e
LEFT JOIN titles AS tl
ON e.emp_no = tl.emp_no

-- 5. Filter the data on the birth_date column to retrieve the employees
-- who were born between 1952 and 1955. Then, order by the employee number.
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

-- 6. Export Retirement titles table - done
-- 7. Confirm looks like sample table - done



-- 8. Copy query from starter code
-- 9. Retrieve the employee number, first and last name, and title columns from the Retirement Titles table.
		-- These columns will be in the new table that will hold the most recent title of each employee.
-- 10. Use the DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title

-- 11. Create a Unique Titles table using the INTO clause.
INTO unique_titles

FROM retirement_titles AS rt

-- 12. Sort the Unique Titles table in ascending order by the employee number and descending order by the last date (i.e. to_date) of the most recent title.
ORDER BY rt.emp_no, rt.to_date DESC;

-- 13. Export unique_titles table as csv - done
-- 14. confirm with sample table - done



-- 15. Write another query in the Employee_Database_challenge.sql file to retrieve the number of employees by their most recent job title who are about to retire.
-- 16. First, retrieve the number of titles from the Unique Titles table.
SELECT COUNT(ut.emp_no), ut.title

-- 17. Then, create a Retiring Titles table to hold the required information.
INTO retiring_titles

FROM unique_titles AS ut

-- 18. Group the table by title, then sort the count column in descending order.
GROUP BY ut.title
-- Resource: https://learnsql.com/cookbook/how-to-order-by-count-in-sql/
ORDER BY COUNT(ut.emp_no) DESC;

-- 19. Export retiring_titles table - done
-- 20. Confirm with sample image - done
-- 21. Save query file - done


-- Deliverable 2: The Employees Eligible for the Mentorship Program
-- Write a query to create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program

-- 1. Retrieve the emp_no, first_name, last_name, and birth_date columns from the Employees table.
-- 2. Retrieve the from_date and to_date columns from the Department Employee table.
-- 3. Retrieve the title column from the Titles table.
-- 4. Use a DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.
SELECT DISTINCT ON(e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	tt.title

-- 5. Create a new table using the INTO clause
INTO mentorship_eligibilty

FROM employees AS e

-- 6. Join the Employees and the Department Employee tables on the primary key.
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)

-- 7. Join the Employees and the Titles tables on the primary key.
INNER JOIN titles AS tt
ON (e.emp_no = tt.emp_no)

-- 8. Filter the data on the to_date column to all the current employees, 
-- then filter the data on the birth_date columns to get all the employees whose birth dates are between January 1, 1965 and December 31, 1965.
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')

-- 9. Order the table by the employee number.
ORDER BY e.emp_no;

-- 10. Export mentorship_eligibilty table
-- 11. Confirm with sample image - done **Error in module sample image for emp_no 10291. Title should be Senior Staff.
