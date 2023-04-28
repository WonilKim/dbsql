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

# 230428
call getSupplierGradesCursor('London', 700, 1000);
call getSupplierGradesCursor('Paris', 700, 1000);

#
call gugudan();

select 1 as '1' union select 2 as '2';

call gugudan2();

call gugudan3();

select 21 div 10;
select 31 div 10;
select 39 div 10;

