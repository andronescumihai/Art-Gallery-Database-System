CREATE TABLE ARTISTI_PRJ (
id_artist	NUMBER(6)	NOT NULL, nume		VARCHAR2(60) NOT NULL,
tara_origine VARCHAR2(40), data_nasterii DATE,
biografie	VARCHAR2(4000),

CONSTRAINT ARTISTI_PRJ_PK PRIMARY KEY (id_artist)

);



CREATE TABLE CLIENTI_PRJ (
id_client NUMBER(6)	NOT NULL,

nume		VARCHAR2(80) NOT NULL, email	VARCHAR2(80),
telefon	VARCHAR2(20), adresa		VARCHAR2(200),
CONSTRAINT CLIENTI_PRJ_PK PRIMARY KEY (id_client)

);



CREATE TABLE EXPOZITII_PRJ (
id_expozitie		NUMBER(6)	NOT NULL, nume	VARCHAR2(80) NOT NULL,
 
data_deschidere DATE
 
NOT NULL,
 

data_inchidere DATE,

locatie	VARCHAR2(100) NOT NULL,
 
CONSTRAINT EXPOZITII_PRJ_PK PRIMARY KEY (id_expozitie)

);



CREATE TABLE LUCRARI_ARTA_PRJ (
id_lucrare		NUMBER(6)	NOT NULL, titlu	VARCHAR2(100) NOT NULL,
an_realizare NUMBER(4),

tehnica	VARCHAR2(60) NOT NULL,

pret_estimativ NUMBER(10,2),

id_artist	NUMBER(6)	NOT NULL,

CONSTRAINT LUCRARI_ARTA_PRJ_PK PRIMARY KEY (id_lucrare), CONSTRAINT LUCRARI_ARTA_PRJ_ARTIST_FK FOREIGN KEY (id_artist)
REFERENCES ARTISTI_PRJ (id_artist)

);



CREATE INDEX LUCRARI_ARTA_PRJ_ARTIST_IX

ON LUCRARI_ARTA_PRJ (id_artist);



CREATE TABLE VANZARI_PRJ (
id_vanzare NUMBER(8) NOT NULL, data_vanzare DATE   NOT NULL,
pret_final NUMBER(10,2) NOT NULL, id_client NUMBER(6) NOT NULL, id_lucrare NUMBER(6)   NOT NULL,
CONSTRAINT VANZARI_PRJ_PK PRIMARY KEY (id_vanzare),
 
CONSTRAINT VANZARI_PRJ_CLIENT_FK FOREIGN KEY (id_client)

REFERENCES CLIENTI_PRJ (id_client),

CONSTRAINT VANZARI_PRJ_LUCRARE_FK FOREIGN KEY (id_lucrare)

REFERENCES LUCRARI_ARTA_PRJ (id_lucrare)

);



CREATE INDEX VANZARI_PRJ_CLIENT_IX

ON VANZARI_PRJ (id_client);



CREATE INDEX VANZARI_PRJ_LUCRARE_IX

ON VANZARI_PRJ (id_lucrare);



CREATE TABLE LUCRARI_EXPOZITII_PRJ (
id_lucrare	NUMBER(6)	NOT NULL,

id_expozitie	NUMBER(6)	NOT NULL, data_expusa		DATE,
loc_in_expozitie VARCHAR2(100),

CONSTRAINT LUCRARI_EXPOZITII_PRJ_PK PRIMARY KEY (id_lucrare, id_expozitie), CONSTRAINT LE_PRJ_LUCRARE_FK FOREIGN KEY (id_lucrare)
REFERENCES LUCRARI_ARTA_PRJ (id_lucrare),

CONSTRAINT LE_PRJ_EXPOZITIE_FK FOREIGN KEY (id_expozitie)

REFERENCES EXPOZITII_PRJ (id_expozitie)

);



CREATE INDEX LE_PRJ_EXPOZITIE_IX

ON LUCRARI_EXPOZITII_PRJ (id_expozitie);
 
CREATE SEQUENCE SEQ_ARTISTI_PRJ START WITH 100
INCREMENT BY 1 NOCACHE;


CREATE SEQUENCE SEQ_CLIENTI_PRJ START WITH 100
INCREMENT BY 1 NOCACHE;


CREATE SEQUENCE SEQ_EXPOZITII_PRJ START WITH 100
INCREMENT BY 1 NOCACHE;


