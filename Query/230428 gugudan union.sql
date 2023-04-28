select a.v, b.v
from(
	select 1 v union
	select 2 v union
	select 3 v union
	select 4 v union
	select 5 v union
	select 6 v union
	select 7 v union
	select 8 v union
    select 9 v) a
join
	(select 2 v) b;
    
select concat(a.v, ' x ', b.v, ' = ', a.v * b.v) as '2단'
from (select 2 v) as a
join	
    (
	select 1 v union
	select 2 v union
	select 3 v union
	select 4 v union
	select 5 v union
	select 6 v union
	select 7 v union
	select 8 v union
    select 9 v) b;
    
#
call gugudan4();