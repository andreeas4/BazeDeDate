[08:39, 30.10.2024] Andreea Stănciulescu: --sa se afiseze pt toti angajatii numele cu majuscula,salariul si departamentul in care lucreaza
    SELECT  upper (nume) AS "nume_ang" ,salariul,id_departament --alias
        from angajati
     where upper(nume) like 'A%'; 
     

    SELECT SUBSTR('ORACLE',1,3)
        FROM dual; --tabela la care are oricine acces
        
    SELECT UPPER(NUME||' '||PRENUME) AS "NUME COMPLET", salariul,id_departament 
        from angajati
     where upper(nume) like 'A%';
     
    SELECT ROUND(1.578,2),trunc(1.578,2) from dual;
    
    SELECT *FROM angajati
        where extract(year from data_angajare)=2018;
        
--sa se afiseze numele si vechimea si salariul pt angajatii cu salarii intre 2 limite citite de la tastatura 

    SELECT nume,round((sysdate-data_angajare)/365,2) as vechime,salariul from angajati
        where salariul between &a and &b;
[08:49, 30.10.2024] Andreea Stănciulescu: SELECT nume,round((sysdate-data_angajare)/365,2) as vechime,salariul from angajati
        where salariul between &a and &b;
    
    select *from angajati
        where data_angajare between to_date('01-01-2018','DD-MM-YYYY') and to_date('31-12-2018','DD-MM-YYYY');
