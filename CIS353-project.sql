SPOOL project.out
SET ECHO ON
/**************************************
CIS 353 - Database Design Project
   Daniel Kelch
   John O'Brien
   Marcus Hughes
   Travis Keel
   Alen Ramic
**************************************/
--
DROP TABLE Country CASCADE CONSTRAINT;
DROP TABLE Event CASCADE CONSTRAINT;
DROP TABLE Athlete CASCADE CONSTRAINT;
DROP TABLE Spectator CASCADE CONSTRAINT;
DROP TABLE Ticket CASCADE CONSTRAINT;
DROP TABLE CompetesIn CASCADE CONSTRAINT;
DROP TABLE Sponsors CASCADE CONSTRAINT;
--
--
CREATE TABLE Country
(
cname CHAR(35) NOT NULL,
population INTEGER NOT NULL,
--
--
CONSTRAINT CC1 PRIMARY KEY (cname),
CONSTRAINT CC2 CHECK (population >= 0)
);
--
-- ------------------------------------
-- Event table
-- ------------------------------------
-- 
CREATE TABLE Event
(
eid INTEGER,
event_date DATE NOT NULL,
empty_seats INTEGER NOT NULL,
sport CHAR(30),
--
-- EC1: The event id (eid) is the primary key of Event
CONSTRAINT EC1 PRIMARY KEY (eid),
-- EC2: The number of empty seats must be between 0 and 10,000
CONSTRAINT EC2 CHECK (empty_seats <= 10000 AND empty_seats >= 0),
-- EC3: Checks that the date of the event is within a valid range
-- for the 2016 summer Olympics (08/05/2016 - 08/21/2016)
CONSTRAINT EC3 CHECK(TO_CHAR(event_date, 'YYYY-MM-DD') >= '2016-08-05' AND TO_CHAR(event_date, 'YYYY-MM-DD') <= '2016-08-21')
);
--
-- ------------------------------------
-- Sponsors table
-- ------------------------------------
--
CREATE TABLE Sponsors
(
eid INTEGER,
sponsor_name CHAR(30) NOT NULL,
--
-- SC1: Event ID and sponsor name are the primary key of Sponsors
CONSTRAINT SC1 PRIMARY KEY (eid, sponsor_name),
-- SC2: Event ID of sponsors is a foreign key of te eid from Event
-- On deletion it will cascade.
CONSTRAINT SC2 FOREIGN KEY (eid) REFERENCES Event(eid)
    ON DELETE CASCADE
    DEFERRABLE INITIALLY DEFERRED
);
--
-- ------------------------------------
-- Athlete table
-- ------------------------------------
--
CREATE TABLE Athlete
(
aid INTEGER,
lname CHAR(30) NOT NULL,
fname CHAR(30) NOT NULL,
country CHAR(35) NOT NULL,
mentorID INTEGER,
--
--
CONSTRAINT AC1 PRIMARY KEY (aid),
CONSTRAINT AC2 FOREIGN KEY (mentorID) REFERENCES Athlete(aid)
	ON DELETE CASCADE
	DEFERRABLE INITIALLY DEFERRED,
CONSTRAINT AC3 FOREIGN KEY (country) REFERENCES Country(cname)
	ON DELETE CASCADE
	DEFERRABLE INITIALLY DEFERRED
);
--
CREATE TABLE CompetesIn
(
eid INTEGER,
aid INTEGER,
medal CHAR(15) NOT NULL,
--
CONSTRAINT CIC1 PRIMARY KEY (eid, aid),
CONSTRAINT CIC2 CHECK(medal = 'gold' OR medal = 'silver' OR medal = 'bronze' OR medal = 'none'),
CONSTRAINT CIC3 FOREIGN KEY (eid) REFERENCES Event(eid)
	ON DELETE CASCADE
	DEFERRABLE INITIALLY DEFERRED,
CONSTRAINT CIC4 FOREIGN KEY (aid) REFERENCES Athlete(aid)
	ON DELETE CASCADE
	DEFERRABLE INITIALLY DEFERRED
);
--
--
-- ------------------------------------
-- Spectator table
-- ------------------------------------
--
CREATE TABLE Spectator
(
sid INTEGER,
lname CHAR(30) NOT NULL,
fname CHAR(30) NOT NULL,
cname CHAR(35) NOT NULL,
--
--
CONSTRAINT SPC1 PRIMARY KEY (sid),
CONSTRAINT SPC3 FOREIGN KEY (cname) REFERENCES Country(cname)
	ON DELETE CASCADE
	DEFERRABLE INITIALLY DEFERRED
);
--
-- ------------------------------------
-- Ticket table
-- ------------------------------------
--
CREATE TABLE Ticket
(
ticket_number INTEGER,
section_number INTEGER,
price INTEGER,
eid INTEGER,
sid INTEGER,
--
CONSTRAINT TC1 PRIMARY KEY (eid, ticket_number),
CONSTRAINT TC2 FOREIGN KEY (eid) REFERENCES Event(eid)
	ON DELETE CASCADE
    	DEFERRABLE INITIALLY DEFERRED,
CONSTRAINT TC3 FOREIGN KEY (sid) REFERENCES Spectator(sid)
	ON DELETE CASCADE
	DEFERRABLE INITIALLY DEFERRED,
CONSTRAINT TC4 CHECK(price >= 100/section_number)
--
);
--
SET AUTOCOMMIT OFF
SET FEEDBACK OFF
---
-- ------------------------------------
-- Populate the tables here
-- ------------------------------------
--
INSERT INTO Event VALUES (1, '06-AUG-16',987, 'Basketball');
INSERT INTO Event VALUES (2, '08-AUG-16', 67, 'Handball');
INSERT INTO Event VALUES (3, '13-AUG-16', 5, 'Water Polo');
INSERT INTO Event VALUES (4, '21-AUG-16', 30, 'Volleyball');
INSERT INTO Event VALUES (5, '07-AUG-16',254, 'Synchronized Swimming');
INSERT INTO Event VALUES (6, '09-AUG-16', 670, 'Rowing');
INSERT INTO Event VALUES (7, '11-AUG-16', 51, 'Judo');
INSERT INTO Event VALUES (8, '11-AUG-16', 0, 'Football');
INSERT INTO Event VALUES (9, '11-AUG-16', 87, 'Cycling Road');
INSERT INTO Event VALUES (10, '21-AUG-16', 67, 'Tennis');
INSERT INTO Event VALUES (11, '15-AUG-16', 9000, 'Golf');
INSERT INTO Event VALUES (12, '16-AUG-16', 0007, 'Diving');
INSERT INTO Event VALUES (13, '17-AUG-16', 21, 'Boxing');
INSERT INTO Event VALUES (14, '18-AUG-16', 781, 'Shooting');
INSERT INTO Event VALUES (15, '19-AUG-16', 19, 'Table Tennis');
INSERT INTO Event VALUES (16, '20-AUG-16', 20, 'Fencing');
--
INSERT INTO Country VALUES('United States', 319134000);
INSERT INTO Country VALUES('China', 1368030000 );
INSERT INTO Country VALUES('India', 1262860000 );
INSERT INTO Country VALUES('Indonesia', 252164800 );
INSERT INTO Country VALUES('Brazil', 203481000 );
INSERT INTO Country VALUES('Pakistan', 18829000 );
INSERT INTO Country VALUES('Nigeria', 178517000 );
INSERT INTO Country VALUES('Bangladesh', 157362000 );
INSERT INTO Country VALUES('Russia', 146146200 );
INSERT INTO Country VALUES('Japan', 127090000 );
INSERT INTO Country VALUES('Philippines', 100588600 );
INSERT INTO Country VALUES('Mexico',119713203 );
INSERT INTO Country VALUES('Vietnam' , 89708900 );
INSERT INTO Country VALUES('Ethiopia', 87952991);
INSERT INTO Country VALUES('Egypt', 8754400 );
INSERT INTO Country VALUES('Germany', 80767000 );
INSERT INTO Country VALUES('Iran', 77912500 );
INSERT INTO Country VALUES('Turkey', 76667864  );
INSERT INTO Country VALUES('France', 66050000 );
INSERT INTO Country VALUES('Thailand',64871000 );
INSERT INTO Country VALUES('United Kingdom',64105654  );
INSERT INTO Country VALUES('Italy',60783711  );
INSERT INTO Country VALUES('South Africa',54002000 );
INSERT INTO Country VALUES('South Korea',5423955  );
INSERT INTO Country VALUES('Colombia', 47875800 );
INSERT INTO Country VALUES('Tanzania',47421786 );
INSERT INTO Country VALUES('Spain' , 46507760);
INSERT INTO Country VALUES('Ukraine',42973696);
INSERT INTO Country VALUES('Argentina' ,42669500 );
INSERT INTO Country VALUES('Kenya',41800000 );
INSERT INTO Country VALUES('Canada', 35540419);
INSERT INTO Country VALUES('Cameroon', 20386799 );
INSERT INTO Country VALUES('Portugal', 10477800 );
INSERT INTO Country VALUES('Jamaica' , 2717991);
INSERT INTO Country VALUES('Sweden',9728498 );
INSERT INTO Country VALUES('Belgium',11225469);
INSERT INTO Country VALUES('Ghana' , 27043093);
--
INSERT INTO Athlete VALUES(10, 'OBrien', 'John', 'United States', NULL);
INSERT INTO Athlete VALUES(11, 'OBrien', 'Jack', 'United States', 10);
INSERT INTO Athlete VALUES(12, 'Hughes', 'Marcus', 'Germany', 15);
INSERT INTO Athlete VALUES(13, 'Keel', 'Travis', 'Germany', 12);
INSERT INTO Athlete VALUES(14, 'Ramic', 'Alen', 'Germany', 15);
INSERT INTO Athlete VALUES(15, 'Kelch', 'Daniel', 'Germany', NULL);
INSERT INTO Athlete VALUES(16, 'Springus', 'Harold', 'Russia', NULL);
INSERT INTO Athlete VALUES(17, 'Hawthorne', 'Gerald', 'Russia', 16);
INSERT INTO Athlete VALUES(18, 'Front', 'Rosemary', 'Russia', 17);
INSERT INTO Athlete VALUES(19, 'Tennis', 'Tim', 'Canada', NULL);
INSERT INTO Athlete VALUES(20, 'Robertson', 'Robert', 'Canada', 19);
INSERT INTO Athlete VALUES(21, 'Hudson', 'Marlene', 'Canada', 20);
INSERT INTO Athlete VALUES(22, 'West', 'North', 'China', NULL);
INSERT INTO Athlete VALUES(23, 'Philips', 'Michael', 'China', 22);
INSERT INTO Athlete VALUES(24, 'Muscle', 'Uncle', 'China', 22);
INSERT INTO Athlete VALUES(25, 'Lee', 'Bryce', 'China', 24);
INSERT INTO Athlete VALUES(26, 'Hoke', 'Brady', 'United States', 10);
INSERT INTO Athlete VALUES(27, 'Seger', 'Bill', 'United States', 11);
INSERT INTO Athlete VALUES(28, 'Obama', 'BarackHUSSEIN', 'Thailand', NULL);
INSERT INTO Athlete VALUES(29, 'Jonas', 'Mick', 'Italy', NULL);
INSERT INTO Athlete VALUES(30, 'Jackson III', 'Curtis James', 'France', NULL);
--
INSERT INTO Spectator VALUES(100, 'Miller', 'John', 'United States');
INSERT INTO Spectator VALUES(101, 'Sanches', 'Aguero', 'Argentina');
INSERT INTO Spectator VALUES(102, 'Lee', 'Wong', 'China');
INSERT INTO Spectator VALUES(103, 'Aqel', 'Mohammad', 'Egypt');
INSERT INTO Spectator VALUES(104, 'Kriplani', 'Malavika', 'India');
INSERT INTO Spectator VALUES(105, 'Curryfresh', 'Rasheed', 'Pakistan');
INSERT INTO Spectator VALUES(106, 'Shizmahal', 'Berut', 'Indonesia');
INSERT INTO Spectator VALUES(107, 'Sanches', 'Neymar', 'Brazil');
INSERT INTO Spectator VALUES(108, 'Kroptykov', 'Vladimir', 'Russia');
INSERT INTO Spectator VALUES(109, 'Shango', 'Wan', 'Japan');
INSERT INTO Spectator VALUES(110, 'Miller', 'John', 'United States');
INSERT INTO Spectator VALUES(111, 'Wienerschintzle', 'Hanz', 'Germany');
INSERT INTO Spectator VALUES(112, 'Uccello', 'Fabio', 'Italy');
INSERT INTO Spectator VALUES(113, 'Fabregas', 'Iniesta', 'Spain');
INSERT INTO Spectator VALUES(114, 'Measho', 'Micheal', 'Ethiopia');
INSERT INTO Spectator VALUES(115, 'Christiano', 'Ronaldo', 'Portugal');
INSERT INTO Spectator VALUES(116, 'Kriplani', 'Mehmenal', 'India');
INSERT INTO Spectator VALUES(117, 'Rastip', 'Shahimteg', 'India');
INSERT INTO Spectator VALUES(118, 'Mahood', 'Melket', 'India');
INSERT INTO Spectator VALUES(119, 'Cunningham', 'Bradley', 'United States');
INSERT INTO Spectator VALUES(120, 'Hanson', 'Jeff', 'United States');
INSERT INTO Spectator VALUES(121, 'Wilson', 'Anthony', 'United States');
--
INSERT INTO Ticket VALUES ( 1 , 1, 120 , 1 , 100); 
INSERT INTO Ticket VALUES (2, 1, 119, 2 , 101);
INSERT INTO Ticket VALUES (3, 1, 118, 3 , 102);
INSERT INTO Ticket VALUES (4, 1, 117, 4 , 103);
INSERT INTO Ticket VALUES (5, 1, 116, 5 , 104);
INSERT INTO Ticket VALUES (6, 1, 115, 6 , 105);
INSERT INTO Ticket VALUES (7, 1, 114, 7 , 106);
INSERT INTO Ticket VALUES (8, 1, 113, 8 , 107);
INSERT INTO Ticket VALUES (9, 1, 112, 9 , 108);
INSERT INTO Ticket VALUES (10, 1, 111, 10, 109); 
INSERT INTO Ticket VALUES (11, 1, 110, 11 , 110);
INSERT INTO Ticket VALUES (12, 1, 109, 12, 111);
INSERT INTO Ticket VALUES (13, 1, 108, 13 , 112);
INSERT INTO Ticket VALUES (14, 1, 107, 14 , 113);
INSERT INTO Ticket VALUES (15, 1, 100, 15 , 114);
INSERT INTO Ticket VALUES (16, 1, 120, 16 , 115);
INSERT INTO Ticket VALUES ( 17 , 2, 120 , 1 , 100); 
INSERT INTO Ticket VALUES (18, 3, 119, 2 , 101);
INSERT INTO Ticket VALUES (19, 3, 118, 3 , 102);
INSERT INTO Ticket VALUES (20, 4, 117, 4 , 103);
INSERT INTO Ticket VALUES (21, 3, 116, 5 , 104);
INSERT INTO Ticket VALUES (22, 2, 115, 6 , 105);
INSERT INTO Ticket VALUES (23, 1, 114, 7 , 106);
INSERT INTO Ticket VALUES (24, 3, 113, 8 , 107);
INSERT INTO Ticket VALUES (25, 4, 112, 9 , 108);
INSERT INTO Ticket VALUES (26 , 2, 111 , 10 , 109); 
INSERT INTO Ticket VALUES (27, 2, 110, 11 , 110);
INSERT INTO Ticket VALUES (28, 3, 109, 12, 111);
INSERT INTO Ticket VALUES (29, 4, 25, 13 , 112);
INSERT INTO Ticket VALUES (30, 5, 30, 14 , 113);
INSERT INTO Ticket VALUES (31, 2, 100, 15 , 114);
INSERT INTO Ticket VALUES (32, 1, 120, 16 , 115);
INSERT INTO Ticket VALUES (33 , 1 , 100 , 10 , 121);
INSERT INTO Ticket VALUES (34, 1, 114, 7 , 117);
INSERT INTO Ticket VALUES (35, 3, 113, 8 , 118);
INSERT INTO Ticket VALUES (36, 4, 112, 9 , 119);
INSERT INTO Ticket VALUES (37 , 2, 111 , 10 , 120); 
INSERT INTO Ticket VALUES (38, 2, 110, 11 , 117);
INSERT INTO Ticket VALUES (39, 3, 109, 12, 118);
INSERT INTO Ticket VALUES (40, 4, 25, 13 , 119);
INSERT INTO Ticket VALUES (41, 5, 30, 14 , 120);
INSERT INTO Ticket VALUES (44 , 1 , 100 , 10 , 121);
--
INSERT INTO Sponsors VALUES (1, 'Microsoft');
INSERT INTO Sponsors VALUES (1, 'Ford');
INSERT INTO Sponsors VALUES (2, 'Ford');
INSERT INTO Sponsors VALUES (2, 'Apple');
INSERT INTO Sponsors VALUES (3, 'GVSU');
INSERT INTO Sponsors VALUES (3, 'Facebook');
INSERT INTO Sponsors VALUES (4, 'Milk');
INSERT INTO Sponsors VALUES (4 , 'Ford');
INSERT INTO Sponsors VALUES (5 , 'Facebook');
INSERT INTO Sponsors VALUES (5 , 'Apple');
INSERT INTO Sponsors VALUES (6 , 'ACM');
INSERT INTO Sponsors VALUES (6 , 'Xfinity');
INSERT INTO Sponsors VALUES (7 , ' Real');
INSERT INTO Sponsors VALUES (7, 'Totco');
INSERT INTO Sponsors VALUES (8 , 'Burger King');
INSERT INTO Sponsors VALUES (8, 'Clean Water');
INSERT INTO Sponsors VALUES (9, 'Powerhouse');
INSERT INTO Sponsors VALUES (9, 'Midland');
INSERT INTO Sponsors VALUES (10 , 'Newhouse');
INSERT INTO Sponsors VALUES (10 , 'GVSU');
INSERT INTO Sponsors VALUES (11 , 'Ford');
INSERT INTO Sponsors VALUES (12 , 'Facebook');
INSERT INTO Sponsors VALUES (11 , 'Milk');
INSERT INTO Sponsors VALUES (12 , 'Real');
INSERT INTO Sponsors VALUES (13 , 'Joes Pizza');
INSERT INTO Sponsors VALUES (13 , 'Apple');
INSERT INTO Sponsors VALUES (14 , 'Totco');
INSERT INTO Sponsors VALUES (14 , 'ACM');
INSERT INTO Sponsors VALUES (15 , 'Facebook');
INSERT INTO Sponsors VALUES (15 , 'Clean Water');
--
INSERT INTO CompetesIn VALUES (10 , 10 , 'none');
INSERT INTO CompetesIn VALUES (2, 11 , 'silver');
INSERT INTO CompetesIn VALUES (3 , 12 , 'bronze');
INSERT INTO CompetesIn VALUES (4 , 13 , 'none');
INSERT INTO CompetesIn VALUES (5 , 15 , 'none');
INSERT INTO CompetesIn VALUES (6 , 14 , 'gold');
INSERT INTO CompetesIn VALUES (7 , 16 , 'silver');
INSERT INTO CompetesIn VALUES (8 , 17 , 'bronze');
INSERT INTO CompetesIn VALUES (9 , 18 , 'none' );
INSERT INTO CompetesIn VALUES (10 , 19 , 'gold');
INSERT INTO CompetesIn VALUES (11, 20 , 'silver');
INSERT INTO CompetesIn VALUES (12 , 21 , 'bronze');
INSERT INTO CompetesIn VALUES (13, 22, 'none');
INSERT INTO CompetesIn VALUES (14, 23 , 'none');
INSERT INTO CompetesIn VALUES (15, 24 , 'gold');
INSERT INTO CompetesIn VALUES (16, 25 , 'silver');
INSERT INTO CompetesIn VALUES (8 , 26 , 'silver');
INSERT INTO CompetesIn VALUES (9 , 27 , 'none' );
INSERT INTO CompetesIn VALUES (12 , 28 , 'gold');
INSERT INTO CompetesIn VALUES (13, 29, 'none');
INSERT INTO CompetesIn VALUES (14, 30 , 'none');
--
--
SET FEEDBACK ON
COMMIT;
--
-- ------------------------------------
-- -----------QUERIES BELOW------------
--
SELECT * FROM Event;
SELECT * FROM Athlete;
SELECT * FROM Country; 
SELECT * FROM Spectator;
SELECT * FROM Ticket;
SELECT * FROM Sponsors;
SELECT * FROM CompetesIn;
--
--
SELECT C.cname FROM Country C
WHERE C.population > 100000000;
--
-- ------------------------------------
-- Uses MINUS and AVG, returns the
-- countries with above avg population
-- ------------------------------------
--
SELECT C.cname, C.population
FROM Country C
MINUS
SELECT C.cname, C.population
FROM Country C
WHERE C.population < (SELECT AVG(C.population) FROM Country C);
--
-- ------------------------------------
-- Self Join
-- ------------------------------------
--
SELECT S1.eid, S2.eid 
FROM Sponsors S1, Sponsors S2
WHERE S1. eid > 3 AND 
S1.sponsor_name = S2.sponsor_name AND
S1.eid < S2.eid ;
--
-- ------------------------------------
-- Correlated subquery
-- ------------------------------------
--
SELECT E.eid, E.event_date
FROM Event E
WHERE  
	NOT EXISTS ( SELECT *
	FROM  Sponsors S
	WHERE E.eid = S.eid);
