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

accept coloana_selectata prompt 'introduceți coloana după care doriți să sortați (id_angajat, nume, salariul, id_departament): ';
accept id_manager prompt 'introduceți id-ul managerului: ';

select id_angajat, nume, salariul, id_departament
from angajati
where id_manager = &id_manager
order by
    case when '&coloana_selectata' = 'id_angajat' then id_angajat end,
    case when '&coloana_selectata' = 'nume' then nume end,
    case when '&coloana_selectata' = 'salariul' then salariul end,
    case when '&coloana_selectata' = 'id_departament' then id_departament end;

--Exercitiul 12
--2. Display all employee last names in which the third letter of the name is a
 select nume from angajati
 where nume like '__a%';
 
 --Exercitiul 13
 --. Display the last names of all employees who have both an a and an e in their last name
 select nume from angajati
    where nume like '%e%a%';
 
 --Exercitiul 14
 -- Display the last name, job, and salary for all employees whose jobs are either sales
--representative or stock clerk and whose salaries are not equal to $2,500, $3,500, or $7,000.
 select nume, id_functie, salariul 
from angajati
where (id_functie = 'SA_REP' or id_functie = 'ST_CLERK') 
      and salariul not in (2500, 3500, 7000);
      
--Exercitiul 15  
--Modify lab_02_06.sql to display the last name, salary, and commission for all
--employees whose commission amount is 20%. Resave lab_02_06.sql as
--lab_02_15.sql. Rerun the statement in lab_02_15.sql. 
 select nume, salariul,comision
    from angajati
    where comision=0.2;then id_departament end;

            
         





