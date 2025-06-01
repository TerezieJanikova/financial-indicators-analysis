--PŘIDÁNÍ HODNOT PRO VŠECHNY CHYBĚJÍCÍ ROKY - AGE

-- INTERVAL 2002-2006 (roky 2003-2005)
BEGIN TRAN

WITH kombinace_1 AS (
  SELECT
    t1.Edu_field,
    t1.Gender,
    t1.Age_class,
    t1.Country,
    t1.Industry_sector,
    t1.Value_czk AS Income_2002,
    t2.Value_czk AS Income_2006
  FROM income_age_final t1
  JOIN income_age_final t2
    ON t1.Edu_field = t2.Edu_field
    AND t1.Gender = t2.Gender
    AND t1.Age_class = t2.Age_class
    AND t1.Country = t2.Country
    AND t1.Industry_sector = t2.Industry_sector
  WHERE t1.Year = 2002 AND t2.Year = 2006
),
interpolace_1 AS (
  SELECT Edu_field, Gender, Age_class, Country, Industry_sector, 2003 AS Year,
    (Income_2006 - Income_2002) / 4.0 * 1 + Income_2002 AS Income
  FROM kombinace_1
  UNION ALL
  SELECT Edu_field, Gender, Age_class, Country, Industry_sector, 2004,
    (Income_2006 - Income_2002) / 4.0 * 2 + Income_2002
  FROM kombinace_1
  UNION ALL
  SELECT Edu_field, Gender, Age_class, Country, Industry_sector, 2005,
    (Income_2006 - Income_2002) / 4.0 * 3 + Income_2002
  FROM kombinace_1
),
k_vlozeni_1 AS (
  SELECT i.*
  FROM interpolace_1 i
  LEFT JOIN income_age_final_all f
    ON f.Edu_field = i.Edu_field
    AND f.Gender = i.Gender
    AND f.Age_class = i.Age_class
    AND f.Country = i.Country
    AND f.Industry_sector = i.Industry_sector
    AND f.Year = i.Year
  WHERE f.Year IS NULL
)
INSERT INTO income_age_final_all (Edu_field, Gender, Age_class, Country, Industry_sector, Year, Value_czk)
SELECT Edu_field, Gender, Age_class, Country, Industry_sector, Year, Income
FROM k_vlozeni_1;

-- INTERVAL 2006-2010 (roky 2007-2009)
WITH kombinace_2 AS (
  SELECT
    t1.Edu_field,
    t1.Gender,
    t1.Age_class,
    t1.Country,
    t1.Industry_sector,
    t1.Value_czk AS Income_2006,
    t2.Value_czk AS Income_2010
  FROM income_age_final t1
  JOIN income_age_final t2
    ON t1.Edu_field = t2.Edu_field
    AND t1.Gender = t2.Gender
    AND t1.Age_class = t2.Age_class
    AND t1.Country = t2.Country
    AND t1.Industry_sector = t2.Industry_sector
  WHERE t1.Year = 2006 AND t2.Year = 2010
),
interpolace_2 AS (
  SELECT Edu_field, Gender, Age_class, Country, Industry_sector, 2007 AS Year,
    (Income_2010 - Income_2006) / 4.0 * 1 + Income_2006 AS Income
  FROM kombinace_2
  UNION ALL
  SELECT Edu_field, Gender, Age_class, Country, Industry_sector, 2008,
    (Income_2010 - Income_2006) / 4.0 * 2 + Income_2006
  FROM kombinace_2
  UNION ALL
  SELECT Edu_field, Gender, Age_class, Country, Industry_sector, 2009,
    (Income_2010 - Income_2006) / 4.0 * 3 + Income_2006
  FROM kombinace_2
),
k_vlozeni_2 AS (
  SELECT i.*
  FROM interpolace_2 i
  LEFT JOIN income_age_final_all f
    ON f.Edu_field = i.Edu_field
    AND f.Gender = i.Gender
    AND f.Age_class = i.Age_class
    AND f.Country = i.Country
    AND f.Industry_sector = i.Industry_sector
    AND f.Year = i.Year
  WHERE f.Year IS NULL
)
INSERT INTO income_age_final_all (Edu_field, Gender, Age_class, Country, Industry_sector, Year, Value_czk)
SELECT Edu_field, Gender, Age_class, Country, Industry_sector, Year, Income
FROM k_vlozeni_2;

