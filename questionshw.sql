-- 1. List all customers who live in Texas (use
-- JOINs)
-- Richard Mccrary, Kim Cruz, Jennifer David, Ian Still, and Bryan Hardison live in Texas
SELECT first_name, last_name, district
FROM customer
INNER JOIN address
ON address.address_id = customer.address_id
WHERE district LIKE 'Texas'
ORDER BY first_name DESC;


-- 2. Get all payments above $6.99 with the Customer's Full
-- Name
-- This command is how I got all payments 

SELECT first_name, last_name, payment.amount
FROM customer
JOIN payment 
ON customer.customer_id = payment.customer_id
WHERE payment.amount > 6.99;



-- 3. Show all customers names who have made payments over $175(use
-- subqueries)
-- Peter Menard

SELECT first_name, last_name
FROM customer
WHERE customer_id IN (SELECT customer_id FROM payment WHERE amount > 175);

-- 4. List all customers that live in Nepal (use the city
-- table)
--  Kevin Schuler 


-- SELECT first_name, last_name, city
-- FROM customer
-- INNER JOIN address
-- ON address.address_id = customer.address_id
-- WHERE district LIKE 'Nepal'
-- ORDER BY first_name DESC;

-- SELECT first_name, last_name
-- FROM customer
-- JOIN address ON customer.address_id = address.address_id
-- JOIN city ON address.city_id = city.city_id
-- WHERE city.country = 'Nepal';

SELECT first_name, last_name
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
WHERE country.country = 'Nepal';




-- 5. Which staff member had the most
-- transactions?
--Jon Stephens had the most transactions (7304)

SELECT first_name, last_name, COUNT(*) as Transactions
FROM staff
JOIN payment ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id
ORDER BY COUNT(*) DESC
LIMIT 1;


-- 6. How many movies of each rating are
-- there?
-- There are 178 G rated movies, 194 PG rated, 195 R rated, 209 NC-17 rated, and 223 PG-13 rated movies

SELECT rating, count(film_id) as movies
FROM film
GROUP BY rating
ORDER BY movies;


-- 7.Show all customers who have made a single payment
-- above $6.99 (Use Subqueries)
-- Christine Roberts, Beverly Brooks, Annie Russel, Megan Palmer, Penny Neal, Bobbie Craig, Scott Shelley, Bobby Boudreau, Jay Robb, Kirk Stclair, Enrique Forsythe 


SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    WHERE amount > 6.99
    GROUP BY customer_id
    HAVING COUNT(*) = 1
);


-- 8. How many free rentals did our stores give away?
--0 free rentals

SELECT COUNT(rental.rental_id) as Free_Rentals
FROM rental
LEFT JOIN payment ON rental.rental_id = payment.rental_id
WHERE payment.amount = 0;