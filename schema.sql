SHOW DATABASES;
SHOW CREATE DATABASE doughnut;

SHOW TABLES;


DROP TABLE IF EXISTS my_contacts;

CREATE TABLE my_contacts(
	contact_id INT NOT NULL AUTO_INCREMENT,
	last_name VARCHAR(30) NOT NULL,
	first_name VARCHAR(20) NOT NULL,
	email VARCHAR(50) NOT NULL,
	gender CHAR(1) NOT NULL DEFAULT 'M',
	birthday DATE,
	age INT(3),
	profession VARCHAR(50),
	status VARCHAR(20) NOT NULL,
	interests VARCHAR(100),
	seeking VARCHAR(100),
	PRIMARY KEY (contact_id)
);

DROP TABLE IF EXISTS my_interests;

CREATE TABLE my_interests(
	interest_id INT(5) NOT NULL PRIMARY KEY,
	interest_name VARCHAR(20) NOT NULL,
	contact_id INT NOT NULL,
	CONSTRAINT my_contacts_contact_id_fk
	FOREIGN KEY (contact_id)
	REFERENCES my_contacts (contact_id)
)

SHOW CREATE TABLE my_contacts;

DESC my_contacts;

SHOW COLUMNS FROM my_contacts;
SHOW INDEX FROM my_contacts;

SHOW WARNINGS;

/*----------------------------------------------------------------*/

INSERT INTO my_contacts
(last_name,first_name,email,gender,birthday,age,profession,
	status,interests,seeking)
VALUES
('Nourhani','Hamed','info@itstar.ir','M','1983-11-1',34,
	'web designer,web developer','married','book,internet',
	'job,firends'

);

/*Escape ' by \ or another '*/
INSERT INTO my_contacts
(first_name,last_name,email,status,age)
VALUES
('hamid','nourhani','hamid@gmail.com','married',19),
('ali''REZA','hamdiPour','ali@gmail.com','single',20),
('hamid\'REZA','alipour','hamedreza@gmail.com','single',36);

SELECT * FROM my_contacts;

SELECT * FROM my_contacts WHERE age < 35;

/* numeric comperation */
SELECT first_name,last_name,age FROM my_contacts WHERE age < 35;
SELECT first_name,last_name,age FROM my_contacts WHERE age <= 34;
SELECT first_name,last_name,age FROM my_contacts WHERE age => 34;
SELECT first_name,last_name,age FROM my_contacts WHERE age <> 34;

/* String or text comperation */
SELECT first_name,last_name,age FROM my_contacts WHERE first_name < 'T' AND first_name > 'A';

/* NUll values */
SELECT first_name,last_name FROM my_contacts WHERE birthday IS NULL;

/* Wildcard   % (any character)   ,   _ (one charccter)   */
SELECT first_name FROM my_contacts WHERE first_name Like '%mid';
SELECT first_name FROM my_contacts WHERE first_name Like '_amid';

/* Period KEYWored  BETWEEN  */
SELECT first_name,last_name FROM my_contacts WHERE age BETWEEN 20 AND 30 AND first_name Like "%R_Z%";

SELECT first_name,last_name FROM my_contacts WHERE age BETWEEN 20 AND 30 AND NOT first_name Like "%R_Z%";
SELECT first_name,last_name FROM my_contacts WHERE age BETWEEN 20 AND 30 AND first_name NOT Like "%R_Z%";
SELECT first_name,last_name FROM my_contacts WHERE NOT age BETWEEN 20 AND 30 ;


/* SET(many list) keyword IN () */
SELECT first_name FROM my_contacts WHERE age IN (20,36);
SELECT first_name FROM my_contacts WHERE first_name IN ('hamid','hamed');
SELECT first_name FROM my_contacts WHERE first_name NOT IN ('hamid','hamed');


/* working wtith strings */
SELECT RIGHT(first_name,3) FROM my_contacts WHERE first_name='hamed'
SELECT SUBSTRING_INDEX(first_name,',',3) FROM my_contacts WHERE first_name='hamed';
SELECT SUBSTRING(first_name,5,3) FROM my_contacts WHERE first_name='hamed';
SELECT UPPER(first_name) FROM my_contacts WHERE first_name='hamed';
SELECT REVERSE(last_name) FROM my_contacts WHERE first_name='hamed';
SELECT LTRIM(last_name) FROM my_contacts WHERE first_name='hamed';
SELECT LENGTH(last_name) FROM my_contacts WHERE first_name='hamed';

/* DELETe */
DELETE FROM my_contacts WHERE first_name='hamed';


/* UPDATE */

UPDATE my_contacts SET first_name='hamid', last_name='nour' WHERE first_name='hamid';
UPDATE my_contacts SET age = age + 7 WHERE first_name IN ('hamed','hamid');

UPDATE my_contacts SET last_name = SUBSTRING(first_name,5,3) WHERE first_name='hamid';

/*
************************************************************************
HOw you are using your data will affect how you setup database and tables
************************************************************************

---------------       MAKING YOUR TABLES NORMAL    ---------------------

****  4 things most consider when designing database tables *******

1- pick your thing, the one you want your table to describe.(what is the main thing you want your table to be about)
2- make a list of information you need to know about your one thing when you are using the table.(how will you use this table)
3- using the list break down the information about your thing in the pieces you can use for organizing your table.(how can you most easily query this table)

4- data must be atomic : must be divided sufficently to pices(columns) 
4-a : a column with atomic data can not have several values of same type in one column.
4-b : a table with atomic data can not have mutliple columns of same data.

5-a: each row of table must contain atomic values
5-b: each row of data must have a unique identifer known as a primary key.
*********************************************************************************************
*/