-- INTERVAL 2010-2014 (roky 2011-2013)
WITH kombinace_3 AS (
  SELECT
    t1.Edu_field,
    t1.Gender,
    t1.Age_class,
    t1.Country,
    t1.Industry_sector,
    t1.Value_czk AS Income_2010,
    t2.Value_czk AS Income_2014
  FROM income_age_final t1
  JOIN income_age_final t2
    ON t1.Edu_field = t2.Edu_field
    AND t1.Gender = t2.Gender
    AND t1.Age_class = t2.Age_class
    AND t1.Country = t2.Country
    AND t1.Industry_sector = t2.Industry_sector
  WHERE t1.Year = 2010 AND t2.Year = 2014
),
interpolace_3 AS (
  SELECT Edu_field, Gender, Age_class, Country, Industry_sector, 2011 AS Year,
    (Income_2014 - Income_2010) / 4.0 * 1 + Income_2010 AS Income
  FROM kombinace_3
  UNION ALL
  SELECT Edu_field, Gender, Age_class, Country, Industry_sector, 2012,
    (Income_2014 - Income_2010) / 4.0 * 2 + Income_2010
  FROM kombinace_3
  UNION ALL
  SELECT Edu_field, Gender, Age_class, Country, Industry_sector, 2013,
    (Income_2014 - Income_2010) / 4.0 * 3 + Income_2010
  FROM kombinace_3
),
k_vlozeni_3 AS (
  SELECT i.*
  FROM interpolace_3 i
  LEFT JOIN income_age_final_all f
    ON f.Edu_field = i.Edu_field
    AND f.Gender = i.Gender
    AND f.Age_class = i.Age_class
    AND f.Country = i.Country
    AND f.Industry_sector = i.Industry_sector
    AND f.Year = i.Year
  WHERE f.Year IS NULL
)
INSERT INTO income_age_final_all (Edu_field, Gender, Age_class, Country, Industry_sector, Year, Value_czk)
SELECT Edu_field, Gender, Age_class, Country, Industry_sector, Year, Income
FROM k_vlozeni_3;

-- INTERVAL 2014-2018 (roky 2015-2017)
WITH kombinace_4 AS (
  SELECT
    t1.Edu_field,
    t1.Gender,
    t1.Age_class,
    t1.Country,
    t1.Industry_sector,
    t1.Value_czk AS Income_2014,
    t2.Value_czk AS Income_2018
  FROM income_age_final t1
  JOIN income_age_final t2
    ON t1.Edu_field = t2.Edu_field
    AND t1.Gender = t2.Gender
    AND t1.Age_class = t2.Age_class
    AND t1.Country = t2.Country
    AND t1.Industry_sector = t2.Industry_sector
  WHERE t1.Year = 2014 AND t2.Year = 2018
),
interpolace_4 AS (
  SELECT Edu_field, Gender, Age_class, Country, Industry_sector, 2015 AS Year,
    (Income_2018 - Income_2014) / 4.0 * 1 + Income_2014 AS Income
  FROM kombinace_4
  UNION ALL
  SELECT Edu_field, Gender, Age_class, Country, Industry_sector, 2016,
    (Income_2018 - Income_2014) / 4.0 * 2 + Income_2014
  FROM kombinace_4
  UNION ALL
  SELECT Edu_field, Gender, Age_class, Country, Industry_sector, 2017,
    (Income_2018 - Income_2014) / 4.0 * 3 + Income_2014
  FROM kombinace_4
),
k_vlozeni_4 AS (
  SELECT i.*
  FROM interpolace_4 i
  LEFT JOIN income_age_final_all f
    ON f.Edu_field = i.Edu_field
    AND f.Gender = i.Gender
    AND f.Age_class = i.Age_class
    AND f.Country = i.Country
    AND f.Industry_sector = i.Industry_sector
    AND f.Year = i.Year
  WHERE f.Year IS NULL
)
INSERT INTO income_age_final_all (Edu_field, Gender, Age_class, Country, Industry_sector, Year, Value_czk)
SELECT Edu_field, Gender, Age_class, Country, Industry_sector, Year, Income
FROM k_vlozeni_4;

