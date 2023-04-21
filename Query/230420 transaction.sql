select * from emp;

start transaction;

delete from emp where eno='e3';
select * from emp;

rollback;

select * from emp;

# mysql 은 auto commit 설정되어 있다.
# 상단 menu의 Query - Auto-Commit Transactions 체크 상태.
# rollbak 과 commit 은 항상 같이 따라다닌다.
