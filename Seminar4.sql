- sa se afiseze angajatoii
select* from angajati;
--angajatii cu salariu intre 2000 si 6000
select* from angajati 
where salariul between 2000 and 6000;
--nume prenume salariu id dep angajati
select nume,prenume,salariul,ID_DEPARTAMENT from angajati;
--ANG CU ID 50 SAU 60 LA DEPARTAMENTE
select nume,prenume,salariul,ID_DEPARTAMENT from angajati
where salariul between 2000 and 6000
    and  (ID_DEPARTAMENT=50 OR ID_DEPARTAMENT=60);
--and mai puternic decat or
--------------------------------------------------------------------------------
select nume,prenume,salariul,ID_DEPARTAMENT from angajati
where salariul between 2000 and 6000
    and  (ID_DEPARTAMENT=50 OR ID_DEPARTAMENT=60)
    order by nume desc;--desc=descending
--------------------------------------------------------------------------------
---------------------------------------------------------SORTARE----------------
    select nume,prenume,salariul,ID_DEPARTAMENT from angajati
where salariul between 2000 and 6000
    and  (ID_DEPARTAMENT=50 OR ID_DEPARTAMENT=60)
    order by id_departament desc ,nume  desc;
-------------------------------------------------------------------------------
-- sa se afiseze angajatii ale caror nume incep cu litera a    
    SELECT* FROM angajati
    WHERE nume like 'A%' or nume like 'a%';
    
----sa se afis nume salariu dep pt angajatii al caror dep ese citi de la tastatura

select nume,prenume,salariul,ID_DEPARTAMENT
from angajati
where id_departament = &a;
----&a variabila de substitutie-- sa se afiseze angajatoii
select* from angajati;
--angajatii cu salariu intre 2000 si 6000
select* from angajati 
where salariul between 2000 and 6000;
--nume prenume salariu id dep angajati
select nume,prenume,salariul,ID_DEPARTAMENT from angajati;
--ANG CU ID 50 SAU 60 LA DEPARTAMENTE
select nume,prenume,salariul,ID_DEPARTAMENT from angajati
where salariul between 2000 and 6000
    and  (ID_DEPARTAMENT=50 OR ID_DEPARTAMENT=60);
--and mai puternic decat or
--------------------------------------------------------------------------------
select nume,prenume,salariul,ID_DEPARTAMENT from angajati
where salariul between 2000 and 6000
    and  (ID_DEPARTAMENT=50 OR ID_DEPARTAMENT=60)
    order by nume desc;--desc=descending
--------------------------------------------------------------------------------
---------------------------------------------------------SORTARE----------------
    select nume,prenume,salariul,ID_DEPARTAMENT from angajati
where salariul between 2000 and 6000
    and  (ID_DEPARTAMENT=50 OR ID_DEPARTAMENT=60)
    order by id_departament desc ,nume  desc;
-------------------------------------------------------------------------------
-- sa se afiseze angajatii ale caror nume incep cu litera a    
    SELECT* FROM angajati
    WHERE nume like 'A%' or nume like 'a%';
    
----sa se afis nume salariu dep pt angajatii al caror dep ese citi de la tastatura

select nume,prenume,salariul,ID_DEPARTAMENT
from angajati
where id_departament = &a;
----&a variabila de substitutie
