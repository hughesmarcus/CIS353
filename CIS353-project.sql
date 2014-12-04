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
SET FEEDBACK OFF
DROP TABLE Sponsors;
DROP TABLE Event;
DROP TABLE Athlete;
DROP TABLE Spectator;
DROP TABLE Ticket;
DROP TABLE Country;
DROP TABLE CompetesIn;
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
	DEFERABLE INITIALLY DEFERRED,
CONSTRAINT AC3 FOREIGN KEY (country) REFERENCES Country(cname)
	ON DELETE CASCADE
	DEFERABLE INITIALLY DEFERRED
);
--
CREATE TABLE CompetesIn
(
eid INTEGER,
aid INTEGER,
medal CHAR(15) NOT NULL,
--
CONSTRAINT CIC1 PRIMARY KEY (eid, aid),
CONSTRAINT CIC2 CHECK(medal = 'gold' || medal = 'silver' || medal = 'bronze' || medal = 'none'),
CONSTRAINT CIC3 FOREIGN KEY (eid) REFERENCES Event(eid),
CONSTRAINT CIC4 FOREIGN KEY (aid) REFERENCES Athlete(aid)
);
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
	DEFERRABLE INITIALLY DEFERRED
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
INSERT INTO Event VALUES (8, '11-AUG-16', 0. 'Football');
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
INSERT INTO Athlete VALUES(10, 'OBrien', 'John');
INSERT INTO Athlete VALUES(11, 'OBrien', 'Jack');
INSERT INTO Athlete VALUES(12, 'Hughes', 'Marcus');
INSERT INTO Athlete VALUES(13, 'Keel', 'Travis');
INSERT INTO Athlete VALUES(14, 'Ramic', 'Alen');
INSERT INTO Athlete VALUES(15, 'Kelch', 'Daniel');
INSERT INTO Athlete VALUES(16, 'Springus', 'Harold');
INSERT INTO Athlete VALUES(17, 'Hawthorne', 'Gerald');
INSERT INTO Athlete VALUES(18, 'Front', 'Rosemary');
INSERT INTO Athlete VALUES(19, 'Tennis', 'Tim');
INSERT INTO Athlete VALUES(20, 'Robertson', 'Robert');
INSERT INTO Athlete VALUES(21, 'Hudson', 'Marlene');
INSERT INTO Athlete VALUES(22, 'West', 'North');
INSERT INTO Athlete VALUES(23, 'Philips', 'Michael');
INSERT INTO Athlete VALUES(24, 'Muscle', 'Uncle');
INSERT INTO Athlete VALUES(25, 'Lee', 'Bryce');
INSERT INTO Athlete VALUES(26, 'Hoke', 'Brady');
INSERT INTO Athlete VALUES(27, 'Seger', 'Bill');
INSERT INTO Athlete VALUES(28, 'Obama', 'BarackHUSSEIN');
INSERT INTO Athlete VALUES(29, 'Jonas', 'Mick');
INSERT INTO Athlete VALUES(30, 'Jackson III', 'Curtis James');

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
SET FEEDBACK ON
COMMIT;
--
-- ------------------------------------
-- -----------QUERIES BELOW------------
-- ------------------------------------
-- Marcus, your queries don't work.---- 
-- At all. ----------------------------
--
SELECT * FROM Event;
SELECT * FROM Athlete;
SELECT * FROM Country; 
SELECT * FROM Spectator;
SELECT * FROM Ticket;
SELECT * FROM Sponsors;
SELECT * FROM CompetesIn;
SELECT * FROM Event;
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

--correlated subquery 
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
-- non-correlated subquery
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
	FROM TICKET T LEFT OUTER JOIN EVENT E ON T.eid = E.eid;
--
-- ------------------------------------
-- Divisional Subquery
-- ------------------------------------
--
SELECT A.aid, A.country, A.lname
FROM Athlete A
WHERE NOT EXISTS((SELECT E.eid
				   FROM Event E
				   WHERE E.eid = 4
				   MINUS
				   (SELECT E.Sport
				    FROM Event E, CompetesIn C
				    WHERE C.aid = A.aid AND
						  C.eid = E.eid AND
						  E.eid = 4)));
						
--------------------------------------
--  GROUP BY ----
--------------------------------------
Select S.country, COUNT(*)
from Spectator s, Country c
Where c.population > 300,000,000 AND
c.cname = s.country
Group By s.country
Having count(*) > 3;



SPOOL OFF
