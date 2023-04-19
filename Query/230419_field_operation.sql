SELECT CONCAT(NAME, '(', Continent, ')', Population)
FROM Country
ORDER BY Name;

SELECT CONCAT(NAME, '(', Continent, ')', Population) as concat_result
FROM Country
ORDER BY Name;

SELECT CONCAT(NAME, '(', Continent, ')', Population, '-', GNP) as concat_result
FROM Country
ORDER BY Name;

SELECT Name, CONCAT(NAME, '(', Continent, ')', Population, '-', GNP) as concat_result
FROM Country
ORDER BY Name;

#
SELECT Continent, Name, (Population/SurfaceArea) AS pd
FROM Country
ORDER BY pd DESC, SurfaceArea DESC;

SELECT Continent, Name, Population, SurfaceArea, (Population/SurfaceArea) AS pd
FROM Country
ORDER BY pd DESC, SurfaceArea DESC;

SELECT Continent, Name, Population, SurfaceArea, pd
FROM 
	(SELECT Continent, Name, Population, SurfaceArea, (Population/SurfaceArea) AS pd
	FROM Country
	where SurfaceArea > 20000) as new_table
where pd > 500
ORDER BY pd DESC, SurfaceArea DESC;