# 1. 무게가 10000그램 이상인 부품의 번호와 무게를 그램으로 찾아라(p 테이블의 weight 는 pound 단위이며 1파운드(lb)는 454 그램이다).
select * from p;

select pno, weight, (weight * 454) as gram from p
	where (weight * 454) > 10000;
    
# 2. 모든 공급자의 번호, 이름, status, 도시를 찾아서 5번째 column에 "공급자"를 tag 항목으로 출력하라.
select * from s;

select *, concat_ws(',', sno, sname, status, city) as tag from s;

# 3. 부품이 공급된 경우에 공급자 번호, 부품 번호, 부품 수량, 부품 무게(파운드)를 찾아라.
select * 
from p, j, spj
where p.pno = spj.pno and j.jno = spj.jno; 

select spj.sno, p.pno, spj.qty, p.weight 
from p, j, spj
where p.pno = spj.pno and j.jno = spj.jno; 

# 4. 각 부품에 대하여 부품 번호와 공급된 부품 수량의 합을 구하라.
select p.pno, spj.qty
from p, j, spj
where p.pno = spj.pno and j.jno = spj.jno;

select p.pno, sum(spj.qty) as sum
from p, j, spj
where p.pno = spj.pno and j.jno = spj.jno
group by p.pno
order by p.pno;

# 5. 모든 부품의 총공급 수량의 합을 구하라.
select sum(qty) from spj;

# 6. 각 공급자에 대하여 공급자 번호와 공급된 부품의 개수를 찾아라.
select distinct sno, pno from spj;

select sno, count(pno) 
from (select distinct sno, pno from spj) as temp
group by sno;

# 7. red 부품을 5개 이상 저장한 부품의 도시를 찾아라.
select * from p;

# 문제 이해 안감.
