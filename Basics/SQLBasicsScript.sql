/****** Problem 4 - Script for select all info about departments command from SSMS  ******/
SELECT d.DepartmentID
      , Name
      , e.FirstName + ' ' + e.LastName as Manager
  FROM SoftUni.dbo.Departments d
  LEFT JOIN SoftUni.dbo.Employees e
  ON d.ManagerID = e.EmployeeID
   
  /****** Problem 5 - Script for Select department names command from SSMS  ******/
SELECT Name
  FROM SoftUni.dbo.Departments


  /****** Problem 6 and 7 - Script for Select employees salaries command from SSMS  ******/
SELECT FirstName, LastName, Salary
  FROM SoftUni.dbo.Employees


  /****** Problem 8 - Script for select employees emails command from SSMS  ******/
SELECT FirstName + '.' + LastName + '@softuni.bg' 
  AS 'Full Email Adresses'
  FROM [SoftUni].[dbo].[Employees]


  /****** Problem 9 - Script for select distinct salaries command from SSMS  ******/
SELECT distinct Salary as DistinctSalaries
  FROM SoftUni.dbo.Employees


  /****** Problem 10 - Script for select all info about Sales Representatives command from SSMS  ******/
SELECT  e.EmployeeID, 
	    e.FirstName,
	    e.LastName, 
		e.MiddleName, 
		e.JobTitle, 
        d.Name as DepartmentName, 
	    m.FirstName + ' ' + m.LastName as ManagerName,
	    e.HireDate,
		e.Salary, 
	    t.Name + ', ' + a.AddressText as FullAddress

  FROM SoftUni.dbo.Employees e
   LEFT JOIN Softuni.dbo.Employees m
   ON e.ManagerID = m.EmployeeID
   JOIN Softuni.dbo.Addresses a
   ON e.AddressID = a.AddressID
   JOIN SoftUni.dbo.Departments d
   ON e.DepartmentID = d.DepartmentID
   JOIN SoftUni.dbo.Towns t
   ON a.TownID = t.TownID
  WHERE e.JobTitle = 'Sales Representative'


  /******  Problem 11 - Script for select employees with first name starting with "Sa" command from SSMS  ******/
SELECT FirstName, LastName
  FROM SoftUni.dbo.Employees
  WHERE FirstName LIKE 'SA%'


  /******  Problem 12 - Script for select employees whos last name contains "ei" command from SSMS  ******/
SELECT FirstName, LastName
  FROM SoftUni.dbo.Employees
  WHERE LastName LIKE '%ei%'


  /****** Problem 13 - Script for select salary of emps in interval [20000,30000] command from SSMS  ******/
SELECT Salary
  FROM SoftUni.dbo.Employees
  WHERE Salary >= 20000 AND Salary <= 30000


  /****** Problem 14 - Script for select empls by salary command from SSMS  ******/
SELECT FirstName, LastName
  FROM SoftUni.dbo.Employees
  WHERE Salary = 25000 
  OR Salary = 14000 
  OR Salary = 12500 
  OR Salary = 23600


  /****** Problem 15 - Script for select emps with managerid null command from SSMS  ******/
SELECT FirstName, LastName, ManagerID
  FROM SoftUni.dbo.Employees
  WHERE ManagerID is NULL


  /****** Problem 16 - Script for emps command from SSMS  ******/
SELECT FirstName, LastName, Salary
  FROM SoftUni.dbo.Employees
  WHERE Salary > 50000
  ORDER BY Salary DESC


  /****** Problem 17 - Script for select top 5 best paid empls command from SSMS  ******/
SELECT TOP 5 FirstName, LastName, Salary
FROM SoftUni.dbo.Employees
ORDER BY Salary DESC


  /****** Problem 18 - Script for select empls with addresses command from SSMS  ******/
SELECT FirstName, LastName, AddressText
  FROM SoftUni.dbo.Employees e
  INNER JOIN SoftUni.dbo.Addresses a
  ON a.AddressID = e.AddressID


/****** Problem 19 - Script for .. command from SSMS  ******/
SELECT FirstName, LastName, AddressText
  FROM SoftUni.dbo.Employees e, SoftUni.dbo.Addresses a
  WHERE a.AddressID = e.AddressID


  /****** Problem 20 - Script for select empls with manager column without nulls command from SSMS  ******/
SELECT 
e.FirstName + ' ' + e.LastName as Employee,
m.FirstName + ' ' + m.LastName as Manager 
  FROM SoftUni.dbo.Employees e
  JOIN SoftUni.dbo.Employees m
  ON m.EmployeeID = e.ManagerID


  /****** Problem 21 - Script for SelectTopNRows command from SSMS  ******/
SELECT 
	e.FirstName + ' ' + e.LastName as Employee, 
	a.AddressText as Address,
    m.FirstName + ' ' + m.LastName as Manager

  FROM SoftUni.dbo.Employees e
  LEFT OUTER JOIN SoftUni.dbo.Employees m
  ON e.ManagerID = m.EmployeeID
  JOIN SoftUni.dbo.Addresses a
  ON e.AddressID = a.AddressID

  /****** Problem 22 - Script for SelectTopNRows command from SSMS  ******/
SELECT Name
  FROM SoftUni.dbo.Departments 
  UNION
  SELECT Name
  FROM SoftUni.dbo.Towns

  /****** Problem 23 - Script for SelectTopNRows command from SSMS  ******/
SELECT 
e.FirstName + ' ' + e.LastName as Employee,
m.FirstName + ' ' + m.LastName as Manager 
  FROM SoftUni.dbo.Employees e
  LEFT OUTER JOIN SoftUni.dbo.Employees m
  ON m.EmployeeID = e.ManagerID

  /****** Problem 24 - Script for select names of all employees from the departments "Sales" 
and "Finance" whose hire year is between 1995 and 2005 command from SSMS  ******/

SELECT e.FirstName,e.LastName, e.HireDate, d.Name as DepartmentName
  FROM SoftUni.dbo.Employees e, SoftUni.dbo.Departments d
  WHERE 
      DATEPART(year, e.HireDate) >= 1995 
  AND DATEPART(year, e.HireDate) <= 2005
  AND e.DepartmentID = d.DepartmentID 
  AND d.Name = 'Sales' OR d.Name = 'Finance'
