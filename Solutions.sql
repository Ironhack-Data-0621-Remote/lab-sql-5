-- 1. Drop column `picture` from `staff`.
ALTER TABLE staff DROP COLUMN picture; 
SELECT *
FROM staff;
-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
INSERT INTO staff (staff_id, first_name, last_name, address_id, email, active, store_id, username, password, last_update)
VALUES (3,'Tammy','Sanders',79,'Tammy.Sanders@sakilastaff.com',2,1,'Tammy','1abc2345','2021-06-25 17:21:00');

-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the `rental_date` column in the `rental` table.
   -- **Hint**: Check the columns in the table rental and see what information you would need to add there. 
   -- You can query those pieces of information. 
   -- For eg., you would notice that you need `customer_id` information as well.
   -- To get that you can use the following query:
SELECT customer_id  FROM sakila.customer
WHERE first_name = 'CHARLOTTE' and last_name = 'HUNTER';
-- 
SELECT staff_id
FROM staff
WHERE first_name = 'MIKE' AND last_name = 'Hillyer';
--
SELECT inventory.inventory_id, film.title
FROM film INNER JOIN
inventory ON film.film_id = inventory.inventory_id
WHERE film.title = "Academy Dinosaur";
--
SELECT * 
FROM rental
ORDER BY rental_id DESC;
--
INSERT INTO rental (rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
VALUES (16050, '2021-06-25 17:41:00', 1, 130, NULL, 1, '2021-06-25 17:41:00');


    -- Use similar method to get `inventory_id`, `film_id`, and `staff_id`.

-- 4. Delete non-active users, but first, create a _backup table_ `deleted_users` to store `customer_id`, `email`, and the `date` for the users that would be deleted. Follow these steps:


   -- 4.1 Check if there are any non-active users
SELECT *
FROM customer
WHERE active = FALSE;
   -- 4.2 Create a table _backup table_ as suggested
CREATE TABLE deleted_users
(
  customer_id INT(11) UNIQUE NOT NULL,
  email VARCHAR(60) DEFAULT NULL,
  date DATE DEFAULT NULL,
  CONSTRAINT PRIMARY KEY (customer_id)
  );

   -- 4.3 Insert the non active users in the table _backup table_
   
INSERT INTO deleted_users (customer_id, email, date)
SELECT customer_id, email, DATE(now())
FROM customer
WHERE active = false;
   -- 4.4 Delete the non active users from the table _customer_
DELETE FROM sakila.customer
WHERE active = FALSE;
   #not sure why is it not working