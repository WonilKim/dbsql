select * from country order by Population;

select code, Continent, Population from country order by Population;
select code, Continent, Population from country order by Continent, Population;
select code, Continent, Population from country order by Population, Continent;

select code, name, Population from country order by Population DESC;
select code, name, Population from country order by Population asc;