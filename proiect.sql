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

alter table utilizator modify data_nasterii DATE NOT NULL;

alter table joc drop constraint editor_id;
alter table joc add constraint fk_editor foreign key(editor_id) references editor(editor_id);

alter table achievement drop constraint pk_ach;
alter table achievement add constraint pk_ach primary key (id_joc, username, achievement_name);
--insert utilizatori
insert into utilizator (username, nume_user, prenume_user, data_nasterii, email_user, telefon_user, credit)
values ('andrei.popescu87', 'Popescu', 'Andrei', to_date('1987-06-15', 'YYYY-MM-DD'), 'andrei.popescu@example.com', '0712345678', 150);

insert into utilizator (username, nume_user, prenume_user, data_nasterii, email_user, telefon_user, credit)
values ('maria.ionescu95', 'Ionescu', 'Maria', to_date('1995-03-22', 'YYYY-MM-DD'), 'maria.ionescu@example.com', '0723456789', 200);

insert into utilizator (username, nume_user, prenume_user, data_nasterii, email_user, telefon_user, credit)
values ('elena.dumitru92', 'Dumitru', 'Elena', to_date('1992-11-10', 'YYYY-MM-DD'), 'elena.dumitru@example.com', '0734567890', 300);

insert into utilizator (username, nume_user, prenume_user, data_nasterii, email_user, telefon_user, credit)
values ('mihai.geo85', 'Georgescu', 'Mihai', to_date('1985-07-19', 'YYYY-MM-DD'), 'mihai.georgescu@example.com', '0745678901', 120);

insert into utilizator (username, nume_user, prenume_user, data_nasterii, email_user, telefon_user, credit)
values ('ioana_stan2000', 'Stan', 'Ioana', to_date('2000-01-30', 'YYYY-MM-DD'), 'ioana.stan@example.com', '0756789012', 500);

insert into utilizator (username, nume_user, prenume_user, data_nasterii, email_user, telefon_user, credit)
values ('cristian.radulescu98', 'Radulescu', 'Cristian', to_date('1998-05-12', 'YYYY-MM-DD'), 'cristian.radulescu@example.com', '0767890123', 250);

insert into utilizator (username, nume_user, prenume_user, data_nasterii, email_user, telefon_user, credit)
values ('diana_marine90', 'Marinescu', 'Diana', to_date('1990-09-05', 'YYYY-MM-DD'), 'diana.marinescu@example.com', '0778901234', 180);

insert into utilizator (username, nume_user, prenume_user, data_nasterii, email_user, telefon_user, credit)
values ('alex.voinea83', 'Voinea', 'Alexandru', to_date('1983-04-25', 'YYYY-MM-DD'), 'alex.voinea@example.com', '0789012345', 320);

insert into utilizator (username, nume_user, prenume_user, data_nasterii, email_user, telefon_user, credit)
values ('rox.lazar96', 'Lazar', 'Roxana', to_date('1996-12-08', 'YYYY-MM-DD'), 'roxana.lazar@example.com', '0790123456', 400);

insert into utilizator (username, nume_user, prenume_user, data_nasterii, email_user, telefon_user, credit)
values ('vlad_enache88', 'Enache', 'Vlad', to_date('1988-02-14', 'YYYY-MM-DD'), 'vlad.enache@example.com', '0701234567', 275);

--inserare editori
insert into editor (editor_id, email_editor, telefon_editor)
values ('EDT-1001', 'editor1@example.com', '0712345678');

insert into editor (editor_id, email_editor, telefon_editor)
values ('EDT-1002', 'editor2@example.com', '0723456789');

insert into editor (editor_id, email_editor, telefon_editor)
values ('EDT-1003', 'editor3@example.com', '0734567890');

insert into editor (editor_id, email_editor, telefon_editor)
values ('EDT-1004', 'editor4@example.com', '0745678901');

insert into editor (editor_id, email_editor, telefon_editor)
values ('EDT-1005', 'editor5@example.com', '0756789012');

insert into editor (editor_id, email_editor, telefon_editor)
values ('EDT-1006', 'editor6@example.com', '0767890123');

insert into editor (editor_id, email_editor, telefon_editor)
values ('EDT-1007', 'editor7@example.com', '0778901234');

