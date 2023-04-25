USE firma;

CREATE DATABASE firma; -- polecenie tworzy pust¹ baze danych 

CREATE SCHEMA ksiegowosc; --polecenie tworzy schemat dla lepszej organizacji tabel

--tworzenie tabeli 
--DROP TABLE rozliczenia.pracownicy;

CREATE TABLE ksiegowosc.pracownicy ( 

id_pracownika INT PRIMARY KEY, 
imie VARCHAR(25) NOT NULL,
nazwisko VARCHAR(30) NOT NULL,
adres VARCHAR(100) NOT NULL,
telefon VARCHAR(12)

) 
--( COMMENT 'komentarz do tabeli';
--sp_updateextendedproperty
EXEC sys.sp_addextendedproperty
    @name=N'TableDescription', 
    @value=N'Tabela zawierajaca dane pracownikow' , -- Coment about the used of table
    @level0type=N'SCHEMA',
    @level0name=N'ksiegowosc', 
    @level1type=N'TABLE',
    @level1name=N'pracownicy';
	--informacje o tabeli 
select 
    tables.name tableName,
    tables.create_date,
    tables.modify_date,
    tableDesc.value TableDescription
from 
    sys.tables  
    left join sys.extended_properties tableDesc on tables.object_id = tableDesc.major_id and tableDesc.name = 'TableDescription'
where 
    tableDesc.name in('TableDescription')
order by tables.name;


EXEC sp_help 'ksiegowosc.pracownicy';


CREATE TABLE ksiegowosc.godziny (

	id_godziny INT PRIMARY KEY,
	data DATE NOT NULL,
	liczba_godzin SMALLINT NOT NULL,
	id_pracownika INT NOT NULL,

);

EXEC sys.sp_addextendedproperty
    @name=N'TableDescription', 
    @value=N'Tabela zawierajaca ilosc przepracowanych godzin' , -- Coment about the used of table
    @level0type=N'SCHEMA',
    @level0name=N'ksiegowosc', 
    @level1type=N'TABLE',
    @level1name=N'godziny';
	--informacje o tabeli 
select 
    tables.name tableName,
    tables.create_date,
    tables.modify_date,
    tableDesc.value TableDescription
from 
    sys.tables  
    left join sys.extended_properties tableDesc on tables.object_id = tableDesc.major_id and tableDesc.name = 'TableDescription'
where 
    tableDesc.name in('TableDescription')
order by tables.name;

CREATE TABLE ksiegowosc.pensja (

	id_pensji INT PRIMARY KEY,
	stanowisko VARCHAR(50) NOT NULL,
	kwota INT NOT NULL,
	

);
EXEC sys.sp_addextendedproperty
    @name=N'TableDescription', 
    @value=N'Tabela zawierajaca informacje o wysokosci pensji w zaleznosci od stanowiska' , -- Coment about the used of table
    @level0type=N'SCHEMA',
    @level0name=N'ksiegowosc', 
    @level1type=N'TABLE',
    @level1name=N'pensja';
	--informacje o tabeli 
select 
    tables.name tableName,
    tables.create_date,
    tables.modify_date,
    tableDesc.value TableDescription
from 
    sys.tables  
    left join sys.extended_properties tableDesc on tables.object_id = tableDesc.major_id and tableDesc.name = 'TableDescription'
where 
    tableDesc.name in('TableDescription')
order by tables.name;

CREATE TABLE ksiegowosc.premia(

	id_premii INT PRIMARY KEY,
	rodzaj VARCHAR(50),
	kwota SMALLMONEY NOT NULL,

);
EXEC sys.sp_addextendedproperty
    @name=N'TableDescription', 
    @value=N'Tabela zawierajaca informacje o wysokosci premii w zaleznosci od osiagnienc' , -- Coment about the used of table
    @level0type=N'SCHEMA',
    @level0name=N'ksiegowosc', 
    @level1type=N'TABLE',
    @level1name=N'premia';
	--informacje o tabeli 
select 
    tables.name tableName,
    tables.create_date,
    tables.modify_date,
    tableDesc.value TableDescription
from 
    sys.tables  
    left join sys.extended_properties tableDesc on tables.object_id = tableDesc.major_id and tableDesc.name = 'TableDescription'
where 
    tableDesc.name in('TableDescription')
order by tables.name;

CREATE TABLE ksiegowosc.wynagrodzenie(

	id_wynagrodzenia INT PRIMARY KEY NOT NULL, 
	data DATE NOT NULL, 
	id_pracownika INT NOT NULL, 
	id_godziny INT NOT NULL, 
	id_pensji INT NOT NULL, 
	id_premii INT NOT NULL,


); 
EXEC sys.sp_addextendedproperty
    @name=N'TableDescription', 
    @value=N'Tabela zawierajaca informacje o powiazaniach tabel' , -- Coment about the used of table
    @level0type=N'SCHEMA',
    @level0name=N'ksiegowosc', 
    @level1type=N'TABLE',
    @level1name=N'wynagrodzenie';
	--informacje o tabeli 
select 
    tables.name tableName,
    tables.create_date,
    tables.modify_date,
    tableDesc.value TableDescription
from 
    sys.tables  
    left join sys.extended_properties tableDesc on tables.object_id = tableDesc.major_id and tableDesc.name = 'TableDescription'
where 
    tableDesc.name in('TableDescription')
order by tables.name;

-----------------------------------------------------------------------------------------------------------------------------------------
--dodanie kluczy obcych

ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);

ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (id_godziny) REFERENCES ksiegowosc.godziny(id_godziny);

ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (id_pensji) REFERENCES ksiegowosc.pensja(id_pensji);

ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premia(id_premii);

