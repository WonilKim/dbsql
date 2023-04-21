#page 125 exercise
use warehouse;

select * from s; # 공급자 supplier
select * from p; # 부품 part
select * from j; # 프로젝트 project

# 1. 런던에 있는 프로젝트 이름을 찾아라
select * from j where city='London';
select jname from j where city='London';

# 2. 프로젝트 j1에 참여하는 공급자의 이름을 찾아라
select * from spj where jno='j1';
select sno from spj where jno='j1';

select sno, sname
from s
where sno in (select sno from spj where jno='j1');

select sno, sname, jno
from s join spj using(sno)
where jno='j1';

# 3. 공급 수량이 300 이상 750 이하인 모든 공급의 sno, pno, qty 를 찾아라.
select * from spj where 300 <= qty and qty <= 750;

# 4. 부품의 color 와 city 의 모든 쌍을 찾아라. 같은 쌍은 한번만 검색되어야 한다.
select distinct p1.color, p1.city 
from p as p1, p as p2;

# 5. 같은 도시에 있는 공급자, 부품, 프로젝트의 모든 sno, pno, jno 쌍을 찾아라. 
#	찾아진 sno, pno, jno 의 city 들은 모두 같아야 한다.
select sno, pno, jno, s.city, p.city, j.city
from s, p, j
where s.city = p.city and p.city = j.city;

# 6. 같은 도시에 있지 않은 공급자, 부품, 프로젝트의 모든 sno, pno, jno 쌍을 찾아라. 
#	찾아진 sno, pno, jno 의 city 들은 모두 같아야 한다.
set sql_safe_updates=0;
update p set city='Paris' where city='Pais';

select sno, pno, jno, s.city, p.city, j.city
from s, p, j
where s.city != p.city and p.city != j.city and j.city != s.city;

# 7. London에 있는 공급자에 의해 공급된 부품의 번호, 이름을 찾아라.
select sno
from s
where city='London';

select *
from spj
where spj.sno in (select sno from s where city='London');

select pno
from spj
where spj.sno in (select sno from s where city='London');

select pno, pname
from p
where pno in (
	select pno
	from spj
	where spj.sno in (select sno from s where city='London')
);

# 8. London 에 있는 공급자가 London 의 프로젝트에 공급한 부품의 부품 번호와 이름을 찾아라.
select *
from s, p, spj
where s.sno=spj.sno and p.pno = spj.pno
	and p.city='London' and s.city='London';

select p.pno, p.pname
from s, p, spj
where s.sno=spj.sno and p.pno = spj.pno
	and p.city='London' and s.city='London';

# 9. 한 도시에 있는 공급자가 다른 도시에 있는 프로젝트에 공급할 때 
#	공급자 도시, 프로젝트 도시 쌍을 모두 구하라.
set sql_safe_updates=0;
update j set city='Athens' where city='Athen';

select *
from s, j, spj
where s.sno=spj.sno and j.jno = spj.jno
	and s.city != j.city;
    
select distinct s.city, j.city
from s, j, spj
where s.sno=spj.sno and j.jno = spj.jno
	and s.city != j.city
    order by s.city, j.city;
    
# 10. 한 도시에 있는 공급자가 같은 도시에 있는 프로젝트에 공급하는 부품의 부품 번호와 이름을 찾아라.
select *
from s, j, p, spj
where s.sno=spj.sno and p.pno = spj.pno and j.jno = spj.jno
	and s.city = j.city;
    
select p.pno, p.pname, s.city, j.city
from s, j, p, spj
where s.sno=spj.sno and p.pno = spj.pno and j.jno = spj.jno
	and s.city = j.city;

# 11. 같은 도시에 있지 않은, 적어도 한 명 이상의 공급자들에 의해 공급되고 있는 프로젝트의 번호와 이름을 찾아라.
select *
from s, j, spj
where s.sno=spj.sno and j.jno = spj.jno
	and s.city != j.city
    order by j.jno;

select s.sno, j.jno, j.jname
from s, j, spj
where s.sno=spj.sno and j.jno = spj.jno
	and s.city != j.city
    order by j.jno;
    
select temp.jno, temp.jname, count(temp.sno)
from (
	select s.sno, j.jno, j.jname
	from s, j, spj
	where s.sno=spj.sno and j.jno = spj.jno
		and s.city != j.city
) as temp
group by jno
order by temp.jno;

# 12. 어떤 공급자가 2개 이상의 부품을 공급할 때 공급된 부품 sno의 리스트를 찾아라. 
#	부품이 1개 공급한 경우는 제외한다.
select *
from s, p, spj
where s.sno = spj.sno and p.pno = spj.pno;

select distinct s.sno, p.pno
from s, p, spj
where s.sno = spj.sno and p.pno = spj.pno
order by sno, pno;
    
select temp.sno, count(temp.pno)
from(
	select distinct s.sno, p.pno
	from s, p, spj
	where s.sno = spj.sno and p.pno = spj.pno
	order by sno, pno
) as temp
group by temp.sno;

select sno
from(
	select temp.sno, count(temp.pno) as part_cnt
	from(
		select distinct s.sno, p.pno
		from s, p, spj
		where s.sno = spj.sno and p.pno = spj.pno
		order by sno, pno
	) as temp
	group by temp.sno
	having part_cnt > 1
) as temp2;

select s.sno, p.pno
from s, p, spj
where s.sno = spj.sno and p.pno = spj.pno
	and s.sno in
	(
		select sno
		from(
			select temp.sno, count(temp.pno) as part_cnt
			from(
				select distinct s.sno, p.pno
				from s, p, spj
				where s.sno = spj.sno and p.pno = spj.pno
				order by sno, pno
			) as temp
			group by temp.sno
			having part_cnt > 1
		) as temp2
    )
