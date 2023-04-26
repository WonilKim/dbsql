use world;
### 'South Korea'에서 사용되는 언어를 검색해서 Language, IsOfficial, Percentage 를 출력해라.
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

# where
select c.Code, c.Name, cl.Language, cl.IsOfficial, Percentage
from country as c, countrylanguage as cl
where c.Code = cl.CountryCode and c.Name='South Korea';

#
call nationLanguage01();

select * from country;
call nationLanguage02('United States');

call nationLanguage02_1('United States');

#
# where
select c.Code, c.Name, cl.Language, cl.IsOfficial, Percentage
from country as c, countrylanguage as cl
where c.Code = cl.CountryCode and c.Name='South Korea';

select max(Percentage)
from(
	select c.Code, c.Name, cl.Language, cl.IsOfficial, Percentage
	from country as c, countrylanguage as cl
	where c.Code = cl.CountryCode and c.Name='South Korea'
) as country_data;

call nationLanguage03('United States', percent);
select percent;