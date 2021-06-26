USE sakila;
-- Drop column picture from staff.
-- ALTER TABLE sakila.staff
-- DROP COLUMN picture;
-- QUESTION: if exists isn't working here??

-- A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. 
-- Update the database accordingly.
SELECT * FROM customer
WHERE first_name = 'TAMMY' 
AND last_name = 'SANDERS';
SELECT * FROM staff
WHERE first_name = 'Jon';
SELECT MAX(staff_id) from staff;
INSERT INTO staff(first_name, last_name, address_id, email, store_id, active, username, last_update)
VALUES('TAMMY', 'SANDERS', '79', 'TAMMY.SANDERS@sakilacustomer.org', '2', '1', 'Tammy', '2006-02-15 04:57:20');
SELECT * FROM staff
WHERE first_name = 'Tammy';

-- Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
-- You can use current date for the rental_date column in the rental table. 
-- Hint: Check the columns in the table rental and see what information you would need to add there. 
-- You can query those pieces of information. For eg., you would notice that you need customer_id information as well. 
-- To get that you can use the following query:
-- select customer_id from sakila.customer
-- where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
-- Use similar method to get inventory_id, film_id, and staff_id.
SELECT * FROM customer
WHERE first_name = 'CHARLOTTE' 
AND last_name = 'HUNTER';
SELECT * FROM staff
WHERE first_name = 'Mike';
SELECT * FROM film
WHERE title = 'Academy Dinosaur';
SELECT * FROM inventory
WHERE film_id = 1;
INSERT INTO rental(rental_date, inventory_id, customer_id, staff_id)
VALUES('2021-06-26 05:00:00', '1', '130', '1');
-- QUESTION: how do i get the right inventory_id as there are multiple movies in store 1 with film_id 1?
-- and tables inventory & film don't show which titles are connected to the inventory id's?

-- Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. 
-- Follow these steps:
-- Check if there are any non-active users
-- Create a table backup table as suggested
-- Insert the non active users in the table backup table
SELECT DISTINCT active from customer;
DROP TABLE IF EXISTS deleted_users;
CREATE TABLE deleted_users(
  customer_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  email VARCHAR(50) DEFAULT NULL,
  CONSTRAINT PRIMARY KEY (customer_id)
);
INSERT INTO deleted_users(customer_id, email) 
SELECT customer_id, email FROM customer
WHERE active = 0;
ALTER TABLE deleted_users
ADD COLUMN delete_date DATETIME;
SET SQL_SAFE_UPDATES = 0;
UPDATE deleted_users
SET delete_date = NOW();
SELECT * FROM deleted_users;
-- Delete the non active users from the table customer
DELETE FROM customer
WHERE active = 0;