--5. Wype³nij ka¿d¹ tabelê 10. rekordami.


INSERT INTO ksiegowosc.pracownicy(

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

SELECT * FROM ksiegowosc.pracownicy;


INSERT INTO ksiegowosc.godziny (

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

SELECT * FROM ksiegowosc.godziny;

INSERT INTO ksiegowosc.premia (

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

SELECT * FROM ksiegowosc.premia;

INSERT INTO ksiegowosc.pensja (

	[id_pensji],
	[kwota],
	[stanowisko]
)
VALUES
(
	1,
	10000,
	'Prezes PGR'
),
(
	2,
	8000,
	'Przedstawiciel handlowy'
),
(
	3,
	8000,
	'Traktorzysta'
),
(
	4,
	5000,
	'Traktorzysta junior'
),
(
	5,
	5000,
	'Mechanik junior'
),
(
	6,
	8000,
	'Mechanik'
),
(
	7,
	8000,
	'Weteryna¿'
),
(
	8,
	5000,
	'Oborowy'
),
(
	9,
	8000,
	'Kombajnista'
),
(
	10,
	2000,
	'Praktykant'
);
SELECT * FROM ksiegowosc.pensja;

INSERT INTO ksiegowosc.wynagrodzenie(

[id_wynagrodzenia],
[data],
[id_pracownika],
[id_godziny],
[id_pensji],
[id_premii]

)
VALUES(

1,
'2023-04-10',
1,
1,
1,
1
),
(

2,
'2023-04-10',
2,
2,
2,
2
),(

3,
'2023-04-10',
3,
3,
3,
3
),(

4,
'2023-04-10',
4,
4,
4,
4
),(

5,
'2023-04-10',
5,
5,
5,
5
),(

6,
'2023-04-10',
6,
6,
6,
6
),(

7,
'2023-04-10',
7,
7,
7,
7
),(

8,
'2023-04-10',
8,
8,
8,
8
),(

9,
'2023-04-10',
9,
9,
9,
9
),(

10,
'2023-04-10',
10,
10,
10,
10
);

SELECT * FROM ksiegowosc.wynagrodzenie;



--a) Wyœwietl tylko id pracownika oraz jego nazwisko.
SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy;
--b) Wyœwietl id pracowników, których p³aca jest wiêksza ni¿ 1000.

SELECT pracownicy.id_pracownika FROM ksiegowosc.pracownicy, ksiegowosc.wynagrodzenie, ksiegowosc.pensja 
WHERE ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika 
AND ksiegowosc.pensja.id_pensji = ksiegowosc.wynagrodzenie.id_pensji 
AND ksiegowosc.pensja.kwota > 1000;

--c) Wyœwietl id pracowników nieposiadaj¹cych premii,których p³aca jest wiêksza ni¿ 2000.

