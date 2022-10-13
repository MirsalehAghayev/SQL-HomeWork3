CREATE DATABASE DemoApp
USE DemoApp

CREATE TABLE Countries
(
	Id int PRIMARY KEY IDENTITY,
	Name nvarchar(30) NOT NULL UNIQUE,
	Areas decimal CHECK(Areas>0)
)
INSERT INTO Countries
VALUES
('Azerbaycan',86600.5),
('İsrail',22072.2),
('Pakistan',88191.3),
('Turkiye',783356.6),
('Dubay',110.4)


CREATE TABLE Cities
(
	Id int PRIMARY KEY IDENTITY,
	Name nvarchar(30) NOT NULL UNIQUE,
	Areas decimal(8,2) CHECK(Areas>0),
	ContriesId  int FOREIGN KEY REFERENCES Countries(Id)
)
INSERT INTO Cities
VALUES
('Baki',2140.1,1),
('Xirdalan', 147.2,1),
('TelEviv', 147.2,2),
('Islamabad',1539.4,3),
('Ankara' ,240.2,4),
('Istanbul',80.7,4),
('EbuDabi',712.5,5)

CREATE TABLE People
(
	Id int PRIMARY KEY IDENTITY,
	Name nvarchar(30) NOT NULL ,
	Surname nvarchar(30) NOT NULL ,
	PhoneNumber nvarchar(50) NOT NULL UNIQUE,
	Email nvarchar(100) NOT NULL UNIQUE,
	Age int CHECK(Age>0),
	Gender nvarchar(30) NOT NULL,
	HasCitizenship nvarchar(30),
	CityId int FOREIGN KEY REFERENCES Cities(Id)
)

INSERT INTO People
VALUES
('Mirsaleh','Agayev','+994000000001','mirsalehagayev52@gmail.com',22,'MALE','Yes',1),
('Tural','Nagiye','+994000000002','tural@gmail.com',22,'MALE','Yes',2),
('Resul','Muradaov','+994000000003','resul@gmail.com',24,'MALE','No',3),
('Aqsin','Agayev','+994000000004','aqsin@gmail.com',32,'MALE','No',4),
('Mirabbas','Seyidov','+994000000005','mirabbas@gmail.com',21,'MALE','No',5),
('Novruz','Eliyev','+994000000006','novruz@gmail.com',28,'MALE','Yes',6),
('Ruslan','Huseyinov','+994000000007','ruslan@gmail.com',33,'MALE','No',7)

SELECT*FROM Countries
SELECT*FROM Cities
SELECT*FROM People

--1. Joinlərdən istifadə edərək hər üç table birləşdirilməlidir,və nəticədə hər bir personun hansı ölkə və hansı şəhərə aid olduğu viewda əks olunmalıdır.
SELECT p.Name 'Person-Name', c.Name 'Contry-Name', ct.Name 'City-Name' FROM Countries AS c
INNER JOIN Cities AS ct
ON c.Id=ct.ContriesId
INNER JOIN People AS p
ON ct.Id=p.CityId

--1.1 Yazılmış bu join query bir 'View'-a assign olunmalıdır və yenidən birbaşa ordan oxunmalıdır.
CREATE VIEW PersonContryCityName
AS
SELECT p.Name 'Person-Name', c.Name 'Contry-Name', ct.Name 'City-Name' FROM Countries AS c
INNER JOIN Cities AS ct
ON c.Id=ct.ContriesId
INNER JOIN People AS p
ON ct.Id=p.CityId

SELECT* FROM PersonContryCityName

--2. Countries table-ı 'Area' -nın artma sırası ilə sıralanmalıdır.
SELECT*FROM Countries
ORDER BY Areas

--2.1 Cities table-ı  'Name'-ə görə əks alphabetic sıra ilə sıralanmalıdır.
SELECT*FROM Cities
ORDER BY Name

--3.1 Aggregate functionların birindən istifadə edərək 'Area'-sı 20.000-dən çox olan ölkələrin sayı göstərilməlidir.
SELECT COUNT(*) 'CountCountry' FROM Countries
WHERE Areas>20.000

--3.2 Aggregate functionlardan istifadə edərək 'Name'-i İ hərfi ilə başlayan ölkələrin arasından ərazi ən böyük olanın 'Area'-sı göstərilməlidir.
SELECT MAX(Areas) 'TheLargestArea' FROM Countries
WHERE Name LIKE 'i%'

--4.1 Unionlardan istifadə edərək ümumiyyətlə hansı ölkə və şəhərlərin olduğu göstərilməlidir.
SELECT Name,Areas FROM Countries
EXCEPT
SELECT Name,Areas FROM Cities

SELECT Name,Areas FROM Countries
UNION ALL
SELECT Name,Areas FROM Cities