CREATE SEQUENCE SEQ_LUCRARI_PRJ START WITH 100
INCREMENT BY 1 NOCACHE;


CREATE SEQUENCE SEQ_VANZARI_PRJ START WITH 100
INCREMENT BY 1 NOCACHE;
 
CREATE VIEW VW_ARTISTI_SIMPLU AS SELECT
id_artist, nume, tara_origine, data_nasterii
FROM ARTISTI_PRJ;





CREATE VIEW VW_STATISTICI_ARTISTI AS SELECT
a.id_artist, a.nume,
COUNT(l.id_lucrare) AS nr_lucrari, ROUND(AVG(l.pret_estimativ), 2) AS pret_mediu
FROM ARTISTI_PRJ a

LEFT JOIN LUCRARI_ARTA_PRJ l

ON a.id_artist = l.id_artist GROUP BY a.id_artist, a.nume;
ALTER TABLE CLIENTI_PRJ

ADD data_inregistrare DATE; ALTER TABLE CLIENTI_PRJ
MODIFY data_inregistrare DEFAULT SYSDATE; ALTER TABLE CLIENTI_PRJ
DROP COLUMN data_inregistrare;

DELETE FROM LUCRARI_EXPOZITII_PRJ; DELETE FROM VANZARI_PRJ;
 
CREATE INDEX VIRT_VANZARI_CLIENT_DATA
ON VANZARI_PRJ (id_client, data_vanzare) NOSEGMENT;
DELETE FROM LUCRARI_ARTA_PRJ;

