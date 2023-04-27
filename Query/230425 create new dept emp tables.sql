use warehouse;
drop table if exists emp;
drop table if exists dept;

drop table if exists emp_old;
drop table if exists dept_old;


RENAME TABLE dept TO dept_old;
RENAME TABLE emp TO emp_old;

create table dept (
	dno varchar(4) primary key, 
    dname varchar(20), 
    budget int
);

create table emp (
	eno varchar(4) primary key, 
    ename varchar(20),
    dno varchar(4),
    salary int,
    #foreign key(dno) references dept(dno) on delete restrict on update restrict
    #foreign key(dno) references dept(dno) on delete set null on update set null
    foreign key(dno) references dept(dno) on delete cascade on update cascade
);

insert into dept (dno, dname, budget) select * from dept_old;
insert into emp (eno, ename, dno, salary) select * from emp_old;

select * from dept;
select * from emp; 

### foreign key(dno) references dept(dno) on delete restrict on update restrict
DELETE FROM dept WHERE dno='d2';
# 에러 발생. Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`warehouse`.`emp`, CONSTRAINT `emp_ibfk_1` FOREIGN KEY (`dno`) REFERENCES `dept` (`dno`) ON DELETE RESTRICT ON UPDATE RESTRICT)

### foreign key(dno) references dept(dno) on delete set null on update set null
DELETE FROM dept WHERE dno='d2';
# dept 테이블의 d2 레코드가 삭제되고 emp 테이블의 d2를 참조 하고있던 column은 null 로 변함.

insert into dept (dno, dname, budget) values ('d2', 'Develop', 7000000);

### foreign key(dno) references dept(dno) on delete cascade on update cascade
DELETE FROM dept WHERE dno='d2';
# dept 테이블의 d2 레코드가 삭제되고 d2를 참조 하고 있던 emp 테이블의 모든 레코드도 삭제됨.