/* adding some columns to exiting table */
ALTER TABLE my_contacts ADD COLUMN contact_id INT NOT NULL AUTO_INCREMENT FIRST, ADD PRIMARY KEY (contact_id);

ALTER TABLE my_contacts ADD COLUMN contact_info VARCHAR(20) AFTER contact_id;
ALTER TABLE my_contacts RENAME TO contacts_list;
ALTER TABLE my_contacts CHANGE contact_info TO INT NOT NULL ;
ALTER TABLE my_contacts DROP COLUMN contact_info;


/* order and grouping */
UPDATE my_contacts SET first_name_length =
	CASE 
		WHEN first_name = 'hamid' AND last_name='nourhani'
			THEN LENGTH(first_name)
		WHEN last_name = 'nourhani'
			THEN LENGTH(last_name)
		ELSE 0
		END; 

UPDATE my_contacts SET first_name_length =
	CASE 
		WHEN first_name = 'hamid' AND last_name='nourhani'
			THEN LENGTH(first_name)
		WHEN last_name = 'nourhani'
			THEN LENGTH(last_name)
		ELSE 0
		END WHERE age < 25; 

SELECT first_name FROM my_contacts WHERE first_name IS NOT NULL ORDER BY first_name;
SELECT first_name FROM my_contacts ORDER BY age DESC, first_name ASC, last_name;

/* ------------- Grouping -------------------*/
SELECT SUM(age) FROM my_contacts WHERE status='married';
SELECT first_name ,SUM(age) FROM my_contacts GROUP BY first_name ORDER BY SUM(age) DESC;
SELECT first_name ,AVG(age) FROM my_contacts GROUP BY first_name ORDER BY AVG(age) ASC , first_name DESC;
SELECT first_name ,MAX(age) FROM my_contacts GROUP BY first_name ORDER BY first_name DESC;
SELECT first_name ,MIN(age) FROM my_contacts GROUP BY first_name ORDER BY first_name ASC;
SELECT status,COUNT(status) FROM my_contacts GROUP BY status;
SELECT birthday,COUNT(DISTINCT birthday ) FROM my_contacts GROUP BY birthday;

/* --------------- LIMIT ----------------------------*/
SELECT status,COUNT(status) FROM my_contacts GROUP BY status ORDER BY status DESC LIMIT 1;
SELECT status,COUNT(status) FROM my_contacts GROUP BY status ORDER BY status DESC LIMIT 0,1;


/*-----SELECT from one table and INSERT to another in same TIME -----------*/

/* FIRST WAY*/
DROP TABLE IF EXISTS profession;
CREATE TABLE profession(
	id INT(5) NOT NULL PRIMARY KEY AUTO_INCREMENT,
	profession VARCHAR(20)
);

INSERT INTO profession (profession)
SELECT profession FROM my_contacts
GROUP BY profession
ORDER BY profession;

/*SECOND WAY */
DROP TABLE IF EXISTS profession;

CREATE TABLE profession AS
SELECT profession FROM my_contacts
GROUP BY profession
ORDER BY profession;

ALTER TABLE profession
ADD COLUMN id INT(5) NOT NULL AUTO_INCREMENT FIRST,
ADD PRIMARY KEY (id);

/* THIRD WAY */
DROP TABLE IF EXISTS profession;

CREATE TABLE profession(
	id INT(5) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	profession VARCHAR(20)
)
AS
SELECT profession FROM my_contacts
GROUP BY profession
ORDER BY profession;



/*-------------------------- JOINIG TABLES ---------------------*/

/* CROSS JOIN */
SELECT mc.first_name ,p.profession
FROM my_contacts AS mc
	CROSS JOIN 
	profession AS p;

SELECT my_contacts.first_name, profession.profession
FROM my_contacts,profession;

/* Inner Join */
/* inner join is a cross join with some conditoin*/
SELECT mc.first_name,mc.last_name,p.profession
FROM my_contacts AS mc
	INNER JOIN 
	profession AS p
	ON 
	mc.contact_id = p.id;

SELECT mc.first_name,mc.last_name,p.profession
FROM my_contacts AS mc
	INNER JOIN 
	profession AS p
	ON 
	mc.contact_id <> p.id;

/* Outer Join */
SELECT mc.first_name,mc.last_name,p.profession
FROM my_contacts AS mc
	LEFT OUTER JOIN 
	profession AS p
	ON mc.profession = p.profession;

SELECT mc.first_name,mc.last_name,p.profession
FROM my_contacts AS mc
	RIGHT OUTER JOIN 
	profession AS p
	ON mc.profession = p.profession;

/* WHEN To table have same column name .(for example one for PRIMARY and other for FOREGEN)*/
SELECT mc.first_name,mc.last_name,p.profession
FROM my_contacts AS mc
	NATURAL JOIN 
	profession AS p;

/* SUB QUERY */
SELECT mc.first_name,p.profession
 From my_contacts AS mc
 INNER JOIN profession AS p
 WHERE p.profession IN (SELECT profession FROM my_contacts);


 SELECT mc.first_name,
 (SELECT profession FROM profession) AS profession
 FROM my_contacts AS mc;

 /* UNION */
 SELECT profession FROM my_contacts
 UNION
 SELECT profession FROM profession;


SELECT profession FROM my_contacts
 UNION ALL
 SELECT profession FROM profession; 

/* INTERSECT & EXCEPT */
 SELECT profession FROM my_contacts
 INTERSECT
 SELECT profession FROM profession; 

 SELECT profession FROM my_contacts
 EXCEPT
 SELECT profession FROM profession; 


 /* ---------------- VIEWS -----------------------*/

CREATE VIEW my_professions AS
SELECT mc.first_name,mc.last_name,p.profession
FROM my_contacts AS mc
	INNER JOIN 
	profession AS p
	ON mc.profession = p.profession;

SELECT * FROM my_professions;