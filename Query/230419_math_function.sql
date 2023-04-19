USE sakila;
SELECT CONCAT(FIRST_NAME, " ", last_name) as name, last_update as ymd
FROM actor
WHERE YEAR(last_update)=2006 LIMIT 10;

select * from actor order by last_update desc;

SELECT DISTINCT(last_update) FROM actor;

select * from payment limit 10;
select * from payment order by payment_date limit 10;
select * from payment order by payment_date desc limit 10;

SELECT *
FROM payment
WHERE MONTH(payment_date)=7 and DAY(payment_date)=11 LIMIT 10;

select 
concat_ws(",", YEAR(payment_date), MONTH(payment_date), DAY(payment_date)) as date,
concat_ws(",", HOUR(payment_date), MINUTE(payment_date), SECOND(payment_date)) as time
FROM payment;

SELECT customer_id, amount,
sin(amount) as sin,
abs(sin(amount)) as abs_sin,
sqrt(amount) as sqrt,
round(sqrt(amount), 3) as round_sqrt,
truncate(sqrt(amount), 3) as truncate_sqrt
FROM payment
order by payment_date;