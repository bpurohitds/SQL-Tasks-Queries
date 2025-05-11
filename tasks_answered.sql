select * from EMPLOYEE;
select * from LOCATION;
select * from DEPARTMENT;   
select * from JOB;


--Simple Queries:--

----1. List all the employee details.----

SELECT * FROM EMPLOYEE;

---2. List all the department details.----

SELECT * FROM DEPARTMENT;

----3. List all job details.-----

SELECT * FROM JOB;

----4. List all the locations.----

SELECT * FROM LOCATION;

----5. List out the First Name, Last Name, Salary, Commission for all Employees.---
SELECT FIRST_NAME,LAST_NAME,SALARY,COMM FROM EMPLOYEE;

----6. List out the Employee ID, Last Name, Department ID for all employees--
--and alias Employee ID as "ID of the Employee", Last Name as "Name of the Employee", Department ID as "Dep_id".---

SELECT EMPLOYEE_ID AS ID, LAST_NAME AS Name_of_the_Employee, DEPARTMENT_ID AS Dep_id
FROM EMPLOYEE;

---7. List out the annual salary of the employees with their names only.---

SELECT CONCAT(FIRST_NAME, ' ', MIDDLE_NAME, ' ', LAST_NAME) AS NAME, (SALARY * 12) AS Annual_Salary FROM EMPLOYEE;

---WHERE Condition:--

---1. List the details about "Smith".---

SELECT * FROM EMPLOYEE WHERE 'Smith' IN (FIRST_NAME, MIDDLE_NAME, LAST_NAME);

--OR--

SELECT * FROM EMPLOYEE WHERE FIRST_NAME = 'Smith' OR MIDDLE_NAME = 'Smith' OR LAST_NAME='Smith';

---2. List out the employees who are working in department 20.---

SELECT * FROM EMPLOYEE WHERE DEPARTMENT_ID=20;

----3. List out the employees who are earning salaries between 3000 and 4500.---

SELECT * FROM EMPLOYEE WHERE SALARY BETWEEN 3000 AND 4500;

----4. List out the employees who are working in department 10 or 20.---

SELECT * FROM EMPLOYEE WHERE DEPARTMENT_ID = 10 OR DEPARTMENT_ID = 20;

---5. Find out the employees who are not working in department 10 or 30.---

SELECT * FROM EMPLOYEE WHERE DEPARTMENT_ID NOT IN (10,30);

---6. List out the employees whose name starts with 'S'.---

SELECT * FROM EMPLOYEE WHERE FIRST_NAME LIKE 'S%'

---7. List out the employees whose name starts with 'S' and ends with 'H'.---

SELECT * FROM EMPLOYEE WHERE FIRST_NAME LIKE 'S%H';

---8. List out the employees whose name length is 4 and start with 'S'.---

SELECT * FROM EMPLOYEE WHERE LEN(FIRST_NAME) = 4 AND FIRST_NAME LIKE 'S%'

---9. List out employees who are working in department 10 and draw salaries more than 3500.---

SELECT * FROM EMPLOYEE WHERE DEPARTMENT_ID=10 AND SALARY >3500;

---10. List out the employees who are not receiving commission.---

SELECT * FROM EMPLOYEE WHERE COMM IS NULL;


--ORDER BY Clause:--

---1. List out the Employee ID and Last Name in ascending order based on the Employee ID.---

SELECT EMPLOYEE_ID, LAST_NAME FROM EMPLOYEE ORDER BY EMPLOYEE_ID;

----2. List out the Employee ID and Name in descending order based on salary.---

SELECT EMPLOYEE_ID, FIRST_NAME, MIDDLE_NAME, LAST_NAME,SALARY FROM EMPLOYEE ORDER BY SALARY DESC;

---3. List out the employee details according to their Last Name in ascending-order.---

SELECT * FROM EMPLOYEE ORDER BY LAST_NAME;

---4. List out the employee details according to their Last Name in ascending order and then Department ID in descending order.--

SELECT * FROM EMPLOYEE ORDER BY LAST_NAME ASC, DEPARTMENT_ID DESC; 

--GROUP BY and HAVING Clause:--

---1. How many employees are in different departments in the organization?---

SELECT DEPARTMENT_ID, COUNT(EMPLOYEE_ID) EMPLOYEE_COUNT FROM EMPLOYEE GROUP BY DEPARTMENT_ID;

----2. List out the department wise maximum salary, minimum salary and average salary of the employees.---

