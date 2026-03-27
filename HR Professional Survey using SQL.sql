

--Analyzing 22,000+ Employee Records using_SQL_Server.


--____________ Adding Age Colum to_get the Age______________

ALTER TABLE 
from dbo.[Human Resources] 
ADD age INT

UPDATE from dbo.[Human Resources]
SET age = timestampdiff(YEAR, birthdate, getdate())


--________________Concatinating First_Name + Last_Name __________

ALTER TABLE 
from dbo.[Human Resources] 
ADD Full_name varchar(25)

update dbo.[Human Resources]
set Full_name = CONCAT((first_name, ' ', last_name))

--________________Dropping First_Name + Last_Name __________

ALTER TABLE [Human Resources]
DROP COLUMN first_name, last_name;

  -----------------------QUESTIONS AND QUERRY---------------------------------
  --1. Employee Count by Department active employees those who haven not left.

  select department, COUNT(*) as Dept_Count
  from dbo.[Human Resources]
  group by department
  order by department desc

  --2. Gender Distribution breakdown of  active employees in the company?

  select gender , COUNT(*) as Gender_Count
  from dbo.[Human Resources]
  group by gender
  order by gender desc

  --3. Longest-Serving Employees top 5 longest-serving employees still currently working

  select top 5 Full_name,hire_date, age,department,jobtitle
  from  dbo.[Human Resources]
  order by hire_date asc


  --4. What is the split between employees working at Headquarters versus those working Remotely?

  select location, COUNT(*) as Count_by_Split
  from dbo.[Human Resources]
  group by location
  order by location desc

  --5.Count of Top 5 most frequent job titles in the organization

select top 5 jobtitle, COUNT(*) as Top_5_Jobtitle
from dbo.[Human Resources]
group by jobtitle
order by jobtitle desc

--6.Average age of employees within each department

select department,AVG(age) as Avg_Age
from dbo.[Human Resources]
group by department
order by department desc

--7. states have the highest number of employees

select top 5 location_state,COUNT(*) as Total_Count
from dbo.[Human Resources]
group by location_state
order by location_state desc

--8.Age_Grouping Grouping active employees_by_age

SELECT 
    CASE 
        WHEN age <= 30 THEN 'Young'
        WHEN age <= 50 THEN 'Middle-aged'
        ELSE 'Senior)'
    END AS age_group,
    COUNT(*) AS total_employees
FROM dbo.[Human Resources]
GROUP BY 
    CASE 
        WHEN age <= 30 THEN 'Young'
        WHEN age <= 50 THEN 'Middle-aged'
        ELSE 'Senior)'
    END;

--9.Number of hires made each_year to identify growth trends.

SELECT YEAR(hire_date) as hire_year, COUNT(*) as hire_count
FROM [Human Resources]
GROUP BY YEAR(hire_date)
ORDER BY hire_year DESC;


--10.Employees who are older than the average_AGE of the company.

SELECT Full_name, birthdate,
DATEDIFF(YEAR, birthdate, GETDATE()) AS age
FROM [Human Resources]
WHERE DATEDIFF(YEAR, birthdate, GETDATE()) > (
SELECT AVG(DATEDIFF(YEAR, birthdate, GETDATE())) 
FROM [Human Resources])
ORDER BY age DESC;

--11.Senior_employees based on by location

WITH Senior_employees AS (SELECT Full_name, jobtitle, location_state
FROM [Human Resources]
WHERE jobtitle LIKE '%Senior%' OR jobtitle LIKE '%III%' OR jobtitle LIKE '%IV%')

SELECT location_state, COUNT(*) as Senior_employees
FROM Senior_employees
GROUP BY location_state
ORDER BY Senior_employees DESC;




