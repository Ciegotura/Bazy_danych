USE firma;

CREATE DATABASE firma; -- polecenie tworzy pust¹ baze danych 

CREATE SCHEMA rozliczenia; --polecenie tworzy schemat dla lepszej organizacji tabel

--tworzenie tabeli 
--DROP TABLE rozliczenia.pracownicy;

CREATE TABLE rozliczenia.pracownicy ( 

id_pracownika INT PRIMARY KEY, 
imie VARCHAR(25) NOT NULL,
nazwisko VARCHAR(30) NOT NULL,
adres VARCHAR(100) NOT NULL,
telefon VARCHAR(9)

);

CREATE TABLE rozliczenia.godziny (

	id_godziny INT PRIMARY KEY,
	data DATE NOT NULL,
	liczba_godzin SMALLINT NOT NULL,
	id_pracownika INT NOT NULL,

);

CREATE TABLE rozliczenia.pensje (

	id_pensji INT PRIMARY KEY,
	stanowisko VARCHAR(50) NOT NULL,
	kwota INT NOT NULL,
	id_premii INT, 

);

CREATE TABLE rozliczenia.premie(

	id_premii INT PRIMARY KEY,
	rodzaj VARCHAR(50),
	kwota SMALLMONEY NOT NULL,

);


--dodanie kluczy obcych

ALTER TABLE rozliczenia.godziny ADD FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);

ALTER TABLE rozliczenia.pensje ADD FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii);

--dodanie wartosci do tabeli

INSERT INTO rozliczenia.pracownicy(

	[id_pracownika],
	[imie],
	[nazwisko],
	[adres],
	[telefon]

)
VALUES
(
	1,
	'Tomasz',
	'Ciêgotura',
	'Ro¿niaty 2, 88-150 Kruszwica',
	'721375404'
),
(
	2,
	'Kacper',
	'Kolenda',
	'Bo¿ejewice 38, 88-150 Kruszwica',
	'554246943'
),
(
	3,
	'Andrzej',
	'Pyra',
	'¯egotki 4, 88-150 Kruszwica',
	'541335222'
),
(
	4,
	'Rafa³',
	'Skarpyta',
	'Janowice 14a, 88-150 Kruszwica',
	'599238512'
),
(
	5,
	'Wiktoria',
	'¯uber',
	'Liberty City 6, 88-150 Kruszwica',
	'000000000'
),
(
	6,
	'Miko³aj',
	'Zbieg',
	'S³awsk Górny 115, 88-150 Kruszwica',
	'554477223'
),
(
	7,
	'Konrad',
	'Œmietnik',
	'Grodztwo 87, 88-150 Kruszwica',
	'997997997'
),
(
	8,
	'Major',
	'Tomaszewski',
	'Kobelniki 1342, 88-150 Kruszwica',
	'666777666'
),
(
	9,
	'Stanis³aw',
	'Wichurski',
	'Arturowo 54, 88-150 Kruszwica',
	'333737365'
),
(
	10,
	'Agnieszka',
	'Gawron',
	'Krankczyn 4, 88-150 Kruszwica',
	'998443571'
);

SELECT * FROM rozliczenia.pracownicy;


INSERT INTO rozliczenia.godziny (

	[id_godziny],
	[data],
	[liczba_godzin],
	[id_pracownika]

)
VALUES
(
	1,
	'2023-04-19',
	160,
	1
),
(
	2,
	'2023-04-20',
	150,
	2
),
(
	3,
	'2023-04-21',
	140,
	3
),
(
	4,
	'2023-04-22',
	130,
	4
),
(
	5,
	'2023-04-23',
	120,
	5
),
(
	6,
	'2023-04-24',
	110,
	6
),
(
	7,
	'2023-04-25',
	100,
	7
),
(
	8,
	'2023-04-26',
	99,
	8
),
(
	9,
	'2023-04-27',
	80,
	9
),
(
	10,
	'2023-04-28',
	70,
	10
);

SELECT * FROM rozliczenia.godziny;

INSERT INTO rozliczenia.premie (

	[id_premii],
	[rodzaj],
	[kwota]

)
VALUES 
(	
	1,
	'best_worker',
	10000

),
(	
	2,
	'worst_worker',
	1000

),
(	
	3,
	'brak_premii',
	0

),
(	
	4,
	'najwiêcej_wypadków',
	2000

),
(	
	5,
	'resocjalizacja',
	500

),
(	
	6,
	'brak_premii',
	100

),
(	
	7,
	'top5_worker',
	3000

),
(	
	8,
	'zapomoga_losowa',
	1000

),
(	
	9,
	'brak_premii',
	0

),
(	
	10,
	'na_zachente',
	1000

);

SELECT * FROM rozliczenia.premie;

INSERT INTO rozliczenia.pensje (

	[id_pensji],
	[id_premii],
	[kwota],
	[stanowisko]
)
VALUES
(
	1,
	1,
	10000,
	'Prezes PGR'
),
(
	2,
	2,
	8000,
	'Traktorzysta'
),
(
	3,
	3,
	8000,
	'Traktorzysta'
),
(
	4,
	4,
	8000,
	'Traktorzysta'
),
(
	5,
	5,
	5000,
	'Oborowy'
),
(
	6,
	6,
	8000,
	'Mechanik'
),
(
	7,
	7,
	8000,
	'Weteryna¿'
),
(
	8,
	8,
	5000,
	'Oborowy'
),
(
	9,
	9,
	8000,
	'Kombajnista'
),
(
	10,
	10,
	2000,
	'Praktykant'
)

SELECT * FROM rozliczenia.pensje;

--nazwiska i adresy pracowkinow
SELECT nazwisko, adres FROM rozliczenia.pracownicy;
--konwersja daty z tabeli godiny na dzien tygodnia i miesiac 
SELECT DATEPART ( dw , data ) AS Dzien_tygodnia ,DATEPART ( mm , data ) AS Miesi¹c FROM rozliczenia.godziny;
--zmiana nazwy atrybutu w tabeli pensje, kwota na kwota brutto
SELECT * FROM rozliczenia.pensje;
--ALTER TABLE rozliczenia.pensje RENAME COLUMN kwota TO kwota_brutto
--ALTER TABLE rozliczenia.pensje CHANGE kwota kwota_brutto INT NOT NULL;;
EXEC sp_rename 'rozliczenia.pensje.kwota', 'kwota_brutto', 'COLUMN';
SELECT * FROM rozliczenia.pensje;
--dodanie atrybutu kwota netto

ALTER TABLE rozliczenia.pensje ADD kwota_netto AS (pensje.kwota_brutto * 0.79);

SELECT * FROM rozliczenia.pensje;