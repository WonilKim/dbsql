# 부품의 color 와 city의 모든 쌍을 찾아라. 같은 상은 한번만 검색되어야 한다.
select * from p;

select distinct color, city from p;

select *
from s, p, j, spj
where s.sno = spj.sno
	and p.pno = spj.pno
    and j.jno = spj.jno;
    
select *
from s
natural join spj;
    
select *
from s
natural join p;

select *
from spj
natural join s
natural join p
natural join j;

select *
from spj
join s using(sno)
join p using(pno)
join j using(jno);

# 필드 이름 중복 제거
select jno, pno, sno, qty, sname, status, s.city as s_city, 
	pname, color, weight, p.city as p_city,
    jname, j.city as j_city 
from spj
join s using(sno)
join p using(pno)
join j using(jno);

select count(*) 
from spj
join s using(sno)
join p using(pno)
join j using(jno);

#
select * from s;
insert into s (sno, sname, status, city) values ('s6', 'Wonil', 40, 'Busan');

