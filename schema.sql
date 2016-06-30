 DROP TABLE my_contacts;

CREATE TABLE my_contacts(
	last_name VARCHAR(30) NOT NULL,
	first_name VARCHAR(20) NOT NULL,
	email VARCHAR(50) NOT NULL,
	gender CHAR(1) NOT NULL DEFAULT 'M',
	birthday DATE,
	age INT(3),
	profession VARCHAR(50),
	status VARCHAR(20) NOT NULL,
	interests VARCHAR(100),
	seeking VARCHAR(100)
);

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
(first_name,last_name,email,status)
VALUES
('hamid','nourhani','hamid@gmail.com','married'),
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






