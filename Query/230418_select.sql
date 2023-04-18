use world;
select * from city limit 10;
select name from country;
select Continent from country;
select Region from country;
select SurfaceArea from country;
select IndepYear from country;
select Population from country;
select LifeExpectancy from country;
select GNP from country;
select GNPOld from country;
select LocalName from country;
select GovernmentForm from country;
select HeadOfState from country;
select Capital from country;
select Code2 from country;

select code, name from country;
select * from country where name = 'South Korea';

select * from countrylanguage limit 10;
select * from countrylanguage where countrycode = 'KOR';