--
-- ------------------------------------
-- Non-correlated subquery
-- ------------------------------------
--
SELECT E.eid,  E.event_date
FROM Event E
WHERE  
	E.eid NOT IN ( SELECT S.eid
	FROM  Sponsors S);
--
-- ------------------------------------
-- Marcus made this
-- ------------------------------------
--
SELECT T.eid , T.ticket_number , E.eid , E.event_date
	FROM Ticket T LEFT OUTER JOIN Event E ON T.eid = E.eid;
--
-- ------------------------------------
-- Divisional Subquery
-- ------------------------------------
--
SELECT S.sid, S.lname
FROM Spectator S
WHERE NOT EXISTS((SELECT E.eid
				  FROM Event E
				  WHERE E.eid = 1)
				  MINUS
				  (SELECT E.eid
				   FROM Ticket T, Event E
				   WHERE T.sid = S.sid AND
						 T.eid = E.eid AND
						 E.eid = 1));
--------------------------------------
--  GROUP BY ----
--------------------------------------
Select S.cname, COUNT(*)
FROM Spectator S, Country C
WHERE C.population > 300000000 AND
C.cname = S.cname
GROUP BY S.cname
HAVING COUNT(*) > 3
ORDER BY COUNT(*);
--------------------------------------
--  Join Involving 4 relations ----
--------------------------------------
SELECT DISTINCT S.fname, A.fname
FROM Spectator S, Athlete A, Ticket T, Event E, CompetesIn CI, Country C
WHERE T.sid = S.sid AND
		T.eid = E.eid AND
		A.aid = CI.aid AND
		E.eid = CI.eid AND
		S.cname = A.country;
