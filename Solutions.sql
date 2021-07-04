-- 1. Drop column `picture` from `staff`.
-- create database if not exists sakila_demo;
-- use sakila_demo;
alter table staff
drop column picture;
select * from staff;

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
select * from staff;
select * from sakila.customer
where first_name regexp 'TAMMY';
insert into staff(staff_id, first_name, last_name, address_id, email, store_id, active, username, password, last_update) values
(3, 'TAMMY', 'SANDERS', 79, 'TAMMY.SANDERS@sakilacustomer.org', 2, 1, 'Tammy', 0, 260215);


-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the `rental_date` column in the `rental` table.
   -- **Hint**: Check the columns in the table rental and see what information you would need to add there. 
  select * from rental
  where customer_id = 130;
  select * from sakila.customer
where first_name regexp 'charlotte';
  -- You can query those pieces of information. 
  select * from staff;
   -- For eg., you would notice that you need `customer_id` information as well.
   -- To get that you can use the following query:

select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';

select film_id from sakila.film
where title = 'Academy Dinosaur';
select * from sakila.film
where title regexp 'Dinosaur';
select inventory_id from sakila.inventory
where film_id = 1 and store_id = 1;
select * from rental;

Insert into rental(rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update) values
(1001, 050524, 2, 130, 050526, 1, 060215);

    -- Use similar method to get `inventory_id`, `film_id`, and `staff_id`.

-- 4. Delete non-active users, but first, create a _backup table_ `deleted_users` to store `customer_id`, `email`, and the `date` for the users that would be deleted. Follow these steps:

   -- 4.1 Check if there are any non-active users
   select * from customer
   where active = 0;
   
   -- 4.2 Create a table _backup table_ as suggested
    create database if not exists sakila_demo;
	use sakila_demo;
    drop table if exists customer_demo;
    create table customer_demo(
	`customer_id` smallint(11) UNIQUE NOT NULL,
    `store_id` tinyint(8) DEFAULT NULL,
    `first_name` varchar(20) DEFAULT NULL,
    `last_name` varchar(20) DEFAULT NULL,
    `email` varchar(50) DEFAULT NULL,
    `address_id` smallint(20) DEFAULT NULL,
    `active` tinyint(11) DEFAULT NULL,
    `create_date` datetime(6) DEFAULT NULL,
	`last_update` timestamp(6) DEFAULT NULL,
    CONSTRAINT PRIMARY KEY (customer_id) 
    );
  
   -- 4.3 Insert the non active users in the table _backup table_
   Insert into customer_demo(customer_id, store_id, first_name, last_name, email, address_id, active, create_date, last_update) values
	(16, 2, 'SANDRA', 'MARTIN', 'SANDRA.MARTIN@sakilacustomer.org', 20, 0, 060214, 060215),
    (64, 2, 'JUDITH', 'COX', 'JUDITH.COX@sakilacustomer.org', 68, 0, 060214, 060215),
	(124, 1, 'SHEILA', 'WELLS', 'SHEILA.WELLS@sakilacustomer.org', 128, 0, 060214, 060215),
	(169, 2, 'ERICA', 'MATTHEWS', 'ERICA.MATTHEWS@sakilacustomer.org', 173, 0, 060214, 060215),
	(241, 2, 'HEIDI', 'LARSON', 'HEIDI.LARSON@sakilacustomer.org', 245, 0, 060214, 060215),
	(271, 1, 'PENNY', 'NEAL', 'PENNY.NEAL@sakilacustomer.org', 276, 0, 060214, 060215),
	(315, 2, 'KENNETH', 'GOODEN', 'KENNETH.GOODEN@sakilacustomer.org', 320, 0, 060214, 060215),
	(368, 1, 'HARRY', 'ARCE', 'HARRY.ARCE@sakilacustomer.org', 373, 0, 060214, 060215),
	(406, 1, 'NATHAN', 'RUNYON', 'NATHAN.RUNYON@sakilacustomer.org', 411, 0, 060214, 060215),
	(446, 2, 'THEODORE', 'CULP', 'THEODORE.CULP@sakilacustomer.org', 451, 0, 060214, 060215),
	(482, 1, 'MAURICE', 'CRAWLEY', 'MAURICE.CRAWLEY@sakilacustomer.org', 487, 0, 060214, 060215),
	(510, 2, 'BEN', 'EASTER', 'BEN.EASTER@sakilacustomer.org', 515, 0, 060214, 060215),
	(534, 1, 'CHRISTIAN', 'JUNG', 'CHRISTIAN.JUNG@sakilacustomer.org', 540, 0, 060214, 060215),
	(558, 1, 'JIMMIE', 'EGGLESTON', 'JIMMIE.EGGLESTON@sakilacustomer.org', 564, 0, 060214, 060215),
	(592, 1, 'TERRANCE', 'ROUSH', 'TERRANCE.ROUSH@sakilacustomer.org', 598, 0, 060214, 060215);


   -- 4.4 Delete the non active users from the table _customer_
   select * from customer;
   
   delete from customer where active = 0;
   
   
   
   