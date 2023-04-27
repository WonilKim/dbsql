#
use world;
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

select max(Percentage)
into @max
from(
	select c.Code, c.Name, cl.Language, cl.IsOfficial, Percentage
	from country as c, countrylanguage as cl
	where c.Code = cl.CountryCode and c.Name='United States'
) as country_data;
select @max;

# 프로시저 nationLanguage02 에서 출력 파라미터에 가장 높은 percentage 를 되돌려 주도록 수정하세요.
call nationLanguage03('United States', @percent);
select @percent;

call nationLanguage03_1('United States', @percent2);
select @percent2;

# nationLanguage03 을 function 형식으로 만드시오