-- INTERVAL 2018-2022 (roky 2019-2021)
WITH kombinace_5 AS (
  SELECT
    t1.Edu_field,
    t1.Gender,
    t1.Age_class,
    t1.Country,
    t1.Industry_sector,
    t1.Value_czk AS Income_2018,
    t2.Value_czk AS Income_2022
  FROM income_age_final t1
  JOIN income_age_final t2
    ON t1.Edu_field = t2.Edu_field
    AND t1.Gender = t2.Gender
    AND t1.Age_class = t2.Age_class
    AND t1.Country = t2.Country
    AND t1.Industry_sector = t2.Industry_sector
  WHERE t1.Year = 2018 AND t2.Year = 2022
),
interpolace_5 AS (
  SELECT Edu_field, Gender, Age_class, Country, Industry_sector, 2019 AS Year,
    (Income_2022 - Income_2018) / 4.0 * 1 + Income_2018 AS Income
  FROM kombinace_5
  UNION ALL
  SELECT Edu_field, Gender, Age_class, Country, Industry_sector, 2020,
    (Income_2022 - Income_2018) / 4.0 * 2 + Income_2018
  FROM kombinace_5
  UNION ALL
  SELECT Edu_field, Gender, Age_class, Country, Industry_sector, 2021,
    (Income_2022 - Income_2018) / 4.0 * 3 + Income_2018
  FROM kombinace_5
),
k_vlozeni_5 AS (
  SELECT i.*
  FROM interpolace_5 i
  LEFT JOIN income_age_final_all f
    ON f.Edu_field = i.Edu_field
    AND f.Gender = i.Gender
    AND f.Age_class = i.Age_class
    AND f.Country = i.Country
    AND f.Industry_sector = i.Industry_sector
    AND f.Year = i.Year
  WHERE f.Year IS NULL
)
INSERT INTO income_age_final_all (Edu_field, Gender, Age_class, Country, Industry_sector, Year, Value_czk)
SELECT Edu_field, Gender, Age_class, Country, Industry_sector, Year, Income
FROM k_vlozeni_5;

UPDATE income_age_final_all
SET Currency = 'Euro'
WHERE Currency IS NULL;
commit 
select * from income_age_final_all where Country like N'Czechia' and Industry_sector like N'Education' order by year ASC
select* from income_age_final_all

drop table income_edu_final_kopie
--PŘIDÁNÍ HODNOT PRO VŠECHNY CHYBĚJÍCÍ ROKY - EDU

begin tran 
WITH kombinace_1 AS (
  SELECT
    t1.Edu_field,
    t1.Gender,
    t1.Education_level,
    t1.Country,
    t1.Industry_sector,
    t1.Value_czk AS Income_2002,
    t2.Value_czk AS Income_2006
  FROM Income_edu_final_bez_duplikat t1
  JOIN Income_edu_final_bez_duplikat t2
    ON t1.Edu_field = t2.Edu_field
    AND t1.Gender = t2.Gender
    AND t1.Education_level = t2.Education_level
    AND t1.Country = t2.Country
    AND t1.Industry_sector = t2.Industry_sector
  WHERE t1.Year = 2002 AND t2.Year = 2006
),
interpolace_1 AS (
  SELECT Edu_field, Gender, Education_level, Country, Industry_sector, 2003 AS Year,
    (Income_2006 - Income_2002) / 4.0 * 1 + Income_2002 AS Income
  FROM kombinace_1
  UNION ALL
  SELECT Edu_field, Gender, Education_level, Country, Industry_sector, 2004,
    (Income_2006 - Income_2002) / 4.0 * 2 + Income_2002
  FROM kombinace_1
  UNION ALL
  SELECT Edu_field, Gender, Education_level, Country, Industry_sector, 2005,
    (Income_2006 - Income_2002) / 4.0 * 3 + Income_2002
  FROM kombinace_1
),
k_vlozeni_1 AS (
  SELECT i.*
  FROM interpolace_1 i
  LEFT JOIN income_edu_final_kopie f
    ON f.Edu_field = i.Edu_field
    AND f.Gender = i.Gender
    AND f.Education_level = i.Education_level
    AND f.Country = i.Country
    AND f.Industry_sector = i.Industry_sector
    AND f.Year = i.Year
  WHERE f.Year IS NULL
)
INSERT INTO income_edu_final_kopie (Edu_field, Gender, Education_level, Country, Industry_sector, Year, Value_czk)
SELECT Edu_field, Gender, Education_level, Country, Industry_sector, Year, Income
FROM k_vlozeni_1;

 -- ROKY 2006-2010 
 
