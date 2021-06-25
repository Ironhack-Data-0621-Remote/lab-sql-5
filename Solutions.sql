-- 1. Drop column `picture` from `staff`.
ALTER TABLE staff DROP picture;

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
SELECT * FROM customer
WHERE first_name = 'Tammy';

INSERT INTO staff 
SET first_name ='Tammy', 
last_name = 'Sanders',
address_id = 79,
email = 'Tammy.Sanders@sakilastaff.com',
store_id = 1,
username = 'Tammy';

SELECT * FROM staff;

-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the `rental_date` column in the `rental` table.
   -- **Hint**: Check the columns in the table rental and see what information you would need to add there. 
   -- You can query those pieces of information. 
   -- For eg., you would notice that you need `customer_id` information as well.
   -- To get that you can use the following query ; -- Use similar method to get `inventory_id`, `film_id`, and `staff_id`.
-- collecting all data needed to insert the new line
select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';

SELECT staff_id FROM staff
WHERE first_name = 'Mike';

SELECT film_id FROM film
WHERE title = 'Academy Dinosaur';

SELECT inventory_id, film_id FROM inventory
WHERE film_id = 1;

-- Inserting the new line
INSERT INTO rental VALUES
(Default, NOW(), 1, 130, Default, 1, Default);

-- checking that the line has been inserted as requested
SELECT * FROM rental
WHERE customer_id = 130
ORDER BY rental_date DESC ;

    
-- 4. Delete non-active users, but first, create a _backup table_ `deleted_users` to store `customer_id`, `email`, and the `date` for the users that would be deleted. Follow these steps:

   -- 4.1 Check if there are any non-active users
SELECT customer_id, active as non_active_users, email, create_date FROM customer
ORDER BY active ASC;
   
   -- 4.2 Create a table _backup table_ as suggested

   CREATE TABLE back_up_table_deleted_users (
  `customer_id` int UNIQUE NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `create_date` date DEFAULT NULL,
    CONSTRAINT PRIMARY KEY (customer_id) 
);
   
   -- 4.3 Insert the non active users in the table _backup table_
   
INSERT INTO back_up_table_deleted_users VALUES
(16,'SANDRA.MARTIN@sakilacustomer.org', '2006-02-14 22:04:36'),
(64,'JUDITH.COX@sakilacustomer.org','2006-02-14 22:04:36'),
(124,'SHEILA.WELLS@sakilacustomer.org', '2006-02-14 22:04:36'),
(169,'ERICA.MATTHEWS@sakilacustomer.org', '2006-02-14 22:04:36'),
(241,'HEIDI.LARSON@sakilacustomer.org', '2006-02-14 22:04:36'),
(271,'PENNY.NEAL@sakilacustomer.org', '2006-02-14 22:04:36'),
(315,'KENNETH.GOODEN@sakilacustomer.org', '2006-02-14 22:04:37'),
(406,'NATHAN.RUNYON@sakilacustomer.org', '2006-02-14 22:04:37'),
(446,'THEODORE.CULP@sakilacustomer.org', '2006-02-14 22:04:37'),
(368,'HARRY.ARCE@sakilacustomer.org', '2006-02-14 22:04:37'),
(510,'BEN.EASTER@sakilacustomer.org', '2006-02-14 22:04:37'),
(482,'MAURICE.CRAWLEY@sakilacustomer.org', '2006-02-14 22:04:37'),
(534,'CHRISTIAN.JUNG@sakilacustomer.org', '2006-02-14 22:04:37'),
(558,'JIMMIE.EGGLESTON@sakilacustomer.org', '2006-02-14 22:04:37'),
(592,'TERRANCE.ROUSH@sakilacustomer.org', '2006-02-14 22:04:37');

SELECT* FROM back_up_table_deleted_users;

   -- 4.4 Delete the non active users from the table _customer_
   
ALTER TABLE customer DROP store_id;
ALTER TABLE customer DROP address_id;
ALTER TABLE payment DROP customer_id;
ALTER TABLE rental DROP customer_id;

DELETE FROM customer 
WHERE active = 0;

SELECT* FROM customer
WHERE active = 0;
