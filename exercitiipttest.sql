select d.id_departament,d.denumire_departament,round(avg(a.salariul),2)salariu_med
from departamente d 
join angajati a on a.id_departament=d.id_departament
group by d.id_departament,d.denumire_departament;

select 
d.denumire_departament,
round(min(a.salariul),2)salariu_min,
round(avg(a.salariul),2)salariu_med,
round(max(a.salariul),2)salariu_max,
count(a.id_angajat)
from departamente d 
join angajati a on a.id_departament=d.id_departament
where a.id_departament in(60,70,80)
having count(a.id_angajat)>0
group by denumire_departament;

--nr de produse vandute din fiecare categorie
select count(p.id_produs),p.categorie
from produse p 
group by p.categorie;

select id_comanda,sum(pret*cantitate)
from rand_comenzi 
group by id_comanda
order by sum(pret*cantitate) desc
fetch first 1 row only ;

select a.id_angajat,a.nume,count(c.id_comanda)nr_comenzi,sum(rc.pret*rc.cantitate)valoare
from angajati a
join comenzi c 
on a.id_angajat=c.id_angajat
join rand_comenzi rc
on rc.id_comanda=c.id_comanda
group by a.id_angajat,a.nume;

select nume,prenume,id_functie,salariul,comision,
case 
    when comision>0 and comision is not null then salariul+comision*salariul
        else salariul
        end as venit_total,
extract (year from sysdate)- extract(year from data_angajare)
as vechime,
(case 
when (extract (year from sysdate)- extract(year from data_angajare))<5 then 0.3

when (extract (year from sysdate)- extract(year from data_angajare))
between 5 and 10 then 0.4

else 0.5
end )*salariul+ salariul+comision*salariul as venit_total_cu_bonus
from angajati;

--1. Sa se modifice salariul angajatilor cu functia FI_MGR astfel incat sa devina egal cu salariul angajatului 204.
update angajati 

set salariul=(select salariul from angajati 
                where id_angajat=204 )
where id_functie like 'FI_MGR';

--2. Sa se micsoreze limita de credit pt clientii nascuti in acelasi an ca si clientul cu id_client 170.

update clienti
set limita_credit=limita_credit-1
where extract(year from data_nastere)=(select extract(year from data_nastere)
                                            from clienti
                                            where id_client=170);
--test
select nume_client,limita_credit from clienti
where extract(year from data_nastere)=1998;

--3. Sa se afiseze angajatii care fac parte din departamentele in care lucreaza si cei cu id-urile 100 si 175.

select * from angajati
where id_departament in(select id_departament from angajati
                        where id_angajat in(100,175));


--4. Sa se afiseze angajatii care fac parte din departamentele in care lucreaza mai putin de 6 angajati.

select * from  angajati
where id_departament in(select id_departament
                            from angajati 
                            having count(distinct id_angajat)<6
                            group by id_departament)
                            
--5. Sa se afiseze angajatii cu salariul mai mic decat salariul mediu al tuturor angajatilor
select * from angajati
where salariul<(select avg(salariul) from angajati);

--6. Sa se afiseze angajatii cu salariul mai mic decat salariul mediu al departamentului din care fac parte

select * from angajati a
where salariul<(select avg(salariul) from angajati b
                    where b.id_departament=a.id_departament);

--7. Sa se afiseze pentru fiecare angajat: numele, denumirea departamentului in care lucreaza si numarul de angajati din departamentul respectiv.
select a.nume,d.denumire_departament,count(b.id_angajat)as nr_angajati
from angajati a 
join departamente d
on a.id_departament=d.id_departament
join angajati b
on  a.id_departament=b.id_departament
group by a.nume,d.denumire_departament;                        

--9. Sa se afiseze comenzile care contin mai putine produse decat comanda 2354.

--nr produse din comanda 2354
select count(id_produs)nr_produse from rand_comenzi
where id_comanda=2354;

