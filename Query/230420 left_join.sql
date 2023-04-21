select * from s where status < 30;
select * from s where status > 20;

# 필드가 같은 두 테이블을 합칠때는 union이 좋다.
(select * from s where status < 30) union (select * from s where status > 20);

select sno, status from s where status < 30;
select sname, city from s where status > 20;

# 필드가 다른 두 테이블을 합치면 에러는 없지만 신뢰할 수 없는 결과가 나온다.
(select sno, sname from s where status < 30) union (select status, city from s where status > 20);

#
select * from s where status < 40;		# 1, 2, 3, 4, 5
select * from s where status > 20;		# 3, 5

select A.sno, A.sname, A.status, A.city		# 1, 2, 4
from (select * from s where status < 40) A
left join (select * from s where status > 20) B
on A.sno = B.sno 
where B.sno is null;

# left join 은 A 에 B 를 가져다 붙이는 것.
select A.sno, A.sname, A.status, A.city		# 1, 2, 4
from (select * from s where status < 40) A			# 1, 2, 3, 4, 5
left join (select * from s where status > 20) B		# 3, 5
on A.sno = B.sno 		# 3, 5
where B.sno is null;

# 합친 후 B에는 on 조건에 맞는 3과 5만 남고 나머지는 null 로 세팅된다.
select 
A.sno, A.sname, A.status, A.city,		
B.sno, B.sname, B.status, B.city
from (select * from s where status < 40) A			
left join (select * from s where status > 20) B		
on A.sno = B.sno 		# 3, 5
where B.sno is null;

# left join 으로 합치면 B에는 on 조건에 맞는 s3과 s5의 레코드만 남고 나머지는 null 로 세팅된다.
select 
A.sno, A.sname, A.status, A.city,		
B.sno, B.sname, B.status, B.city
from (select * from s where status < 40) A			# 1, 2, 3, 4, 5
left join (select * from s where status > 20) B		# 3, 5
on A.sno = B.sno;

# left join 으로 합치면 B에는 on 조건에 맞는 s3과 s5의 레코드만 남고 나머지는 null 로 세팅된다.
# where B.sno is null 절을 통해 B의 레코드가 null 인 라인들의 지정한 필드들 출력
select 
A.sno, A.sname, A.status, A.city,		
B.sno, B.sname, B.status, B.city
from (select * from s where status < 40) A			
left join (select * from s where status > 20) B		
on A.sno = B.sno 		# 3, 5
where B.sno is null;

# left join 으로 합치면 B에는 on 조건에 맞는 s3과 s5의 레코드만 남고 나머지는 null 로 세팅된다.
# where B.sno is null 절을 통해 B의 레코드가 null 인 라인들의 지정한 A의 필드들 출력
select A.sno, A.sname, A.status, A.city		# 1, 2, 4
from (select * from s where status < 40) A
left join (select * from s where status > 20) B
on A.sno = B.sno 
where B.sno is null;

