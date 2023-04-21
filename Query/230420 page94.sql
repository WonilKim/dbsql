use warehouse;
select * from emp;
select * from dept;

select * from dept where budget > 8;

select dno, budget from dept;

select emp.dno, dname, budget, eno, ename, salary 
from dept, emp 		# from 절에 테이블이 2개 이상이면 join.
where dept.dno = emp.dno;
