# 1.
select sno, status from s where status > 20 and city='Paris';

# 2. 같은 도시에 있는 공급자들의 번호 쌍을 찾아라.
select * from s;

select *
from s as s1, s as s2
where s1.city = s2.city;

select s1.sno, s2.sno, s1.sname, s2.sname, s1.city
from s as s1, s as s2
where s1.city = s2.city and s1.sname != s2.sname;

# 3. 부품 p2를 공급하는 공급자의 번호, 이름, status, 도시를 찾아라
select * from s;

select * 
from s, p, spj
where s.sno = spj.sno and p.pno = spj.pno;

select distinct s.sno, s.sname, s.status, s.city 
from s, p, spj
where s.sno = spj.sno and p.pno = spj.pno and p.pno='p2';

# 4. 적어도 한 개 이상의 red 부품을 공급하는 공급자의 이름을 찾아라
select * 
from s, p, spj
where s.sno = spj.sno and p.pno = spj.pno and color='red';

select distinct s.sname
from s, p, spj
where s.sno = spj.sno and p.pno = spj.pno and color='red';

# 5. 공급자 s2에 의해 공급된 부품을 적어도 한 개 이상 공급하는 공급자의 이름을 찾아라.
select * 
from s, p, spj
where s.sno = spj.sno and p.pno = spj.pno and s.sno='s2';

select distinct p.pno
from s, p, spj
where s.sno = spj.sno and p.pno = spj.pno and s.sno='s2';

select distinct s.sno, s.sname 
from s, p, spj
where s.sno = spj.sno and p.pno = spj.pno 
	and p.pno in (
		select distinct p.pno
		from s, p, spj
		where s.sno = spj.sno and p.pno = spj.pno and s.sno='s2'
	);
    
# 6. 모든 부품을 공급하는 공급자의 이름을 찾아라.
select *
from s, p, spj
where s.sno = spj.sno and p.pno = spj.pno;

select distinct pno from p;
select count(pno) from (select distinct pno from p) as temp;

select distinct s.sno, p.pno
from s, p, spj
where s.sno = spj.sno and p.pno = spj.pno
order by sno, pno;

select temp.sno, count(temp.pno) as cnt
from (
	select distinct s.sno, p.pno
	from s, p, spj
	where s.sno = spj.sno and p.pno = spj.pno
	order by sno, pno
) as temp
group by temp.sno
having cnt = (select count(pno) from (select distinct pno from p) as temp)
order by temp.sno;

# 7. 부품 p2를 공급하지 않는 공급자의 이름을 찾아라.
select distinct p.pno, s.sno 
from s, p, spj
where s.sno = spj.sno and p.pno = spj.pno and p.pno = 'p2'; # p2를 공급하는 사람.

select distinct sno
from s
where sno not in (
	select distinct s.sno 
	from s, p, spj
	where s.sno = spj.sno and p.pno = spj.pno and p.pno = 'p2'
)
order by sno;

# 8. 공급자 s2 에 의해 공급되는 부품을 적어도 모두 공급하는 공급자의 번호를 찾아라.
select distinct p.pno
from s, p, spj
where s.sno = spj.sno and p.pno = spj.pno and s.sno='s2';

select count(temp.pno)
from (
	select distinct p.pno
	from s, p, spj
	where s.sno = spj.sno and p.pno = spj.pno and s.sno='s2'
) as temp;

select distinct s.sno, p.pno 
from s, p, spj
where s.sno = spj.sno and p.pno = spj.pno
	and p.pno in (
		select distinct p.pno
		from s, p, spj
		where s.sno = spj.sno and p.pno = spj.pno and s.sno='s2'
    );

select temp.sno, count(temp.pno) as cnt
from (
	select distinct s.sno, p.pno 
	from s, p, spj
	where s.sno = spj.sno and p.pno = spj.pno
		and p.pno in (	# s2 가 공급하는 부품들을 포함하고 있는
			select distinct p.pno	# s2 가 공급하는 부품들
			from s, p, spj
			where s.sno = spj.sno and p.pno = spj.pno and s.sno='s2'
		)
) as temp
group by temp.sno
having cnt >= (	# s2 가 공급하는 부품들의 개수 이상의 cnt 를 갖는 
	select count(temp.pno)	# s2 가 공급하는 부품들의 개수
	from (
		select distinct p.pno	# s2 가 공급하는 부품들
		from s, p, spj
		where s.sno = spj.sno and p.pno = spj.pno and s.sno='s2'
	) as temp
);

# 9. 공급자 s2가 공급하거나 부품의 무게가 26 pound 이상인 부품의 번호를 찾아라.
select *
from s, p, spj
where s.sno = spj.sno and p.pno = spj.pno;

select *
from s, p, spj
where s.sno = spj.sno and p.pno = spj.pno and (s.sno='s2' or p.weight>=26);