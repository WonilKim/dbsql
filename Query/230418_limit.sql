select count(*) from city;
select * from city limit 10;
select * from city order by id desc limit 10;

select * from city limit 10;
select * from city limit 0, 10; # 0번 인덱스 부터 10개
select * from city limit 10, 10; # 10번 인덱스 부터 10개