insert into editor (editor_id, email_editor, telefon_editor)
values ('EDT-1008', 'editor8@example.com', '0789012345');

insert into editor (editor_id, email_editor, telefon_editor)
values ('EDT-1009', 'editor9@example.com', '0790123456');

insert into editor (editor_id, email_editor, telefon_editor)
values ('EDT-1010', 'editor10@example.com', '0701234567');

insert into editor (editor_id, email_editor, telefon_editor)
values ('EDT-1011', 'editor11@example.com', '0712233445');

insert into editor (editor_id, email_editor, telefon_editor)
values ('EDT-1012', 'editor12@example.com', '0723344556');

insert into editor (editor_id, email_editor, telefon_editor)
values ('EDT-1013', 'editor13@example.com', '0734455667');

insert into editor (editor_id, email_editor, telefon_editor)
values ('EDT-1014', 'editor14@example.com', '0745566778');

insert into editor (editor_id, email_editor, telefon_editor)
values ('EDT-1015', 'editor15@example.com', '0756677889');

--inserare jocuri

--inserare jocuri
insert into joc (id_joc, memorie_utilizata, categorie, titlu, pret, editor_id)
values ('JOC-1001', 2048, 'Action', 'Super Adventure', 45, 'EDT-1001');

insert into joc (id_joc, memorie_utilizata, categorie, titlu, pret, editor_id)
values ('JOC-1002', 1024, 'Strategy', 'War Tactics', 55, 'EDT-1002');

insert into joc (id_joc, memorie_utilizata, categorie, titlu, pret, editor_id)
values ('JOC-1003', 512, 'Puzzle', 'Mind Challenge', 35, 'EDT-1003');

insert into joc (id_joc, memorie_utilizata, categorie, titlu, pret, editor_id)
values ('JOC-1004', 3072, 'RPG', 'Fantasy Quest', 60, 'EDT-1004');

insert into joc (id_joc, memorie_utilizata, categorie, titlu, pret, editor_id)
values ('JOC-1005', 4096, 'Shooter', 'Battlefield X', 70, 'EDT-1005');

insert into joc (id_joc, memorie_utilizata, categorie, titlu, pret, editor_id)
values ('JOC-1006', 1024, 'Racing', 'Speed Rush', 50, 'EDT-1006');

insert into joc (id_joc, memorie_utilizata, categorie, titlu, pret, editor_id)
values ('JOC-1007', 512, 'Simulation', 'City Builder', 40, 'EDT-1007');

insert into joc (id_joc, memorie_utilizata, categorie, titlu, pret, editor_id)
values ('JOC-1008', 2048, 'Sports', 'Football Pro', 55, 'EDT-1008');

insert into joc (id_joc, memorie_utilizata, categorie, titlu, pret, editor_id)
values ('JOC-1009', 3072, 'Horror', 'Dark Nightmares', 65, 'EDT-1009');

insert into joc (id_joc, memorie_utilizata, categorie, titlu, pret, editor_id)
values ('JOC-1010', 1024, 'Adventure', 'Lost Island', 48, 'EDT-1010');

insert into joc (id_joc, memorie_utilizata, categorie, titlu, pret, editor_id)
values ('JOC-1011', 1536, 'Strategy', 'Empire Builder', 58, 'EDT-1011');

insert into joc (id_joc, memorie_utilizata, categorie, titlu, pret, editor_id)
values ('JOC-1012', 4096, 'Action', 'Cyber Assault', 75, 'EDT-1012');

insert into joc (id_joc, memorie_utilizata, categorie, titlu, pret, editor_id)
values ('JOC-1013', 1024, 'Puzzle', 'Brain Teaser', 30, 'EDT-1013');

insert into joc (id_joc, memorie_utilizata, categorie, titlu, pret, editor_id)
values ('JOC-1014', 512, 'RPG', 'Hero’s Journey', 45, 'EDT-1014');

insert into joc (id_joc, memorie_utilizata, categorie, titlu, pret, editor_id)
values ('JOC-1015', 2048, 'Shooter', 'Alien Invasion', 67, 'EDT-1015');

insert into joc (id_joc, memorie_utilizata, categorie, titlu, pret, editor_id)
values ('JOC-1016', 3072, 'Horror', 'Haunted Mansion', 55, 'EDT-1001');

