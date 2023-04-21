use sampledb;

# self join
# ‘Jim Jones’가 일하는 회사의 모든 고객 담당자에게 메일을 보낸다
SELECT cust_id, cust_name, cust_contact
FROM Customers
WHERE cust_name=(SELECT cust_name
                           FROM Customers
                           WHERE cust_contact='Jim Jones');

SELECT c1.cust_id, c1.cust_name, c1.cust_contact
FROM Customers AS c1, Customers AS c2
WHERE c1.cust_name=c2.cust_name
    AND c2.cust_contact='Jim Jones';

#
SELECT cust_id, cust_name, cust_contact
FROM Customers;

SELECT c1.cust_id, c1.cust_name, c1.cust_contact
FROM Customers AS c1, Customers AS c2
WHERE c1.cust_name=c2.cust_name;

# 모든 고객과 그 고객의 주문 목록을 조회한다.
SELECT Customers.cust_id, Orders.order_num
FROM Customers, Orders
WHERE Customers.cust_id=Orders.cust_id;

SELECT Customers.cust_id, Orders.order_num
FROM Customers
LEFT OUTER JOIN Orders
ON Customers.cust_id=Orders.cust_id;

# right join
SELECT Customers.cust_id, Orders.order_num
FROM Customers, Orders
WHERE Customers.cust_id=Orders.cust_id;

SELECT Customers.cust_id, Orders.order_num
FROM Customers
RIGHT OUTER JOIN Orders
ON Customers.cust_id=Orders.cust_id;
