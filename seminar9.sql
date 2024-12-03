--1. Sa se afiseze numele, prenumele, functia si salariul angajatilor, iar pe baza functiei sa se acorde fiecarui salariat un bonus, astfel: pentru IT_PROG – 5%, pentru AD_PRES – 10%, pentru celelalte functii – 1%
select a.nume,a.prenume,f.denumire_functie,a.salariul,
case when upper(a.id_functie)='IT_PROG' then salariul*0.05
when upper(a.id_functie)='AD_PRES' then salariul*0.1
else salariul*0.01
end as bonus
from angajati a,functii f
where a.id_functie=f.id_functie;

select nume,prenume,id_functie,salariul,
decode(id_functie,'IT_PROG',0.05,'AD_PRES',0.1,0.01)*salariul as bonus
from angajati join functii using(id_functie);


--2. Să se afişeze numele angajatului, valoarea comenzilor intermediate, denumirea functiei detinute şi, pe baza acesteia, comisionul aplicat la valorea comenzilor înlesnite, astfel: pentru IT_PROG – 5%, pentru AD_PRES – 3%, pentru celelalte funcţii – 1%
select a.nume,f.denumire_functie,sum(rc.pret*rc.cantitate) valoare_comenzi,
case when a.id_functie='IT_PROG' then 0.05
when a.id_functie='AD_PRES' then 0.03
else 0.01 end*sum(rc.pret*rc.cantitate) as valoare_comision
from angajati a,functii f,comenzi c,rand_comenzi rc
where a.id_functie=f.id_functie and a.id_angajat=c.id_angajat and c.id_comanda=rc.id_comanda
group by a.id_angajat,a.nume,f.denumire_functie,a.id_functie;


--3. Să se afişeze numele, prenumele, funcţia şi venitul total al angajaţilor, iar pe baza vechimii fiecarui salariat sa se acorde un bonus, astfel: pentru vechime<5 ani atunci 0.3, pentru vechime intre 5-10 --0.4, altfel 0.5.
select nume,prenume,denumire_functie,salariul+nvl(comision,0) venit_total,trunc(months_between(sysdate,data_angajare)/12) vechime,
case when trunc(months_between(sysdate,data_angajare)/12)<5 then 0.3
when trunc(months_between(sysdate,data_angajare)/12) in (5,10) then 0.4
else 0.5 end*(salariul+nvl(comision,0)) as bonus
from angajati a,functii f
where a.id_functie=f.id_functie
group by nume,prenume,denumire_functie,salariul+nvl(comision,0),trunc(months_between(sysdate,data_angajare)/12);



--4. Să se afișeze denumirea și categoria produselor care nu au fost comandate
select denumire_produs,categorie
from produse
where id_produs not in(select id_produs from rand_comenzi);



--5. Să se afișeze pentru fiecare angajat numele, vechimea, venitul, denumirea funcției și a departamentului, precum și numele complet al managerului pentru care lucrează
select a.nume,trunc(months_between(sysdate,a.data_angajare)/12) vechime, a.salariul+nvl(a.comision,0) venit,f.denumire_functie,d.denumire_departament,m.nume ||' '||m.prenume nume_manager
from angajati a,functii f,departamente d,angajati m
where a.id_departament=d.id_departament and a.id_functie=f.id_functie and a.id_manager=m.id_angajat;


--6. Să se afișeze primele 3 comenzi din anul 2019 cu cele mai multe produse
select c.id_comanda,c.data,sum(rc.cantitate) total_produse
from comenzi c,rand_comenzi rc
where c.id_comanda=rc.id_comanda and c.data like '%-19%'
group by c.id_comanda,c.data
order by sum(rc.cantitate) desc
fetch first 3 rows only;


--7. Sa se afiseze angajatii cu salariul mai mic decat salariul mediu
select id_angajat,nume,prenume
from angajati
where salariul<(select avg(salariul) from angajati)
group by id_angajat,nume,prenume;


--8. Sa se afiseze angajatii care au mai detinut cel putin 2 functii anterioare
select a.id_angajat,a.nume,a.prenume,count(isf.id_angajat) nr_f_ant
from angajati a,istoric_functii isf
where a.id_angajat=isf.id_angajat
group by a.id_angajat,a.nume,a.prenume
having count(isf.id_angajat)>=2;


--9. Să se afişeze pentru fiecare departament (identificat prin denumire) numărul de angajați care au intermediat comenzi
select denumire_departament,count(distinct c.id_angajat)
from angajati a,comenzi c,departamente d
where a.id_angajat=c.id_angajat and a.id_departament=d.id_departament
group by denumire_departament;


--10. Sa se majoreze salariul pe baza functiei, astfel: pentru IT_PROG – 5%, pentru AD_PRES – 10%, pentru celelalte functii – 1%
update angajati
set salariul=salariul*(
case when id_functie='IT_PROG' then 1.05
when id_functie='AD_PRES' then 1.10
else 1.01 end
);
