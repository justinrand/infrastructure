DROP DATABASE IF EXISTS ARTIFICIAL_LOAD;
CREATE DATABASE ARTIFICIAL_LOAD
  DEFAULT CHARACTER SET utf8
  DEFAULT COLLATE utf8_general_ci;

USE ARTIFICIAL_LOAD;

create table EMP (
  id INT,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  email VARCHAR(50),
  gender VARCHAR(50),
  bio TEXT,
  department VARCHAR(50),
  city VARCHAR(50),
  mobile VARCHAR(50),
  birth_day DATE
);
insert into EMP (id, first_name, last_name, email, gender, bio, department, city, mobile, birth_day) values (1, 'Maison', 'Loud', 'mloud0@facebook.com', 'Male', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl.', 'Training', 'Lomma', '522-359-2885', '1972-06-24 07:19:27');

select * from EMP where bio like '%lorem%';
select * from EMP where bio like '%massa%';
select * from EMP where bio like '%odio%';
select * from EMP where bio like '%eu%eu%';
select * from EMP where bio like '%eu%lorem%';
select * from EMP where bio like '%eget%';
select * from EMP where bio like '%id%lorem%';
select * from EMP where bio like '%in&ac%';
select * from EMP where bio like '%est%nisi%';
select * from EMP where bio like '%in&ac%';
select * from EMP where bio like '%amet%sapien%';
DROP DATABASE ARTIFICIAL_LOAD;