WITH kombinace_2 AS (
  SELECT
    t1.Edu_field,
    t1.Gender,
    t1.Education_level,
    t1.Country,
    t1.Industry_sector,
    t1.Value_czk AS Income_2006,
    t2.Value_czk AS Income_2010
  FROM Income_edu_final_bez_duplikat t1
  JOIN Income_edu_final_bez_duplikat t2
    ON t1.Edu_field = t2.Edu_field
    AND t1.Gender = t2.Gender
    AND t1.Education_level = t2.Education_level
    AND t1.Country = t2.Country
    AND t1.Industry_sector = t2.Industry_sector
  WHERE t1.Year = 2006 AND t2.Year = 2010
),
interpolace_2 AS (
  SELECT Edu_field, Gender, Education_level, Country, Industry_sector, 2007 AS Year,
    (Income_2010 - Income_2006) / 4.0 * 1 + Income_2006 AS Income
  FROM kombinace_2
  UNION ALL
  SELECT Edu_field, Gender, Education_level, Country, Industry_sector, 2008,
    (Income_2010 - Income_2006) / 4.0 * 2 + Income_2006
  FROM kombinace_2
  UNION ALL
  SELECT Edu_field, Gender, Education_level, Country, Industry_sector, 2009,
    (Income_2010 - Income_2006) / 4.0 * 3 + Income_2006
  FROM kombinace_2
),
k_vlozeni_2 AS (
  SELECT i.*
  FROM interpolace_2 i
  LEFT JOIN income_edu_final_kopie f
    ON f.Edu_field = i.Edu_field
    AND f.Gender = i.Gender
    AND f.Education_level = i.Education_level
    AND f.Country = i.Country
    AND f.Industry_sector = i.Industry_sector
    AND f.Year = i.Year
  WHERE f.Year IS NULL
)
INSERT INTO income_edu_final_kopie (Edu_field, Gender, Education_level, Country, Industry_sector, Year, Value_czk)
SELECT Edu_field, Gender, Education_level, Country, Industry_sector, Year, Income
FROM k_vlozeni_2;

-- 2010-2014
WITH kombinace_3 AS (
  SELECT
    t1.Edu_field,
    t1.Gender,
    t1.Education_level,
    t1.Country,
    t1.Industry_sector,
    t1.Value_czk AS Income_2010,
    t2.Value_czk AS Income_2014
  FROM Income_edu_final_bez_duplikat t1
  JOIN Income_edu_final_bez_duplikat t2
    ON t1.Edu_field = t2.Edu_field
    AND t1.Gender = t2.Gender
    AND t1.Education_level = t2.Education_level
    AND t1.Country = t2.Country
    AND t1.Industry_sector = t2.Industry_sector
  WHERE t1.Year = 2010 AND t2.Year = 2014
),
interpolace_3 AS (
  SELECT Edu_field, Gender, Education_level, Country, Industry_sector, 2011 AS Year,
    (Income_2014 - Income_2010) / 4.0 * 1 + Income_2010 AS Income
  FROM kombinace_3
  UNION ALL
  SELECT Edu_field, Gender, Education_level, Country, Industry_sector, 2012,
    (Income_2014 - Income_2010) / 4.0 * 2 + Income_2010
  FROM kombinace_3
  UNION ALL
  SELECT Edu_field, Gender, Education_level, Country, Industry_sector, 2013,
    (Income_2014 - Income_2010) / 4.0 * 3 + Income_2010
  FROM kombinace_3
),
k_vlozeni_3 AS (
  SELECT i.*
  FROM interpolace_3 i
  LEFT JOIN income_edu_final_kopie f
    ON f.Edu_field = i.Edu_field
    AND f.Gender = i.Gender
    AND f.Education_level = i.Education_level
    AND f.Country = i.Country
    AND f.Industry_sector = i.Industry_sector
    AND f.Year = i.Year
  WHERE f.Year IS NULL
)
INSERT INTO income_edu_final_kopie (Edu_field, Gender, Education_level, Country, Industry_sector, Year, Value_czk)
SELECT Edu_field, Gender, Education_level, Country, Industry_sector, Year, Income
FROM k_vlozeni_3;

