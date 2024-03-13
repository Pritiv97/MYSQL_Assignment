-- SET 1

-- 1. create a database called 'assignment' (Note please do the assignment tasks in this database) --

create database assignment;

-- 2. Create the tables from ConsolidatedTables.sql and enter the records as specified in it --

use assignment;

-- 3. Create a table called countries with the following columns --
-- name, population, capital  
-- choose appropriate datatypes for the columns

create table countries  
(
name varchar(25) unique,
population int,
capital varchar(25) 
);

-- a) Insert the following data into the table --

Insert Into countries values('China',1382,'Beijing');
Insert Into countries values('India',1326,'Delhi');
Insert Into countries values('United States',324,'Washington D.C.');
Insert Into countries values('Indonesia',260,'Jakarta');
Insert Into countries values('Brazil',1382,'Brasilia');
Insert Into countries values('Pakistan',193,'Islamabad');
Insert Into countries values('Nigeria',187,'Abuja');
Insert Into countries values('Bangladesh',163,'Dhaka');
Insert Into countries values('Russia',143,'Moscow');
Insert Into countries values('Mexico',128,'Mexico City');
Insert Into countries values('Japan',126,'Tokyo');
Insert Into countries values('Philippines',102,'Manila');
Insert Into countries values('Ethiopia',101,'Addis Ababa');
Insert Into countries values('Vietnam',94,'Hanoi');
Insert Into countries values('Egypt',93,'Cairo');
Insert Into countries values('Germany',81,'Berlin');
Insert Into countries values('Iran',80,'Tehran');
Insert Into countries values('Turkey',79,'Ankara');
Insert Into countries values('Congo',79,'Kinshasa');
Insert Into countries values('France',64,'Paris');
Insert Into countries values('United Kingdom',65,'London');
Insert Into countries values('Italy',60,'Rome');
Insert Into countries values('South Africa',55,'Pretoria');
Insert Into countries values('Myanmar',54,'Naypyidaw');

-- b) Add a couple of countries of your choice --

Insert Into countries values('South Korea',51,'Seoul');
Insert Into countries values('Colombia',46,'Bogota');
Insert Into countries values('Spain',46,'Madrid');
Insert Into countries values('Uganda',45,'Kampala');

-- c) Change ‘Delhi' to ‘New Delhi' --

Update countries
set capital ='New Delhi'
where name = 'India' and population =1326;

-- 4. Rename the table countries to big_countries --

ALTER TABLE countries
RENAME TO big_countries;

-- 5. Create the following tables. Use auto increment wherever applicable --
-- a. Product
-- product_id - primary key
-- product_name - cannot be null and only unique values are allowed
-- description
-- supplier_id - foreign key of supplier table

create table product
	(
     product_id int primary key auto_increment,
     product_name varchar(30) unique not null,
     description varchar(500),
     supplier_id int
     );
     
alter table product
	auto_increment = 100;
    
create table Suppliers
(
supplier_id int primary key auto_increment,
supplier_name varchar(25),
location varchar(30)
);

alter table Suppliers
    auto_increment=1000;
    
create table stock
	(
     id int primary key auto_increment,
     product_id int,
     balance_stock int,
     foreign key(product_id)
		references product(product_id)
        on delete set null
	 );
     
alter table stock
	auto_increment=2000;
    
    
Alter table product
	add foreign key (supplier_id)
		references suppliers(supplier_id)
        on delete cascade;
        
        
-- 6. Enter some records into the three tables. --

Insert Into product values(101,'Laptop','A laptop computer, sometimes called a notebook computer by manufactures, is a battery- or AC -powered personal computer',Null);
Insert Into product values(102,'Mobile', 'A mobile phone, portable device for connecting to a telecommunications network in order to transmit and receive voice, etc.',Null);
Insert Into product values(103,'Watch','A watch is a portable timepiece intended to be carried or worn by a person.',Null);
Insert Into product values(104,'Headphone','A Headphones are a pair of padded speakers which you wear over your ears in order to listen to a recorded music.',Null );

Insert Into suppliers values(1001,'HP','United States');
Insert Into suppliers values(1002,'Oneplus','China');
Insert Into suppliers values(1003,'MI','China');
Insert Into suppliers values(1004,'RealMe','China');

select * from product;
select * from suppliers;

update product 
set supplier_id= case product_name 
when 'Laptop' then 1001 
when 'Mobile' then 1002
when 'Watch' then 1003
when 'Headphone' then 1004
end
   where product_name IN('Laptop','Mobile','Watch','Headphone');
					
                   
                    
Insert Into stock values(1,101,205);
Insert Into stock values(3,103,567);
Insert Into stock values(4,104,45);
Insert Into stock values(2,102,156);
 
 select * from suppliers;
 
-- 7. Modify the supplier table to make supplier name unique and not null --
 
 Alter table suppliers 
 modify supplier_name varchar(25) unique not null;
 
-- 8. Modify the emp table as follows --

-- a.Add a column called deptno

Alter table emp 
add column deptno int after hire_date;

-- b. b. Set the value of deptno in the following order

-- deptno = 20 where emp_id is divisible by 2
-- deptno = 30 where emp_id is divisible by 3
-- deptno = 40 where emp_id is divisible by 4
-- deptno = 50 where emp_id is divisible by 5
-- deptno = 10 for the remaining records.

Alter table emp
rename column emp_no to emp_id;

Update emp 
set dept_-no=
          case
 when emp_id % 2 = 0 Then 20
 when emp_id % 3 = 0 Then 30
 when emp_id % 4 = 0 Then 40
 when emp_id % 5 = 0 Then 50
 ELSE 10 
 End;
 
 -- 9. Create a unique index on the emp_id column --
 
 create unique index emp_id_unique
 on emp(emp_id);
 
-- 10.Create a view called emp_sal on the emp table by selecting the following fields in the order of highest salary to the lowest salary --

-- emp_no, first_name, last_name, salary

create view emp_view
as
select emp_no,
concat('first_name',' ','last_name') as employee,
salary from emp order by salary desc;

select * from emp_sal;




 
 