SELECT c.id_comanda, COUNT(rc.id_produs) AS numar_produse
FROM comenzi c
JOIN rand_comenzi rc
ON rc.id_comanda = c.id_comanda
GROUP BY c.id_comanda
HAVING COUNT(rc.id_produs) < (
    SELECT COUNT(id_produs)
    FROM rand_comenzi
    WHERE id_comanda = 2354
);

--2. Să se afișeze numele superiorului direct al angajatului 102.
select nume from angajati 
where id_angajat=(select id_manager from angajati
                    where id_angajat=102);


--1. Sa se insereze în angajați o nouă coloana cu minim o restricție



--2. Sa se modifice limita de credit pt clienții care au avut comenzi după 2017 cu media celor care au avut peste 3 comenzi
--3. Sa se afișeze nume, denumire, salariu... pentru cei care nu și-au schimbat funcția și nu mai știu ce (erau 4 tabele în join)


--1. Sa se insereze în angajați o nouă coloana cu minim o restricție
alter table angajati
add domiciliu varchar2(200);
    
alter table angajati
add constraint domiciliu_format check(domiciliu like 'jud.%loc.%str.%nr.%');



--2. Sa se modifice limita de credit pt clienții care au avut comenzi după 2017 cu media celor care au avut peste 3 comenzi

--clientii care au avut comenzi dupa 2017
--media clientilor care au peste 3 comenzi
select avg(limita_credit)
from clienti c
join comenzi cz
on c.id_client=cz.id_client
having count(cz.id_comanda)>3;

update clienti
set limita_credit=(select avg(limita_credit)
                    from clienti c
                    join comenzi cz
                    on c.id_client=cz.id_client
                    having count(cz.id_comanda)>3)
where id_client in(select id_client from comenzi
                    where extract(year from data)>2017 )


SELECT i.id_client,i.limita_credit
FROM clienti i
JOIN comenzi ci
  ON i.id_client = ci.id_client
WHERE EXTRACT(YEAR FROM ci.data) > 2017;

 --1. Sa se insereze în angajați o nouă coloana cu minim o restricție
alter table angajati
add domiciliu varchar2(200);
    
alter table angajati
add constraint domiciliu_format check(domiciliu like 'jud.%loc.%str.%nr.%');



--2. Sa se modifice limita de credit pt clienții care au avut comenzi după 2017 cu media celor care au avut peste 3 comenzi

--clientii care au avut comenzi dupa 2017
--media clientilor care au peste 3 comenzi
select avg(limita_credit)
from clienti c
join comenzi cz
on c.id_client=cz.id_client
having count(cz.id_comanda)>3;

update clienti
set limita_credit=(select avg(limita_credit)
                    from clienti c
                    join comenzi cz
                    on c.id_client=cz.id_client
                    having count(cz.id_comanda)>3)
where id_client in(select id_client from comenzi
                    where extract(year from data)>2017 )


SELECT i.id_client,i.limita_credit
FROM clienti i
JOIN comenzi ci
  ON i.id_client = ci.id_client
WHERE EXTRACT(YEAR FROM ci.data) > 2017;

 

 rollback
 
 --sa se adauge in tabela angajati o coloana noua numita durata_contract
 --avand doua restrictii si o valoare implicita
 
 alter table angajati
 add durata_contract number(10) default 2;
 
 alter table angajati
modify durata_contract not null;

alter table angajati
add constraint durata_determinata check(durata_contract between 1 and 20);

 alter table angajati
modify durata_contract default 2;
 
 --sa se modifice pretul de lista al produselor din categoria hardware 7
 --care se regasesc in comenzi intermediate in ultimul an in care s au dat comenzi
 --noul pret de lista va fi egal cu cel mai mare pret de lista al
 --produselor din aceasta categorie
 
 update produse
 set pret_lista=
 (select max(pret_lista) from produse)
where id_produs in
(
select id_produs from comenzi
where extract(year from data)=(select extract(year from data)from comenzi
                                    order desc by data
                                    fetch first 1 row only)
);
           
rollback











                                






