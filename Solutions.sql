-- 1. Drop column `picture` from `staff`.
use sakila;
ALTER TABLE staff
  DROP COLUMN picture;

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
Alter Table staff
	INSERT INTO staff ('staff_id', 'first_name', 'last_name', 'address_id', 'email', 'store_id', 'active', 'username','password', 'last_update') 
    VALUES (3, 'Tammy', 'Sanders', 79, 'Tammy.Sanders@sakilastaff.com', 2, 1, 'Tammy', NULL, 2006-02-15 04:57:20);

-- Why doesn't it work`?


-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the `rental_date` column in the `rental` table.
   -- **Hint**: Check the columns in the table rental and see what information you would need to add there. 
   -- You can query those pieces of information. 
   -- For eg., you would notice that you need `customer_id` information as well.
   -- To get that you can use the following query:

select * from film
where title = 'Academy Dinosaur';

select * from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';

-- customer id 130
-- film id 1
-- inventory 1001

select * from inventory;


select * from rental;
Insert into rental ('rental_id', 'rental_date', 'inventory_id', 'customer_id', 'return_date', 'staff_id', 'last_update')
values (1002, 2021-06-25 07:33:00, 1001, 130, 2021-06-26 12:00:00, 1, 2021-06-25 07:33:00);

-- Same as above: Why doesn't it work?


-- 4. Delete non-active users, but first, create a _backup table_ `deleted_users` to store `customer_id`, `email`, and the `date` for the users that would be deleted. Follow these steps:

   -- 4.1 Check if there are any non-active users
   
   select * from customer
   WHERE active = False;
   

   -- 4.2 Create a table _backup table_ as suggested
   drop table if exists deleted_users;
   create table deleted_users (
   customer_id int(22) unique not null,
   email varchar(50) default null,
   deletion_date date not null,
   constraint primary key (customer_id),
   constraint foreign key (email) references sakila.customer(email)
   ) ;

   
   -- 4.3 Insert the non active users in the table _backup table_
   
   
   -- 4.4 Delete the non active users from the table _customer_
   delete from customer
   where active = false;
   
   