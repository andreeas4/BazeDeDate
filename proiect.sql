create table utilizator
(   
username varchar2(20) constraint pk_users primary key,
nume_user varchar2(20),
prenume_user varchar2(20),
data_nasterii date,
email_user varchar2(35),
telefon_user varchar2(10),
credit number,

constraint nn_data_nastere check(data_nasterii is not null),
constraint nn_email check(email_user is not null),
constraint email_unique Unique (email_user),
constraint email_type check  (email_user like '%@%.com')



);


create table editor
(
  editor_id varchar2(20) constraint pk_editor primary key, 
  email_editor varchar2(35),
  telefon_editor char(10),
  constraint email_unique_editor Unique (email_editor),
  constraint nn_email_editor check(email_editor is not null),
  constraint email_type_editor check  (email_editor like '%@%.com')

);



create table joc
(
id_joc char(10),
memorie_utilizata number,
categorie varchar2(15),
titlu varchar2(30),
pret number,
editor_id varchar2(20),
constraint pk_id_joc primary key(id_joc),
constraint editor_id foreign key(editor_id) references editor(editor_id)

);


create table biblioteca_user
(
id_joc char(10) constraint fk_joc references joc(id_joc),
username varchar2(20) constraint fk_users references utilizator(username),
data_adaugare date,

constraint pk_bibl_joc_user primary key (id_joc,username)


);





create table achizitii (
    id_joc char(10),
    username varchar2(20),
    id_comanda char(20) constraint pk_comanda primary key,
    data_comanda date not null,
    constraint fk_bibl_user foreign key (id_joc, username) references biblioteca_user (id_joc, username)
);

create table achievement
(
id_joc char(10),
username varchar2(20),
achievement_name varchar2(25) constraint pk_ach primary key,
constraint fk_bibl_user_ach foreign key (id_joc, username) references biblioteca_user (id_joc, username)

);

insert into utilizator (username, nume_user, prenume_user, data_nasterii, email_user, telefon_user, credit)
values ('utilizator1', 'Popescu', 'Andrei', to_date('1987-06-15', 'YYYY-MM-DD'), 'utilizator1@example.com', '0712345678', 150);

insert into utilizator (username, nume_user, prenume_user, data_nasterii, email_user, telefon_user, credit)
values ('utilizator2', 'Ionescu', 'Maria', to_date('1990-11-22', 'YYYY-MM-DD'), 'utilizator2@example.com', '0723456789', 250);

insert into utilizator (username, nume_user, prenume_user, data_nasterii, email_user, telefon_user, credit)
values ('utilizator3', 'Georgescu', 'Ion', to_date('1995-02-10', 'YYYY-MM-DD'), 'utilizator3@example.com', '0734567890', 300);



insert into utilizator (username, nume_user, prenume_user, data_nasterii, email_user, telefon_user, credit)
values ('utilizator1', 'Popescu', 'Andrei', to_date('1987-06-15', 'YYYY-MM-DD'), 'utilizator1@example.com', '0712345678', 150);

insert into utilizator (username, nume_user, prenume_user, data_nasterii, email_user, telefon_user, credit)
values ('utilizator2', 'Ionescu', 'Maria', to_date('1990-11-22', 'YYYY-MM-DD'), 'utilizator2@example.com', '0723456789', 250);

insert into utilizator (username, nume_user, prenume_user, data_nasterii, email_user, telefon_user, credit)
values ('utilizator3', 'Georgescu', 'Ion', to_date('1995-02-10', 'YYYY-MM-DD'), 'utilizator3@example.com', '0734567890', 300);

insert into editor (editor_id, email_editor, telefon_editor)
values ('editor001', 'editor1@example.com', '0712345678');

insert into editor (editor_id, email_editor, telefon_editor)
values ('editor002', 'editor2@example.com', '0723456789');

insert into editor (editor_id, email_editor, telefon_editor)
values ('editor003', 'editor3@example.com', '0734567890');

insert into joc (id_joc, memorie_utilizata, categorie, titlu, pret, editor_id)
values ('game01', 2048, 'Action', 'Super Adventure', 45, 'editor001');

insert into joc (id_joc, memorie_utilizata, categorie, titlu, pret, editor_id)
values ('game02', 1024, 'Strategy', 'War Tactics', 55, 'editor002');

insert into joc (id_joc, memorie_utilizata, categorie, titlu, pret, editor_id)
values ('game03', 512, 'Puzzle', 'Mind Challenge', 35, 'editor003');

insert into biblioteca_user (id_joc, username, data_adaugare)
values ('game01', 'utilizator1', to_date('2024-01-15', 'YYYY-MM-DD'));

insert into biblioteca_user (id_joc, username, data_adaugare)
values ('game02', 'utilizator2', to_date('2024-02-10', 'YYYY-MM-DD'));

insert into biblioteca_user (id_joc, username, data_adaugare)
values ('game03', 'utilizator3', to_date('2024-03-05', 'YYYY-MM-DD'));

insert into achizitii (id_joc, username, id_comanda, data_comanda)
values ('game01', 'utilizator1', 'comanda01', to_date('2024-01-16', 'YYYY-MM-DD'));

