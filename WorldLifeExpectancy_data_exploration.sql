#World life expectancy data analysis


#Fetches complete dataset for analysis.
SELECT *
FROM worldlifeexpectancy;

#1.Life Expectancy Change: Calculates the increase in life expectancy over 15 years per country.
#It finds the minimum and maximum life expectancy for each country.
#The difference (MAX - MIN) gives the improvement in life expectancy over the years.
#The HAVING clause ensures that countries with missing data (0 values) are excluded.
#The results are sorted in descending order, highlighting the countries with the highest improvement in life expectancy over time.
The difference (MAX - MIN) gives the improvement in life expectancy over the years.
The HAVING clause ensures that countries with missing data (0 values) are excluded.
The results are sorted in descending order, highlighting the countries with the highest improvement in life expectancy over time.
SELECT Country, MIN(`Life expectancy`), MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`),1) AS Life_Increase_15_Years
FROM worldlifeexpectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) != 0
AND MAX(`Life expectancy`) != 0
ORDER BY Life_Increase_15_Years DESC
;

#3.Avg Life Expectancy Trend: Shows global average life expectancy trend over time.
#It filters out missing (0) values to avoid skewed results.
SELECT Year, ROUND(AVG(`Life expectancy`),2)
FROM worldlifeexpectancy
WHERE `Life expectancy` != 0
AND `Life expectancy` != 0
GROUP BY Year
ORDER BY Year
;

#4 Life Expectancy vs GDP: Compares average life expectancy and GDP per country.
#Life Expectancy vs GDP: Compares average life expectancy and GDP per country.
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(GDP),1) AS GDP 
FROM worldlifeexpectancy
GROUP BY Country
HAVING Life_Exp > 0
AND GDP > 0
ORDER BY GDP DESC
;

#5 GDP & Life Expectancy: Analyzes life expectancy difference between high-GDP and low-GDP countries.

SELECT 
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP >= 1500 THEN `Life Expectancy` ELSE NULL END) High_GDP_Life_Expectancy,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP_Count,
AVG(CASE WHEN GDP <= 1500 THEN `Life Expectancy` ELSE NULL END) Low_GDP_Life_Expectancy
FROM worldlifeexpectancy
;

#6Life Expectancy by Status: Compares life expectancy in developed vs developing countries.

SELECT Status, Round(AVG(`Life Expectancy`),1)
FROM worldlifeexpectancy
GROUP BY Status
;

#7 Country Count & Life Expectancy: Counts countries in each status category and their avg life expectancy.

SELECT Status, COUNT(DISTINCT Country),Round(AVG(`Life Expectancy`),1)
FROM worldlifeexpectancy
GROUP BY Status
;

#8 Life Expectancy vs BMI: Examines the correlation between BMI and life expectancy per country.

SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(BMI),1) AS BMI
FROM worldlifeexpectancy
GROUP BY Country
HAVING Life_Exp > 0
AND BMI > 0
ORDER BY BMI DESC
;

#9 Rolling Adult Mortality: Tracks cumulative adult mortality over time for countries with "United" in their name.
# The SUM() OVER(PARTITION BY Country ORDER BY Year) function computes a rolling sum of adult mortality, 
#showing how the total mortality has accumulated over the years.
# This analysis helps in understanding trends in adult mortality and whether healthcare improvements have reduced adult mortality over time.

SELECT Country,
Year,
`Life Expectancy`,
`Adult Mortality`,
SUM(`Adult Mortality`)OVER(PARTITION BY Country ORDER BY Year) AS Rolling_total
FROM worldlifeexpectancy
WHERE Country LIKE '%united%'
;















