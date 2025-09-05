create database protect;
use protect;

CREATE TABLE Users (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100)
);

CREATE TABLE Books (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(100),
  author VARCHAR(100)
);

CREATE TABLE Rentals (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED,
  book_id BIGINT UNSIGNED,
  rental_date DATE,
  FOREIGN KEY (user_id) REFERENCES Users(id),
  FOREIGN KEY (book_id) REFERENCES Books(id)
);

INSERT INTO Users (name, email) VALUES 
('Alice', 'alice@email.com'),
('Bob', 'bob@email.com'),
('Charlie', 'charlie@email.com');

INSERT INTO Books (title, author) VALUES 
('SQL 기초', '김데이터'),
('파이썬 마스터', '박개발'),
('알고리즘 여행', '이알고');

INSERT INTO Rentals (user_id, book_id, rental_date) VALUES 
(1, 2, '2024-07-01'), 
(1, 3, '2024-07-02'), 
(2, 1, '2024-07-03');

select * from rentals;
select * from books;
select * from users;
-- *Alice가 대여한 책의 제목과 저자를 모두 출력하시오.*
select b.title,b.author from rentals r join users u 
on r.user_id = u.id join books b on r.book_id = b.id
where u.name='Alice';


-- ✅ 문제 1: 온라인 영화 스트리밍 서비스

-- 📋 요구사항
-- 사용자(User)는 이름, 이메일을 가진다.
-- 영화(Movie)는 제목, 장르, 제작연도를 가진다.
-- 사용자는 여러 편의 영화를 즐겨찾기(Favorite)로 등록할 수 있다.
-- 즐겨찾기에는 등록한 날짜도 기록된다.
create table tbl_user( 
id bigint unsigned auto_increment primary key,
user_name varchar (255) not null,
user_email varchar (255) not null
);
create table tbl_movie(
id bigint unsigned auto_increment primary key,
movie_title varchar (255) not null,
movie_genre varchar (255) not null,
movie_production_year year not null
);
create table tbl_favorite(
id bigint unsigned auto_increment primary key,
favorite_registration_date date not null,
movie_id bigint unsigned,
user_id bigint unsigned,
constraint fk_favorite_movie foreign key(movie_id)
references tbl_movie(id),
constraint fk_favorite_user foreign key(user_id)
references tbl_user(id)
);


-- ❓ 문제
-- 2024년에 즐겨찾기로 등록한 영화의 제목과
-- 그 영화를 등록한 사용자의 이름을 출력하는 SQL 쿼리를 작성하세요.
insert into tbl_user 
(user_name,user_email)
values('홍길동','abc@naver.com');
insert into tbl_user 
(user_name,user_email)
values('김기성','ab24c@naver.com');
insert into tbl_user 
(user_name,user_email)
values('류현진','a66bc@naver.com');

select * from tbl_user ;
insert into tbl_movie 
(movie_title,movie_genre,movie_production_year)
values('영화3','도박',2024);
insert into tbl_movie 
(movie_title,movie_genre,movie_production_year)
values('영화1','개그',2000);
insert into tbl_movie 
(movie_title,movie_genre,movie_production_year)
values('영화2','무협',2017);
select * from tbl_movie ;
select * from tbl_favorite;
insert into tbl_favorite 
(favorite_registration_date,user_id,movie_id)
values(20250603,1,2);
insert into tbl_favorite 
(favorite_registration_date,user_id,movie_id)
values(20220103,2,3);
insert into tbl_favorite 
(favorite_registration_date,user_id,movie_id)
values(20251103,3,1);
-- ❓ 문제
-- 2024년에 즐겨찾기로 등록한 영화의 제목과
-- 그 영화를 등록한 사용자의 이름을 출력하는 SQL 쿼리를 작성하세요.
select u.user_name,m.movie_title  from tbl_movie m 
join tbl_favorite f 
on m.id =f.movie_id 
join tbl_user u 
on u.id =f.user_id where year (f.favorite_registration_date) =2022;

-- ✅ 문제 2: 온라인 코스 플랫폼

-- 📋 요구사항
-- 학생(Student)은 이름과 연락처가 있다.
-- 강의(Course)는 제목과 가격이 있다.
-- 학생은 여러 개의 강의를 수강할 수 있으며, 수강 시작 날짜가 기록된다.
create table tbl_student(
id bigint unsigned auto_increment primary key,
student_name varchar (255) not null,
student_phone_number varchar (255)  not null
);