order by s.sno;

# 13. 공급자 s1이 공급한 프로젝트 개수를 찾아라.
select *
from s, j, spj
where s.sno=spj.sno and j.jno = spj.jno
	and s.sno='s1';
    
select count(*)
from s, j, spj
where s.sno=spj.sno and j.jno = spj.jno
	and s.sno='s1';
    
# 14. 공급자 s1이 공급한 부품 p1 의 전체 수량을 찾아라.
select *
from s, p, spj
where s.sno=spj.sno and p.pno = spj.pno
order by s.sno;

select *
from s, p, spj
where s.sno=spj.sno and p.pno = spj.pno
	and s.sno='s1';
    
select *
from s, p, spj
where s.sno=spj.sno and p.pno = spj.pno
	and s.sno='s1' and p.pno='p1';
    
select sum(qty)
from s, p, spj
where s.sno=spj.sno and p.pno = spj.pno
	and s.sno='s1' and p.pno='p1';
    
# 15. 프로젝트에 공급된 각 부품에 대하여, 각 부품 번호, 공급된 프로젝트 번호, 각 프로젝트에 공급된 수량을 찾아라.
select *
from p, j, spj
where p.pno=spj.pno and j.jno = spj.jno
order by p.pno;

select p.pno, j.jno, spj.qty
from p, j, spj
where p.pno=spj.pno and j.jno = spj.jno
order by p.pno, j.jno, spj.qty;

select p.pno, j.jno, sum(spj.qty)
from p, j, spj
where p.pno=spj.pno and j.jno = spj.jno
group by p.pno, j.jno
order by p.pno, j.jno;

# 16. any 프로젝트에 공급된 부품의 수량 평균이 350 이상인 부품의 번호를 찾아라. 
#	부품이 여러 프로젝트 공급되는데 공급된 부품 수량의 평균(부품 수량을 프로젝트 개수로 나눈)이 350 이상 되는 것을 말한다.
select *
from j, spj
where j.jno=spj.jno
order by j.jno;

select j.jno, avg(qty)
from j, spj
where j.jno=spj.jno
group by j.jno
order by j.jno;

select j.jno, p.pno, spj.qty
from p, j, spj
where p.pno=spj.pno and j.jno = spj.jno
order by j.jno, p.pno;

select j.jno, p.pno, avg(spj.qty) as avg_qty
from p, j, spj
where p.pno=spj.pno and j.jno = spj.jno
group by j.jno, p.pno
having avg_qty >= 350
order by j.jno, p.pno;

# 17. 공급자 s1이 공급한 프로젝트 번호와 이름을 찾아라.
select *
from s, j, spj
where s.sno=spj.sno and j.jno = spj.jno
	and s.sno='s1'
order by s.sno;

select s.sno, j.jno, j.jname
from s, j, spj
where s.sno=spj.sno and j.jno = spj.jno
	and s.sno='s1'
order by s.sno;

# 18. 공급자 s1이 공급한 부품의 color 를 찾아라
select *
from s, p, spj
where s.sno=spj.sno and p.pno = spj.pno
	and s.sno='s1'
order by s.sno;

select s.sno, p.pno, p.color
from s, p, spj
where s.sno=spj.sno and p.pno = spj.pno
	and s.sno='s1'
order by s.sno;

select distinct s.sno, p.pno, p.color
from s, p, spj
where s.sno=spj.sno and p.pno = spj.pno
	and s.sno='s1'
order by s.sno;

# 19. London에 있는 프로젝트에 공급한 부품의 번호와 이름을 찾아라.
select *
from j, p, spj
where j.jno=spj.jno and p.pno = spj.pno
	and j.city='London'
order by j.jno;

select j.jno, p.pno, p.pname
from j, p, spj
where j.jno=spj.jno and p.pno = spj.pno
	and j.city='London'
order by j.jno, p.pno, p.pname;

# 20. 공급자 s1 이 공급한 anny 부품을 적어도 한 개 이상 사용하는 프로젝트의 번호와 이름을 찾아라
select *
from s, p, j, spj
where s.sno=spj.sno and j.jno=spj.jno and p.pno = spj.pno
	and s.sno='s1';

select j.jno, s.sno, p.pno
from s, p, j, spj
where s.sno=spj.sno and j.jno=spj.jno and p.pno = spj.pno
	and s.sno='s1';

select j.jno, count(p.pno) as part_cnt
from s, p, j, spj
where s.sno=spj.sno and j.jno=spj.jno and p.pno = spj.pno
	and s.sno='s1'
group by j.jno
having part_cnt >= 1;

select temp.jno
from(
	select j.jno, count(p.pno) as part_cnt
	from s, p, j, spj
	where s.sno=spj.sno and j.jno=spj.jno and p.pno = spj.pno
		and s.sno='s1'
	group by j.jno
	having part_cnt >= 1
) as temp;

select j.jno, s.sno, p.pno
from s, p, j, spj
where s.sno=spj.sno and j.jno=spj.jno and p.pno = spj.pno
	and s.sno='s1'
    and j.jno in (   
		select temp.jno
		from(
			select j.jno, count(p.pno) as part_cnt
			from s, p, j, spj
			where s.sno=spj.sno and j.jno=spj.jno and p.pno = spj.pno
				and s.sno='s1'
			group by j.jno
			having part_cnt >= 1
		) as temp
    );
