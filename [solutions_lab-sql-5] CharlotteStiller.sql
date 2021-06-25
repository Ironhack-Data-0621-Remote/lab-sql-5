USE sakila;
SELECT picture FROM staff;

-- 1. Drop column picture from staff.
ALTER TABLE staff DROP COLUMN picture; 
DESCRIBE staff; 

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
SELECT * FROM customer WHERE first_name = "TAMMY" AND last_name = "SANDERS"; 

INSERT INTO staff(first_name, last_name, address_id, email, store_id, active, username) VALUES ("Tammy", "Sanders", 79, "Tammy.Sanders@sakilastaff.org", 1, 1, "Tammy");
-- didn't know how to handle the store_id, because it didn't accept an NULL or DEFAULS value so I picked one of the two store_ids. 
 SELECT * FROM staff LIMIT 10; 
 
 
 -- 3. Add rental for movie "Academy Dinosaur"
SELECT customer_id FROM sakila.customer
WHERE first_name = 'CHARLOTTE' AND last_name = 'HUNTER';
SELECT film_id, title FROM FILM WHERE title = "Academy Dinosaur";
SELECT * FROM INVENTORY WHERE film_id = 1;
SELECT staff_id FROM staff WHERE store_id = 1;

INSERT INTO rental(rental_date, inventory_id, customer_id, return_date, staff_id) VALUES(NOW(), 9, 130, NULL, 1);
-- rental_id ()
-- rental_date ()
-- inventory_id 9 -- because so far there are 8 
-- customer_id 130
-- return_date DEFAULT
-- staff_id 1 -- should be Mike (Before addeting Tammy)  
-- last_update ()
-- film_id 1 
-- store_id 1 
SELECT * FROM rental WHERE customer_id = 130 AND inventory_id = 9; 

-- 4. Delete non-active users
DROP table if exists deleted_users;

CREATE TABLE deleted_users (
  `costumer_id` int(11) UNIQUE NOT NULL, 
  `email` text DEFAULT NULL, 
  `date_deleted` date DEFAULT NULL, 
  CONSTRAINT PRIMARY KEY (costumer_id)  
); 
SELECT * FROM deleted_users;
 
 -- 4.1. Check if there are any non-active users
 SELECT COUNT(active) FROM customer WHERE active = 0;
 -- 15 costumers are not active 
 
 -- 4.2. Create a table backup table as suggested
 -- DONE 
 
 -- 4.3. Insert the non active users in the table backup table
SET sql_mode = '';
SET sql_mode = 'STRICT_TRANS_TABLES';
INSERT INTO deleted_users(costumer_id, email, date_deleted)  
SELECT customer_id, email, last_update 
FROM `customer`
WHERE `active` = '0';
 
SELECT * FROM deleted_users;

-- 4.4. Delete the non active users from the table customer

DELETE FROM customer WHERE active = 0; 
-- did not work, because it is an foreign key (Error Code: 1451). Googled a lot. Was not sure how to fix it without deleting values I want to keep. 
