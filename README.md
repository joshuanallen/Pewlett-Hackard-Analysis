# Employee Retirement analysis using SQL

## Project Overview
Pewlett Hackard has requested an analysis of their current aging workforce to prepare for their pending "silver tsunami". They've requested the following data:
1. Identify the number of retiring employees per title
2. Identify employees eligible for the mentorship program

## Resources
- Data Sources: departments.csv, dept_emp.csv, dept_info.csv, dept_manager.csv, emp_info.csv, employees.csv, manager_info.csv, mentorship_eligibility.csv, retirement_info.csv, retirement_titles.csv, salaries.csv, titles.csv, unique_titles.csv
- Software: pgAdmin 4, PostgreSQL 11, Visual Studio Code 1.54.3

## Summary
Given the above data sources we built an ERD to associate the data shown below in Picture 1.1.

**Picture 1.1 Hewlett Packard employee data ERD**
![Hewlett Packard employee data ERD](https://github.com/joshuanallen/Pewlett-Hackard-Analysis/blob/ec1d332f3a50d1c66e31250ceb541358116021ee/schema/Employees_DB.png)

Using the employee data in employees.csv data we extracted those employees born between January 1, 1952 and December 31, 1955. That data was then passed into a new table for analysis (`retirement_titles.csv`) to identify the employees most recent position as the first query did not account for employees changing roles throughout their tenure at Pewlett Hackard. Additionally, we grouped the qualifying retiring employees into their respective job titles. 

### Results
The results from the retirement age queries are below:
1. Our first query identified **133,777 database entries within employees.csv** for those employees **born from 1/1/52-12/31/55**
2. Using the SQL `DISTINCT ON()` function, we eliminated duplicate entries produced by the first query to get a true count of retiring employees, which resulted in a total of **90,398 eligible employees** in the `unique_titles.csv` table.
3. Grouping the 90,398 retirement-eligible employees by job title resulted in the `retiring_titles.csv` table shown in Picture 1.2.

**Picture 1.2 Retirement-eligible Pewlett Hackard employees by job title**
![Retirement-eligible Pewlett Hackard employees by job title](https://github.com/joshuanallen/Pewlett-Hackard-Analysis/blob/ec1d332f3a50d1c66e31250ceb541358116021ee/Queries/Retirement_eligibility_by_title.png)

Pewlett Hackard HR department requested a list of employees eligible for their mentoring program. The eligibility parameters are as follows: employee must be currently employed at PH and born in 1965. 

4. The resulting query generated a list of **1,549 eligible mentorship employees** into the `mentorship_eligibility.csv`

### Additional Analysis
In addition to the above queries about employees eligible for retirement and the mentorship progran, we wanted to provide more insight into the effect of these actions.

#### Budget released for new hires if all employees born 1952-1955 retire
1. The total annual salaries of the 90,398 retirement-eligible employees in `unique_titles.csv` is **$4,782,884,264**.
    - Picture 1.3 below shows the retiring annual salaries by their most recent job title to show where salary budgets will be freed for hiring.

**Picture 1.3 Sum of salaries for retirement-age employees by title**
![Sum of salaries for retirement-age employees by title](https://github.com/joshuanallen/Pewlett-Hackard-Analysis/blob/ec1d332f3a50d1c66e31250ceb541358116021ee/Queries/retiring_salaries_by_title.png)

#### Expansion of mentorship program eligibilty from employees born in 1965 to 1964-1966
2. If the parameters for qualifying for the mentorship program are expanded one year in each direction, **the pool of eligible employees skyrockets from only 1,549 to 19,905**. This would make the progam large enough to replace part of the "silver tsunami." Results are shown in the `mentorship_eligibility_expanded` table.

## Conclusions
Pewlett Hackard is indeed heading into a "silver tsunami" for their aging workforce. With 90,398 out of 300,024 employees being born in 1952-1955 they are poised for a significant amount of their workforce retiring soon. Additionally, only a small number (1,549) of employees qualify for their mentorship program, which is only 2% of the workforce at retirement age leaving a large gap in managerial experience.

### Recommended Improvements
The initial anaylsis can be improved by identifying those employees within the employees.csv database still employed at PH by using the `current_employees` table instead of `employees` table.

Additionally, it should be recommended to expand eligibility requirements for the mentorship program as the current parameters are too limiting to fulfill the potential need.

Further queries can include breaking down the mentorship eligibile employees by department to identify departments where the eligiblity parameters need to be further altered to meet the upcoming needs.
