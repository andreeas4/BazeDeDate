1. Sa se afiseze pentru fiecare departament: id-ul departamentului, denumirea departamentului si salariul mediu al angajatilor din cadrul acestora
select d.id_departament,d.denumire_departament,round(avg(a.salariul),2) salariul_med
from departamente d, angajati a 
where d.id_departament=a.id_departament
group by d.id_departament,d.denumire_departament;

--2. Sa se afiseze denumirile, salariile minime, maxime si medii pentru departamentele 60, 70 si 80. Afisati doar departamentele care au mai mult de 5 angajati.
select d.denumire_departament,min(a.salariul) salariul_min,max(a.salariul) salariul_max,round(avg(a.salariul),2) salariul_mediu
from departamente d,angajati a
where d.id_departament=a.id_departament and d.id_departament in ('60','70','80') 
group by d.id_departament,d.denumire_departament
having count(d.id_departament)>5;


--3. Sa se afiseze numarul de produse existente din fiecare categorie
select categorie,count(id_produs) nr_produse
from produse
group by categorie;

--4. Sa se afiseze numarul de produse vandute din fiecare categorie
select p.categorie,count(rc.cantitate)
from produse p, rand_comenzi rc
where p.id_produs=rc.id_produs
group by p.categorie; 

--5. Sa se afiseze numarul de produse existente din fiecare grupa de produse (se vor analiza datele din tabela!!! categoriile sunt software1, software2..., hardware1, hardware2... vrem grupare dupa software, hardware etc)

--6. Sa se afiseze valoarea fiecarei comenzi
select id_comanda,sum(pret*cantitate) valoare_comanda
from rand_comenzi
group by id_comanda;

--7. Sa se afiseze valoarea fiecarei comenzi incheiate in anul 2020
select c.id_comanda,c.data,sum(rc.pret*rc.cantitate) valoare_comanda
from comenzi c,rand_comenzi rc
where c.id_comanda=rc.id_comanda and extract(year from c.data)=2020
group by c.id_comanda,c.data;

--8. Sa se afiseze valoarea fiecarei comenzi care contine mai mult de 10 produse
select c.id_comanda,sum(rc.pret*rc.cantitate),count(rc.id_produs)
from comenzi c, rand_comenzi rc
where c.id_comanda=rc.id_comanda
group by c.id_comanda
having count(rc.id_produs)>10;


--9. Sa se afiseze identificatorul si data de incheiere pentru comenzile alcatuite din zece produse.
select c.id_comanda,c.data,count(rc.id_produs) nr_produse
from comenzi c,rand_comenzi rc
where c.id_comanda=rc.id_comanda
group by c.id_comanda,c.data
having count(rc.id_produs)=10;

--10. Sa se afiseze id_comanda si SUM(pret * cantitate) pentru cea mai valoroasa comanda.

--11. Sa se creeze tabela ProduseSoftware cu aceeasi structura ca tabela Produse si care sa contina numai produsele din categoria software
create table ProduseSoftware
as
select *
from produse 
where categorie like 'software%';


--12. Sa se afiseze pentru fiecare angajat care a intermediat comenzi: identificatorul si numele, precum si numarul de comenzi si valoarea acestora
select a.id_angajat,a.nume,count(c.id_comanda) nr_comenzi,sum(rc.pret*rc.cantitate) valoare_totala
from comenzi c, rand_comenzi rc,angajati a
where c.id_comanda=rc.id_comanda and a.id_angajat=c.id_angajat
group by a.id_angajat,a.nume;

Seminar 8
