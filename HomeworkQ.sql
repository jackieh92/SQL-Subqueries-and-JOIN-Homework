-- 1. List of all the customers who live in Texas (Using joins)--
SELECT first_name, last_name, district
FROM customer  --Table A
INNER JOIN address --Table B
ON customer.customer_id = address.address_id
WHERE address.district = 'Texas';

SELECT first_name, last_name, address.address_id, address.district 
FROM customer
JOIN address ON customer.address_id=address.address_id
WHERE address.district = 'Texas';

-- 2. Get all payments above $6.99 with the customer's full name--
SELECT first_name, last_name, payment.amount
FROM customer
FULL JOIN payment
ON payment.customer_id = customer.customer_id
WHERE amount > 6.99
ORDER BY amount DESC;

-- 3. Show all customer's names who have made payments over $175 (using subquery)--
SELECT *
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING COUNT (amount) > 175	
);

SELECT amount
FROM payment
GROUP BY amount
ORDER BY MAX(amount) DESC

SELECT customer_id,first_name,last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);


--4. List all customers that live in Nepal (use city table)--
SELECT last_name, first_name, city.country_id
FROM customer
FULL JOIN city
ON customer.customer_id = city.country_id
FULL JOIN country
ON city.country_id = country.country_id
WHERE country LIKE 'Nepal';


-- 5. Which staff member had the most transactions? --
SELECT first_name, last_name, COUNT(payment.staff_id) AS Top_Seller
FROM staff
INNER JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id
ORDER BY COUNT (payment.staff_id) DESC;


--6. How many movies of each rating are there? --
--SELECT title, rating, COUNT(inventory.film_id) AS movie_count_rating, SUM(inventory.film_id) AS total_count
--FROM film
--INNER JOIN inventory
--ON film.film_id = inventory.film_id
--GROUP BY film.film_id
--ORDER BY COUNT (inventory.film_id) DESC;

--SELECT rating, COUNT(inventory.film_id) AS Movie_Count
--FROM film
--INNER JOIN inventory
--ON film.film_id = inventory.film_id
--GROUP BY film.film_id
--ORDER BY COUNT (inventory.film_id) DESC;

--Here was yesterdays problem, I tried to answer it using join but didnt see the point
--When film_id and rating are in the same table.
SELECT rating, COUNT(film_id) AS Movie_Count
FROM film
GROUP BY rating
ORDER BY COUNT(film_id) DESC;


SELECT rating, film_id, title
FROM film

--7. Show all Customers who have made a single payment above $6.99 using subqueries --
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT  customer_id
	FROM payment
	GROUP BY payment.customer_id
	HAVING COUNT(DISTINCT payment.amount) > 6.99
	ORDER BY customer_id DESC
);

--8. How many free rentals did our stores give away?--
SELECT amount, payment.staff_id, rental.rental_id
FROM payment -- Table A
FULL JOIN rental-- Table B
ON rental.rental_id = payment.rental_id
WHERE amount = 0