SELECT pracownicy.id_pracownika FROM ksiegowosc.pracownicy, ksiegowosc.wynagrodzenie, ksiegowosc.premia, ksiegowosc.pensja 
WHERE ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika 
AND ksiegowosc.premia.id_premii = ksiegowosc.wynagrodzenie.id_premii
AND ksiegowosc.pensja.id_pensji = ksiegowosc.wynagrodzenie.id_pensji 
AND ksiegowosc.premia.kwota = 0 AND ksiegowosc.pensja.kwota > 2000;

-- d) Wyœwietl pracowników, których pierwsza litera imienia zaczyna siê na literê ‘J’.

SELECT pracownicy.imie FROM ksiegowosc.pracownicy WHERE pracownicy.imie LIKE 'J%';

-- e) Wyœwietl pracowników, których nazwisko zawiera literê ‘n’ oraz imiê koñczy siê na literê ‘a’.

SELECT pracownicy.imie, pracownicy.nazwisko FROM ksiegowosc.pracownicy WHERE pracownicy.imie LIKE '%a' AND pracownicy.nazwisko LIKE '%n%';

--f) Wyœwietl imiê i nazwisko pracowników oraz liczbê ich nadgodzin, przyjmuj¹c, i¿ standardowy czas pracy to 140 h miesiêcznie. 

SELECT pracownicy.imie, pracownicy.nazwisko, godziny.liczba_godzin -140 AS Nadgodziny FROM ksiegowosc.pracownicy, ksiegowosc.godziny, ksiegowosc.wynagrodzenie 
WHERE ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika 
AND ksiegowosc.godziny.id_godziny = ksiegowosc.wynagrodzenie.id_godziny
AND ksiegowosc.godziny.liczba_godzin > 140;

--g) Wyœwietl imiê i nazwisko pracowników, których pensja zawiera siê w przedziale 1500 –3000PLN.

SELECT pracownicy.imie, pracownicy.nazwisko FROM ksiegowosc.pracownicy, ksiegowosc.pensja, ksiegowosc.wynagrodzenie 
WHERE ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika 
AND ksiegowosc.pensja.id_pensji = ksiegowosc.wynagrodzenie.id_pensji
AND ksiegowosc.pensja.kwota > 1500
AND ksiegowosc.pensja.kwota < 3000;

--h) Wyœwietl imiê i nazwisko pracowników, którzy pracowali w nadgodzinachi nie otrzymali premii.

SELECT pracownicy.imie, pracownicy.nazwisko FROM ksiegowosc.pracownicy, ksiegowosc.godziny, ksiegowosc.wynagrodzenie, ksiegowosc.premia
WHERE ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika 
AND ksiegowosc.godziny.id_godziny = ksiegowosc.wynagrodzenie.id_godziny
AND ksiegowosc.premia.id_premii = ksiegowosc.wynagrodzenie.id_premii
AND ksiegowosc.godziny.liczba_godzin > 140
AND ksiegowosc.premia.kwota = 0;

--i) Uszereguj pracowników wed³ug pensji.

SELECT pracownicy.imie, pracownicy.nazwisko, ksiegowosc.pensja.kwota FROM ksiegowosc.pracownicy, ksiegowosc.pensja, ksiegowosc.wynagrodzenie 
WHERE ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika 
AND ksiegowosc.pensja.id_pensji = ksiegowosc.wynagrodzenie.id_pensji
ORDER BY ksiegowosc.pensja.kwota;

