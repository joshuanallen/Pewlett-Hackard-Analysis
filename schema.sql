-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

-- Break down the three main components of our CREATE TABLE statement.
-- 1. CREATE TABLE is the syntax required to create a new table in SQL.
-- 2. departments is the name of the table and how it will be referenced in queries.
-- So the table has been named, now the structure needs to be created. The content inside the parentheses is how we'll do that.
-- 3. dept_no VARCHAR(4) NOT NULL, creates a column named "dept_no" that can hold up to four varying characters, while NOT NULL
-- tells SQL that no null fields will be allowed when importing data.
-- There are times when we don't want a data field to be null. For example, the dept_no column is our primary key—each row has
-- a unique number associated with it. If we didn't have the NOT NULL constraint, then there's a chance that a row (or more than
-- one row) won't have a primary key associated with the data.
-- 4. dept_name VARCHAR(40) NOT NULL, creates a column similar to the dept_no, only the varying character count has a maximum of 40.
-- 5. PRIMARY KEY (dept_no), means that the dept_no column is used as the primary key for this table.
-- 6. UNIQUE (dept_name) adds the unique constraint to the dept_name column.

-- https://stackoverflow.com/questions/4448340/postgresql-duplicate-key-violates-unique-constraint
-- SELECT MAX(emp_no) FROM employees;

-- SELECT nextval('the_primary_key_sequence');
-- SELECT setval('the_primary_key_sequence', (SELECT MAX(the_primary_key) FROM the_table)+1);


CREATE TABLE employees (
	emp_no INT NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	Primary Key (emp_no)
);



CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

-- Remember that foreign keys reference the primary key of other tables. In the two lines above we can see that:
-- The FOREIGN KEY constraint tells Postgres that there is a link between two tables
-- The parentheses following FOREIGN KEY specify which of the current table's columns is linked to another table
-- REFERENCES table_name (column_name) tells Postgres which other table uses that column as a primary key


CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);


CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	from_date DATE NOT NULL,
    to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	FOREIGN KEY (emp_no) REFERENCES salaries (emp_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
    to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no, title, from_date)
);

-- test tables to ensure they're built correctly
-- SELECT * FROM titles;

-- The SELECT statement tells Postgres that we're about to query the database.
-- The asterisk tells Postgres that we're looking for every column in a table.
-- FROM departments tells pgAdmin which table to search.
-- The semicolon signifies the completion of the query.


-- DROP TABLE titles CASCADE;