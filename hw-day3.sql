
--List all customers who live in Texas (use JOINs)
select * from address a 

select concat(first_name, ' ', last_name) as Name, district 
from customer c 
join address a on c.address_id = a.address_id 
where district = 'Texas'

select concat(first_name, ' ', last_name) as Name
from customer c 
where address_id in
(select address_id
from address a 
where district = 'Texas')
/* 5 customers*/

--Get all payments above $6.99 with the Customer's FullName
select * from payment p 

select concat(first_name, ' ', last_name) as Name, amount
from customer c 
join payment p on c.customer_id = p.customer_id 
where amount > 6.99 
order by amount desc
/* 1406 rows*/

--Show all customers names who have made payments over $175(use subqueries)
select concat(first_name, ' ', last_name) as Name
from customer c  
where customer_id in
(select customer_id
from payment p 
group by customer_id 
having sum(amount) > 175
)
order by (
select sum(amount)
from payment p2
where c.customer_id = p2.customer_id
) desc



select concat(first_name, ' ', last_name) as Name, sum(amount)
from customer c 
join payment p on c.customer_id = p.customer_id 
group by Name 
having sum(amount) > 175
order by sum(amount) desc

/*6 rows*/

--List all customers that live in Nepal (use the city table)
select * from city c 

select concat(first_name, ' ', last_name) as Name, country
from customer c 
join address a on c.address_id = a.address_id 
join city c2 on a.city_id = c2.city_id
join country c3 on c2.country_id = c3.country_id 
where country = 'Nepal'

select concat(first_name, ' ', last_name) as Name, email
from customer c2 
where address_id in
(select address_id 
from address a 
where city_id in
(select city_id
from city c
where country_id  in
(select country_id
from country c 
where country = 'Nepal')))
-- 1 row : Kevin Schuler

--Which staff member had the most transactions?

select concat(first_name, ' ', last_name) as Name, count(p.staff_id) as Number_Transactions
from staff s 
join payment p on s.staff_id = p.staff_id 
group by Name
order by count(p.staff_id) desc
/*Jon Stephens has the most transactions at 7304.*/

--How many movies of each rating are there?
select * from film f 

select rating, count(rating) as Number
from film f 
group by rating 
order by count(rating) desc

/* 5 rating in total with PG-13 has the most movies, 223*/

--7.Show all customers who have made a single payment above $6.99 (Use Subqueries)

SELECT CONCAT(first_name, ' ', last_name) AS Name, p.amount
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
WHERE c.customer_id IN (
    SELECT customer_id
    FROM payment
    WHERE amount > 6.99
)
order by amount desc


select concat(first_name, ' ', last_name) as Name, amount
from customer c 
join payment p on c.customer_id = p.customer_id 
where amount > 6.99 
order by amount desc


--How many free rentals did our store give away

select count(payment_id)
from payment p 
where amount = 0

--24 free rentals

