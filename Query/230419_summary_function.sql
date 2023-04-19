use world;
SELECT *
FROM country
limit 10;

select avg(population), count(code), min(SurfaceArea), max(SurfaceArea), sum(population)
from country;

select avg(population), count(code), min(SurfaceArea), max(SurfaceArea), sum(population)
from country
where population > 10000000;