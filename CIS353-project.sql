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
sponsor_name CHAR(20) NOT NULL,
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
lname CHAR(10) NOT NULL,
fname CHAR(10) NOT NULL,
--
--
CONSTRAINT AC1 PRIMARY KEY (aid)
);
--
--
CREATE TABLE Country
(
cname VARCHAR2(15) NOT NULL,
population INTEGER,
--
--
CONSTRAINT CC1 PRIMARY KEY (cname)
);
--
-- ------------------------------------
-- Spectator table
-- ------------------------------------
--
CREATE TABLE Spectator
(
sid INTEGER,
lname CHAR(10) NOT NULL,
fname CHAR(10) NOT NULL,
--
--
CONSTRAINT SPC1 PRIMARY KEY (sid)
);
-- ------------------------------------
-- Ticket table
-- ------------------------------------
--
CREATE TABLE Ticket
(
ticket_number INTEGER,
section_number INTEGER,
price INTEGER
--
);
--
SET AUTOCOMMIT OFF
--
INSERT INTO Event VALUES (1, '06-AUG-16',987);
INSERT INTO Event VALUES (2, '08-AUG-16', 67);
INSERT INTO Event VALUES (3, '13-AUG-16', 5);
INSERT INTO Event VALUES (4, '21-AUG-16', 30);
INSERT INTO Event VALUES (5, '07-AUG-16',254);
INSERT INTO Event VALUES (6, '09-AUG-16', 670);
INSERT INTO Event VALUES (7, '11-AUG-16', 51);
INSERT INTO Event VALUES (8, '11-AUG-16', 0);
INSERT INTO Event VALUES (9, '11-AUG-16', 87);
INSERT INTO Event VALUES (10, '21-AUG-16', 67);
INSERT INTO Event VALUES (11, '15-AUG-16', 9000);
INSERT INTO Event VALUES (12, '16-AUG-16', 0007);
INSERT INTO Event VALUES (13, '17-AUG-16', 21);
INSERT INTO Event VALUES (14, '18-AUG-16', 781);
INSERT INTO Event VALUES (15, '19-AUG-16', 19);
INSERT INTO Event VALUES (16, '20-AUG-16', 20);
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
--
INSERT INTO
--
COMMIT;
-- ------------------------------------
SELECT * FROM Event;
SELECT C.cname FROM Country C
WHERE C.population > 100000000;
SPOOL OFF
--
