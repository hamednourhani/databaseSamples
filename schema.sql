SHOW DATABASES;
SHOW CREATE DATABASE doughnut;

SHOW TABLES;


DROP TABLE IF EXISTS my_contacts;

CREATE TABLE my_contacts(
	contact_id INT NOT NULL,
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



/* DELETe */
DELETE FROM my_contacts WHERE first_name='hamed';


/* UPDATE */

UPDATE my_contacts SET first_name='hamid', last_name='nour' WHERE first_name='hamid';
UPDATE my_contacts SET age = age + 7 WHERE first_name IN ('hamed','hamid');

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
