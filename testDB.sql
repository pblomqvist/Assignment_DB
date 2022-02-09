DROP DATABASE PernillaBlomqvist;
CREATE DATABASE PernillaBlomqvist;
USE PernillaBlomqvist;

-- TABLES
CREATE TABLE spelare (
    pnr CHAR(13) NOT NULL,
    namn VARCHAR(20),
    ålder INT,
    PRIMARY KEY (pnr)
)  ENGINE=INNODB;

CREATE TABLE jacka (
    märke VARCHAR(40),
    storlek VARCHAR(3),
    material VARCHAR(20),
    ägare CHAR(13) NOT NULL,
    PRIMARY KEY (ägare , märke),
    FOREIGN KEY (ägare)
        REFERENCES spelare (pnr)
        ON DELETE CASCADE
)  ENGINE=INNODB;

CREATE TABLE konstruktion (
    serienummer VARCHAR(15),
    hårdhet VARCHAR(10),
    PRIMARY KEY (serienummer)
)  ENGINE=INNODB;

CREATE TABLE klubba (
    ägare CHAR(13),
    nr VARCHAR(2),
    material VARCHAR(10),
    konstruktion varchar(15),
    PRIMARY KEY (nr , ägare),
     FOREIGN KEY (konstruktion)
        REFERENCES konstruktion (serienummer)
        ON DELETE CASCADE,
    FOREIGN KEY (ägare)
        REFERENCES spelare (pnr)
        ON DELETE CASCADE
)  ENGINE=INNODB;

CREATE TABLE tävling (
    namn VARCHAR(40),
    datum DATE,
    PRIMARY KEY (namn),
    UNIQUE (namn)
)  ENGINE=INNODB;

CREATE TABLE deltagare (
    tävling VARCHAR(40),
    person_pnr CHAR(13),
    PRIMARY KEY (tävling , person_pnr),
    FOREIGN KEY (person_pnr)
        REFERENCES spelare (pnr)
        ON DELETE CASCADE,
    FOREIGN KEY (tävling)
        REFERENCES tävling (namn)
        ON DELETE CASCADE
)  ENGINE=INNODB;

CREATE TABLE väder (
    typ VARCHAR(10),
    vindstyrka VARCHAR(5),
    temperatur VARCHAR(5),
    PRIMARY KEY (typ)
)  ENGINE=INNODB;

CREATE TABLE tävling_väder (
    tidpunkt VARCHAR(15),
    vädertyp VARCHAR(15),
    tävling VARCHAR(40),
    PRIMARY KEY (tidpunkt , tävling),
    FOREIGN KEY (tävling)
        REFERENCES tävling (namn)
)  ENGINE=INNODB;

-- INSERT RECORDS
INSERT INTO spelare (pnr, namn, ålder)
VALUES ('19970603-2013', 'Johan Andersson', '25'),
		('19780603-8650', 'Nicklas Jansson', '48'),
        ('20020215-6510', 'Annika Persson', '20'),
        ('20001220-7680', 'Monika Lund', '21'),
        ('19560220-3089', 'Lars Broberg', '66'),
        ('19330901-1010', 'Lasse Larsson', '89');

INSERT INTO jacka (märke, storlek, material, ägare)
VALUES ('Fjällräven', 'M', 'Goretex', '19970603-2013'),
		('Adidas', 'L', 'Fleece', '19970603-2013'),
        ('Helly Hansen', 'S', 'Goretex', '19780603-8650'),
        ('Tommy Hilfiger', 'M', 'Nylon', '20020215-6510'),
        ('Filippa K', 'L', 'Bomull', '20001220-7680'),
        ('BOSS', 'XS', 'Polyamid', '19560220-3089'),
        ('ROCKANDBLUE', 'L', 'Polyester', '19330901-1010');
        
INSERT INTO konstruktion
VALUES ('SN001', '01'),
		('SN002', '02'),
		('SN003', '03'),
		('SN004', '04'),
		('SN005', '05'),
		('SN006', '06'),
		('SN007', '07'),
		('SN008', '08'),
		('SN009', '09'),
		('SN010', '10');

INSERT INTO klubba (ägare, nr, material, konstruktion)
VALUES ('19780603-8650', '01', 'Trä', 'SN010'),
		('20020215-6510', '02', 'Trä', 'SN005'),
        ('19970603-2013', '03', 'Plast', 'SN004'),
        ('20001220-7680', '04', 'Metall', 'SN002');

INSERT INTO tävling (namn, datum)
VALUES ('Big Golf Cup Skövde', '2021-06-10'),
		('Göteborg Big Swing', '2021-09-30');

INSERT INTO deltagare (tävling, person_pnr)
VALUES ('Big Golf Cup Skövde', '19970603-2013'),
		('Big Golf Cup Skövde', '19780603-8650'),
        ('Big Golf Cup Skövde', '20020215-6510'),
        ('Göteborg Big Swing', '20001220-7680'),
        ('Göteborg Big Swing', '19560220-3089'),
        ('Göteborg Big Swing', '19330901-1010');

INSERT INTO väder (typ, vindstyrka, temperatur)
VALUES ('Hagel', '10m/s', '12 C'),
		('Solsken', '2m/s', '1 C');

INSERT INTO tävling_väder
VALUES ('12:00', 'Hagel', 'Big Golf Cup Skövde'),
('13:00', 'Solsken', 'Göteborg Big Swing');

-- 01
SELECT 
    ålder
FROM
    spelare
WHERE
    namn = 'Johan Andersson';

-- 02
SELECT 
    datum
FROM
    tävling
WHERE
    namn = 'Big Golf Cup Skövde';

-- 03
SELECT 
    material
FROM
    klubba
WHERE
    ägare = '19970603-2013';
    
-- 04
SELECT 
    *
FROM
    jacka
WHERE
    ägare = '19970603-2013';

-- 05
SELECT 
    person_pnr
FROM
    deltagare
WHERE
    tävling = 'Big Golf Cup Skövde';

-- 06
SELECT 
	väder.vindstyrka
FROM 
	tävling_väder
	INNER JOIN
		väder 
		ON tävling_väder.vädertyp=väder.typ
WHERE tävling_väder.tävling="Big Golf Cup Skövde";

-- 07
SELECT 
    *
FROM
    spelare
WHERE
    ålder <= 30;

-- 08
DELETE FROM jacka 
WHERE
    ägare = '19970603-2013';

-- 09
DELETE FROM spelare 
WHERE
    pnr = '19780603-8650';
    
-- 10
    SELECT 
    AVG(ålder)
FROM
    spelare;