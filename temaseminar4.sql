--Tema 
-------------------------------------------------------------------------------------
--Exercitiul 1
--Because of budget issues, the HR department needs a report that displays the last name and
--salary of employees who earn more than $12,000.
 select nume,salariul from angajati
    where salariul>12000
    order by salariul;
    
--Exercitiul 2
--Create a report that displays the last name and department number for employee number
--176.

 select nume,id_departament from angajati
   where id_angajat=176;
 
 --Exercitiul 3
 --The HR department needs to find high-salary and low-salary employees. Modify
--lab_02_01.sql to display the last name and salary for any employee whose salary is
--not in the range of $5,000 to $12,000. 
  select nume,salariul from angajati
    where salariul not between 5000 and 12000
    order by salariul;
    
--Exercitiul 4
--Create a report to display the last name, job ID, and start date for the employees with the
--last names of Matos and Taylor. Order the query in ascending order by start date
 select nume,id_functie,data_angajare from angajati
    where nume='Matos' or nume='Taylor'
    order by data_angajare;
    
--Exercitiul 5
--Display the last name and department number of all employees in departments 20 or 50 in
--ascending alphabetical order by name.
 select nume,id_departament from angajati
    where (id_departament=20 or id_departament=50)
    order by nume;
--Exercitiul 6
--Modify lab_02_03.sql to display the last name and salary of employees who earn
--between $5,000 and $12,000 and are in department 20 or 50. Label the columns
--Employee and Monthly Salary, respectively. Resave lab_02_03.sql as
--lab_02_06.sql. Run the statement in lab_02_06.sql.
 select nume,salariul from angajati
    where (id_departament=20 or id_departament=50)
    and salariul between 5000 and 12000
    order by nume;

--Exercitiul 7
--The HR department needs a report that displays the last name and hire date for all
--employees who were hired in 1994.
 select nume,data_angajare from angajati
 where(data_angajare > date '1994-01-01' and data_angajare < date '1994-12-31');
 
--Exercitiul 8
--Create a report to display the last name and job title of all employees who do not have a
--manager.
 select nume,id_functie from angajati
 where id_manager is null;
 
 --Exercitiul 9
 --Create a report to display the last name, salary, and commission of all employees who earn
--commissions. Sort data in descending order of salary and commissions.
   select nume,salariul,comision from angajati
   where comision is not null
   order by salariul desc,comision desc;
   
--Exercitiul 10
--Members of the HR department want to have more flexibility with the queries that you are
--writing. They would like a report that displays the last name and salary of employees who
--earn more than an amount that the user specifies after a prompt. (You can use the query
--that you created in practice exercise 1 and modify it.) Save this query to a file named
--.sql. If you enter 12000 when prompted, the report displays the following
--results:

   select nume,salariul from angajati
        where salariul>&a;
        
--Exercitiul 11
--The HR department wants to run reports based on a manager. Create a query that prompts
--the user for a manager ID and generates the employee ID, last name, salary, and department
--for that manager’s employees. The HR department wants the ability to sort the report on a
--selected column. You can test the data with the following values:

    SELECT id_angajat, nume, salariul, id_departament
FROM angajati
WHERE id_manager = &id_manager
ORDER BY 
    CASE 
        WHEN '&coloana_selectata' = 'id_angajat' THEN id_angajat
        WHEN '&coloana_selectata' = 'nume' THEN nume
        WHEN '&coloana_selectata' = 'salariul' THEN salariul
        WHEN '&coloana_selectata' = 'id_departament' THEN id_departament
    END;
             
            
         





