#CREATE SCHEMA TB;
use TB;

DROP TABLE IF EXISTS tb;

CREATE TABLE tb 
(
  country varchar(100) NOT NULL,
  year int NOT NULL,
  sex varchar(6) NOT NULL,
  child int NULL,
  adult int NULL,
  elderly int NULL
);

SELECT * FROM tb;

##
SHOW VARIABLES LIKE 'secure%';
##


LOAD DATA LOCAL INFILE 'Users/anjalhussan/Desktop/607 Data Acquisition/DATA_607_CUNY_SPS/Week_2_Assignment/TB/tb.csv'
INTO TABLE tb
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(country, year, sex, @child, @adult, @elderly)
SET
child = nullif(@child,-1),
adult = nullif(@adult,-1),
elderly = nullif(@elderly,-1)
;

SELECT * FROM tb WHERE elderly IS NULL;
SELECT COUNT(*) FROM tb;

##hand's on lab

SELECT * FROM tb LIMIT 20; 

SELECT country, year, sex, child+adult+elderly AS cases 
FROM tb; 

DROP TABLE IF EXISTS tb_cases;
CREATE TABLE tb_cases AS 
 SELECT country, year, sex, child+adult+elderly AS cases 
FROM tb; 

SELECT * 
FROM tb_cases 
WHERE country = 'Afghanistan' 
ORDER BY country, year 
LIMIT 50; 


SELECT country, year, SUM(cases) AS cases 
 FROM tb_cases 
GROUP BY country, year 
HAVING cases IS NOT NULL 
ORDER BY country, year; 

SELECT country, year, SUM(cases) AS cases INTO OUTFILE 'Users/anjalhussan/Desktop/607 Data Acquisition/DATA_607_CUNY_SPS/Week_2_Assignment/TB/tb_cases.csv' 
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' 
ESCAPED BY '\\' 
LINES TERMINATED BY '\n' 
FROM tb_cases 
GROUP BY country, year 
HAVING cases IS NOT NULL 
ORDER BY country, year; 