-- 1. Drop column `picture` from `staff`.
USE sakila;

SELECT * FROM sakila.staff; -- check how the table looks like

ALTER TABLE staff -- drop the picture column. 'drop' means that it is permanently gone from the table
DROP COLUMN picture;

SELECT * FROM staff; -- Check how the table looks like

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
SELECT * FROM customer
WHERE first_name = 'Tammy';

SELECT * FROM staff;

INSERT INTO staff
VALUES(3, 'Tammy', 'Sanders', 79, 'tammy.sanders@sakilacustomer.org', 2, 1, 'Tammy', NULL, NOW());

SELECT * FROM staff;


-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the `rental_date` column in the `rental` table.
   -- **Hint**: Check the columns in the table rental and see what information you would need to add there. 
   -- You can query those pieces of information. 
   -- For eg., you would notice that you need `customer_id` information as well.
   -- To get that you can use the following query:
     -- Use similar method to get `inventory_id`, `film_id`, and `staff_id`.

SELECT * FROM rental;



SELECT max(rental_id) FROM rental; -- check the rental id - 16049

-- check film id -- 1
SELECT * FROM film
WHERE title REGEXP 'academy dinosaur';

-- Check the inventory id-- it can be 1 - 4
SELECT * FROM store;
SELECT * FROM inventory
WHERE film_id = 1;
SELECT DISTINCT inventory_id FROM rental;
SELECT * FROM rental
WHERE inventory_id < 5
and staff_id = 1;
-- All inventory_id (1-4) from store1 is returned so I can assign any inventory_id to the rental from customer_id 130


-- customer id
select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';

-- staff ID
SELECT * FROM staff;


-- Insert the values (rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
INSERT INTO rental
Value(16050, NOW(), 1, 130, NULL, 1, NOW());

SELECT * FROM rental -- check if it is really there or not
WHERE rental_id = 16050;

  
-- 4. Delete non-active users, but first, create a _backup table_ `deleted_users` to store `customer_id`, `email`, and the `date` for the users that would be deleted. Follow these steps:

   -- 4.1 Check if there are any non-active users
   SELECT *, active FROM customer
   WHERE active = 0;
   
   SELECT count(*) active FROM customer
   WHERE active = 0; -- 15 inactive users
   
   -- 4.2 Create a table _backup table_ as suggested
   CREATE TABLE backup_table(
   customer_id INT(11) UNIQUE NOT NULL,
   email VARCHAR(50) DEFAULT NULL,
   date INT(11) DEFAULT NULL,
   CONSTRAINT PRIMARY KEY (customer_id)
   );
   
   ALTER TABLE backup_table
   ADD COLUMN latest_date INT(60) DEFAULT NULL;
      
   SELECT * FROM backup_table;
   
   ALTER TABLE backup_table
   drop column date;
   
   SELECT * FROM backup_table;
   
   ALTER TABLE backup_table
   MODIFY latest_date timestamp;
  
  SELECT * FROM backup_table;
   
   
   -- 4.3 Insert the non active users in the table _backup table_
   SELECT *, active FROM customer
   WHERE active = 0;
   
   INSERT INTO backup_table
   VALUES
   (16, 'SANDRA.MARTIN@sakilacustomer.org', NOW()),
   (64, 'JUDITH.COX@sakilacustomer.org', NOW()),
   (124, 'SHEILA.WELLS@sakilacustomer.org', NOW()),
   (169, 'ERICA.MATTHEWS@sakilacustomer.org', NOW()),
   (241, 'HEIDI.LARSON@sakilacustomer.org', NOW()),
   (271, 'PENNY.NEAL@sakilacustomer.org', NOW()),
   (315, 'KENNETH.GOODEN@sakilacustomer.org', NOW()),
   (368, 'HARRY.ARCE@sakilacustomer.org', NOW()),
   (406, 'NATHAN.RUNYON@sakilacustomer.org', NOW()),
   (446, 'THEODORE.CULP@sakilacustomer.org', NOW()),
   (482, 'MAURICE.CRAWLEY@sakilacustomer.org', NOW()),
   (510, 'BEN.EASTER@sakilacustomer.org', NOW()),
   (534, 'CHRISTIAN.JUNG@sakilacustomer.org', NOW()),
   (558, 'JIMMIE.EGGLESTON@sakilacustomer.org', NOW()),
   (592, 'TERRANCE.ROUSH@sakilacustomer.org', NOW());
   
   SELECT * FROM backup_table;
   
   -- 4.4 Delete the non active users from the table _customer_
   SET SQL_SAFE_UPDATES = 0; -- Deactivate the safemode!
   
   DELETE FROM customer -- THIS ISNT WORKING....BUT I DONT KNOW WHY.
   WHERE active = 0;
   
   SELECT * from customer; 