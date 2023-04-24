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
    
# 21. 적어도 한 개 이상의 red 부품을 공급하는 적어도 한 명 이상의 공급자들이 공급하는 
#	적어도 한개 이상의 부품을 공급하는 공급자의 번호와 이름을 찾아라
select *
from s, p, spj
where s.sno=spj.sno and p.pno = spj.pno;

# 문제가 무슨 말인지 모르겠음.

# 22. 공급자 s1의 status 값보다 더 낮은 status 를 갖는 공급자의 번호와 이름을 찾아라
select * from s;

select status from s where sno='s1';

select sno, sname, status from s where status < (select status from s where sno='s1');

# 23. 프로젝트의 city 목록에서 알파벳 순서에서 첫번째 도시의 프로젝트 번호와 이름을 찾아라
select * from j order by city;

select * from j order by city limit 1;

# 24. 부품 p1의 프로젝트 공급 수량의 평균이 프로젝트 j1에 공급된 any 부품의 최대 수량보다 더 큰 프로젝트의 번호와 이름을 찾아라.
#	부품 p1은 공급자 s1, s2, ..., sn 에 의하여 각프로젝트에 공급될 때 각 공급자의 공급 수량의 평균을 구한다.
select *
from s, p, j, spj
where s.sno=spj.sno and j.jno=spj.jno and p.pno = spj.pno;

select j.jno, p.pno
from s, p, j, spj
where s.sno=spj.sno and j.jno=spj.jno and p.pno = spj.pno and p.pno='p1';

select j.jno, p.pno
from s, p, j, spj
where s.sno=spj.sno and j.jno=spj.jno and p.pno = spj.pno and j.jno='j1';

# 질문 이해 안됨


# 25. 부품 p1을 어던 프로젝트에 공급하는 수량이 그 프로젝트를 위한 부품 p1의 평균 공급 수량
#	(평균 공급 수량은 각 공급자가 공급하는 수량의 평균이다)보다 더 큰 공급자의 번호와 이름을 찾아라. 

# 질문 이해 안됨

# 26. London 에 있는 공급자에 의해 어떠한 red 부품도 공급받지 않는 프로젝트의 번호와 이름을 찾아라.
select s.sno, s.city, p.color, j.jno
from s, p, j, spj
where s.sno=spj.sno and j.jno=spj.jno and p.pno = spj.pno and s.city='London';

select *
from j
where j.jno not in (
	select j.jno
	from s, p, j, spj
	where s.sno=spj.sno and j.jno=spj.jno and p.pno = spj.pno and s.city='London'
);

# 27. 공급자 s1에 의해서만 부품을 공급받는 프로젝트의 번호와 이름을 찾아라.
select s.sno, s.city, p.color, j.jno
from s, p, j, spj
where s.sno=spj.sno and j.jno=spj.jno and p.pno = spj.pno and s.sno='s1';

select j.jno, s.sno
from s, p, j, spj
where s.sno=spj.sno and j.jno=spj.jno and p.pno = spj.pno
order by j.jno;

select j.jno, count(s.sno) as cnt
from s, p, j, spj
where s.sno=spj.sno and j.jno=spj.jno and p.pno = spj.pno
group by j.jno;

select j.jno, count(s.sno) as cnt # sno 가 1개인 프로젝트 출력
from s, p, j, spj
where s.sno=spj.sno and j.jno=spj.jno and p.pno = spj.pno
group by j.jno
having cnt = 1;


# 28. London 에 있는 모든 프로젝트에 공급되는 부품의 번호와 이름을 찾아라

# 29. 모든 프로젝트에 같은 부품들을 공급하는 공급자의 번호와 이름을 찾아라.

# 30. 공급자 s1이 공급하는 모든 부품을 적어도 그 이상 공급받는 프로젝트의 번호와 이름을 찾아라.

# 31. 적어도 한 공급자가 있는 city 이거나, 적어도 한 부품의 city 이거나, 
#	적어도 한 프로젝트의 city 인 모든 city 이름을 찾아라.

# 32. London 에 있는 공급자에 의해서 공급되거나 London 에 있는 프로젝트에 공급된 부품의 번호와 이름을 찾아라.

# 33. 어떤 부품을 공급하지 않는 공급자 또는 어떤 고급자에 의해서도 공급되지 않는 부품의 공급자 번호, 부품 번호 쌍을 찾아라.

# 34. 같은 종류의 부품들을 공급하는 고급자 쌍을 공급자 번호의 쌍으로 찾아라.
