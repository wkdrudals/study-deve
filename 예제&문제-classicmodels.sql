use classicmodels;

show tables;
# 전체 데이터 조회
select * from customers;
# count : 데이터 수를 알 수 있다.
select count(*)from customers;
# 5개 데이터만 보기
select * from customers limit 5;
# 특정 컬럼 조회
select customerName
	 , phone
	 , addressLine1
	 , city 
from customers
;

# 컬럼명 변경
select 
	   customerName as cust_name
	 , phone 		as cust_phone
	 , addressLine1 as cust_address
	 , city 		as cust_city
from customers
;


# 하나의 조건 추가
select 
	   customerName as cust_name
	 , phone 		as cust_phone
	 , addressLine1 as cust_address
	 , city 		as cust_city
from customers
where 1=1 # 항상 참인 조건 적용
  and (city = 'NYC' or city = 'Las Vegas')
;

select 
	   customerName as cust_name
	 , phone 		as cust_phone
	 , addressLine1 as cust_address
	 , city 		as cust_city
from customers
where 1=1 # 항상 참인 조건 적용
  and (city = 'NYC' or city = 'Las Vegas')
  and customerName like 'M%'
;

###########문제##################
select * from employees;

select 
	 lastName  as empl_lastName
   , firstName as empl_firstName
   , email as empl_email
   , officecode as empl_officecode
from employees
where 1=1 # 항상 참인 조건 적용
  and (officecode = 1 or officecode = 2)
  and lastName like 'B%'
;

