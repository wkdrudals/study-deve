# DDL 
# database 목록 조회
show databases;
# database 선택(사용)
use mysql;
use sys;

# database 생성하기
create database dbname;
show databases;
use dbname;

# database 삭제
drop database dbname;
show databases;
# dbname이 없을 때, 실행하면 오류발생
drop database dbname;
# 만약에 dbname이 존재한다면, 삭제해달라는 명령어
drop database if exists dbname;


###########
# dbname 데이터베이스에서 실행
# tabale 생성
create table student(
	student_id int comment '학생아이디', 
	student_name varchar(10) comment '학생이름',
	student_address varchar(50) comment '학생집주소',
	primary key(student_id)
);
commit; # database 시스템에 적용완료됨
# table들 조회
show tables;
# 특정 table의 자세한 정보 조회
desc student;
# 새로운 컬럼 추가
alter table student add column student_age int not null;
commit;
desc student;
# 기존 컬럼의 데이터 타입 변경
alter table student modify column student_address varchar(30) not null;
commit;
desc student;
# 컬럼 삭제
alter table student_info drop column student_age;
desc student_info ;
# table 삭제
drop  table if exists student_info;
show tables;

########
# database create
create database info;
show databases;
use info;

# create table
create table class_info(
	class_id int not null comment '수강아이디',
	student_name varchar(10) not null comment '학생이름',
	subject_name varchar(30) not null comment '과목명',
	primary key(class_id)
);
commit;
desc class_info;
drop database if exists info;
show databases;

use dbname;
drop table class_info ;

# 학생 student
create table student (
	student_id INT UNSIGNED auto_increment COMMENT '학생아이디',
	student_name varchar(10) not null COMMENT '학생이름',
	student_address varchar(50) null COMMENT '학생집주소',
	create_dt TIMESTAMP not null default now() COMMENT '생성일자',
	modify_dt TIMESTAMP not null default now() COMMENT '수정일자',
	PRIMARY KEY(student_id)
);
commit;

# 교수 professor
create table professor (
	professor_id INT UNSIGNED auto_increment COMMENT '교수아이디',
	professor_name varchar(10) not null COMMENT '교수이름',
	create_dt TIMESTAMP not null default now() COMMENT '생성일자',
	modify_dt TIMESTAMP not null default now() COMMENT '수정일자',
	PRIMARY KEY(professor_id)
);
commit;

# 과목 subject
create table subject (
	subject_cd varchar(10) COMMENT '과목코드',
	subject_name varchar(10) not null unique COMMENT '과목명',
	subject_desc text COMMENT '과목설명',
	professor_id INT unsigned not null COMMENT '교수아이디',
	create_dt TIMESTAMP not null default now() COMMENT '생성일자',
	modify_dt TIMESTAMP not null default now() COMMENT '수정일자',
	PRIMARY KEY(subject_cd),
	FOREIGN KEY (professor_id) REFERENCES professor(professor_id) ON UPDATE CASCADE
);
commit;

# 수강신청 enrolment
create table enrolment (
	enrolment_id INT UNSIGNED auto_increment COMMENT '수강신청아이디',
	semester varchar(10) not null COMMENT '학기',
	student_id INT unsigned not null COMMENT '학생아이디',
	subject_cd varchar(10) not null COMMENT '과목코드',
	create_dt TIMESTAMP not null default now() COMMENT '생성일자',
	modify_dt TIMESTAMP not null default now() COMMENT '수정일자',
	PRIMARY KEY(enrolment_id),
	FOREIGN KEY (student_id) REFERENCES student(student_id) ON UPDATE cascade,
	FOREIGN KEY (subject_cd) REFERENCES subject(subject_cd) ON UPDATE CASCADE
);
commit;

##############################################################################