insert into joc (id_joc, memorie_utilizata, categorie, titlu, pret, editor_id)
values ('JOC-1017', 1024, 'Adventure', 'Space Odyssey', 50, 'EDT-1002');

insert into joc (id_joc, memorie_utilizata, categorie, titlu, pret, editor_id)
values ('JOC-1018', 4096, 'Racing', 'Off-Road Kings', 60, 'EDT-1003');

insert into joc (id_joc, memorie_utilizata, categorie, titlu, pret, editor_id)
values ('JOC-1019', 1536, 'Simulation', 'Farming Life', 45, 'EDT-1004');

insert into joc (id_joc, memorie_utilizata, categorie, titlu, pret, editor_id)
values ('JOC-1020', 1024, 'Sports', 'Tennis Champion', 35, 'EDT-1005');

INSERT INTO biblioteca_user (id_joc, username, data_adaugare)
VALUES ('JOC-1004', 'andrei.popescu87', TO_DATE('2024-02-01', 'YYYY-MM-DD'));

INSERT INTO biblioteca_user (id_joc, username, data_adaugare)
VALUES ('JOC-1005', 'maria.ionescu95', TO_DATE('2024-02-10', 'YYYY-MM-DD'));

INSERT INTO biblioteca_user (id_joc, username, data_adaugare)
VALUES ('JOC-1006', 'elena.dumitru92', TO_DATE('2024-02-20', 'YYYY-MM-DD'));

INSERT INTO biblioteca_user (id_joc, username, data_adaugare)
VALUES ('JOC-1007', 'mihai.geo85', TO_DATE('2024-03-05', 'YYYY-MM-DD'));

INSERT INTO biblioteca_user (id_joc, username, data_adaugare)
VALUES ('JOC-1008', 'ioana_stan2000', TO_DATE('2024-03-10', 'YYYY-MM-DD'));

INSERT INTO biblioteca_user (id_joc, username, data_adaugare)
VALUES ('JOC-1009', 'cristian.radulescu98', TO_DATE('2024-03-15', 'YYYY-MM-DD'));

INSERT INTO biblioteca_user (id_joc, username, data_adaugare)
VALUES ('JOC-1010', 'diana_marine90', TO_DATE('2024-03-20', 'YYYY-MM-DD'));

INSERT INTO biblioteca_user (id_joc, username, data_adaugare)
VALUES ('JOC-1011', 'alex.voinea83', TO_DATE('2024-03-25', 'YYYY-MM-DD'));

INSERT INTO biblioteca_user (id_joc, username, data_adaugare)
VALUES ('JOC-1012', 'rox.lazar96', TO_DATE('2024-04-01', 'YYYY-MM-DD'));

INSERT INTO biblioteca_user (id_joc, username, data_adaugare)
VALUES ('JOC-1013', 'vlad_enache88', TO_DATE('2024-04-05', 'YYYY-MM-DD'));

INSERT INTO biblioteca_user (id_joc, username, data_adaugare)
VALUES ('JOC-1015', 'mihai.geo85', TO_DATE('2024-04-12', 'YYYY-MM-DD'));

INSERT INTO biblioteca_user (id_joc, username, data_adaugare)
VALUES ('JOC-1016', 'ioana_stan2000', TO_DATE('2024-04-15', 'YYYY-MM-DD'));

INSERT INTO biblioteca_user (id_joc, username, data_adaugare)
VALUES ('JOC-1017', 'cristian.radulescu98', TO_DATE('2024-04-20', 'YYYY-MM-DD'));

INSERT INTO biblioteca_user (id_joc, username, data_adaugare)
VALUES ('JOC-1018', 'diana_marine90', TO_DATE('2024-04-22', 'YYYY-MM-DD'));

INSERT INTO biblioteca_user (id_joc, username, data_adaugare)
VALUES ('JOC-1019', 'alex.voinea83', TO_DATE('2024-04-25', 'YYYY-MM-DD'));

INSERT INTO biblioteca_user (id_joc, username, data_adaugare)
VALUES ('JOC-1020', 'rox.lazar96', TO_DATE('2024-04-28', 'YYYY-MM-DD'));