create table tbl_course(
id bigint unsigned auto_increment primary key,
course_name varchar (255) not null,
course_price int (255) not null,
course_strat_date date not null,
student_id bigint unsigned,
constraint fk_course_student foreign key(student_id)
references tbl_student(id)
);



-- ❓ 문제
-- 가격이 50,000원 이상인 강의를 수강한
-- 학생의 이름과 수강한 강의 제목을 출력하는 SQL 쿼리를 작성하세요.

insert into tbl_student 
(student_name ,student_phone_number)
values('둘리','01021924823');
insert into tbl_student 
(student_name ,student_phone_number)
values('또치','01045924823');
insert into tbl_student 
(student_name ,student_phone_number)
values('둘리','01014523432');
select *from tbl_student;
insert into tbl_course 
(course_name,course_price,course_strat_date,student_id)
values('국어',30000,20250703,1);
insert into tbl_course 
(course_name,course_price,course_strat_date,student_id)
values('수학',127000,20250701,2);
insert into tbl_course 
(course_name,course_price,course_strat_date,student_id)
values('과학',70000,20250603,3);

select * from tbl_course ;

select s.student_name,c.course_name  from tbl_course c join tbl_student s 
on s.id = c.student_id where  c.course_price >50000;

/* on 조건문에 and붙인거랑 where 이후 작성하는거랑 차이가없는데 내가 where 을잘못쓴건가?

3. 영화 대여 시스템
영화 대여 시스템을 관리하는 데이터베이스를 설계하라.

영화에는 제목, 감독, 장르, 개봉일, 가격 정보가 있다.

대여자는 이름, 연락처, 주소를 기록해야 하며, 한 사람이 여러 영화를 대여할 수 있다.

각 영화는 여러 대여자가 대여할 수 있다.

대여자는 영화 대여일과 반납일, 대여 기간에 대한 정보가 기록된다.

대여자는 한 번에 여러 개의 영화를 대여할 수 있으며, 반납 시기를 관리해야 한다.
*/
create table tbl_movie(
id bigint unsigned auto_increment primary key,
movie_title varchar (255) not null,
movie_supervision varchar (255) not null,
movie_genre varchar (255) not null,
movie_release_date date not null,
movie_price varchar (255) not null
);
select * from tbl_movie;
create table tbl_renter( 
id bigint unsigned auto_increment primary key,
renter_name varchar (255) not null,
renter_phone_number varchar(255) not null,
renter_address varchar (255) not null
);
create table tbl_rental(
id bigint unsigned auto_increment primary key,
rental_start_date date not null,
rental_finsh_date date not null,
rental_period int not null,
movie_state enum ('대여 가능' ,'대여중') default '대여중',
movie_id  bigint unsigned,
renter_id  bigint unsigned,
constraint fk_rental_movie foreign key(movie_id)
references tbl_movie(id),
constraint fk_rental_renter foreign key(renter_id)
references tbl_renter(id)
);



/*5. 병원 예약 시스템
병원 예약 시스템을 설계하라.

병원에는 여러 진료과목이 있고, 각 진료과목은 여러 의사가 담당한다.

환자는 이름, 나이, 연락처, 병원 방문 이유를 기록해야 하며, 여러 번 병원 예약을 할 수 있다.

각 예약은 환자의 진료과목, 의사, 예약 일자, 예약 상태(진료 예정/취소 등)를 기록한다.

진료 예약은 중복되지 않도록 예약 시간을 관리해야 한다.
*/


create table tbl_subject(
id bigint unsigned auto_increment primary key,
subject_name varchar (255) not null
);
create table tbl_docter(
id bigint unsigned auto_increment primary key,
docter_name varchar (255) not null,
subject_id bigint unsigned,
constraint fk_docter_subject foreign key(subject_id)
references tbl_subject(id)
);
create table tbl_patient(
id bigint unsigned auto_increment primary key,
patient_name varchar (255) not null,
patient_age int not null,
patient_phone_number varchar (255) not null,
patient_Reason varchar (255) not null
);
create table tbl_reservation(
reservation enum ('진료가능','불가'),
reservation_date date unique,
subject_id bigint unsigned,
docter_id bigint unsigned,
patient_id bigint unsigned,
constraint fk_reservation_subject foreign key(subject_id)
references tbl_subject(id),
constraint fk_reservation_docter foreign key(docter_id)
references tbl_docter(id),
constraint fk_reservation_patient foreign key(patient_id)
references tbl_patient(id)
);






