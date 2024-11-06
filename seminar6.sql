select sum(salariul),min(salariul) from angajati;



select count(id_angajat) nr_ang

from angajati

where id_departament in(50,60);



select id_departament, count(id_angajat)

from angajati

group by id_departament; --nr ang din fiecare dep



--nr ang per depart daca slariile sunt peste 8000



select id_departament, count(id_angajat)

from angajati

where salariul>8000 

group by id_departament

having count(id_angajat)>1 --daca sunt mai multi ang

order by 2 desc; --a doua coloana de la output





--ex 1

select id_functie,count(id_angajat)

from angajati

group by id_functie;



--ex 2

select id_departament,id_functie, count(id_angajat)

from angajati

group by id_departament,id_functie;



--ex3

select id_departament, sum(salariul)/count(id_angajat) 

from angajati

where id_departament in(60,70,80)

group by id_departament;



--ex4

SELECT user, sysdate, 'STANCIULESCU ANDREEA' FROM dual; 



--ex5

select id_comanda, count(id_produs)

from rand_comenzi

group by id_comanda;



--ex6

select id_comanda,sum(pret*cantitate) as valoare

from rand_comenzi

group by id_comanda;



--ex 7

select id_produs,sum(pret*cantitate) as valoare

from rand_comenzi

group by id_produs;



--ex 8

select id_comanda,sum(pret*cantitate) as valoare

from rand_comenzi

group by id_comanda

having count(id_produs)>5

order by sum(pret*cantitate) desc;



--ex 9

select id_angajat,count(id_functie) 

from istoric_functii

group by id_angajat

having count(id_functie) > 2;



--ex 10

select id_departament, round(sum(salariul)/count(id_angajat) )as salariu_mediu

from angajati

group by id_departament

order by 2 desc

fetch first 1 row only; 



--ex 11



update ANGAJATI 

SET SALARIUL =(select salariul from angajati 

                where id_angajat=204)

where id_functie='IT_PROG';



--ex 12

