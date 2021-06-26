-- 1. Drop column `picture` from `staff`.
use sakila;
alter table staff
drop column picture;
-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
select * from staff
limit 10;

select *
from customer
where first_name = 'TAMMY' and last_name ='SANDERS';

insert into staff
values (2, 'Tammy', 'Sanders', 79, 'Tammy.Sanders@sakilastaff.com',2,1,'Tammy','8cb2237d0679ca88db6464eac60da96345513964', '2021-06-25 22:11:20');
select * from staff;

-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the `rental_date` column in the `rental` table.
  select customer_id from customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';

select *
from staff
where first_name = 'Tammy'; -- Mike does not exist in my database, I used new worker Tammy

select film_id from film
where title = 'Academy Dinosaur';

select *
from inventory
where film_id = 1 and store_id = 1;

  -- **Hint**: Check the columns in the table rental and see what information you would need to add there. 
   select *from rental;
   select count(*) from rental; -- next entry 16045, but all primary key until 16049 exist, so next ID 16050
   -- is there a way just to add at the end and insert at the end with new ID / index)?
  
  -- You can query those pieces of information. 
insert into rental
values (16050, now(), 1, 130, null, 2, now());


-- 4. Delete non-active users, but first, create a _backup table_ `deleted_users` to store `customer_id`, `email`, and the `date` for the users that would be deleted. Follow these steps:

   -- 4.1 Check if there are any non-active users
   select count(*)
   from customer
   where active = 0;
   select *
   from customer
   where active = 0;
   -- 4.2 Create a table _backup table_ as suggested
   drop table if exists _backuptable_;
CREATE TABLE _backuptable_(
customer_id int(11) UNIQUE NOT NULL,
email varchar(255) DEFAULT NULL,
CONSTRAINT PRIMARY KEY (customer_id)
);
-- Can you see the backup table in the Schemas or how to check if it worked?

   -- 4.3 Insert the non active users in the table _backup table_
insert into _backuptable_(customer_id, email)
select customer_id, email
from customer
where active = 0;
-- check:
select * from _backuptable_;
   -- 4.4 Delete the non active users from the table _customer_
SET SQL_SAFE_UPDATES = 0;
delete from customer
where active = 0; -- Error 1451: Cannot delete or update a parent row: A foreign key constraint failed....