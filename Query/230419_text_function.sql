SELECT Name, UPPER(LEFT(Name, 2)) AS Alias, LENGTH(Name) AS Len
FROM Country
LIMIT 10;		

SELECT Name, UPPER(LEFT(Name, 2)) AS Alias1, LOWER(RIGHT(Name, 3)) AS Alias2, LENGTH(Name) AS Len
FROM Country
LIMIT 10;

SELECT Name, UPPER(LEFT(Name, 2)) AS Alias1, LOWER(RIGHT(Name, 3)) AS Alias2, LENGTH(Name) AS Len
FROM Country
order by Len desc
LIMIT 10;

select '        testtest' as t;
select ltrim('        testtest') as t;
select 'testtest        ' as t;
select rtrim('testtest        ') as t;
select concat('testtest        ', '!') as t;
select concat(rtrim('testtest        '), '!') as t;