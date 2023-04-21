use sampledb;

SELECT vend_name, prod_name, prod_price
FROM Vendors, Products
WHERE Vendors.vend_id = Products.vend_id;

#
SELECT * from Vendors;
SELECT * from Products;

SELECT Vendors.vend_id, vend_name, prod_name, prod_price
FROM Vendors, Products
WHERE Vendors.vend_id = Products.vend_id;

# 위 내용을 join 으로 바꾸면
SELECT Vendors.vend_id, vend_name, prod_name, prod_price
FROM Vendors join Products
on Vendors.vend_id = Products.vend_id;

# natural join
# 위 두개의 결과와 비슷하다
# 두 테이블이 공통으로 갖고 있는 필드를 사용해 자동으로 합친다.
# 결과에는 중복된 필드가 나타나지 않음
SELECT vend_name, prod_name, prod_price
FROM Vendors NATURAL JOIN Products;

SELECT *
FROM Vendors, Products
where Vendors.vend_id = Products.vend_id;	# vend_id 중복

SELECT *
FROM Vendors natural join Products;			# vend_id 중복 되지 않음

# join 은 무조건 = 으로 조건을 걸어야 한다.
# 다른 조건은 and 로 추가.
SELECT *
FROM Vendors, Products
where Vendors.vend_id = Products.vend_id
	and vend_state = 'CA';

# join = inner join, inner 가 생략됨
# left join = left outer join
# 기본 join 은 default 가 inner join 이다. (교집합) 
SELECT vend_name, prod_name, prod_price
FROM Vendors INNER JOIN Products
ON Vendors.vend_id = Products.vend_id;

#
SELECT vend_name, prod_name, prod_price
FROM Vendors JOIN Products 
USING (vend_id);		# ON Vendors.vend_id = Products.vend_id; 와 같다


# Cross join : where 절이 없는 join
SELECT vend_name, prod_name, prod_price
FROM Vendors, Products;
# 아래와 같은 테이블이 있을때
# A		B
# ano	bno		ano
# a1	b1		a1
# a2	b2		a1
#
# Cross join 은 A와 B의 모든 데이터를 교차해서 만들어 준다.
# a1	b1
# a1	b2
# a2	b1
# a2	b2


# Inner join : where 절이 있는 join
SELECT vend_name, prod_name, prod_price
FROM Vendors, Products
WHERE Vendors.vend_id = Products.vend_id;

#
SELECT Vendors.vend_id as v_vend_id, vend_name, prod_name, prod_price, Products.vend_id as p_vend_id
FROM Vendors, Products
WHERE Vendors.vend_id = Products.vend_id;	# v_vend_id 와 p_vend_id 가 같다.

SELECT Vendors.vend_id as v_vend_id, vend_name, prod_name, prod_price, Products.vend_id as p_vend_id
FROM Vendors, Products;				# 모든 v_vend_id 가 한가지의 p_vend_id 포함된다.

   
select * from OrderItems where order_num=20007;
select * from Products;
select * from Vendors;

# 주문 번호가 20007 인 모든 정보를 조회
SELECT prod_name, vend_name, prod_price, quantity
FROM OrderItems, Products, Vendors
WHERE Products.vend_id=Vendors.vend_id
   AND OrderItems.prod_id=Products.prod_id
   AND order_num=20007;

# quantity, prod_price 정렬
SELECT prod_name, vend_name, prod_price, quantity
FROM OrderItems, Products, Vendors
WHERE Products.vend_id=Vendors.vend_id
   AND OrderItems.prod_id=Products.prod_id
   AND order_num=20007
   order by quantity, prod_price;

# quantity, prod_name 정렬
SELECT prod_name, vend_name, prod_price, quantity
FROM OrderItems, Products, Vendors
WHERE Products.vend_id=Vendors.vend_id
   AND OrderItems.prod_id=Products.prod_id
   AND order_num=20007
   order by quantity, prod_name;

#
select vend_name, sum(prod_price * quantity) as total_price, sum(quantity) as total_quantity
from (
	SELECT prod_name, vend_name, prod_price, quantity
	FROM OrderItems, Products, Vendors
	WHERE Products.vend_id=Vendors.vend_id
	   AND OrderItems.prod_id=Products.prod_id
	   AND order_num=20007
   ) as temp
group by vend_name;

#
SELECT prod_name, vend_name, prod_price, quantity
	FROM OrderItems, Products, Vendors
	WHERE Products.vend_id=Vendors.vend_id
	   AND OrderItems.prod_id=Products.prod_id;
       
select vend_name, sum(prod_price * quantity), sum(quantity)
from (
	SELECT prod_name, vend_name, prod_price, quantity
	FROM OrderItems, Products, Vendors
	WHERE Products.vend_id=Vendors.vend_id
	   AND OrderItems.prod_id=Products.prod_id
   ) as temp
group by vend_name;