DELETE FROM EXPOZITII_PRJ; DELETE FROM CLIENTI_PRJ;

 
DELETE FROM ARTISTI_PRJ;
INSERT INTO ARTISTI_PRJ VALUES (1, 'Andrei Popescu', 'Romania', 1980','DD-MM-YYYY'), 'Pictor contemporan, peisaje urbane.');
 


TO_DATE('15-03-
 

 
INSERT INTO ARTISTI_PRJ VALUES (2, 'Maria Ionescu',
1985','DD-MM-YYYY'), 'Lucrari abstracte in acrilic.');
 
'Romania',	TO_DATE('22-07-
 

 
INSERT INTO ARTISTI_PRJ VALUES (3, 'Luca Bianchi',
MM-YYYY'), 'Pictor italian cu influente clasice.');
INSERT INTO ARTISTI_PRJ VALUES (4, 'Sophie Dubois',
 
'Italia',	TO_DATE('01-11-1975','DD-


'Franta',	TO_DATE('09-02-
 
1990','DD-MM-YYYY'), 'Artista franceza orientata spre minimalism.');

INSERT INTO ARTISTI_PRJ VALUES (5, 'Emily Johnson',	'SUA',	TO_DATE('30-05-
1982','DD-MM-YYYY'), 'Portrete realiste in ulei.');

INSERT INTO ARTISTI_PRJ VALUES (6, 'Kenji Tanaka',	'Japonia',	TO_DATE('12-09-
1978','DD-MM-YYYY'), 'Combinatie de tehnici traditionale si digitale.');

 
INSERT INTO ARTISTI_PRJ VALUES (7, 'Carlos Martinez', 'Spania', 1983','DD-MM-YYYY'), 'Lucrari foarte colorate in ulei.');
INSERT INTO ARTISTI_PRJ VALUES (8, 'Anna Muller',
 
TO_DATE('04-04-
 
1987','DD-MM-YYYY'), 'Arte geometrice si conceptuale.');
 
'Germania',	TO_DATE('19-08-
 
INSERT INTO ARTISTI_PRJ VALUES (9, 'Elena Petrescu', 'Romania', 1992','DD-MM-YYYY'), 'Lucrari in acuarela.');
INSERT INTO ARTISTI_PRJ VALUES (10, 'Oliver Smith',
1970','DD-MM-YYYY'), 'Instalatii si mixed-media.');
 

TO_DATE('05-12-
 
'Marea Britanie',TO_DATE('27-01-


 
INSERT INTO CLIENTI_PRJ VALUES (1, 'Ion Radu',
721111111', 'Str. Lalelelor 10, Bucuresti');
 
'ion.radu@example.com',	'+40
 

 
INSERT INTO CLIENTI_PRJ VALUES (2, 'Mihai Georgescu', 'mihai.geo@example.com', 722222222', 'Str. Unirii 25, Cluj-Napoca');
INSERT INTO CLIENTI_PRJ VALUES (3, 'Ana Marinescu', 'ana.m@example.com', 723333333', 'Str. Victoriei 5, Timisoara');
INSERT INTO CLIENTI_PRJ VALUES (4, 'Laura Pop',
 
'+40


'+40
 
724444444', 'Str. Horea 18, Oradea');	'laura.pop@example.com',	'+40
 
INSERT INTO CLIENTI_PRJ VALUES (5, 'George Iancu',
725555555', 'Str. Decebal 3, Iasi');
 
'george.i@example.com',	'+40
 

 
INSERT INTO CLIENTI_PRJ VALUES (6, 'Cristina Dobre', 'cristina.d@example.com', 726666666', 'Str. Libertatii 12, Brasov');
 
'+40
 
INSERT INTO CLIENTI_PRJ VALUES (7, 'Radu Muntean',
727777777', 'Str. Republicii 8, Sibiu');
INSERT INTO CLIENTI_PRJ VALUES (8, 'Oana Toma',
728888888', 'Str. Eminescu 40, Constanta');
 
'radu.m@example.com',	'+40


'oana.t@example.com',	'+40
 
INSERT INTO CLIENTI_PRJ VALUES (9, 'Victor Enache', 'victor.e@example.com', 729999999', 'Str. Saturn 2, Ploiesti');
INSERT INTO CLIENTI_PRJ VALUES (10, 'Irina Pavel',
730101010', 'Str. Stefan cel Mare 14, Galati');
 

'+40
 
'irina.p@example.com',	'+40


 
INSERT INTO CLIENTI_PRJ VALUES (11, 'Dan Tudor',
731111010', 'Str. Florilor 6, Arad');
 
'dan.t@example.com',	'+40
 
INSERT INTO CLIENTI_PRJ VALUES (12, 'Elena Calinescu', 'elena.c@example.com', 732121212', 'Str. Primaverii 21, Craiova');
INSERT INTO CLIENTI_PRJ VALUES (13, 'Paul Sandu',
 
'+40
 
733131313', 'Str. Pacii 11, Targu Mures');
INSERT INTO CLIENTI_PRJ VALUES (14, 'Bianca Rusu',
734141414', 'Str. Lucian Blaga 9, Bacau');
 
'paul.s@example.com',	'+40


'bianca.r@example.com',	'+40
 


 
INSERT INTO CLIENTI_PRJ VALUES (15, 'Florin Matei',
735151515', 'Str. Dunarii 30, Braila');
 
'florin.m@example.com',	'+40
 

 
INSERT INTO CLIENTI_PRJ VALUES (16, 'Monica Stoica', 'monica.s@example.com', 736161616', 'Str. Scolii 7, Suceava');
INSERT INTO CLIENTI_PRJ VALUES (17, 'Alexandru Damian', 'alex.d@example.com', 737171717', 'Str. Garii 1, Satu Mare');
INSERT INTO CLIENTI_PRJ VALUES (18, 'Carmen Ilie',
 
'+40


'+40
 
738181818', 'Str. Industriei 15, Baia Mare');
INSERT INTO CLIENTI_PRJ VALUES (19, 'Vlad Neagu',
739191919', 'Str. Noua 4, Alba Iulia');
 
'carmen.i@example.com',	'+40


'vlad.n@example.com',	'+40
 


 
INSERT INTO CLIENTI_PRJ VALUES (20, 'Sorina Lupu',
740202020', 'Str. Tineretului 5, Pitesti');
 
'sorina.l@example.com',	'+40
 

INSERT INTO EXPOZITII_PRJ VALUES (1, 'Culori Urbane',	TO_DATE('10-03-2023','DD-MM-
YYYY'), TO_DATE('25-03-2023','DD-MM-YYYY'), 'Galeria Centrala, Bucuresti');
 
INSERT INTO EXPOZITII_PRJ VALUES (2, 'Abstract si Forme',	TO_DATE('05-04-2023','DD-MM- YYYY'), TO_DATE('20-04-2023','DD-MM-YYYY'), 'Galeria ArtSpace, Cluj');
INSERT INTO EXPOZITII_PRJ VALUES (3, 'Portrete Contemporane', TO_DATE('15-05-2023','DD- MM-YYYY'), TO_DATE('30-05-2023','DD-MM-YYYY'), 'Muzeul de Arta, Iasi');
INSERT INTO EXPOZITII_PRJ VALUES (4, 'Lumi Imaginare',	TO_DATE('01-06-2023','DD-MM- YYYY'), TO_DATE('15-06-2023','DD-MM-YYYY'), 'Galeria Modern, Timisoara');
INSERT INTO EXPOZITII_PRJ VALUES (5, 'Minimalism si Linie', TO_DATE('20-06-2023','DD-MM- YYYY'), TO_DATE('05-07-2023','DD-MM-YYYY'), 'Galeria Minimal, Brasov');

INSERT INTO EXPOZITII_PRJ VALUES (6, 'Peisaje si Natura',	TO_DATE('10-07-2023','DD-MM- YYYY'), TO_DATE('25-07-2023','DD-MM-YYYY'), 'Galeria Verde, Sibiu');


INSERT INTO LUCRARI_ARTA_PRJ VALUES (1, 'Noapte in Bucuresti', 2020, 'Ulei pe panza', 3500, 1);
 
INSERT INTO LUCRARI_ARTA_PRJ VALUES (2, 'Blocuri de lumina', 2800, 1);
 
2021, 'Acrilic pe panza',
 

 
INSERT INTO LUCRARI_ARTA_PRJ VALUES (3, 'Strada veche', 3000, 1);
 
2019, 'Ulei pe panza',
 
INSERT INTO LUCRARI_ARTA_PRJ VALUES (4, 'Abstractie albastra', 2022, 'Acrilic', 2);
INSERT INTO LUCRARI_ARTA_PRJ VALUES (5, 'Forme in miscare',
 
2600,
 
3200, 2);
INSERT INTO LUCRARI_ARTA_PRJ VALUES (6, 'Piazza veche', 4000, 3);
INSERT INTO LUCRARI_ARTA_PRJ VALUES (7, 'Portret italian', 3);
 
2021, 'Mixed media',


2018, 'Ulei pe panza',


2017, 'Ulei pe panza',	4200,
 


 
INSERT INTO LUCRARI_ARTA_PRJ VALUES (8, 'Linii de Paris', 4);
 
2020, 'Acuarela',	2100,
 
INSERT INTO LUCRARI_ARTA_PRJ VALUES (9, 'Minimal Paris', 4);
INSERT INTO LUCRARI_ARTA_PRJ VALUES (10, 'Portret de femeie', 3500, 5);
INSERT INTO LUCRARI_ARTA_PRJ VALUES (11, 'Familie in parc', 3300, 5);
 
2021, 'Desen tus',	1900,


2019, 'Ulei pe panza',


2020, 'Acrilic pe panza',
 
INSERT INTO LUCRARI_ARTA_PRJ VALUES (12, 'Tokyo Night', 6);
 
2021, 'Digital print',	2500,
 
INSERT INTO LUCRARI_ARTA_PRJ VALUES (13, 'Fuziune traditionala', 2019, 'Ulei si tus', 3800, 6);
 
INSERT INTO LUCRARI_ARTA_PRJ VALUES (14, 'Soare iberic', 2700, 7);
INSERT INTO LUCRARI_ARTA_PRJ VALUES (15, 'Dansul culorilor', 7);
 
2020, 'Ulei pe panza',


2022, 'Acrilic',	2900,
 
INSERT INTO LUCRARI_ARTA_PRJ VALUES (16, 'Forme geometrice I',
2000, 8);	2018, 'Acrilic',
INSERT INTO LUCRARI_ARTA_PRJ VALUES (17, 'Forme geometrice II', 2019, 'Acrilic', 2100, 8);


 
INSERT INTO LUCRARI_ARTA_PRJ VALUES (18, 'Lacul la apus', 9);
INSERT INTO LUCRARI_ARTA_PRJ VALUES (19, 'Copaci in ceata', 1900, 9);
 
2020, 'Acuarela',	1800,


2021, 'Acuarela',
 
INSERT INTO LUCRARI_ARTA_PRJ VALUES (20, 'Instalatie luminoasa', 2017, 'Instalatie', 5000, 10);
INSERT INTO LUCRARI_ARTA_PRJ VALUES (21, 'Umbre in oras',
3600, 10);
2018, 'Ulei pe panza',


 
INSERT INTO LUCRARI_ARTA_PRJ VALUES (22, 'Texturi urbane', 3400, 10);
 
2019, 'Mixed media',
 
INSERT INTO LUCRARI_ARTA_PRJ VALUES (23, 'Portret batran', 3100, 3);
INSERT INTO LUCRARI_ARTA_PRJ VALUES (24, 'Podul peste Sena', 2200, 4);
 
2018, 'Ulei pe panza',


2019, 'Acuarela',
 
INSERT INTO VANZARI_PRJ VALUES (1, TO_DATE('15-03-2022','DD-MM-YYYY'), 3600, 1, 1);


INSERT INTO VANZARI_PRJ VALUES (2, TO_DATE('20-03-2022','DD-MM-YYYY'), 2850, 2, 2);

INSERT INTO VANZARI_PRJ VALUES (3, TO_DATE('05-04-2022','DD-MM-YYYY'), 3050, 3, 3);

INSERT INTO VANZARI_PRJ VALUES (4, TO_DATE('10-04-2022','DD-MM-YYYY'), 2700, 4, 4);

INSERT INTO VANZARI_PRJ VALUES (5, TO_DATE('18-04-2022','DD-MM-YYYY'), 3300, 5, 5);

INSERT INTO VANZARI_PRJ VALUES (6, TO_DATE('25-04-2022','DD-MM-YYYY'), 4100, 6, 6);

INSERT INTO VANZARI_PRJ VALUES (7, TO_DATE('01-05-2022','DD-MM-YYYY'), 4300, 7, 7);
 
INSERT INTO VANZARI_PRJ VALUES (8, TO_DATE('10-05-2022','DD-MM-YYYY'), 2150, 8, 8);

INSERT INTO VANZARI_PRJ VALUES (9, TO_DATE('18-05-2022','DD-MM-YYYY'), 1950, 9, 9);

INSERT INTO VANZARI_PRJ VALUES (10, TO_DATE('25-05-2022','DD-MM-YYYY'), 3550, 10, 10);

INSERT INTO VANZARI_PRJ VALUES (11, TO_DATE('02-06-2022','DD-MM-YYYY'), 3350, 11, 11);

INSERT INTO VANZARI_PRJ VALUES (12, TO_DATE('10-06-2022','DD-MM-YYYY'), 2550, 12, 12);

INSERT INTO VANZARI_PRJ VALUES (13, TO_DATE('18-06-2022','DD-MM-YYYY'), 3850, 13, 13);

INSERT INTO VANZARI_PRJ VALUES (14, TO_DATE('25-06-2022','DD-MM-YYYY'), 2750, 14, 14);

INSERT INTO VANZARI_PRJ VALUES (15, TO_DATE('05-07-2022','DD-MM-YYYY'), 2950, 15, 15);

INSERT INTO VANZARI_PRJ VALUES (16, TO_DATE('12-07-2022','DD-MM-YYYY'), 2050, 16, 16);

INSERT INTO VANZARI_PRJ VALUES (17, TO_DATE('20-07-2022','DD-MM-YYYY'), 2150, 17, 17);

INSERT INTO VANZARI_PRJ VALUES (18, TO_DATE('28-07-2022','DD-MM-YYYY'), 1850, 18, 18);

INSERT INTO VANZARI_PRJ VALUES (19, TO_DATE('05-08-2022','DD-MM-YYYY'), 1950, 19, 19);

INSERT INTO VANZARI_PRJ VALUES (20, TO_DATE('12-08-2022','DD-MM-YYYY'), 5100, 20, 20);

INSERT INTO VANZARI_PRJ VALUES (21, TO_DATE('20-08-2022','DD-MM-YYYY'), 3650, 1, 21);

INSERT INTO VANZARI_PRJ VALUES (22, TO_DATE('28-08-2022','DD-MM-YYYY'), 3450, 2, 22);

INSERT INTO VANZARI_PRJ VALUES (23, TO_DATE('05-09-2022','DD-MM-YYYY'), 3150, 3, 23);

INSERT INTO VANZARI_PRJ VALUES (24, TO_DATE('12-09-2022','DD-MM-YYYY'), 2300, 4, 24);

INSERT INTO VANZARI_PRJ VALUES (25, TO_DATE('20-09-2022','DD-MM-YYYY'), 3700, 5, 1);

INSERT INTO VANZARI_PRJ VALUES (26, TO_DATE('28-09-2022','DD-MM-YYYY'), 2600, 6, 4);

INSERT INTO VANZARI_PRJ VALUES (27, TO_DATE('05-10-2022','DD-MM-YYYY'), 4200, 7, 7);

INSERT INTO VANZARI_PRJ VALUES (28, TO_DATE('15-10-2022','DD-MM-YYYY'), 3200, 8, 13);

INSERT INTO VANZARI_PRJ VALUES (29, TO_DATE('22-10-2022','DD-MM-YYYY'), 2900, 9, 15);
INSERT INTO VANZARI_PRJ VALUES (30, TO_DATE('30-10-2022','DD-MM-YYYY'), 3600, 10, 21); INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (1, 1, TO_DATE('10-03-2023','DD-MM-YYYY'),
'Sala 1 peretele A');

INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (2, 1, TO_DATE('10-03-2023','DD-MM-YYYY'),
'Sala 1 peretele B');
 
INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (3, 1, TO_DATE('11-03-2023','DD-MM-YYYY'),
'Sala 2 peretele A');

INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (21,1, TO_DATE('12-03-2023','DD-MM-YYYY'),
'Sala 2 peretele B');

INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (22,1, TO_DATE('12-03-2023','DD-MM-YYYY'),
'Sala 3 peretele A');
INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (4, 2, TO_DATE('05-04-2023','DD-MM-YYYY'),
'Sala 1 peretele A');
INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (5, 2, TO_DATE('05-04-2023','DD-MM-YYYY'),
'Sala 1 peretele B');
INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (16,2, TO_DATE('06-04-2023','DD-MM-YYYY'),
'Sala 2 peretele A');



INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (17,2, TO_DATE('06-04-2023','DD-MM-YYYY'),
'Sala 2 peretele B');
INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (12,2, TO_DATE('07-04-2023','DD-MM-YYYY'),
'Sala 3 colt digital');
INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (13,2, TO_DATE('07-04-2023','DD-MM-YYYY'),
'Sala 3 panou lateral');
INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (7, 3, TO_DATE('15-05-2023','DD-MM-YYYY'),
'Sala 1 portrete A');



INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (10,3, TO_DATE('15-05-2023','DD-MM-YYYY'),
'Sala 1 portrete B');

INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (11,3, TO_DATE('16-05-2023','DD-MM-YYYY'),
'Sala 2 perete portrete');
INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (23,3, TO_DATE('16-05-2023','DD-MM-YYYY'),
'Sala 2 colt clasic');
INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (3, 3, TO_DATE('17-05-2023','DD-MM-YYYY'),
'Sala 3 intrare');
INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (8, 4, TO_DATE('01-06-2023','DD-MM-YYYY'),
'Sala 1 peretele A');



INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (9, 4, TO_DATE('01-06-2023','DD-MM-YYYY'),
'Sala 1 peretele B');

INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (14,4, TO_DATE('02-06-2023','DD-MM-YYYY'),
'Sala 2 colt color');
 
INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (15,4, TO_DATE('02-06-2023','DD-MM-YYYY'),
'Sala 2 perete principal');

INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (20,4, TO_DATE('03-06-2023','DD-MM-YYYY'),
'Sala 3 instalatie centrala');

INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (16,5, TO_DATE('20-06-2023','DD-MM-YYYY'),
'Sala 1 peretele A');
INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (17,5, TO_DATE('20-06-2023','DD-MM-YYYY'),
'Sala 1 peretele B');
INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (8, 5, TO_DATE('21-06-2023','DD-MM-YYYY'),
'Sala 2 panou mic');
INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (9, 5, TO_DATE('21-06-2023','DD-MM-YYYY'),
'Sala 2 panou mare');



INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (24,5, TO_DATE('22-06-2023','DD-MM-YYYY'),
'Sala 3 perete fundal');
INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (18,6, TO_DATE('10-07-2023','DD-MM-YYYY'),
'Sala 1 perete peisaje');
INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (19,6, TO_DATE('10-07-2023','DD-MM-YYYY'),
'Sala 1 colt acuarela');
INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (1, 6, TO_DATE('11-07-2023','DD-MM-YYYY'),
'Sala 2 peisaj urban');



INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (6, 6, TO_DATE('11-07-2023','DD-MM-YYYY'),
'Sala 2 peisaj istoric');

INSERT INTO LUCRARI_EXPOZITII_PRJ VALUES (2, 6, TO_DATE('12-07-2023','DD-MM-YYYY'),
'Sala 3 iesire');
COMMIT;
