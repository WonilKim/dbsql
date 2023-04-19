use sampledb;

select * from orderitems;

# 1. ‘RGAN01’ 제품을 포함하는 모든 주문의 주문 번호를 얻는다.
select * from orderitems where prod_id='RGAN01';
select order_num from orderitems where prod_id='RGAN01';

# 2. 얻어진 주문 번호를 기반으로 각 주문을 한 고객의 고객ID를 얻는다
select * from orders;
SELECT cust_id
FROM orders
WHERE order_num IN (20007,20008);

# 3. 얻어진 고객ID를 기반으로 고객의 정보를 얻는다.
SELECT cust_name, cust_contact
FROM customers
WHERE cust_id IN ('1000000004', '1000000005');

# 위의 1, 2, 3 을 SubQuery 로 합치기
SELECT cust_name, cust_contact
FROM customers
WHERE cust_id IN (
	SELECT cust_id
	FROM orders
	WHERE order_num IN (
		select order_num 
        from orderitems 
        where prod_id='RGAN01'
	)
);

# Customers 테이블에서 고객 목록을 가져온다.

select * from customers;


# 가져온 고객을 기준으로 각 고객이 주문한 주문 수를 Orders 테이블에서 센다
select * from orders;
select cust_id, count(order_num)
from orders
group by cust_id;


# 강의 자료 답
SELECT cust_name, 
cust_state, 
(SELECT count(*)
 FROM orders							   
 WHERE orders.cust_id=customers.cust_id
 ) AS orders
FROM Customers
ORDER BY cust_name;