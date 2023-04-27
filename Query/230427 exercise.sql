use warehouse;

select * from joined_spj;

select sno, s_city, sum(qty) as sum_qty
from joined_spj
group by sno;

select sno, s_city, sum(qty) as sum_qty
from joined_spj
group by sno
having s_city = 'London';

select getGrade(100, 50, 75) as 'grade';
select getGrade(70, 50, 75) as 'grade';
select getGrade(40, 50, 75) as 'grade';

call getSupplierGrades('London', 700, 1000);

select sno, s_city, sum(qty) as sum_qty, getGrade(sum(qty), 50, 75) as grade
from joined_spj
group by sno
having s_city = 'London';

call getSupplierGrades('London', 700, 1000);