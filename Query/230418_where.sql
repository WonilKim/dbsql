select Continent, Name, Population from country where Population > 100000000;
select Continent, Name, Population from country where Population > 100000000 order by Population desc;
select Continent, Name, Population from country where Population <> 0;
select Continent, Name, Population from country where Population <> 0 order by Population;
select Continent, Name, Population from country where Population <> 0 order by Population desc;
select Continent, Name, Population from country where Population between 0 and 10000;
select Continent, Name, Population from country 
where Population between 0 and 20000 order by Population desc;
select Name, Capital, Population from country where Capital is null;
select Continent, Name, Population, GNP from country 
where Population > 10000000 and GNP < 100000;
select Continent, Name, Population, GNP from country 
where Population > 10000000 and GNP < 100000 order by GNP desc;
select Continent, Name, Population, GNP from country 
where Population > 10000000 and GNP < 100000 order by GNP desc, Continent asc;
select Continent, Name, Population, GNP, GNPOld from country 
where Population > 10000000 or GNP < 100000 and GNPOld is null; #우선순위 and > or
select Continent, Name, Population, GNP, GNPOld from country 
where (Population > 10000000) or (GNP < 100000 and GNPOld is null); #괄호를 쓰는것이 더 확실하다.
select Continent, Name, Population, GNP, GNPOld from country 
where (Population > 10000000 or GNP < 100000) and GNPOld is null;

select Continent, Name, Population, GNP from country where Code in ('KOR', 'CHN', 'JPN'); 
select Continent, Name, Population, GNP from country where Code in ('kor', 'chn', 'jpn'); 
select Continent, Name, Population, GNP from country 
where Code ='KOR' or Code = 'CHN' or Code = 'JPN'; 

select Continent, Name, Population from country 
where Continent = 'Asia' order by Population desc;
select Continent, Name, Population, GNP from country 
where Continent = 'Asia' and GNP > 100000 order by GNP desc;

select Continent, Name, Population, GNP from country 
where not Continent in ('Asia', 'Europe', 'Africa') order by Name; 
select Continent, Name, Population, GNP from country 
where Continent !='Asia' and Continent != 'Europe' and Continent != 'Africa' order by Name; 

