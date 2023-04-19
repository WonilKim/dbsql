SELECT Continent, COUNT(*) AS nation_count
FROM country
GROUP BY Continent;

SELECT Continent, COUNT(*) AS nation_count, avg(population) AS avg_pop, sum(population) AS sum_pop
FROM country
GROUP BY Continent;

select * from country where Continent = 'Antarctica';

# GROUP BY 는 그룹화한 결과를 연산 (avg, sum, count 등의 요약 집계 연산)
# HAVING 은 GROUP BY 에 의해 연산된 값에 대해 연산.

# WHERE 는 그룹화 전에 필터링
# HAVING 은 그룹화 후에 필터링

SELECT Continent, COUNT(*) AS nation_count
FROM country
GROUP BY Continent
HAVING nation_count > 40;

SELECT Continent, 			# 4. (그룹별) 대륙 출력
Count(*) AS nation_count	# 5. 그룹별 카운트 출력
FROM country
WHERE Population>10000000	# 1. 인구수가 천만 이상인 나라를 찾아서
GROUP BY Continent			# 2. 대륙 별로 그룹화한 뒤에
HAVING nation_count >= 2;	# 3. 나라가 2개 이상이면

(SELECT max(Population) AS max_pop
FROM country
GROUP BY Continent);

