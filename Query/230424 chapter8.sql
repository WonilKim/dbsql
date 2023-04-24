create table tt (
	id int auto_increment primary key,
    name varchar(20) not null default '',
    content varchar(20) default 'content'
);

# insert into tt(...) values(...);
insert into tt(id, name, content) values(1, '이름', 'Content');
select * from tt;

insert into tt(name, content) values('이름2', 'Content2');
select * from tt;

insert into tt(id, name, content) values(100, '이름100', 'Content100');
select * from tt;

insert into tt(id, name, content) values(10, '이름10', 'Content10');
select * from tt;

insert into tt(name, content) values('이름3', 'Content3');
select * from tt;

select last_insert_id();

insert into tt(name, content) values('이름6', 'Content6'), ('Lee2', 'BD2'), ('Park2', 'SE2'), ('Moon2', 'DB2');
select * from tt;

select last_insert_id();