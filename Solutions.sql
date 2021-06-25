use sakila;

-- 1. Drop column `picture` from `staff`.
alter table staff
drop column picture;

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
select *
from customer
where first_name = 'TAMMY' and last_name = 'SANDERS';

select*
from staff
limit 5;

insert into staff
values (3,'Tammy','Sanders',79,'Tammy.Sanders@sakilastaff.com',2,1,'Tammy','8cb2237d0679ca88db6464eac60da96345513964', '2021-06-25 19:01:20');

update customer
set email = 'TAMMY.SANDERS@sakilastaff.com', last_update = '2021-06-25 19:03:20'
where customer_id = 75;

-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the `rental_date` column in the `rental` table.
select * from rental
order by rental_id desc
limit 1;

select customer_id from customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';

select film_id from film
where title = 'Academy Dinosaur';

select *
from inventory
where film_id = 1 and store_id = 1;

select *
from staff
where first_name = 'Mike';

   -- **Hint**: Check the columns in the table rental and see what information you would need to add there. 
   -- You can query those pieces of information. 
   -- For eg., you would notice that you need `customer_id` information as well.
   -- To get that you can use the following query:
	-- Use similar method to get `inventory_id`, `film_id`, and `staff_id`.		

insert into rental
values (16050, now(), 1, 130, null, 1, now());

-- 4. Delete non-active users, but first, create a _backup table_ `deleted_users` to store `customer_id`, `email`, and the `date` for the users that would be deleted. Follow these steps:

   -- 4.1 Check if there are any non-active users
select *
from customer
where active = 0
limit 100;

   -- 4.2 Create a table _backup table_ as suggested
drop table if exists deleted_users;   

CREATE TABLE deleted_users(
  customer_id int(11) UNIQUE NOT NULL,
  email varchar(255) DEFAULT NULL,
  date_deleted date DEFAULT NULL,
  CONSTRAINT PRIMARY KEY (customer_id)
);

   -- 4.3 Insert the non active users in the table _backup table_
insert into deleted_users (customer_id, email, date_deleted)
select customer_id, email, date(now())
from customer
where active = 0;

   -- 4.4 Delete the non active users from the table _customer_
SET SQL_SAFE_UPDATES = 0;

delete from customer
where active = 0;
-- not possible because of a foreign key constrain, alternative: deleting payment data for  fk_payment_customer / customer_id with active = 0 but not really realistic