INSERT INTO biblioteca_user (id_joc, username, data_adaugare)
VALUES ('JOC-1004', 'vlad_enache88', TO_DATE('2024-05-01', 'YYYY-MM-DD'));

INSERT INTO biblioteca_user (id_joc, username, data_adaugare)
VALUES ('JOC-1005', 'andrei.popescu87', TO_DATE('2024-05-03', 'YYYY-MM-DD'));

INSERT INTO biblioteca_user (id_joc, username, data_adaugare)
VALUES ('JOC-1006', 'maria.ionescu95', TO_DATE('2024-05-05', 'YYYY-MM-DD'));

INSERT INTO biblioteca_user (id_joc, username, data_adaugare)
VALUES ('JOC-1007', 'elena.dumitru92', TO_DATE('2024-05-08', 'YYYY-MM-DD'));

INSERT INTO biblioteca_user (id_joc, username, data_adaugare)
VALUES ('JOC-1004', 'mihai.geo85', TO_DATE('2024-02-01', 'YYYY-MM-DD'));

INSERT INTO biblioteca_user (id_joc, username, data_adaugare)
VALUES ('JOC-1005', 'ioana_stan2000', TO_DATE('2024-02-02', 'YYYY-MM-DD'));

INSERT INTO biblioteca_user (id_joc, username, data_adaugare)
VALUES ('JOC-1006', 'cristian.radulescu98', TO_DATE('2024-02-03', 'YYYY-MM-DD'));

INSERT INTO biblioteca_user (id_joc, username, data_adaugare)
VALUES ('JOC-1007', 'diana_marine90', TO_DATE('2024-02-04', 'YYYY-MM-DD'));

INSERT INTO biblioteca_user (id_joc, username, data_adaugare)
VALUES ('JOC-1008', 'alex.voinea83', TO_DATE('2024-02-05', 'YYYY-MM-DD'));

INSERT INTO biblioteca_user (id_joc, username, data_adaugare)
VALUES ('JOC-1009', 'rox.lazar96', TO_DATE('2024-02-06', 'YYYY-MM-DD'));

INSERT INTO biblioteca_user (id_joc, username, data_adaugare)
VALUES ('JOC-1010', 'vlad_enache88', TO_DATE('2024-02-07', 'YYYY-MM-DD'));

INSERT INTO biblioteca_user (id_joc, username, data_adaugare)
VALUES ('JOC-1011', 'andrei.popescu87', TO_DATE('2024-02-08', 'YYYY-MM-DD'));

INSERT INTO biblioteca_user (id_joc, username, data_adaugare)
VALUES ('JOC-1012', 'maria.ionescu95', TO_DATE('2024-02-09', 'YYYY-MM-DD'));

INSERT INTO biblioteca_user (id_joc, username, data_adaugare)
VALUES ('JOC-1013', 'elena.dumitru92', TO_DATE('2024-02-10', 'YYYY-MM-DD'));

INSERT INTO achievement (id_joc, username, achievement_name)
VALUES ('JOC-1004', 'mihai.geo85', 'Legendary Warrior');

INSERT INTO achievement (id_joc, username, achievement_name)
VALUES ('JOC-1005', 'ioana_stan2000', 'Sharpshooter Elite');

INSERT INTO achievement (id_joc, username, achievement_name)
VALUES ('JOC-1006', 'cristian.radulescu98', 'Speed Demon');

INSERT INTO achievement (id_joc, username, achievement_name)
VALUES ('JOC-1007', 'diana_marine90', 'Architect of the Future');

INSERT INTO achievement (id_joc, username, achievement_name)
VALUES ('JOC-1008', 'alex.voinea83', 'Football Legend');

INSERT INTO achievement (id_joc, username, achievement_name)
VALUES ('JOC-1009', 'rox.lazar96', 'Master of Fear');

INSERT INTO achievement (id_joc, username, achievement_name)
VALUES ('JOC-1010', 'vlad_enache88', 'Survival Expert');

INSERT INTO achievement (id_joc, username, achievement_name)
VALUES ('JOC-1011', 'andrei.popescu87', 'Empire Architect');

INSERT INTO achievement (id_joc, username, achievement_name)
VALUES ('JOC-1012', 'maria.ionescu95', 'Cyber Warrior');