insert into achizitii (id_joc, username, id_comanda, data_comanda)
values ('game02', 'utilizator2', 'comanda02', to_date('2024-02-11', 'YYYY-MM-DD'));

insert into achizitii (id_joc, username, id_comanda, data_comanda)
values ('game03', 'utilizator3', 'comanda03', to_date('2024-03-06', 'YYYY-MM-DD'));

insert into achievement (id_joc, username, achievement_name)
values ('game01', 'utilizator1', 'Master Explorer');

insert into achievement (id_joc, username, achievement_name)
values ('game02', 'utilizator2', 'Tactics Genius');

insert into achievement (id_joc, username, achievement_name)
values ('game03', 'utilizator3', 'Puzzle Expert');

-- 1. Obțineți lista utilizatorilor și titlurile jocurilor din biblioteca lor, împreună cu numărul total de zile de când jocul a fost adăugat.
select u.username, u.nume_user, u.prenume_user, j.titlu, 
       trunc(sysdate - b.data_adaugare) as zile_in_biblioteca
from utilizator u
join biblioteca_user b on u.username = b.username
join joc j on b.id_joc = j.id_joc;

-- 2. Lista editorilor și numărul total de jocuri publicate de fiecare editor.
select e.editor_id, e.email_editor, count(j.id_joc) as numar_jocuri
from editor e
left join joc j on e.editor_id = j.editor_id
group by e.editor_id, e.email_editor;

-- 3. Obțineți utilizatorii care au achiziționat cel puțin un joc și suma totală cheltuită pe jocuri.
select u.username, u.nume_user, u.prenume_user, sum(j.pret) as suma_cheltuita
from utilizator u
join achizitii a on u.username = a.username
join joc j on a.id_joc = j.id_joc
group by u.username, u.nume_user, u.prenume_user
having sum(j.pret) > 0;

-- 4. Lista utilizatorilor care au achiziționat cel puțin două jocuri și suma totală cheltuită.
select u.username, u.nume_user, u.prenume_user, count(a.id_joc) as numar_jocuri, sum(j.pret) as suma_cheltuita
from utilizator u
join achizitii a on u.username = a.username
join joc j on a.id_joc = j.id_joc
group by u.username, u.nume_user, u.prenume_user
having count(a.id_joc) >= 2;

-- 5. Obțineți utilizatorii care au în bibliotecă jocuri cu memorie utilizată mai mare de 1GB (1024 MB).
select u.username, u.nume_user, u.prenume_user, j.titlu, j.memorie_utilizata
from utilizator u
join biblioteca_user b on u.username = b.username
join joc j on b.id_joc = j.id_joc
where j.memorie_utilizata > 1024
order by j.memorie_utilizata desc;

-- 1. Totalul de bani cheltuiți pe fiecare categorie de jocuri
SELECT j.categorie, SUM(j.pret) AS total_cheltuit
FROM joc j
JOIN achizitii a ON j.id_joc = a.id_joc
GROUP BY j.categorie
ORDER BY total_cheltuit DESC;


 --2. Numărul de jocuri din fiecare categorie din bibliotecile utilizatorilor

SELECT j.categorie, COUNT(b.id_joc) AS numar_jocuri
FROM biblioteca_user b
JOIN joc j ON b.id_joc = j.id_joc
GROUP BY j.categorie
ORDER BY numar_jocuri DESC;

-- 3. Suma creditelor disponibile pentru fiecare utilizator pe lună
SELECT TO_CHAR(b.data_adaugare, 'YYYY-MM') AS luna, u.username, SUM(u.credit) AS total_credit
FROM utilizator u
JOIN biblioteca_user b ON u.username = b.username
GROUP BY TO_CHAR(b.data_adaugare, 'YYYY-MM'), u.username
ORDER BY luna, u.username;

-- 4. Numărul total de achiziții făcute de fiecare utilizator, împărțit pe luni
SELECT u.username, TO_CHAR(a.data_comanda, 'YYYY-MM') AS luna, COUNT(a.id_comanda) AS total_achizitii
FROM utilizator u
JOIN achizitii a ON u.username = a.username
GROUP BY u.username, TO_CHAR(a.data_comanda, 'YYYY-MM')
ORDER BY u.username, luna;

