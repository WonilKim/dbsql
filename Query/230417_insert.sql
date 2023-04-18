insert into warehouse.p (pno, pname, color, weight, city) values ('p1', 'Nut', 'Red', 12.0, 'London');
insert into warehouse.p (pno, pname, color, weight, city) values ('p2', 'Bolt', 'Green', 17.0, 'Paris');
insert into warehouse.p (pno, pname, color, weight, city) values ('p3', 'Screw', 'Blue', 17.0, 'Oslo'),
 ('p4', 'Screw', 'Red', 14.0, 'London'),
 ('p5', 'Cam', 'Blue', 12.0, 'Pais'),
 ('p6', 'Cog', 'Red', 19.0, 'London');


#insert into j (jno, jname, city) values ('j2', 'Display', 'Rome'), ('j3', 'OCR', 'Athen'), ('j4', 'Console', 'Athen'), ('j5', 'RAID', 'London'), ('j6', 'EDS', 'Oslo'), ('j7', 'Tape', 'London'); 

insert into warehouse.spj (sno, pno, jno, qty) values 
('s1', 'p1', 'j1', 200),
('s1', 'p1', 'j4', 700),
('s2', 'p3', 'j1', 400),
('s2', 'p3', 'j2', 200),
('s2', 'p3', 'j3', 200),
('s2', 'p3', 'j4', 500),
('s2', 'p3', 'j5', 600),
('s2', 'p3', 'j6', 400),
('s2', 'p3', 'j7', 800),
('s2', 'p5', 'j2', 100),
('s3', 'p3', 'j1', 200),
('s3', 'p4', 'j2', 500),
('s4', 'p6', 'j3', 300),
('s4', 'p6', 'j7', 300),
('s5', 'p2', 'j2', 200),
('s5', 'p2', 'j4', 100),
('s5', 'p5', 'j5', 500),
('s5', 'p5', 'j7', 100),
('s5', 'p6', 'j2', 200),
('s5', 'p1', 'j4', 100),
('s5', 'p3', 'j4', 200),
('s5', 'p4', 'j4', 800),
('s5', 'p5', 'j4', 400),
('s5', 'p6', 'j4', 500);

insert into warehouse.dept (dno, dname, budget) values 
('d1', 'Marketing', 10000000), 
('d2', 'Dvelopment', 12000000), 
('d3', 'Research', 5000000);

insert into warehouse.emp (eno, ename, dno, salary) values 
('e1', 'Lopez', 'd1', 40000), 
('e2', 'Cheng', 'd1', 42000), 
('e3', 'Finzi', 'd2', 30000), 
('e4', 'Saito', 'd2', 35000); 

#use warehouse; #Schemas 에서 warehouse 테이블을 더블클릭해도 선택됨.
select * from warehouse.s;

show tables;