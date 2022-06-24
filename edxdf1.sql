Create database anew;  --  created new database 
use anew;
SET SESSION sql_mode = '';-- shut safe mode off
-- create TABLE name edsdf1
CREATE TABLE edxdf1 (
    course_id VARCHAR(255) NOT NULL DEFAULT 'NA',
    course_short_title VARCHAR(255) NOT NULL DEFAULT 'NA',
    course_long_title VARCHAR(255) NOT NULL DEFAULT 'NA',
    userid_di VARCHAR(255) NOT NULL DEFAULT 'NA',
    registered INT NOT NULL DEFAULT 0,
    viewed INT NOT NULL DEFAULT 0,
    explored INT NOT NULL DEFAULT 0,
    certified INT NOT NULL DEFAULT 0,
    country VARCHAR(255) NOT NULL DEFAULT 'NA',
    loe_di VARCHAR(255) NOT NULL DEFAULT 'NA',
    yob VARCHAR(255) NOT NULL DEFAULT 'NA',
    age VARCHAR(255) NOT NULL DEFAULT 'NA',
    gender VARCHAR(255) NOT NULL DEFAULT 'NA',
    grade DECIMAL NOT NULL DEFAULT 0,
    start_time_di DATE,
    last_event_di DATE,
    nevents INT NOT NULL DEFAULT 0,
    ndays_act INT NOT NULL DEFAULT 0,
    nplay_video INT NOT NULL DEFAULT 0,
    nchapters INT NOT NULL DEFAULT 0,
    nforum_posts INT NOT NULL DEFAULT 0,
    roles VARCHAR(255) NOT NULL DEFAULT 'NA',
    incomplete_flag INT NOT NULL DEFAULT 0
);
-- loading data into edxdf1                    
Load data infile  "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/EdX_2013 Academic Year Courses.csv"
into table edxdf1
fields terminated by ','
ENCLOSED BY ''''
ignore 1 lines  ;

select * from edxdf1
select distinct loe_di from edxdf1

--  count yob where na and update 
  
  select yob as va ,count(yob) as count from edxdf1  where yob = 'NA';-- 58132
  
UPDATE edxdf1 
SET 
    yob = 'NA'
WHERE
    yob = '';

SELECT 
    COUNT(gender)
FROM
    edxdf1
WHERE
    gender = 'NA';-- 57393

SELECT DISTINCT
    (age)
FROM
    edxdf1
WHERE
    age = 2014;-- 57393
 
UPDATE edxdf1 
SET 
    age = 0
WHERE
    age = 2014;  
  
 -- created a new column season to split
 
 Alter table edxdf1
 add column season varchar(255) not null default 'NA';
   alter table edxdf1
    add column institute varchar(255) not null default 'NA';
 
UPDATE edxdf1 
SET 
    institute = SUBSTRING_INDEX(course_id, '/', 1);
UPDATE edxdf1 
SET 
    season = SUBSTRING_INDEX(course_id, '/', - 1);
    
SELECT DISTINCT
    season
FROM
    edxdf1;
UPDATE edxdf1 
SET 
    Season = '2012_Winter'
WHERE
    season != '2012_Fall' AND season = 2012;
    
    --  outliers in age 0

SELECT DISTINCT
    age
FROM
    edxdf1
WHERE
    age = 'NA';
UPDATE edxdf1 
SET 
    age = 0
WHERE
    age = '';
UPDATE edxdf1 
SET 
    age = 0
WHERE
    age = 'NA'	;
    
     alter table edxdf1
     add column len_age INT not null default 0;
     UPDATE edxdf1
     set len_age = CHAR_LENGTH("age")
     select count(age)  from edxdf1  where age > 1000 -- 41888
     
	select  distinct loe_di , char_length(loe_di) as len from edxdf1 where len = 11      -- like  '%Caribbean%'
    ALTER TABLE edxdf1
    add column xcountry VARCHAR(255) not null default 'NA';
    
 -- concat values in country and loe_di where loe = carribean
UPDATE edxdf1 
SET 
    loe_di = 'NA'
WHERE
    loe_di = '';
SELECT 
    COUNT(loe_di)
FROM
    edxdf1
WHERE
    loe_di IN ('Caribbean"');
 
UPDATE edxdf1 
SET 
    country = CONCAT(country, loe_di)
WHERE
    loe_di IN ('Caribbean"');
    
 -- deal with nulls 
 
SELECT 
    COUNT(loe_di)
FROM
    edxdf1
WHERE
    loe_di IN ('');-- 47710
    
UPDATE edxdf1 
SET 
    loe_di = 'NA'
WHERE
    loe_di IN ('');

-- doe_di fixed

SELECT DISTINCT
    loe_di
FROM
    edxdf1;
 
UPDATE edxdf1 
SET 
    loe_di = 'NA'
WHERE
    loe_di = 'Caribbean"';

-- fix yob 
select DISTINCT age from edxdf1
 where char_length(age) > 2
 
 update edxdf1
 set yob = age 
 where char_length(age) > 2
    
select distinct (yob) from edxdf1 where yob in (0,'')
    
select DISTINCT yob from edxdf1
    
  update edxdf1
 set yob = 2014 
 where yob in (0,'') 
 
 -- fix age 
 
 select count(age) from edxdf1    where (age) < 15 and age != 0
 
update edxdf1
set age = gender 
where gender > 1 
    
update edxdf1
set age = 0 
where age = 2014
    
    
-- fix gender

select DISTINCT gender from edxdf1 where gender > 0;

UPDATE edxdf1 
SET 
    gender = 'NA'
WHERE
    gender = '';

UPDATE edxdf1 
SET 
    gender = TRIM(gender);

UPDATE edxdf1 
SET 
    gender = 'NA'
WHERE
    CHAR_LENGTH(gender) > 2;
 
UPDATE edxdf1 
SET 
    gender = 'NA'
WHERE
    gender IN ('NA' , '', '#VALUE!');
    
-- fix duplicates start_time_di,userid_di,course_id,course_short_title
SELECT 
    COUNT(DISTINCT userid_di,
        course_id,
        course_short_title,
        start_time_di),
    COUNT(userid_di)
FROM
    edxdf1;
    
   
SELECT 
    COUNT(DISTINCT start_time_di, userid_di, course_id)
FROM
    edxdf1; -- userid_di 641138  distinct = 476532
   SELECT distinct          userid_di       from edxdf1 where   userid_di  is null
   SELECT distinct          userid_di        from edxdf1 where   userid_di  = ''
   
   select * from edxdf1
   
      select distinct grade from edxdf1
   select distinct start_time_di from edxdf1
   select distinct last_event_di from edxdf1
   select distinct nevents from edxdf1
   select distinct ndays_act from edxdf1
   select distinct nplay_video from edxdf1
   select distinct nchapters from edxdf1
   select distinct nforum_posts from edxdf1
   select distinct roles from edxdf1
   select distinct incomplete_flag from edxdf1
   select distinct institute from edxdf1
   select distinct season from edxdf1
   alter table edxdf1
   drop column roles
   
TABLE edxdf1
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/edxdf.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'