--j) Uszereguj pracowników wed³ug pensji i premii malej¹co.

SELECT pracownicy.imie, pracownicy.nazwisko, ksiegowosc.pensja.kwota + ksiegowosc.premia.kwota AS Dochod FROM ksiegowosc.pracownicy, ksiegowosc.pensja, ksiegowosc.wynagrodzenie, ksiegowosc.premia
WHERE ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika 
AND ksiegowosc.pensja.id_pensji = ksiegowosc.wynagrodzenie.id_pensji
AND ksiegowosc.premia.id_premii = ksiegowosc.wynagrodzenie.id_premii
ORDER BY Dochod DESC;

--k) Zlicz i pogrupuj pracowników wed³ug pola ‘stanowisko’.

SELECT COUNT(pensja.id_pensji) AS Liczba_pracownikow, pensja.stanowisko FROM ksiegowosc.pensja--, ksiegowosc.pracownicy, ksiegowosc.wynagrodzenie
--WHERE ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika 
--AND ksiegowosc.pensja.id_pensji = ksiegowosc.wynagrodzenie.id_pensji
GROUP BY pensja.stanowisko;

--l) Policz œredni¹, minimaln¹ i maksymaln¹ p³acê dla stanowiska ‘kierownik’ (je¿eli takiego nie masz, to przyjmij dowolne inne).

SELECT AVG(pensja.kwota) AS Srednia_placa, MAX(pensja.kwota) AS Maksymalna_placa, MIN(pensja.kwota) AS Minimalna_placa FROM ksiegowosc.pensja
WHERE ksiegowosc.pensja.stanowisko = 'Prezes PGR';

--m) Policz sumê wszystkich wynagrodzeñ.

SELECT SUM(pensja.kwota) AS Suma_wynagrodzen FROM ksiegowosc.pensja;

--f) Policz sumê wynagrodzeñ w ramach danego stanowiska.

SELECT SUM(pensja.kwota) AS Liczba_pracownikow, pensja.stanowisko FROM ksiegowosc.pensja GROUP BY pensja.stanowisko;

--g) Wyznacz liczbê premii przyznanych dla pracowników danego stanowiska.

SELECT COUNT(premia.id_premii),  pensja.stanowisko FROM ksiegowosc.premia, ksiegowosc.pensja, ksiegowosc.wynagrodzenie
WHERE
ksiegowosc.wynagrodzenie.id_premii = ksiegowosc.premia.id_premii
AND ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
GROUP BY pensja.stanowisko;

--h) Usuñ wszystkich pracowników maj¹cych pensjê mniejsz¹ ni¿ 1200 z³.
--CASCADE delete zastosowalem
DELETE ksiegowosc.pracownicy FROM ksiegowosc.pracownicy, ksiegowosc.pensja, ksiegowosc.wynagrodzenie
WHERE 
ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
AND ksiegowosc.pensja.id_pensji = ksiegowosc.wynagrodzenie.id_pensji
AND pensja.kwota < 2200;

SELECT * FROM ksiegowosc.pracownicy;
SELECT * FROM ksiegowosc.wynagrodzenie;
SELECT * FROM ksiegowosc.pensja;
SELECT * FROM ksiegowosc.premia;
SELECT * FROM ksiegowosc.godziny;

INSERT INTO ksiegowosc.pracownicy( 	[id_pracownika],[imie],[nazwisko],[adres],[telefon])VALUES(	10,'Agnieszka','Gawron','Krankczyn 4, 88-150 Kruszwica','998443571');
INSERT INTO ksiegowosc.wynagrodzenie( 	[id_wynagrodzenia],[data],[id_pracownika],[id_godziny],[id_pensji],[id_premii])VALUES(	10,'2023-04-10',10,10,10,10);
