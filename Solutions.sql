USE sakila;

-- 1. Drop column `picture` from `staff`.
ALTER TABLE staff
DROP COLUMN picture;

SELECT * FROM staff;

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, 
-- and she is a customer. Update the database accordingly.
SELECT * FROM customer WHERE first_name = 'Tammy' AND last_name = 'Sanders';

INSERT INTO staff
VALUES (3, 'Tammy', 'Sanders', 79, 'TAMMY.SANDERS@sakilacustomer.org', 2, 1, 'Tammy', NULL, '2006-02-15 04:57:20');

SELECT * FROM staff;

-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer 
-- at Store 1. 
-- You can use current date for the `rental_date` column in the `rental` table.

-- **Hint**: Check the columns in the table rental and see what information you would need to add there. 
-- You can query those pieces of information. 
-- For eg., you would notice that you need `customer_id` information as well.
-- To get that you can use the following query:

SELECT * FROM rental;

-- columns which are needed for new row:
-- (rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update) 

-- customer_id: 130
SELECT customer_id FROM sakila.customer
WHERE first_name = 'CHARLOTTE' AND last_name = 'HUNTER';

-- film_id = 1
SELECT film_id FROM film
WHERE title = 'Academy Dinosaur'; 

-- inventory_id: 1, 2, 3 or 4
SELECT inventory_id FROM inventory
WHERE film_id = 1 and store_id = 1;

-- staff_id: 1
SELECT staff_id FROM staff
WHERE first_name = 'Mike' AND last_name = 'Hillyer';

-- rental_id: 16050 (one higher than last id)
SELECT * FROM rental
ORDER BY rental_id DESC;

-- inserting new column:

INSERT INTO rental (rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update) 
VALUES (16050, NOW(), 1, 130, NULL, 1, NOW());

SELECT * FROM rental
WHERE rental_id = 16050;

-- 4. Delete non-active users, 
-- but first, create a _backup table_ `deleted_users` to store `customer_id`, `email`, and the `date` 
-- for the users that would be deleted.

-- 4.1 Check if there are any non-active users
SELECT * FROM customer WHERE active = 0;

-- 4.2 Create a table _backup table_ as suggested

DROP TABLE IF EXISTS backup_table;  

CREATE TABLE backup_table(
   customer_id INT(11) UNIQUE NOT NULL,
   email VARCHAR(50) DEFAULT NULL,
   create_date DATE DEFAULT NULL,
   delete_date DATE DEFAULT NULL,
   CONSTRAINT PRIMARY KEY (customer_id)
   );
   
-- 4.3 Insert the non active users in the table _backup table_
   
INSERT INTO backup_table
SELECT customer_id, email, create_date, DATE(NOW())
FROM customer
WHERE active = 0;

SELECT * FROM backup_table;
   
-- 4.4 Delete the non active users from the table _customer_
SET SQL_SAFE_UPDATES = 0;

DELETE FROM customer
WHERE active = 0;