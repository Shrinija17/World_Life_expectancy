#World life expectancy data analysis

SELECT *
FROM worldlifeexpectancy;

SELECT Country, MIN(`Life expectancy`), MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`),1) AS Life_Increase_15_Years
FROM worldlifeexpectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) != 0
AND MAX(`Life expectancy`) != 0
ORDER BY Life_Increase_15_Years DESC
;

SELECT Year, ROUND(AVG(`Life expectancy`),2)
FROM worldlifeexpectancy
WHERE `Life expectancy` != 0
AND `Life expectancy` != 0
GROUP BY Year
ORDER BY Year
;

SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(GDP),1) AS GDP 
FROM worldlifeexpectancy
GROUP BY Country
HAVING Life_Exp > 0
AND GDP > 0
ORDER BY GDP DESC
;

SELECT 
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP >= 1500 THEN `Life Expectancy` ELSE NULL END) High_GDP_Life_Expectancy,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP_Count,
AVG(CASE WHEN GDP <= 1500 THEN `Life Expectancy` ELSE NULL END) Low_GDP_Life_Expectancy
FROM worldlifeexpectancy
;


SELECT Status, Round(AVG(`Life Expectancy`),1)
FROM worldlifeexpectancy
GROUP BY Status
;


SELECT Status, COUNT(DISTINCT Country),Round(AVG(`Life Expectancy`),1)
FROM worldlifeexpectancy
GROUP BY Status
;

SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(BMI),1) AS BMI
FROM worldlifeexpectancy
GROUP BY Country
HAVING Life_Exp > 0
AND BMI > 0
ORDER BY BMI DESC
;

SELECT Country,
Year,
`Life Expectancy`,
`Adult Mortality`,
SUM(`Adult Mortality`)OVER(PARTITION BY Country ORDER BY Year) AS Rolling_total
FROM worldlifeexpectancy
WHERE Country LIKE '%united%'
;















