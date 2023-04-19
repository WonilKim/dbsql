use world;
select Continent, Name, Population, GNP from country 
where Continent like 'A%'; # A로 시작되는 모든 단어

select count(*) from country 
where Continent like 'A%';

select count(Continent, Name, Population, GNP) from country 
where Continent like 'A%';  # 에러, count() 의 인자는 하나.
#Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ', Name, Population, GNP) from country  where Continent like 'A%'' at line 1

select count((Continent, Name, Population, GNP)) from country 
where Continent like 'A%';  # 에러
#Error Code: 1241. Operand should contain 1 column(s)

select count(Continent) from country 
where Continent like 'A%'; # 컬럼을 1개만 사용하면 정상 실행됨.

select Continent, Name, Population, GNP from country 
where Continent like 'A___'; # A로 시작되는 4글자 단어 

select Continent, Name, Population, GNP from country 
where Name like 'A_g%'; # A로 시작하고 3번째 자리는 g 이며 이후의 글자수는 상관없는 단어.

select Continent, Name, Population, GNP from country 
where Name like '%k%';

select Continent, Name, Population, GNP from country 
where Name like '%k';

select Continent, Name, Population, GNP from country 
where Name like 'a%a';