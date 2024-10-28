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
