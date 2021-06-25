-- 1. Drop column `picture` from `staff`.
alter table sakila.staff
drop column picture;
select * from sakila.staff;

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
insert into sakila.staff
values (3, 'Tammy', 'Sanders', 5, 'tammy.sanders@sakilastaff.com', 2, 1, 'Tammy', '8cb2237d0679ca88db6464eac60da96345513964', now());
select * from sakila.staff;

-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the `rental_date` column in the `rental` table.
   -- **Hint**: Check the columns in the table rental and see what information you would need to add there. 
   -- You can query those pieces of information. 
   -- For eg., you would notice that you need `customer_id` information as well.
   -- To get that you can use the following query:
   select * from sakila.rental;
   insert into sakila.rental
   values(16050, now(), 9, 130, null, 1, now());
select * from sakila.rental
order by rental_id desc;

    -- Use similar method to get `inventory_id`, `film_id`, and `staff_id`.
select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';

select inventory_id from sakila.inventory
where film_id = 1;

select film_id from sakila.film
where title = 'Academy Dinosaur';

select staff_id from sakila.staff
where store_id = 1;

-- 4. Delete non-active users, but first, create a _backup table_ `deleted_users` to store `customer_id`, `email`, and the `date` for the users that would be deleted. Follow these steps:

   -- 4.1 Check if there are any non-active users
   select *
   from sakila.customer
   where active = 0;
   -- There are 15 non active customers
   
   -- 4.2 Create a table _backup table_ as suggested
   drop table if exists deleted_users;
   create table deleted_users (
   customer_id int(22) unique not null,
   email varchar(50) default null,
   deletion_date date not null,
   constraint primary key (customer_id),
   constraint foreign key (email) references sakila.customer(email)
   ) ;
   -- what am I doing wrong here ? Cannot understand the below error message:
-- Referencing column 'email_id' and referenced column 'email' in foreign key constraint 'deleted_users_ibfk_1' are incompatible.

   
   -- 4.3 Insert the non active users in the table _backup table_
   
   -- 4.4 Delete the non active users from the table _customer_