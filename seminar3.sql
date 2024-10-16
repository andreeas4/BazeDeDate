--alter
--sa se adauge in tabela abonati 2 coloane : email si telefon
alter table abonati
add ( 
email varchar2(20),
telefon char(10) UNIQUE

);



--modificare a tipului de data sau a dimensiunii pt localitate
ALTER TABLE abonati
modify (localitate varchar2(40));

--redenumire camp email
ALTER TABLE abonati
RENAME column email to adresa_mail;

--stergere coloane
ALTER TABLE abonati
drop column localitate;

--sa se adauge o restrictie prin care coloana email sa primeasca val unice
ALTER TABLE abonati
add constraint email_unique Unique (adresa_mail);

--sa se adauge o restrictie coloanei adresei de mail prin  care sa se verifice formatul emailului
ALTER TABLE abonati
add constraint format_mail check(adresa_mail like '%@%.%');

--sa se adauge o restrictie coloanei adresa mail prin care sa fie obligatorie 
ALTER TABLE abonati
add constraint email_nn check(adresa_mail is not null);
--sau 
--ALTER TABLE abonati
--modify (adresa_mail not null)

--sa se adauge o restrictie la nivelul coloanei cnp prin care sa se verifice lungimea sirului introdus
ALTER TABLE abonati
add constraint cnp_lungime check(length(trim(cnp)=13)); 

--insert
insert into abonati 
values (1,'60','Ion','Gigel','gigel@gmail.com','0754271289');

delete from abonati; --stergere date din abonati

--stergere restrictie 
ALTER TABLE abonati
drop constraint cnp_lungime;

--obs char=13byte deci
--enable/disable constraint
insert into abonati 
values (1,'6050894032133','Ion','Gigel','gigel@gmail.com','0754271289');

ALTER TABLE abonati
add constraint cnp_lungime check(length(trim(cnp))=13); 

ALTER TABLE abonati
disable constraint cnp_lungime;