SELECT DEP.NAME AS Department, MAX(SALARY) AS MAX_Salary, MIN(SALARY) as MIN_Salary, AVG(SALARY) AS AVG_Salary 
FROM EMPLOYEE EMP INNER JOIN DEPARTMENT DEP ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID GROUP BY EMP.DEPARTMENT_ID, DEP.NAME;

---3. List out the job wise maximum salary, minimum salary and average salary of the employees.---

SELECT JOB.Designation, MAX(SALARY) Max_Salary, MIN(SALARY) Min_Salary, AVG(SALARY) Avg_Salary 
FROM EMPLOYEE EMP INNER JOIN JOB ON EMP.JOB_ID=JOB.JOB_ID
GROUP BY JOB.Designation;

---4. List out the number of employees who joined each month in ascending order.---

SELECT DATENAME(month, hire_date) AS Month,
       COUNT(EMPLOYEE_ID) AS No_Of_Employees
FROM EMPLOYEE
GROUP BY DATENAME(month, hire_date)
ORDER BY DATENAME(month, hire_date) ASC;

---5. List out the number of employees for each month and year in ascending order based on the year and month.--

SELECT YEAR(hire_date) AS Year,
       MONTH(hire_date) AS Month,
       COUNT(EMPLOYEE_ID) AS No_Of_Employees
FROM EMPLOYEE
GROUP BY YEAR(hire_date), MONTH(hire_date)
ORDER BY YEAR(hire_date), MONTH(hire_date) ASC;

---6. List out the Department ID having at least four employees.---

SELECT DEPARTMENT_ID, COUNT(EMPLOYEE_ID) 
FROM EMPLOYEE 
GROUP BY DEPARTMENT_ID 
HAVING COUNT(EMPLOYEE_ID) >=4;

----7. How many employees joined in the month of January?---

SELECT HIRE_DATE, COUNT(EMPLOYEE_ID) EMPLOYEE_JOINED 
FROM EMPLOYEE 
GROUP BY HIRE_DATE 
HAVING MONTH(HIRE_DATE)=1;

--8. How many employees joined in the month of January or September?--

SELECT COUNT(EMPLOYEE_ID) AS EMPLOYEE_JOINED 
FROM EMPLOYEE 
GROUP BY HIRE_DATE 
HAVING MONTH(HIRE_DATE) in (1,9);

---9. How many employees joined in 1985?---

SELECT COUNT(EMPLOYEE_ID) AS EMPLOYEE_JOINED 
FROM EMPLOYEE 
WHERE YEAR(HIRE_DATE) = 1985;

---10. How many employees joined each month in 1985?---

SELECT DATENAME(MONTH, HIRE_DATE) AS MONTH, COUNT(EMPLOYEE_ID) AS EMPLOYEE_JOINED
FROM EMPLOYEE
GROUP BY HIRE_DATE
HAVING YEAR(HIRE_DATE) = 1985;

---11. How many employees joined in March 1985?---

SELECT COUNT(EMPLOYEE_ID) AS EMPLOYEE_JOINED
FROM EMPLOYEE
GROUP BY HIRE_DATE
HAVING YEAR(HIRE_DATE) = 1985 AND MONTH(HIRE_DATE) = 3;

---12. Which is the Department ID having greater than or equal to 3 employees joining in April 1985?---

SELECT DEPARTMENT_ID, COUNT(EMPLOYEE_ID) AS EMPLOYEE_JOINED
FROM EMPLOYEE
GROUP BY HIRE_DATE, DEPARTMENT_ID
HAVING YEAR(HIRE_DATE) = 1985 AND MONTH(HIRE_DATE) = 4 
AND COUNT(EMPLOYEE_ID) >=3;


--JOINS:-

---1. List out employees with their department names.---

SELECT EMP.*, DEP.NAME AS Department_Name 
FROM EMPLOYEE EMP INNER JOIN DEPARTMENT DEP ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID;

---2. Display employees with their designations.---

SELECT EMP.*, JOB.DESIGNATION AS DESIGNATION 
FROM EMPLOYEE EMP INNER JOIN JOB ON EMP.JOB_ID = JOB.JOB_ID;

---3. Display the employees with their department names and regional groups.---

SELECT E.*, D.NAME AS Department_Name, L.CITY AS REGIONAL_GROUP
FROM EMPLOYEE E 
INNER JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
INNER JOIN LOCATION L ON D.LOCATION_ID = L.LOCATION_ID;

