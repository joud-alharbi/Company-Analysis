select * from [dbo].[Employees$]
select * from [dbo].[departments$]
select * from [dbo].[dept_emp$]
select * from [dbo].[dept_manager$]
select * from [dbo].[employee_titles$]
select * from [dbo].[salaries$]

--1. Retrieve the first name and last name of all employees.
select first_name,last_name from Employees$


--2. Find the department numbers and names.
select dep_no,dep_name from [dbo].[departments$]


--3. Get the total number of employees.
select COUNT(DISTINCT emp_no)  as TotalEmployees from Employees$ 


--4. Find the average salary of all employees.
select avg(salary) as AverageSalary from salaries$


--26. Get the total number of employees who have held the title "Senior Manager."
select count(emp_no) as SeniorManagersCount from employee_titles$ where title='Senior Manager';


--29. Retrieve the employee number, first name, last name, and title of employees whose hire date is between '2005-01-01' and '2006-01-01'.
select Employees$.emp_no,first_name,last_name,title,from_date from Employees$
join employee_titles$ on Employees$.emp_no=employee_titles$.emp_no
where from_date between '2005-01-01' and '2006-01-01';


--30. Get the department number, name, and the oldest employee's birth date for each department.

SELECT d.dep_no,d.dep_name, 
 MIN(e.birth_date) AS oldest_employee_birth_date
FROM  
departments$ d JOIN  dept_emp$ ed
ON d.dep_no = ed.dept_no
JOIN  Employees$ e ON ed.emp_no = e.emp_no
GROUP BY  d.dep_no, d.dep_name;


--23. Retrieve the employee number, first name, last name, and department name of employees who are currently working in the Finance department.
SELECT 
   DISTINCT e.emp_no, 
    e.first_name, 
    e.last_name, 
    d.dep_name
FROM 
    Employees$ e
JOIN 
    dept_emp$ de ON e.emp_no = de.emp_no
JOIN 
    departments$ d ON de.dept_no = d.dep_no
WHERE 
    d.dep_name = 'Finance'
 AND (de.from_date <= GETDATE() AND (de.to_date IS NULL OR de.to_date >= GETDATE()));


-- 21. Retrieve the employee number, first name, last name, and salary of employees hired before the year 2005.
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    s.salary,
    e.hire_date
FROM 
    Employees$ e
JOIN 
    salaries$ s ON e.emp_no = s.emp_no
WHERE 
    e.hire_date < '2005-01-01';


--27. Retrieve the department number, name, and the number of employees who have worked there for more than 5 years.
	SELECT 
    d.dep_no, 
    d.dep_name, 
    COUNT(*) AS num_employees
FROM 
    departments$ d
JOIN 
    dept_emp$ de ON d.dep_no = de.dept_no
JOIN 
    Employees$ e ON de.emp_no = e.emp_no
WHERE 
    DATEDIFF(YEAR, e.hire_date, GETDATE()) > 5
GROUP BY 
    d.dep_no, 
    d.dep_name;

