--jonctiunea interna
select nume,salariul,denumire_departament
from angajati a inner join departamente d
on a.id_departament=d.id_departament

select nume,salariul,denumire_departament
from angajati inner join departamente
using (id_departament);

select nume,salariul,denumire_departament
from angajati natural join departamente;
--teasteazaz a.id_dep=d.id_dep si a.id_manager=d.id_manager

--jonctiunea externa
select nume,salariul,denumire_departament
from angajati a left outer join departamente d
on a.id_departament=d.id_departament;--arata si angajatii care nu sunt in vreun departament

select nume,salariul,denumire_departament
from angajati a right outer join departamente d
on a.id_departament=d.id_departament;--arata si departamente in care nu exista angajati

select nume,salariul,denumire_departament
from angajati a full outer join departamente d
on a.id_departament=d.id_departament;


--SQL Oracle
select nume,salariul,denumire_departament
from angajati a,departamente d
where a.id_departament=d.id_departament;

select nume,salariul,denumire_departament
from angajati a,departamente d
where a.id_departament=d.id_departament(+);

select nume,salariul,denumire_departament
from angajati a,departamente d
where d.id_departament=a.id_departament(+);

select nume,salariul,denumire_departament
from angajati a,departamente d
where a.id_departament=d.id_departament(+);
union 
select nume,salariul,denumire_departament
from angajati a,departamente d
where d.id_departament=a.id_departament(+);


--sa se afiseze pt fiecare angajat numele,salariul,denumirea functiei, denumirea departamentului
select nume,salariul,denumire_functie,denumire_departament
from angajati a, functii f,departamente d
where a.id_functie=f.id_functie and a.id_departament=d.id_departament;

select nume,salariul,denumire_functie,denumire_departament
from angajati a join functii f
on a.id_functie=f.id_functie
join departamente d
on a.id_departament=d.id_departament;

--sa se afiseze pt fiecare angajat numele,salariul,numele managerului => self join
select a.nume nume_ang ,a.salariul salariul_ang, m.nume nume_manager
from angajati a,angajati m
where a.id_manager=m.id_angajat;

-- 1. Sa se afiseze cantitatea totala comandata din fiecare produs identificat prin id si denumire.
select p.id_produs,denumire_produs,sum(cantitate) cantitate_tot
from rand_comenzi c, produse p
where c.id_produs=p.id_produs
group by p.id_produs,denumire_produs;

2. Sa se afiseze cantitatea totala comandata din fiecare produs din categoriile hardware2 sau hardware3.
select p.id_produs,denumire_produs,sum(cantitate) cantitate_tot
from rand_comenzi c, produse p
--where c.id_produs=p.id_produs and categorie in ('hardware2','hardware3')
group by p.id_produs,denumire_produs
having sum(cantitate)>1000;