----4. How many employees are working in different departments? Display with department names.---

SELECT D.NAME AS Department_Name, COUNT(E.EMPLOYEE_ID) Employees_Count FROM EMPLOYEE E 
INNER JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.NAME;

---5. How many employees are working in the sales department?---

SELECT D.NAME AS Department_Name, COUNT(E.EMPLOYEE_ID) Employees_Count FROM EMPLOYEE E 
INNER JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.NAME HAVING D.NAME = 'Sales';

---6. Which is the department having greater than or equal to 5 employees? Display the department names in ascending order.--

SELECT D.NAME AS Department_Name
FROM EMPLOYEE E 
INNER JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.NAME 
HAVING COUNT(EMPLOYEE_ID) >=5 
ORDER BY D.NAME;

----7. How many jobs are there in the organization? Display with designations.---

SELECT J.DESIGNATION, COUNT(E.JOB_ID) AS No_Of_Jobs 
FROM EMPLOYEE E
INNER JOIN JOB J ON E.JOB_ID = J.JOB_ID
GROUP BY J.DESIGNATION;

----8. How many employees are working in "New York"?---

SELECT L.CITY as City, COUNT(E.EMPLOYEE_ID) AS Employee_Count 
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
INNER JOIN LOCATION L ON D.LOCATION_ID = L.LOCATION_ID
GROUP BY CITY
HAVING CITY = 'New York';

----9. Display the employee details with salary grades. Use conditional statement to create a grade column.---

SELECT *,
 CASE 
	WHEN SALARY < 1000 THEN 'C'
	WHEN SALARY > 2000 THEN 'A'
	ELSE 'B'
END AS GRADE
FROM EMPLOYEE;

---10. List out the number of employees grade wise. Use conditional statement to create a grade column.---

SELECT
  Grade,
  COUNT(EMPLOYEE_ID) AS No_Of_Employees
FROM (
  SELECT EMPLOYEE_ID,
    CASE 
      WHEN SALARY < 1000 THEN 'C'
      WHEN SALARY > 2000 THEN 'A'
      ELSE 'B'
    END AS GRADE
  FROM EMPLOYEE
) AS EmployeeWithGrade
GROUP BY GRADE;

----11. Display the employee salary grades and the number of employees between 2000 to 5000 range of salary.

SELECT
  Grade,
  COUNT(EMPLOYEE_ID) AS No_Of_Employees
FROM (
  SELECT EMPLOYEE_ID,
    CASE 
      WHEN SALARY < 1000 THEN 'C'
      WHEN SALARY > 2000 THEN 'A'
      ELSE 'B'
    END AS GRADE
  FROM EMPLOYEE WHERE SALARY BETWEEN 2000 AND 5000
) AS EmployeeWithGrade
GROUP BY GRADE;

----12. Display all employees in sales or operation departments.---

SELECT EMP.*, DEPT.NAME FROM EMPLOYEE EMP INNER JOIN DEPARTMENT DEPT ON EMP.DEPARTMENT_ID = DEPT.DEPARTMENT_ID
WHERE DEPT.NAME IN ('Sales', 'Operations');

--SET Operators ::---

---1. List out the distinct jobs in sales and accounting departments.---

SELECT JOB.DESIGNATION
FROM EMPLOYEE EMP
INNER JOIN DEPARTMENT DEPT ON EMP.DEPARTMENT_ID = DEPT.DEPARTMENT_ID
INNER JOIN JOB ON EMP.JOB_ID = JOB.JOB_ID
WHERE DEPT.NAME = 'Sales'

UNION

SELECT JOB.DESIGNATION
FROM EMPLOYEE EMP
INNER JOIN DEPARTMENT DEPT ON EMP.DEPARTMENT_ID = DEPT.DEPARTMENT_ID
INNER JOIN JOB ON EMP.JOB_ID = JOB.JOB_ID
WHERE DEPT.NAME = 'Accounting';

---2. List out all the jobs in sales and accounting departments.---

SELECT JOB.DESIGNATION
FROM EMPLOYEE EMP
INNER JOIN DEPARTMENT DEPT ON EMP.DEPARTMENT_ID = DEPT.DEPARTMENT_ID
INNER JOIN JOB ON EMP.JOB_ID = JOB.JOB_ID
WHERE DEPT.NAME = 'Sales'

UNION All

