-- 1. Drop column `picture` from `staff`.
-- ALTER TABLE staff
-- DROP COLUMN picture;

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
-- Here I used the same info as Jon to fill the fields.
-- INSERT INTO staff
-- VALUES (3, 'Tammy', 'Sanders', 4, 'email', 2, 1, 'Tammy', 'password', now());

-- After adding the row I realized a pattern for e-mail and password, so I updated the table.
-- UPDATE staff
-- SET email = 'Tammy.Sanders@sakilastaff.com', password = '8cb2237d0679ca88db6464eac60da96345513964'
-- WHERE staff_id = 3;

-- Then I realized that she is a customer, so I got a new address_id.
-- I didn't update the e-mail bc as a staff member should not use hers/his customer one.
-- UPDATE staff
-- SET address_id = 79
-- WHERE staff_id = 3;

-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the `rental_date` column in the `rental` table.
   -- **Hint**: Check the columns in the table rental and see what information you would need to add there. 
   -- You can query those pieces of information. 
   -- For eg., you would notice that you need `customer_id` information as well.
   -- To get that you can use the following query:
	   -- select customer_id from sakila.customer
	   -- where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
   -- Use similar method to get `inventory_id`, `film_id`, and `staff_id`.

-- rental_id (I'm considering the last entrance + 1 --> 16050)
-- SELECT rental_id + 1 FROM rental
-- ORDER BY rental_id DESC
-- LIMIT 1;

-- inventory_id (I'm considering the first entrance --> 1)
-- SELECT inventory_id FROM inventory
-- WHERE film_id =
        -- film_id
-- 		(SELECT film_id FROM film
-- 		WHERE title = 'Academy Dinosaur')
-- 		AND store_id = 1
-- 		LIMIT 1;
        
-- customer_id --> 130
-- SELECT customer_id FROM customer
-- WHERE first_name = 'CHARLOTTE' AND last_name = 'HUNTER';

-- staff_id --> 1
-- SELECT staff_id FROM staff
-- WHERE first_name = 'Mike' AND last_name = 'Hillyer' AND store_id = 1;

-- INSERT INTO rental
-- VALUES(
-- 	-- rental_id (I'm considering the last entrance + 1)
-- 	16050, 
-- 	-- rental_date
-- 	now(), 
-- 	-- inventory_id (I'm considering the first entrance)
-- 	1, 
-- 	-- customer_id
-- 	130, 
-- 	-- return_date
-- 	now(), 
-- 	-- staff_id
-- 	1, 
-- 	-- last_update
-- 	now()
--  );
    
-- I tried with subqueries but didn't work     
-- INSERT INTO rental
-- VALUES(
-- 	-- rental_id (I'm considering the last entrance + 1)
-- 	(SELECT rental_id FROM rental
-- 	ORDER BY rental_id DESC
-- 	LIMIT 1) +1, 

-- 	-- rental_date
-- 	now(), 

-- 	-- inventory_id (I'm considering the first entrance)
-- 	(SELECT inventory_id FROM inventory
-- 	WHERE film_id =

-- 		-- film_id
-- 		(SELECT film_id FROM film
-- 		WHERE title = 'Academy Dinosaur')
-- 		AND store_id = 1
-- 		LIMIT 1), 

-- 	-- customer_id
-- 	(SELECT customer_id FROM customer
-- 	WHERE first_name = 'CHARLOTTE' AND last_name = 'HUNTER'), 

-- 	-- return_date
-- 	now(), 

-- 	-- staff_id
-- 	(SELECT staff_id FROM staff
-- 	WHERE first_name = 'Mike' AND last_name = 'Hillyer' AND store_id = 1), 

-- 	-- last_update
-- 	now()
--  );

-- 4. Delete non-active users, but first, create a _backup table_ `deleted_users` to store `customer_id`, `email`, and the `date` for the users that would be deleted. Follow these steps:

   -- 4.1 Check if there are any non-active users
SELECT active AS status, count(active) AS amount FROM customer
GROUP BY active;

   -- 4.2 Create a table _backup table_ as suggested
-- if the table already exists:
DROP TABLE deleted_users;

CREATE TABLE deleted_users (
    customer_id smallint NOT NULL,
    email varchar(50) DEFAULT NULL,
    delete_date date NOT NULL
);
   -- 4.3 Insert the non active users in the table _backup table_
INSERT INTO deleted_users (customer_id, email, delete_date)
SELECT customer_id, email, now()
FROM customer
WHERE active = 0;
  
   -- 4.4 Delete the non active users from the table _customer_
   -- but here we have a foreign key problem
DELETE FROM customer
WHERE status = 0;