--2014-2018
WITH kombinace_4 AS (
  SELECT
    t1.Edu_field,
    t1.Gender,
    t1.Education_level,
    t1.Country,
    t1.Industry_sector,
    t1.Value_czk AS Income_2014,
    t2.Value_czk AS Income_2018
  FROM Income_edu_final_bez_duplikat t1
  JOIN Income_edu_final_bez_duplikat t2
    ON t1.Edu_field = t2.Edu_field
    AND t1.Gender = t2.Gender
    AND t1.Education_level = t2.Education_level
    AND t1.Country = t2.Country
    AND t1.Industry_sector = t2.Industry_sector
  WHERE t1.Year = 2014 AND t2.Year = 2018
),
interpolace_4 AS (
  SELECT Edu_field, Gender, Education_level, Country, Industry_sector, 2015 AS Year,
    (Income_2018 - Income_2014) / 4.0 * 1 + Income_2014 AS Income
  FROM kombinace_4
  UNION ALL
  SELECT Edu_field, Gender, Education_level, Country, Industry_sector, 2016,
    (Income_2018 - Income_2014) / 4.0 * 2 + Income_2014
  FROM kombinace_4
  UNION ALL
  SELECT Edu_field, Gender, Education_level, Country, Industry_sector, 2017,
    (Income_2018 - Income_2014) / 4.0 * 3 + Income_2014
  FROM kombinace_4
),
k_vlozeni_4 AS (
  SELECT i.*
  FROM interpolace_4 i
  LEFT JOIN income_edu_final_kopie f
    ON f.Edu_field = i.Edu_field
    AND f.Gender = i.Gender
    AND f.Education_level = i.Education_level
    AND f.Country = i.Country
    AND f.Industry_sector = i.Industry_sector
    AND f.Year = i.Year
  WHERE f.Year IS NULL
)
INSERT INTO income_edu_final_kopie (Edu_field, Gender, Education_level, Country, Industry_sector, Year, Value_czk)
SELECT Edu_field, Gender, Education_level, Country, Industry_sector, Year, Income
FROM k_vlozeni_4;

--2018-2022

WITH kombinace_5 AS (
  SELECT
    t1.Edu_field,
    t1.Gender,
    t1.Education_level,
    t1.Country,
    t1.Industry_sector,
    t1.Value_czk AS Income_2018,
    t2.Value_czk AS Income_2022
  FROM Income_edu_final_bez_duplikat t1
  JOIN Income_edu_final_bez_duplikat t2
    ON t1.Edu_field = t2.Edu_field
    AND t1.Gender = t2.Gender
    AND t1.Education_level = t2.Education_level
    AND t1.Country = t2.Country
    AND t1.Industry_sector = t2.Industry_sector
  WHERE t1.Year = 2018 AND t2.Year = 2022
),
interpolace_5 AS (
  SELECT Edu_field, Gender, Education_level, Country, Industry_sector, 2019 AS Year,
    (Income_2022 - Income_2018) / 4.0 * 1 + Income_2018 AS Income
  FROM kombinace_5
  UNION ALL
  SELECT Edu_field, Gender, Education_level, Country, Industry_sector, 2020,
    (Income_2022 - Income_2018) / 4.0 * 2 + Income_2018
  FROM kombinace_5
  UNION ALL
  SELECT Edu_field, Gender, Education_level, Country, Industry_sector, 2021,
    (Income_2022 - Income_2018) / 4.0 * 3 + Income_2018
  FROM kombinace_5
),
k_vlozeni_5 AS (
  SELECT i.*
  FROM interpolace_5 i
  LEFT JOIN income_edu_final_kopie f
    ON f.Edu_field = i.Edu_field
    AND f.Gender = i.Gender
    AND f.Education_level = i.Education_level
    AND f.Country = i.Country
    AND f.Industry_sector = i.Industry_sector
    AND f.Year = i.Year
  WHERE f.Year IS NULL
)
INSERT INTO income_edu_final_kopie (Edu_field, Gender, Education_level, Country, Industry_sector, Year, Value_czk)
SELECT Edu_field, Gender, Education_level, Country, Industry_sector, Year, Income
FROM k_vlozeni_5;