create table client_hotel
(
    nr_client CHAR(3) CONSTRAINT pk_clienti PRIMARY KEY,
    cnp CHAR(13) CONSTRAINT uq_cnp UNIQUE,
    nume VARCHAR2(25) CONSTRAINT nn_nume NOT NULL,
    prenume VARCHAR2(25) NOT NULL,
    email varchar2(35) not null,
    telefon char(10) not null
   

);
create table serviciu
( id_serviciu number(5) constraint pk_serviciu primary key,
    nume_serviciu varchar2(15),
    tip varchar2(10),
    pret number(4),
    disponibilitate number(1) check (disponibilitate=0 or disponibilitate=1),
    check (disponibilitate is not null)
    
);
create table manager
(  
    id_manager number(5) constraint pk_manager primary key,
    cnp CHAR(13) CONSTRAINT uq UNIQUE,
    nume VARCHAR2(25) CONSTRAINT n_nume NOT NULL,
    prenume VARCHAR2(25) NOT NULL,
    email varchar2(35) not null,
    telefon char(10) not null
   

    

);


create table receptioner
(   id_receptioner number(5) constraint pk_receptioner primary key,
    id_manager number(5) constraint fk_manager references manager(id_manager),
    cnp CHAR(13) CONSTRAINT uq_receptioner_cnp  UNIQUE,
    nume VARCHAR2(25) CONSTRAINT nume_recept NOT NULL,
    prenume VARCHAR2(25) NOT NULL,
    email varchar2(35) not null,
    telefon char(10) not null
    

);
create table discount
(
    id_discount number(2) constraint pk_discount primary key,
    id_manager number(5) constraint fk_manager_acc_discount references manager(id_manager),
    procent_discount varchar2(4)


);

CREATE TABLE rezervare (
    nr_rezervare NUMBER(5) CONSTRAINT pk_rezervare PRIMARY KEY,
    id_receptioner NUMBER(5) CONSTRAINT fk_receptioner_rezervare REFERENCES receptioner(id_receptioner),
    nr_client CHAR(3) CONSTRAINT fk_client_rezervare REFERENCES client_hotel(nr_client),
    data_incepere_sejur DATE,
    data_incheiere_sejur DATE,
    id_discount NUMBER(2) CONSTRAINT fk_discount_rezervare REFERENCES discount(id_discount)
);

CREATE TABLE cazare (
    id_cazare NUMBER(5) CONSTRAINT pk_cazare PRIMARY KEY,
    nr_rezervare NUMBER(5) CONSTRAINT fk_rezervare_cazare REFERENCES rezervare(nr_rezervare),
    nr_client CHAR(3) CONSTRAINT fk_client_cazare REFERENCES client_hotel(nr_client),
    data_check_in DATE NOT NULL,
    data_check_out DATE NOT NULL,
    tip_camera VARCHAR2(20) NOT NULL, -- Tipul camerei (ex: single, dublă, apartament)
    status_cazare VARCHAR2(20) CONSTRAINT ck_status CHECK (status_cazare IN ('cazat', 'necazat')) NOT NULL
);
CREATE TABLE factura (
    id_factura NUMBER(5) CONSTRAINT pk_factura PRIMARY KEY,
    id_cazare NUMBER(5) CONSTRAINT fk_cazare_factura REFERENCES cazare(id_cazare),
    data_facturii DATE NOT NULL,
    suma_totală NUMBER(8, 2) NOT NULL, -- Suma totală de plată
    tip_plata VARCHAR2(15) CHECK (tip_plata IN ('transfer bancar', 'numerar', 'card bancar')) NOT NULL, -- Modalitatea de plată
    status_plata VARCHAR2(15) CHECK (status_plata IN ('plătită', 'neplătită')) NOT NULL -- Statusul plății
);
CREATE TABLE feedback (
    id_feedback NUMBER(5) CONSTRAINT pk_feedback PRIMARY KEY,
    id_cazare NUMBER(5) CONSTRAINT fk_cazare_feedback REFERENCES cazare(id_cazare),
    rating NUMBER(1) CHECK (rating BETWEEN 1 AND 5) NOT NULL, -- Rating-ul acordat (1 - 5)
    comentarii VARCHAR2(500), -- Comentarii ale clientului
    data_feedback DATE NOT NULL -- Data în care a fost completat feedback-ul
);

CREATE TABLE info_rezervari (
    id_info_rezervare NUMBER(5) CONSTRAINT pk_info_rezervare PRIMARY KEY,  -- Cheie primară
    nr_rezervare NUMBER(5) CONSTRAINT fk_rezervare_info REFERENCES rezervare(nr_rezervare),  -- Cheie străină către tabela rezervare
    id_serviciu NUMBER(5) CONSTRAINT fk_serviciu_info REFERENCES serviciu(id_serviciu),  -- Cheie străină către tabela serviciu
    data_rezervare DATE NOT NULL,  -- Data rezervării
    cantitate NUMBER(3) DEFAULT 1,  -- Cantitatea serviciului (opțional)
    pret_total NUMBER(8, 2),  -- Prețul total pentru serviciu (opțional)
    CONSTRAINT chk_cantitate CHECK (cantitate > 0),  -- Verificare cantitate pozitivă
    CONSTRAINT chk_pret_total CHECK (pret_total >= 0)  -- Verificare preț pozitiv
);




