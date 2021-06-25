use sakila;

-- 1. Drop column `picture` from `staff`.
alter table staff
drop column picture;

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
select * from staff;

insert into staff values (3, 'Tammy', 'Sanders', 5 , 'Tammy.Sanders@sakilastaff.com', 2, 1, 'Tammy', ' ', now());

-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the `rental_date` column in the `rental` table.
   -- **Hint**: Check the columns in the table rental and see what information you would need to add there. 
   -- You can query those pieces of information. 
   -- For eg., you would notice that you need `customer_id` information as well.
   -- To get that you can use the following query:
select * from rental;
select inventory_id from inventory;
-- select customer_id from sakila.customer
-- where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
-- Use similar method to get `inventory_id`, `film_id`, and `staff_id`.
insert into rental values (16050, now(), 4581, 130, (CURDATE()+1), 2, now()); 

-- 4. Delete non-active users, but first, create a _backup table_ `deleted_users` to store `customer_id`, `email`, and the `date` for the users that would be deleted. Follow these steps:

   -- 4.1 Check if there are any non-active users
select * from customer
where active = 0;
   -- 4.2 Create a table _backup table_ as suggested
drop table if exists deleted_users; 
create table deleted_users (
	customer_id int(22) unique not null,
    email varchar(50) default null,
    datee date not null,
    constraint primary key (customer_id)
    ); 
   -- 4.3 Insert the non active users in the table _backup table_
INSERT INTO deleted_users (customer_id, email, datee)
SELECT customer_id, email, last_update FROM customer
WHERE active = 0;

update deleted_users
set datee = now()
where datee = '2006-02-15';

select * from deleted_users;
   -- 4.4 Delete the non active users from the table _customer_
select * from customer;

DELETE FROM customer
WHERE EXISTS
  (SELECT customer_id, email, datee
   FROM deleted_users);

-- I couldn't find the solution for the last question because I have a problem with a foreign key