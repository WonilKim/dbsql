
SELECT Cust_State, cust_name, cust_contact, cust_email
FROM Customers
WHERE Cust_State IN ('IL', 'IN', 'MI');

# 데이터 1
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE Cust_State IN ('IL', 'IN', 'MI');

# 데이터 2
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_name='Fun4All';

# 데이터 1, 2 union
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE Cust_State IN ('IL', 'IN', 'MI')
UNION
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_name='Fun4All';

# 같은 내용
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_State IN ('IL', 'IN', 'MI')
      OR cust_name='Fun4All';
      
# UNION ALL 은 중복을 제거하지 않음
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_State IN ('IL', 'IN', 'MI')
UNION ALL
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_name='Fun4All';

# 정렬
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_State IN ('IL', 'IN', 'MI')
UNION ALL
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_name='Fun4All'
ORDER BY cust_name, cust_contact;
