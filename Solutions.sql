USE sakila;

-- 1. Drop column `picture` from `staff`.

ALTER TABLE staff
DROP COLUMN picture;

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.

SELECT *
FROM customer
WHERE first_name = "TAMMY";

-- the staff table requires an address_id all customer have so searched first  in the customer table for her address ID.

INSERT INTO staff (store_id, first_name, last_name, address_id, username)
VALUES ("2", "Tammy", "Sanders", 79, "Tammy");

-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the `rental_date` column in the `rental` table.
   -- **Hint**: Check the columns in the table rental and see what information you would need to add there. 
   -- You can query those pieces of information. 
   -- For eg., you would notice that you need `customer_id` information as well.
   -- To get that you can use the following query:
   

select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
-- customer id = 130

    -- Use similar method to get `inventory_id`, `film_id`, and `staff_id`.
    
SELECT *
FROM film
WHERE title REGEXP "Academy Dinosaur";
-- film_id = 1 

SELECT *
FROM staff
WHERE first_name= "Mike";
-- staff_id = 1
 
SELECT * FROM inventory
WHERE film_id = 1 AND store_id = 1;
-- store 1 has 4 copies in the inventory with the ids 1-4. lets just pick id 4

-- then the final query to input this new rental into the rental table
    
INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id, last_update)
VALUES ('2021-06-25', 4, 130, 1, '2021-06-25');


-- 4. Delete non-active users, but first, create a _backup table_ `deleted_users` to store `customer_id`, `email`, and the `date` for the users that would be deleted. Follow these steps:

   -- 4.1 Check if there are any non-active users
   
SELECT COUNT(*)
FROM customer
WHERE active = False;
-- 15 inactive users

   -- 4.2 Create a table _backup table_ as suggested
CREATE TABLE deleted_users (
customer_id INT(11) UNIQUE NOT NULL,
email VARCHAR(50) DEFAULT NULL,
date INT(11) DEFAULT NULL,
CONSTRAINT PRIMARY KEY (customer_id)
);

   -- 4.3 Insert the non active users in the table _backup table_
SELECT *
FROM customer
WHERE active = False;   

INSERT INTO deleted_users (customer_id, email)
SELECT customer_id, email
FROM customer
WHERE active = False;
-- this query inserted the 15 inactive users to the deleted_user table (without the date, not sure how to do that).

   -- 4.4 Delete the non active users from the table _customer_

DELETE FROM customer
WHERE active = False;

-- there is a foreign key constraint - not sure how to correctly alter the schema so I can delete the inactive customers.