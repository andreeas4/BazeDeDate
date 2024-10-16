--crearea tabelei Abonati cu indicarea restrictiilor in-line (la nivel de coloana)
CREATE TABLE abonati (
    nr_abonat CHAR(3) CONSTRAINT pk_abonati PRIMARY KEY,
    cnp CHAR(13) CONSTRAINT uq_cnp UNIQUE,
    nume VARCHAR2(25) CONSTRAINT nn_nume NOT NULL,
    prenume VARCHAR2(25) NOT NULL,
    adresa VARCHAR2(30),
    localitate VARCHAR2(20)
);

--crearea tabelei Fise cu indicarea restrictiilor out-of-line (la nivel de tabela)
CREATE TABLE fise (
    nr_fisa          NUMBER,
    data_imprumut    DATE,
    nr_abonat        CHAR(3),
    CONSTRAINT pk_fise PRIMARY KEY (nr_fisa),
    CONSTRAINT nn_data CHECK (data_imprumut IS NOT NULL),
    CONSTRAINT fk_abonati FOREIGN KEY (nr_abonat) REFERENCES abonati(nr_abonat)
);

--crearea tabelei Carti cu indicarea sumara a restrictiilor (fara a scrie sintaxa completa: CONSTRAINT...)
CREATE TABLE carti (
    ISBN   CHAR(10) PRIMARY KEY,
    titlu_carte  VARCHAR2(20),
    autori  VARCHAR2(60) NOT NULL,
    CHECK (titlu_carte IS NOT NULL)
);

--crearea tabelei Detalii_fise
CREATE TABLE detalii_fise (
    ISBN CHAR(10) CONSTRAINT fk_carti REFERENCES carti(ISBN), --definirea in-line a restrictiei de cheie externa !! FARA indicarea explicita a tipului de restrictie FOREIGN KEY
    nr_fisa NUMBER,
    data_retur Date,
    CONSTRAINT fk_fise FOREIGN KEY (nr_fisa) REFERENCES fise(nr_fisa), --definirea out-of-line a restrictiei de cheie externa
    CONSTRAINT pk_detalii PRIMARY KEY (ISBN, nr_fisa) -- definirea cheii primare compuse !! se poate numai out-of-line
);
