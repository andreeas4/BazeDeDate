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

