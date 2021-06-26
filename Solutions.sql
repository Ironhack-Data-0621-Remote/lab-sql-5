USE sakila;

-- 1. Drop column `picture` from `staff`.
SELECT *
FROM staff;

ALTER TABLE sakila.staff
DROP COLUMN picture;

SELECT *
FROM staff;

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
SELECT *
FROM customer
WHERE first_name = "Tammy";

-- information from customer table: 75	2	TAMMY	SANDERS	TAMMY.SANDERS@sakilacustomer.org	79	1	2006-02-14 22:04:36	2006-02-15 04:57:20

INSERT INTO sakila.staff
VALUES (3, "Tammy", "Sanders", 79, "Tammy.Sanders@sakilastaff.com", 2, 1, "Tammy", NULL, NOW());

-- review changes
SELECT *
FROM staff;

-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the `rental_date` column in the `rental` table.
   -- **Hint**: Check the columns in the table rental and see what information you would need to add there. 
   SELECT * 
   FROM RENTAL;
   -- information to add rental_id = new running number, rental_date = now, inventory_id = 1, customer_id = 130, return_date = NULL, staff_id = 1, last_update = now
   -- You can query those pieces of information. 
   -- For eg., you would notice that you need `customer_id` information as well.
   -- To get that you can use the following query:
select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
-- customer_id = 130
    -- Use similar method to get `inventory_id`, `film_id`, and `staff_id`.

SELECT *
FROM film
WHERE title = "Academy Dinosaur";
-- film_id = 1

SELECT *
FROM inventory
WHERE film_id = 1
AND store_id = 1;
-- inventory_id are 1,2,3,4

SELECT *
FROM rental
WHERE inventory_id IN ("1","2","3","4");
-- all inventory is available to rent - we will use inventory_id = 1

-- running number for new rental
SELECT *
FROM rental
ORDER BY rental_id DESC;

INSERT INTO rental
Value (16050, NOW(), 1, 130, NULL, 1, NOW());

-- review result
SELECT *
FROM rental
WHERE rental_id = 16050;


-- why does this not work?
-- SELECT f.film_id, i.inventory_id
-- FROM film AS f, inventory AS i
-- WHERE f.title = "Academy Dinosaur";



-- 4. Delete non-active users, but first, create a _backup table_ `deleted_users` to store `customer_id`, `email`, and the `date` for the users that would be deleted. Follow these steps:
   -- 4.1 Check if there are any non-active users
  -- check values from active column
  SELECT DISTINCT customer.active
   FROM customer;

-- check all inactive customers - result 15 inactive customers
   SELECT *
   FROM customer
   WHERE customer.active = 0;
   
   -- 4.2 Create a table _backup table_ as suggested
   CREATE TABLE deleted_users 
   SELECT customer_id, email, create_date, last_update 
   FROM customer 
   WHERE customer.active =0;
   
   SELECT *
   FROM deleted_users;
   
   -- 4.3 Insert the non active users in the table _backup table_
   -- see previous step
   -- 4.4 Delete the non active users from the table _customer_
   DELETE FROM sakila.customer
   WHERE customer.active =0;