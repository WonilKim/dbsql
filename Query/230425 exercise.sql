use world;

select * from country;
select * from countrylanguage where CountryCode like '%KOR%';

select * from countrylanguage where CountryCode = 'KOR';

select * from country where Name like '%korea%';

### 한국에서 사용되는 언어를 검색해서 Language, IsOfficial, Percentage 를 출력해라.
# exist
select *
from country
where name = 'South Korea';

select Language, IsOfficial, Percentage
from countrylanguage
where exists(
	select *
	from country
	where name = 'South Korea'
		and country.Code = countrylanguage.CountryCode
);

# join
select c.Code, c.Name, cl.Language, cl.IsOfficial, Percentage
from country as c join countrylanguage as cl
on c.Code = cl.CountryCode and c.Code='KOR';

# where
select c.Code, c.Name, cl.Language, cl.IsOfficial, Percentage
from country as c, countrylanguage as cl
where c.Code = cl.CountryCode and c.Code='KOR';

# city 테이블에서 국가코드가 'KOR'인 도시의 수를 표시하세요.
select * from city where CountryCode = 'KOR';
select count(*) from city where CountryCode = 'KOR';

# city 테이블에서 국가코드가 'KOR'인 도시들의 인구수 총합을 구하세요.
select sum(Population) from city where CountryCode = 'KOR';

# city 테이블에서 국가코드가 'KOR'인 도시들의 인구수 중 최소값을 구하세요.
#	단 결과를 나타내는 테이블의 필드는 '최소값'으로 표시하세요
select min(Population) as min from city where CountryCode = 'KOR';

# city 테이블에서 국가코드가 'KOR'인 도시들의 인구수 평균을 구하세요.
select avg(Population) from city where CountryCode = 'KOR';

# city 테이블에서 국가별 도시의 수를 표시하세요.
select * from city;

select CountryCode, count(Name)
from city
group by CountryCode;

# city 테이블에서 국가별 도시의 수를 표시하고 국가명도 같이 표시하세요.
select * from city;

select CountryCode, country.Name, count(city.Name) as cnt
from city, country
where city.CountryCode = country.Code
group by CountryCode
order by CountryCode, country.Name;

# 도시의 수가 10개 이상인 국가에 대해서, city 테이블에서 국가별 도시의 수를 표시하고 국가명도 같이 표시하세요.
select * from city;

select CountryCode, country.Name, count(city.Name) as cnt
from city, country
where city.CountryCode = country.Code
group by CountryCode
having cnt >= 10
order by CountryCode, country.Name;