using System.Collections;
using System.Collections.Generic;
using SoftUni;

namespace Softuni
{
    ﻿using System;
    using System.Data.Entity;
    using System.Linq;

    class EmployeesDAO
    {

        public static Employee GetEmplByName(string fName, string lName)
        {
            var softuniEntities = new SoftUniEntities();

            return softuniEntities.Employees.FirstOrDefault(e => e.FirstName == fName && e.LastName == lName);
        }

        public static int InsertEmployee(string fName, string mName, string lName, string jTitle, int departmentId,
            int managerId, DateTime hireDate, decimal salary, int addressId)
        {
            var softuniEntities = new SoftUniEntities();

            var emp = new Employee
            {
                FirstName = fName,
                MiddleName = mName,
                LastName = lName,
                JobTitle = jTitle,
                DepartmentID = departmentId,
                ManagerID = managerId,
                HireDate = hireDate,
                Salary = salary,
                AddressID = addressId
            };

            softuniEntities.Employees.Add(emp);
            softuniEntities.SaveChanges();
            Console.WriteLine(String.Format("Employee {0} {1} inserted", fName, lName));

            return emp.EmployeeID;
        }

        public static void EditEmplManagerId(int emplId, int newManId)
        {
            var softuniEntities = new SoftUniEntities();
            var empl = softuniEntities.Employees.Find(emplId);
            var oldManId = empl.ManagerID;

            empl.ManagerID = newManId;
            softuniEntities.SaveChanges();
            Console.WriteLine(String.Format("old manager id: {0}, new: {1}", oldManId, newManId));
        }

        public static void EditEmplJobTitle(int emplId, string newJobTitle)
        {
            var softuniEntities = new SoftUniEntities();
            var empl = softuniEntities.Employees.Find(emplId);
            var oldJobTitle = empl.JobTitle;

            empl.JobTitle = newJobTitle;
            softuniEntities.SaveChanges();
            Console.WriteLine(String.Format("old: {0}, new: {1}", oldJobTitle, newJobTitle));
        }

        public static void DeleteEmployee(int emplId)
        {
            var softuniEntities = new SoftUniEntities();
            var empl = softuniEntities.Employees.Find(emplId);
            var removedEmplName = String.Format("{0} {1}", empl.FirstName, empl.LastName);

            softuniEntities.Employees.Remove(empl);
            softuniEntities.SaveChanges();

            Console.WriteLine(removedEmplName + " was removed");
        }

        /*
         * Task 03 - write a method that finds all employees who 
         * have projects with start date in 2002 year
         */

        public static void FindEmplsWithProjects(int startYear)
        {
            var softuniEntities = new SoftUniEntities();

            var empls = softuniEntities.Employees
                .Where(e => (e.Projects
                    .Any(p => p.StartDate.Year == startYear)))
                .OrderBy(e => e.FirstName);

            // Console.WriteLine(empls.Count());

            foreach (var empl in empls)
            {
                //Console.WriteLine(empl.GetType());
                Console.WriteLine(String.Format("{0} {1}", empl.FirstName, empl.LastName));
            }
        }

        /*
         * Task 04 - solve the previous task by using native SQL query and 
         * executing it through the DbContext
         */

        public static void FindEmplsWithProjectsNativeQuery(int startYear)
        {
            var softuniEntities = new SoftUniEntities();

            string query = @"SELECT DISTINCT e.[EmployeeID]
      ,[FirstName]
      ,[LastName]
      ,[MiddleName]
      ,[JobTitle]
      ,[DepartmentID]
      ,[ManagerID]
      ,[HireDate]
      ,[Salary]
      ,[AddressID]
  FROM [SoftUni].[dbo].[Employees] e
  JOIN EmployeesProjects ep ON ep.EmployeeID = e.EmployeeID
  JOIN Projects p ON p.ProjectID = ep.ProjectID
  WHERE DATEPART(YEAR, p.StartDate) = {0}
  ORDER BY e.[FirstName]";

            object[] parameters = { startYear };

            var empls = softuniEntities.Database.SqlQuery<Employee>(query, parameters).ToList();

            foreach (var empl in empls)
            {
                Console.WriteLine(empl.ToString());
            }
        }


        /*
         * Task 05 - write a method that finds all employees by specified 
         * department (name) and manager (first name and last name)
         */

        public static void FindEmplsByDepartmentAndManager(string depName, string manFirstName, string manLastName)
        {
            var softuniEntities = new SoftUniEntities();

            var empls = softuniEntities.Employees
                .Where(
                    e =>
                        e.Department.Name == depName && e.Employee1.FirstName == manFirstName &&
                        e.Employee1.LastName == manLastName).ToList();

            foreach (var empl in empls)
            {
                Console.WriteLine(empl.ToString());
            }
        }

        /*
         * Task 07 - create a class, which allows employees to access their corresponding 
         * territories as property of the type EntitySet<T> by inheriting the Employee 
         * entity class or by using a partial class
         */



        /*
         * Task 08 - create a method that inserts a new project in the SoftUni database. 
         * The project should contain several employees
         */
        public static int InsertNewProject(string name, string descr, DateTime start, DateTime end, ICollection<Employee> empls)
        {
            var softuniEntities = new SoftUniEntities();

            using (softuniEntities)
            {
                using (DbContextTransaction tran = softuniEntities.Database.BeginTransaction())
                {
                    Project toInsert = new Project();

                    try
                    {
                        toInsert.Name = name;
                        toInsert.Description = descr;
                        toInsert.StartDate = start;
                        toInsert.EndDate = end;
                        toInsert.Employees = empls;

                        softuniEntities.Projects.Add(toInsert);
                        softuniEntities.SaveChanges();
                        tran.Commit();
                    }
                    catch (Exception ex)
                    {
                        tran.Rollback();
                    }

                    return toInsert.ProjectID;
                }
            }
        }

        /*
         *  Task 09 - create a stored procedure in the SoftUni database for finding 
         *  all projects for given employee (first name and last name). Using EF implement 
         *  a C# method that calls the stored procedure and returns the retuned record set
         */

        public static void GetProjectsByEmplName(string fName, string lName)
        {
            var softuniEntities = new SoftUniEntities();
            using (softuniEntities)
            {
                var projects = softuniEntities.usp_FindProjForEmployee(fName, lName);

                foreach (var proj in projects)
                {
                    Console.WriteLine(String.Format(">  {0}, {1}. \n{2} - {3}", proj.Name, proj.Description, proj.StartDate, proj.EndDate));
                }
            }
        }

        public static void Main(string[] args)
        {
            // Task 02 test
            Console.WriteLine(GetEmplByName("Svetlin", "Nakov").ToString());

            // Task 03 test
            // FindEmplsWithProjects(2002);
            Console.WriteLine();

            // Task 04 test
            // FindEmplsWithProjectsNativeQuery(2002);
            Console.WriteLine();
            // Task 05 test
            // FindEmplsByDepartmentAndManager("Engineering", "Roberto", "Tamburello");

            Console.WriteLine();

            // Task 08 test

            var softuniEntities = new SoftUniEntities();
            var employeesForProject = softuniEntities.Employees.Where(e => e.EmployeeID == 4 && e.EmployeeID == 45).ToList();

            int id = InsertNewProject("Tracker", "Prosledqvane na krasivi jeni po ulicata", new DateTime(2015, 10, 12),
                new DateTime(2017, 10, 12), employeesForProject);
            // Console.WriteLine(id);

            //Task 09 test
            GetProjectsByEmplName("Roberto", "Tamburello");
        }
    }
}