# 순차적으로 풀어 나가는 방법
SELECT prod_id, quantity, item_price
FROM orderitems
WHERE order_num = 20007;

SELECT products.prod_id, orderitems.quantity, orderitems.item_price
FROM orderitems, products
WHERE products.prod_id=orderitems.prod_id
   AND order_num=20007;

SELECT Vendors.vend_name, products.prod_id,
           orderitems.quantity, orderitems.item_price
FROM orderitems, products, Vendors
WHERE products.vend_id=Vendors.vend_id
    AND products.prod_id=orderitems.prod_id
    AND order_num=20007;

# 순차적으로 풀어 나가는 방법
SELECT order_num, prod_id, quantity, item_price
FROM orderitems
WHERE order_num = 20007;

SELECT *
FROM orderitems, products
WHERE products.prod_id=orderitems.prod_id;

SELECT order_num, products.prod_id, orderitems.quantity, orderitems.item_price
FROM orderitems, products
WHERE products.prod_id=orderitems.prod_id;
   
SELECT order_num, products.prod_id, orderitems.quantity, orderitems.item_price
FROM orderitems, products
WHERE products.prod_id=orderitems.prod_id
   AND order_num=20007;

SELECT order_num, Vendors.vend_name, products.prod_id,
           orderitems.quantity, orderitems.item_price
FROM orderitems, products, Vendors
WHERE products.vend_id=Vendors.vend_id
    AND products.prod_id=orderitems.prod_id
    AND order_num=20007;
    
# 아래 3가지 쿼리는 같은 결과
# 중첩 쿼리
SELECT cust_name, cust_contact	# 3. 가져온 cust_id 들을 값으로 갖고 있는 customers 테이블 레코드들의 cust_name 과 cust_contact 가져오기
FROM customers
WHERE cust_id IN (SELECT cust_id	# 2. 가져온 order_num 들을 값으로 갖고 있는 orders 테이블 레코드들의 cust_id 가져오기
                          FROM orders
                          WHERE order_num IN (SELECT order_num	# 1. orderitems 테이블에서 prod_id='RGAN01' 인 order_num 들을 가져오기
                                                         FROM orderitems
                                                         WHERE prod_id='RGAN01'));
# where 
SELECT cust_name, cust_contact
FROM Customers, Orders, OrderItems
WHERE Customers.cust_id=Orders.cust_id
   AND OrderItems.order_num=Orders.order_num
   AND prod_id='RGAN01';

# join using
SELECT cust_name, cust_contact
FROM Customers
JOIN Orders USING (cust_id)
JOIN OrderItems USING (order_num)
WHERE prod_id='RGAN01';

# join on
SELECT cust_name, cust_contact
FROM Customers
JOIN Orders on Customers.cust_id=Orders.cust_id
JOIN OrderItems on OrderItems.order_num=Orders.order_num
WHERE prod_id='RGAN01';

# 실습
# 월별 주문량을 검색해서 년,월 순으로 정렬해서 보이시오

select * from orders;
select * from orderitems;
select * from orders join orderitems using (order_num);
select *, year(order_date), month(order_date) 
from orders join orderitems using (order_num); 

select y, m, sum(quantity)
from (
	select *, year(order_date) as y, month(order_date) as m
	from orders join orderitems using (order_num)
) as temp
group by y, m;

select y, m, sum(quantity) as total_quantity
from (
	select *, year(order_date) as y, month(order_date) as m
	from orders join orderitems using (order_num)
) as temp
group by y, m
order by y, m;

#
SELECT year, mon, count(*)
FROM (SELECT YEAR(order_date) AS year, MONTH(order_date) AS mon
	FROM orders
	GROUP BY year, mon
	ORDER BY year, mon) AS YM, orders
WHERE YM.year=YEAR(orders.order_date) and YM.mon=MONTH(orders.order_date)
GROUP BY year, mon
ORDER BY year, mon;

#
SELECT YEAR(order_date) AS year, MONTH(order_date) AS mon, count(*)
FROM orders
GROUP BY year, mon
ORDER BY year, mon;

# 실습
# 고객별 월별 주문량을 검색해서 고객명, 년,월 순으로 오름차순으로 정렬해서 보이시오
select * from orders;
select * from orderitems;
select * from orders join orderitems using (order_num);
select * from orders join orderitems using (order_num) join customers using (cust_id);

select * 
from orders 
join orderitems using (order_num) 
join customers using (cust_id);

select cust_id, cust_name, y, m, sum(quantity) as total_quantity
from (
	select *, year(order_date) as y, month(order_date) as m 
	from orders 
	join orderitems using (order_num) 
	join customers using (cust_id)
) as temp
group by cust_id, y, m
order by cust_name, y, m;

#
SELECT cust_name, YEAR(order_date) AS year, MONTH(order_date) AS mon, count(*)
FROM orders, customers
WHERE orders.cust_id = customers.cust_id
GROUP BY orders.cust_id, year, mon
ORDER BY orders.cust_id, year, mon;