-- 5. Jocurile care au generat cele mai multe achiziții
SELECT j.titlu, COUNT(a.id_comanda) AS numar_achizitii
FROM joc j
JOIN achizitii a ON j.id_joc = a.id_joc
GROUP BY j.titlu
ORDER BY numar_achizitii DESC;
--1.Lista utilizatorilor care au cumpărat jocuri cu preț mai mare decât prețul mediu al tuturor jocurilor
select username, nume_user, prenume_user
from utilizator
where username in (
    select a.username
    from achizitii a
    join joc j on a.id_joc = j.id_joc
    where j.pret > (select avg(pret) from joc)
);
--2.utilizatorii care au achiziționat jocuri care costă mai mult de 50
select u.username, u.nume_user, u.prenume_user
from utilizator u
where u.username in (
    select a.username
    from achizitii a
    join joc j on a.id_joc = j.id_joc
    where j.pret > 50
);
--3.editorii care au publicat jocuri cu mai mult de 2GB de memorie utilizată:
select e.editor_id, e.email_editor
from editor e
where e.editor_id in (
    select j.editor_id
    from joc j
    where j.memorie_utilizata > 2048
);
--4.utilizatorii care au cheltuit mai mult de 10 pe jocuri:
select u.username, u.nume_user, u.prenume_user, sum(j.pret) as suma_cheltuita
from utilizator u
join achizitii a on u.username = a.username
join joc j on a.id_joc = j.id_joc
group by u.username, u.nume_user, u.prenume_user
having sum(j.pret) > 10;
--5.jocurile care au fost achiziționate de utilizatori cu mai mult de 100 de credit disponibil:
select j.titlu, count(a.id_comanda) as numar_achizitii
from joc j
join achizitii a on j.id_joc = a.id_joc
join utilizator u on a.username = u.username
where u.credit > 100
group by j.titlu;
--cereri ierarhice
----------------------------
-- 1. Afișarea subordonaților direcți ai unui editor, având id_editor=editor001
select e.editor_id, e.email_editor, j.titlu
from editor e
join joc j on e.editor_id = j.editor_id
where e.editor_id = 'editor001';



-- 2. Afișarea superiorilor unui joc 
select level, e.editor_id, e.email_editor
from editor e
start with e.editor_id = 'editor003'
connect by nocycle prior e.editor_id = e.editor_id  
order by level;

-- 3. Afișarea subordonaților direcți și indirecți ai unui editor
select level, e.editor_id, e.email_editor, j.titlu
from editor e
join joc j on e.editor_id = j.editor_id
start with e.editor_id = 'editor001'
connect by nocycle prior e.editor_id = e.editor_id  -- Prevenirea buclelor
order by level;

-- 4. Afișarea superiorilor direcți ai unui editor
select level, e.editor_id, e.email_editor
from editor e
start with e.editor_id = 'editor003'
connect by nocycle prior e.editor_id = e.editor_id  -- Prevenirea buclelor
order by level;

-- 5. Afișarea numărului total de subordonați direcți și indirecți ai unui editor
select count(*) as numar_subordonati
from (
    select level, e.editor_id, e.email_editor
    from editor e
    start with e.editor_id = 'editor001'
    connect by nocycle prior e.editor_id = e.editor_id 
);

-- Crearea unei tabele virtuale (view) pentru utilizatorii care au cheltuit mai mult de 50 pe jocuri
create or replace view utilizatori_care_au_cheltuit_mai_mult_de_50
as
select u.username, u.nume_user, u.prenume_user, sum(j.pret) as suma_cheltuita
from utilizator u
join achizitii a on u.username = a.username
join joc j on a.id_joc = j.id_joc
group by u.username, u.nume_user, u.prenume_user
having sum(j.pret) > 50;

select * from utilizatori_care_au_cheltuit_mai_mult_de_50;


-- Crearea unui index compus pe coloanele 'pret' și 'memorie_utilizata'

create index idx_pret_memorie on joc(pret, memorie_utilizata);

-- Crearea unui index pe coloana 'editor_id'

create index idx_editor_id on joc(editor_id);

-- Crearea unui index pe coloana 'titlu'

create index idx_titlu on joc(titlu);

-- Crearea unui index pe coloana 'id_joc' (deși de obicei este deja indexat implicit)

create index idx_id_joc on joc(id_joc);

-- Crearea unui index pe coloana 'pret' pentru a ajuta la ordonarea rapidă a jocurilor pe baza prețului
create index idx_pret_order on joc(pret);





-- Crearea unui sinonim pentru tabelul 'joc'
-- Astfel, putem folosi 'games' în loc de 'joc' în interogările noastre
create synonym games for joc;

-- Crearea unui sinonim pentru coloana 'id_joc'
-- Acum putem folosi 'game_id' în loc de 'id_joc' în interogările noastre
create synonym game_id for id_joc;

-- Crearea unui sinonim pentru coloana 'memorie_utilizata'
-- Folosim 'used_memory' în loc de 'memorie_utilizata'
create synonym used_memory for memorie_utilizata;


create synonym category for categorie;

-- Crearea unui sinonim pentru coloana 'titlu'
-- Vom folosi 'title' în loc de 'titlu'
create synonym title for titlu;

-- Crearea unui sinonim pentru coloana 'pret'
-- Folosim 'price' în loc de 'pret'
create synonym price for pret;

-- Crearea unui sinonim pentru coloana 'editor_id'
-- Folosim 'editor_id_ref' în loc de 'editor_id'
create synonym editor_id_ref for editor_id;


-- Crearea unei secvențe pentru generarea automată a valorilor pentru 'game_id'
-- Folosim sinonimul 'game_id' pentru a se referi la coloana 'id_joc'
create sequence game_id_seq
start with 1
increment by 1;

-- Crearea unei secvențe pentru generarea automată a valorilor pentru 'editor_id_ref'
-- Folosim sinonimul 'editor_id_ref' pentru a se referi la coloana 'editor_id'
create sequence editor_id_seq
start with 1
increment by 1;












