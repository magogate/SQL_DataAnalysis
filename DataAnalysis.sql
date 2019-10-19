/*
1
List the following details of each employee: 
employee number, last name, first name, gender, and salary.

-- There are no duplicate emp_no in salaries table
select sal.emp_no
, count(*)
from salaries sal
group by sal.emp_no
having count(*) > 1
*/

select emp.emp_no
, emp.last_name
, emp.first_name
, emp.gender
, sal.salary
from employees emp
join salaries sal
	on emp.emp_no = sal.emp_no;
	
/*
2
List employees who were hired in 1986.
https://www.postgresql.org/docs/8.0/functions-datetime.html
*/

select *
from employees emp
where 1=1
and extract(year from emp.hire_date) = '1986'


/*
3
List the manager of each department with the following information:
department number, department name, 
the manager's employee number, last name, first name, 
and start and end employment dates.
*/

select depMgr.dept_no
, dep.dept_name
, emp.emp_no as Mgr_Emp_No
, emp.last_name as Mgr_Last_Name
, emp.first_name as Mgr_First_Name
, depMgr.from_date
, depMgr.to_date
from dept_manager depMgr
join departments dep
	on dep.dept_no = depMgr.dept_no
join employees emp
	on emp.emp_no = depMgr.emp_no
	
/*
4
List the department of each employee with the following information
: employee number, last name, first name, and department name
*/

select emp.emp_no
, emp.last_name
, emp.first_name
, dep.dept_name
from dept_emp deptEmp
join employees emp
	on emp.emp_no = deptEmp.emp_no
join departments dep
	on dep.dept_no = deptEmp.dept_no
	
/*
5
List all employees whose first name is "Hercules" 
and last names begin with "B."
*/

select *
from employees emp
where 1=1
and emp.first_name = 'Hercules'
and emp.last_name like 'B%'

/*
6
List all employees in the Sales department,
including their employee number, last name, first name, and department name.
*/

select emp.emp_no
, emp.last_name
, emp.first_name
, dep.dept_name
from dept_emp deptemp
join employees emp
	on emp.emp_no = deptemp.emp_no
join departments dep
	on deptemp.dept_no = dep.dept_no
	and dep.dept_name = 'Sales'

/*
7
List all employees in the Sales and Development departments
, including their employee number, last name, first name, and department name.
*/

select emp.emp_no
, emp.last_name
, emp.first_name
, dep.dept_name
from dept_emp deptemp
join employees emp
	on emp.emp_no = deptemp.emp_no
join departments dep
	on deptemp.dept_no = dep.dept_no
	and dep.dept_name in ('Sales','Development')


/*
8
In descending order, list the frequency count of employee last names
, i.e., how many employees share each last name.
*/

select last_name
, count(*) frequencyCount
from employees emp
group by last_name
order by 2 desc

/*
Extra - Avg salary by title
*/

select title.title
, round(avg(sal.salary),2) avgSalary
from salaries sal
	join titles title
	on sal.emp_no = title.emp_no
group by title.title
order by 2 desc