--
-- TEST CONSTRAINTS
--
-- ------------------------------------
-- Country Test
-- ------------------------------------
INSERT INTO Country VALUES ('United States', 2);
INSERT INTO Country VALUES ('Just a test', -2);
INSERT INTO Country VALUES ('THIS SHOULD WORK', 0);
--
-- ------------------------------------
-- Event Test
-- ------------------------------------
INSERT INTO Event VALUES (1, '6-AUG-16', 2, 'Sport');
INSERT INTO Event VALUES (44444, '6-AUG-16', 10001, 'Sport');
INSERT INTO Event VALUES (44444, '6-AUG-16', -1, 'Sport');
INSERT INTO Event VALUES (55555, '6-AUG-12', 2, 'S');
INSERT INTO Event VALUES (2222, '8-JAN-16', 2, 'S');
--
-- ------------------------------------
-- Sponsors Test
-- ------------------------------------
INSERT INTO Sponsors VALUES (1, 'Microsoft');
INSERT INTO Sponsors VALUES (1, 'Apple');
INSERT INTO Sponsors VALUES (99999, 'Anything');
DELETE FROM Event
WHERE eid = 1;

-- ------------------------------------------
--CompetesIn Test
-- --------------------------------------
INSERT INTO CompetesIn VALUES (14, 30 , 'mike');
INSERT INTO CompetesIn VALUES (14, 30 , 'none');



--
SPOOL OFF