SELECT JOB.DESIGNATION
FROM EMPLOYEE EMP
INNER JOIN DEPARTMENT DEPT ON EMP.DEPARTMENT_ID = DEPT.DEPARTMENT_ID
INNER JOIN JOB ON EMP.JOB_ID = JOB.JOB_ID
WHERE DEPT.NAME = 'Accounting';

----3. List out the common jobs in research and accounting departments in ascending order.---

SELECT JOB.DESIGNATION
FROM EMPLOYEE EMP
INNER JOIN DEPARTMENT DEPT ON EMP.DEPARTMENT_ID = DEPT.DEPARTMENT_ID
INNER JOIN JOB ON EMP.JOB_ID = JOB.JOB_ID
WHERE DEPT.NAME = 'Research'

INTERSECT

SELECT JOB.DESIGNATION
FROM EMPLOYEE EMP
INNER JOIN DEPARTMENT DEPT ON EMP.DEPARTMENT_ID = DEPT.DEPARTMENT_ID
INNER JOIN JOB ON EMP.JOB_ID = JOB.JOB_ID
WHERE DEPT.NAME = 'Accounting'
ORDER BY JOB.DESIGNATION ASC;

---Subqueries::--

---1. Display the employees list who got the maximum salary.---

SELECT * FROM EMPLOYEE WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE);

---2. Display the employees who are working in the sales department.---

SELECT * FROM EMPLOYEE WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM DEPARTMENT WHERE NAME = 'Sales');

---3. Display the employees who are working as 'Clerk'.---

SELECT * FROM EMPLOYEE WHERE JOB_ID IN (SELECT JOB_ID FROM JOB WHERE Designation = 'CLERK');

---4. Display the list of employees who are living in "New York".---

SELECT * FROM EMPLOYEE EMP
INNER JOIN DEPARTMENT DEPT ON EMP.DEPARTMENT_ID = DEPT.DEPARTMENT_ID
INNER JOIN LOCATION LOC ON DEPT.LOCATION_ID = LOC.LOCATION_ID
WHERE LOC.LOCATION_ID IN (SELECT LOCATION_ID FROM LOCATION WHERE City = 'New York');

---5. Find out the number of employees working in the sales department.---

SELECT COUNT(EMPLOYEE_ID) AS NO_OF_EMPLOYEES 
FROM EMPLOYEE 
WHERE DEPARTMENT_ID IN (
SELECT DEPARTMENT_ID FROM DEPARTMENT WHERE NAME = 'Sales'
);

----6. Update the salaries of employees who are working as clerks on the basis of 10%.---

UPDATE EMPLOYEE SET SALARY = (SALARY + (SALARY * 0.1)) 
WHERE JOB_ID = (SELECT JOB_ID FROM JOB WHERE DESIGNATION='CLERK');

---7. Delete the employees who are working in the accounting department.---

DELETE FROM EMPLOYEE WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID 
FROM DEPARTMENT WHERE 
Name ='Accounting');

----8. Display the second highest salary drawing employee details.---

SELECT * FROM EMPLOYEE WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE WHERE SALARY < (SELECT MAX(SALARY) FROM EMPLOYEE));

---9. Display the nth highest salary drawing employee details.---

SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY SALARY DESC) AS SalaryRank
    FROM EMPLOYEE
) AS RankedEmployees
WHERE SalaryRank = N; ---'N' can be replaced with whatever ranked salary we want to display from highest-

----10. List out the employees who earn more than every employee in department 30.---

SELECT * FROM EMPLOYEE 
WHERE SALARY > 
	(SELECT MAX(SALARY) FROM EMPLOYEE WHERE DEPARTMENT_ID=30);

---11. List out the employees who earn more than the lowest salary in department.---

SELECT * FROM EMPLOYEE WHERE SALARY > (SELECT MIN(SALARY) FROM EMPLOYEE);

---12. Find out which department has no employees.--

SELECT NAME AS DEPARTMENT_NAME FROM DEPARTMENT WHERE DEPARTMENT_ID NOT IN (SELECT DEPARTMENT_ID FROM EMPLOYEE);

---13. Find out the employees who earn greater than the average salary for their department.---

SELECT E.*
FROM EMPLOYEE E
WHERE E.SALARY > (
    SELECT AVG(S.SALARY)
    FROM EMPLOYEE S
    WHERE S.DEPARTMENT_ID = E.DEPARTMENT_ID
);

----------------------------------------------------------
----------------------------------------------------------
