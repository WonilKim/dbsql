select * from dept;
select dname, bLevel(budget) from dept;

call getBudgetLevel('Develop', @lvl);
select @lvl;

insert into dept (dno, dname, budget) values ('d4', 'DB', 9000000); 

call findLevel();

show procedure status;
show function status;