SELECT title, release_year, film_actor.actor_id, first_name, last_name
FROM film
FULL JOIN film_actor
ON film.film_id = film_actor.film_id
FULL JOIN actor
ON film_actor.actor_id= actor.actor_id
WHERE first_name LIKE 'J__';

-- Count the staff ID that we have in our stores that have taken payments
SELECT first_name, last_name, email, COUNT(payment.staff_id) AS highest_selling, SUM(amount) AS total_money
FROM staff
INNER JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id
ORDER BY COUNT (payment.staff_id) DESC;

-- Getting this info without SUBQUERY
SELECT customer_id
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 175
ORDER BY SUM(amount)DESC;

SELECT *
FROM customer;

-- SUBQUERY VERSION --
SELECT *
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);


SELECT  *
FROM film
WHERE language_id IN (
	SELECT language_id
	FROM language
	WHERE name = 'English'
);


SELECT *
FROM city
WHERE country_id IN (
	SELECT country_id
	FROM country
	WHERE city LIKE 'A__%'
);

--Stored Functions in SQL 
CREATE OR REPLACE FUNCTION actorsWithG()
RETURNS table(first_name VARCHAR(45))
AS
$$
BEGIN
	RETURN query
	SELECT actor.first_name AS actorsWithG
	FROM actor
	WHERE actor.first_name LIKE 'G__%';
END;
$$
LANGUAGE plpgsql;

SELECT actorsWithG();

-- How to delete a function

DROP FUNCTION addamount();

--How to create a function
CREATE OR REPLACE FUNCTION addAmount()
RETURNS BOOLEAN 
AS 
$$
BEGIN
	UPDATE payment
	SET amount = payment.amount + 10.00
	WHERE customer_id = 2;
	RETURN FOUND;

END;
$$
LANGUAGE plpgsql;

--Will be true because I have updated the amount via addamount function
SELECT addAmount();

--Here we can see that the function did work
SELECT amount
FROM payment
WHERE customer_id = 2;












