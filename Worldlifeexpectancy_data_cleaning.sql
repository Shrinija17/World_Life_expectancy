#world_life_expectancy data cleaning

SELECT * 
FROM worldlifeexpectancy;

SELECT country, year, CONCAT(country, year), COUNT(CONCAT(country, year))
FROM worldlifeexpectancy
GROUP BY country, year, CONCAT(country, year)
HAVING COUNT(CONCAT(country, year))>1;

SELECT *
FROM(
   SELECT row_id,
   CONCAT(country, year),
   ROW_NUMBER() OVER( PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT (Country, Year)) AS Row_Num
   FROM worldlifeexpectancy
) AS Row_table
WHERE Row_Num >1
;

SET SQL_SAFE_UPDATES = 0;


DELETE FROM worldlifeexpectancy
WHERE 
     row_id IN (
     SELECT row_id
FROM(
   SELECT Row_ID,
   CONCAT(country, year),
   ROW_NUMBER() OVER( PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT (Country, Year)) AS Row_Num
   FROM worldlifeexpectancy
) AS Row_table
WHERE Row_Num >1
);


SELECT * 
FROM worldlifeexpectancy
WHERE Status = ''
;

SELECT DISTINCT(Status) 
FROM worldlifeexpectancy
WHERE Status != ' '
;

SELECT DISTINCT(Country)
FROM worldlifeexpectancy
WHERE Status = 'Developing';

UPDATE worldlifeexpectancy
SET Status = 'Developing'
WHERE Country IN(SELECT DISTINCT(Country)
                FROM worldlifeexpectancy
                WHERE Status = 'Developing');

UPDATE worldlifeexpectancy t1
JOIN worldlifeexpectancy t2
     ON t1.country = t2.country
SET t1.Status = 'Developing'
WHERE t1.Status = ''
AND t2.Status != ''
AND t2.Status = 'Developing'     
;


UPDATE worldlifeexpectancy t1
JOIN worldlifeexpectancy t2
     ON t1.country = t2.country
SET t1.Status = 'Developed'
WHERE t1.Status = ''
AND t2.Status != ''
AND t2.Status = 'Developed'     
;


SELECT t1.Country,t1.Year,t1.`Life expectancy`,
t2.Country,t2.Year,t2.`Life expectancy`,
t3.Country,t3.Year,t3.`Life expectancy`,
ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
FROM worldlifeexpectancy t1
JOIN worldlifeexpectancy t2
     ON t1.Country = t2.Country
     AND t1.Year = t2.Year - 1
JOIN worldlifeexpectancy t3
     ON t1.Country = t3.Country
     AND t1.Year = t3.Year + 1
WHERE t1.`Life expectancy`=''    
;


UPDATE worldlifeexpectancy t1
JOIN worldlifeexpectancy t2
     ON t1.Country = t2.Country
     AND t1.Year = t2.Year - 1
JOIN worldlifeexpectancy t3
     ON t1.Country = t3.Country
     AND t1.Year = t3.Year + 1
SET t1.`Life expectancy`= ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
WHERE t1.`Life expectancy` = ''
;
