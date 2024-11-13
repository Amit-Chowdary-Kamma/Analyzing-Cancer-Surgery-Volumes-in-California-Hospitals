CREATE DATABASE IF NOT EXISTS akamma_ait_project;
USE akamma_ait_project;




#query1 # Answers research question 4
SELECT hospital, Surgery, SUM(`number_of_cases`) AS TotalCases
FROM cancervolume1
GROUP BY hospital, Surgery
ORDER BY hospital, TotalCases DESC;


#query2
SELECT County, 
       SUM(CASE WHEN Year = 2013 THEN number_of_cases ELSE 0 END) AS Cases_2013,
       SUM(CASE WHEN Year = 2021 THEN number_of_cases ELSE 0 END) AS Cases_2021,
       SUM(CASE WHEN Year = 2021 THEN number_of_cases ELSE 0 END) - 
       SUM(CASE WHEN Year = 2013 THEN number_of_cases ELSE 0 END) AS SurgeryIncrease
FROM cancervolume1
GROUP BY County
ORDER BY SurgeryIncrease DESC
LIMIT 10;


#query3
SELECT t1.County, t1.hospital, t1.TotalSurgeries
FROM (
    SELECT County, hospital, SUM(number_of_cases) AS TotalSurgeries,
           ROW_NUMBER() OVER(PARTITION BY County ORDER BY SUM(number_of_cases) DESC) AS hospital_rank
    FROM cancervolume1
    GROUP BY County, hospital
) AS t1
WHERE t1.hospital_rank = 1;



