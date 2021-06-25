use sakila;

-- Drop column picture from staff. 

ALTER TABLE staff
DROP COLUMN picture;

-- A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.

INSERT INTO staff (staff_id, first_name, last_name, address_id, email, active, store_id, username, password, last_update)
VALUES (3,'Tammy','Sanders',79,'Tammy.Sanders@sakilastaff.com',2,1,'Tammy','1abc2345','2021-06-25 17:21:00');

-- Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
-- You can use current date for the rental_date column in the rental table. 
-- Hint: Check the columns in the table rental and see what information you would need to add there. 
-- You can query those pieces of information. For eg., you would notice that you need customer_id information as well. 
-- To get that you can use the following query:

-- to get customer_id
SELECT customer_id 
FROM sakila.customer
WHERE first_name = 'CHARLOTTE' AND last_name = 'HUNTER';

-- to get inventory_id
SELECT film.title, inventory.inventory_id
FROM film INNER JOIN
inventory ON film.film_id = inventory.inventory_id
WHERE film.title = "Academy Dinosaur";

-- to get staff_id
SELECT staff_id
FROM staff
WHERE first_name = 'MIKE' AND last_name = 'Hillyer';

-- to get rental_id
SELECT * 
FROM rental
ORDER BY rental_id DESC;

INSERT INTO rental (rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
VALUES (16050, '2021-06-25 17:41:00', 1, 130, NULL, 1, '2021-06-25 17:41:00');

-- Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. 
-- Follow these steps:
-- Check if there are any non-active users

SELECT * 
FROM customer
WHERE active = 0;

-- Create a table backup table as suggested

CREATE table deleted_users (
customer_id int(10) UNIQUE NOT NULL,
email varchar(60) DEFAULT NULL,
deletion_date DATE NULL,
CONSTRAINT PRIMARY KEY (customer_id)
);

-- Insert the non active users in the table backup table

INSERT INTO deleted_users (customer_id, email)
SELECT customer_id, email
FROM customer
WHERE active = 0;

SET SQL_SAFE_UPDATES = 0;

UPDATE deleted_users
SET deletion_date = '2021-06-25';

-- Delete the non active users from the table customer

SET FOREIGN_KEY_CHECKS=0;  -- not sure if this is correct but it was the way to solve this error in order to delete the rows: Cannot delete or update a parent row: a foreign key constraint fails (`sakila`.`payment`, CONSTRAINT `fk_payment_customer` FOREIGN KEY (`customer_id`)

DELETE FROM customer 
WHERE active = 0;
