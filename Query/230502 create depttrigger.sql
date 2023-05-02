create table `depttrigger` (
	`id` int not null auto_increment,
    `dno` varchar(4) default null,
    `dname` varchar(20) default null,
    `budget` int default null,
    `event` enum('insert', 'delete', 'update') default null,
    `eventdate` date default null,
    primary key (id)
);

# 트리거 insert
select * from dept;
insert into dept (dno, dname, budget) values ('d5', 'AI', 20000000);

select * from dept;
select * from depttrigger;

# 트리거 delete
delete from dept where dno = 'd5';
select * from dept;
select * from depttrigger;

# 트리거 update
insert into dept (dno, dname, budget) values ('d5', 'AI', 20000000);

update dept set dno = 'd6', dname = 'Backend', budget = 11000000 where dno = 'd5';
select * from dept;
select * from depttrigger;