INSERT INTO achievement (id_joc, username, achievement_name)
VALUES ('JOC-1013', 'elena.dumitru92', 'Brainiac');

SET SERVEROUTPUT ON
-- 1. Cursor implicit pentru a insuma preturile jocurilor dintr-o categorie specifica
DECLARE
    v_suma NUMBER := 0;
BEGIN
   
    SELECT SUM(pret) INTO v_suma FROM joc WHERE categorie = 'Sports';
    
    DBMS_OUTPUT.PUT_LINE('Suma preturilor pentru categoria Sports: ' || v_suma);
END;
/
select *from joc;
SET SERVEROUTPUT ON
-- 2. Cursor explicit pentru a lista titlurile jocurilor cu memorie utilizata mai mare de 500MB
DECLARE
    CURSOR c_jocuri IS
        SELECT titlu FROM joc WHERE memorie_utilizata > 500;
    v_titlu joc.titlu%TYPE;
BEGIN
    OPEN c_jocuri;
    LOOP
        FETCH c_jocuri INTO v_titlu;
        EXIT WHEN c_jocuri%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Joc: ' || v_titlu);
    END LOOP;
    CLOSE c_jocuri;
END;
/
select editor_id from joc;

SET SERVEROUTPUT ON
-- 3. Cursor FOR LOOP pentru a afisa toate jocurile dintr-o categorie data
BEGIN
    FOR r_joc IN (SELECT titlu FROM joc WHERE categorie ='RPG') LOOP
        DBMS_OUTPUT.PUT_LINE('Joc de actiune: ' || r_joc.titlu);
    END LOOP;
END;

/
SET SERVEROUTPUT ON
-- 4. Cursor explicit pentru a actualiza pretul jocurilor sub 50 cu o crestere de 10%
DECLARE
    CURSOR c_preturi IS
        SELECT id_joc, pret FROM joc WHERE pret < 50 FOR UPDATE;
    v_id joc.id_joc%TYPE;
    v_pret joc.pret%TYPE;
BEGIN
    OPEN c_preturi;
    LOOP
        FETCH c_preturi INTO v_id, v_pret;
        EXIT WHEN c_preturi%NOTFOUND;
        UPDATE joc SET pret = v_pret * 1.1 WHERE id_joc = v_id;
    END LOOP;
    CLOSE c_preturi;
    COMMIT;
END;
/
SET SERVEROUTPUT ON
--5.Cursor explicit cu parametri afișează toate jocurile care costă mai mult decât un preț dat ca parametru.
DECLARE
    CURSOR cur_jocuri(v_pret NUMBER) IS 
        SELECT titlu, pret FROM joc WHERE pret > v_pret;

    v_titlu joc.titlu%TYPE;
    v_pret joc.pret%TYPE;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('Jocurile cu pret mai mare decat pragul dat:');
    
    OPEN cur_jocuri(50); -- De exemplu, 50 RON ca limită
    LOOP
        FETCH cur_jocuri INTO v_titlu, v_pret;
        EXIT WHEN cur_jocuri%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Titlu: ' || v_titlu || ' | Pret: ' || v_pret || ' RON');
    END LOOP;
    
    CLOSE cur_jocuri;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: ' || SQLERRM);
END;
/
SET SERVEROUTPUT ON
--6. Cursor implicit care calculează și afișează suma totală a memoriei utilizate de jocurile din fiecare categorie.
DECLARE
    v_total_memorie NUMBER;
    v_categorie joc.categorie%TYPE;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Total memorie utilizata per categorie:');
    
    FOR rec IN (SELECT categorie, SUM(memorie_utilizata) AS total_mem FROM joc GROUP BY categorie) LOOP
        v_categorie := rec.categorie;
        v_total_memorie := rec.total_mem;
        
        DBMS_OUTPUT.PUT_LINE('Categorie: ' || v_categorie || ' | Memorie Totala: ' || v_total_memorie || ' MB');
    END LOOP;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista date in tabel.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: ' || SQLERRM);
END;
/


ALTER TABLE joc RENAME TO jocuri;
ALTER TABLE utilizator RENAME TO utilizatori;
ALTER TABLE editor RENAME TO editori;












