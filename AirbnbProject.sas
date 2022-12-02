PROC SQL;
ALTER TABLE work.bnb 
DROP survey_id, country, city, borough, minstay, bathrooms; 
RUN;

PROC SQL;
SELECT * FROM work.bnb WHERE name IS NULL;
RUN;

PROC SQL;
DELETE FROM work.bnb WHERE name IS NULL;
RUN;

PROC SQL;
SELECT * FROM work.bnb WHERE name IS NULL;
RUN;

PROC SQL;
SELECT COUNT(name) AS Count FROM work.bnb WHERE name IS NULL;
RUN;

PROC SQL;
CREATE TABLE numroomtypes as
SELECT COUNT('room_type'n) AS count, 'room_type'n FROM work.bnb GROUP BY 'room_type'n;
RUN;

title 'Distributing number of room types';
proc SGPLOT data = work.numroomtypes;
  vbar 'room_type'n /RESPONSE= count
    categoryorder=respdesc nostatlabel;
  run;
  quit;
  
PROC SQL OUTOBS=50;
CREATE TABLE satis as
select reviews, overall_satisfaction from work.bnb; 
RUN;

TITLE 'Reviews vs Overall Satisfaction';
PROC sgscatter  DATA = satis;
   PLOT reviews*overall_satisfaction 
   / datalabel = reviews group = overall_satisfaction grid;
RUN;

PROC SQL OUTOBS=20;
CREATE TABLE avgneighbor as
SELECT avg(overall_satisfaction) AS satisfaction, neighborhood 
FROM  work.bnb  
GROUP BY neighborhood  
ORDER BY satisfaction DESC;
RUN;

title 'Distributing the first 20 neighborhoods with the average level of satisfaction';
proc SGPLOT data = work.avgneighbor;
  vbar neighborhood /RESPONSE= satisfaction
    categoryorder=respdesc nostatlabel;
  run;
  quit;
 
PROC SQL;
CREATE TABLE expensive AS
SELECT MAX(price) AS price, neighborhood 
FROM work.bnb 
GROUP BY neighborhood 
ORDER BY price desc;
RUN;

title 'Distributing the most expensive rooms (prices in Euro)';
proc SGPLOT data = work.expensive;
  format price euro9.2;
  vbar neighborhood /RESPONSE= price
     categoryorder=respdesc nostatlabel;
  run;
  quit;

PROC SQL OUTOBS=230;
CREATE TABLE location AS
SELECT neighborhood, latitude, longitude 
FROM work.bnb  
WHERE price > 50 AND price < 20;
RUN;

PROC SQL OUTOBS=230;
CREATE TABLE location AS
SELECT neighborhood, latitude, longitude 
FROM work.bnb  
WHERE price < 20;
RUN;


PROC SQL outobs=10;
CREATE TABLE host as
select distinct 'host_id'n AS hostId, count(distinct 'room_id'n) AS count
FROM work.bnb  
GROUP BY hostId 
ORDER BY count DESC;
RUN;

title 'Distributing the number of rooms per host';
proc SGPLOT data = work.host;
  vbar hostId /RESPONSE= count
     categoryorder=respdesc nostatlabel;
  run;
  quit;


PROC SQL;
CREATE TABLE rooms AS
select avg(price) AS 'avg_price'n, 'room_type'n 
from work.bnb 
GROUP BY 'room_type'n 
ORDER BY 'avg_price'n desc;
RUN;

title 'Distributing average prices for each room type';
proc SGPLOT data = work.rooms;
  format 'avg_price'n euro8.2;
  vbar room_type /RESPONSE= avg_price
     categoryorder=respdesc nostatlabel;
  run;
  quit;


PROC SQL;
CREATE TABLE room_per_neighborhood AS
select count(room_type) AS count ,neighborhood ,'room_type'n 
from  work.bnb  
GROUP BY 'room_type'n, neighborhood  
ORDER BY count desc;
RUN;

title 'Distributing the neighborhood and number of room types it have';
proc SGPLOT data = work.room_per_neighborhood;
    vbar neighborhood / response= count group = 'room_type'n  GROUPDISPLAY = CLUSTER 
    categoryorder=respdesc nostatlabel;
run;
quit;

PROC SQL outobs=5;
CREATE TABLE count_host AS
select count(host_id) as count, neighborhood 
from work.bnb
group by neighborhood 
order by count desc;
RUN;

title 'Distributing neighborhoods with the most number of host';
proc gchart data=work.count_host;
       pie neighborhood / sumvar=count  
               noheading           
          percent=inside plabel=(height=12pt)             
          slice=outside value=none 
          name='PieChart';              
run;
quit;

PROC SQL;
CREATE TABLE revprice AS
SELECT reviews, price 
FROM work.bnb;
RUN;

TITLE 'Reviews based on price(Euro)';
PROC sgscatter  DATA = revprice;
   format price euro8.2;
   PLOT price * reviews
   / datalabel = price group = reviews grid;
RUN;


PROC SQL outobs=40;
CREATE TABLE accommodation AS
select DISTINCT(room_id) AS rooms, accommodates 
from work.bnb 
WHERE accommodates BETWEEN 10 AND 15 
GROUP BY rooms 
ORDER BY accommodates desc;
RUN;

title 'Distributing rooms that can accommodate 10 to 15 people';
proc SGPLOT data = work.accommodation;
  hbar rooms /RESPONSE= accommodates
    categoryorder=respdesc nostatlabel;
  run;
  quit;


PROC SQL outobs=40; 
CREATE TABLE bedroom AS
select DISTINCT(room_id) AS roomnumber, SUM(bedrooms) AS count
from work.bnb 
GROUP BY roomnumber 
ORDER BY count DESC;
RUN;

title 'Distributing number of bedrooms in each room';
proc SGPLOT data = work.bedroom;
  vbar roomnumber /RESPONSE= count
    categoryorder=respdesc nostatlabel;
  run;
  quit;


  
