use classicmodels;

show tables;

select * from orders;

# 문제1) orders 테이블에서 Shipped 상태인 값들은?
select count(*) as count 
from orders
where 1=1
	and status = 'Shipped';

# 문제2) orderDate(주문날짜) 기준으로 1월달 전체 주문수량은?
# -> 1월달 전체 뜻은 -> 2월보다 작은 날짜들

# 1번째 문제풀이 방법
select 
	count(*) as order_cnt
from orders 
where 1=1
	and orderDate < '2003-02-01'
	and orderDate >= '2003-01-01'
;

# 2번째 문제풀이 방법
select 
	count(t1.orderNumber) as `2003-01_cnt`
from orders t1
where 1=1
	and t1.orderDate < '2003-02-01'
	and t1.orderDate >= '2003-01-01'
;


# 문제3) 요청일 기준 3월닫 중에서 customerNumber가 가장 큰 숫자는?
select * from orders;

select max(customerNumber) from orders 
where 1=1
	and orderDate < '2003-04-01'
	and orderDate >= '2003-03-01'
;



# 문제4) 요청일 기준 3~5월달 중에서 Shipped, In Process인 수량은?
select 
	count(*) as `03-05_Shipped,In Process_cnt`
from orders 
where 1=1
	and orderDate < '2003-06-01'
	and orderDate >= '2003-03-01'
	and (status = 'Shipped' or status = 'In process')
;

## 기간부터 계산하면 쿼리계산이 느려진다. / = 조건이 있다면, = 이 먼저와야 계산이 빨라진다.
select 
	count(*) as `03-05_Shipped,In Process_cnt`
from orders 
where 1=1
	and (status = 'Shipped' or status = 'In process')
	and orderDate < '2003-06-01'
	and orderDate >= '2003-03-01'
;

# 문제5) Shipped, Resolved, Cancelled인 경우에 속하는 고객 수

select * from orders;

select 
	count(customerNumber) as `s,r,c_cust_cnt`
	
from orders 
where 1=1
	and (status = 'Shipped' or status = 'Resolved' or status = 'Cancelled')
;


# 문제6) shipped(배송완료)된 주문 정보(orderdetails)를 order by orderNumber, orderLineNumber 정렬

select * from orders;
select * from orderdetails;

select 
	t1.orderNumber
  , t1.shippedDate 
  , t1.comments
  , t1.status 
from orders t1
;

select 
	t2.orderNumber
  , t2.orderLineNumber
  , t2.quantityOrdered
from orderdetails t2
;

select 
	t1.orderNumber
  , t1.shippedDate 
  , t1.comments
  , t1.status 
  , t2.orderNumber
  , t2.orderLineNumber
  , t2.quantityOrdered
from  orders t1 inner join orderdetails t2
on t1.orderNumber = t2.orderNumber
where 1=1
	and t1.status = 'Shipped'
order by t2.orderNumber, t2.orderLineNumber
;


###
select 
	t2.*
from orders t1 inner join orderdetails t2
   on t1.orderNumber = t2.orderNumber 
where 1=1
  and t1.status = 'Shipped'
order by t2.orderNumber, t2.orderLineNumber 
;

# 두번째 방법 
select 
	t2.*
from orders t1, orderdetails t2
where 1=1
  and t1.status = 'Shipped'
  and t1.orderNumber = t2.orderNumber
order by t2.orderNumber, t2.orderLineNumber 
;

###

# 문제7) shipped(배송완료)된 주문 정보(orderdetails)를 orderNumber별 주문 수량

select * from orderdetails;

select 
	t2.orderNumber, count(t2.orderLineNumber)
from orders t1, orderdetails t2
where 1=1
  and t1.status = 'Shipped'
  and t1.orderNumber = t2.orderNumber
group by orderNumber # o
rderNumber를 기준으로 통계값을 뽑기 
;

## 2번째 방법
select 
	t2.orderNumber, max(t2.orderLineNumber)
from orders t1, orderdetails t2
where 1=1
  and t1.status = 'Shipped'
  and t1.orderNumber = t2.orderNumber
group by orderNumber # orderNumber를 기준으로 통계값을 뽑기 
;

# 세번째 방법 
select 
	t2.*
from ( 
	select * from orders
	where 1=1
	and status = 'Shipped'
) t1 inner join orderdetails t2
   on t1.orderNumber = t2.orderNumber 
where 1=1
order by t2.orderNumber, t2.orderLineNumber 
;

# 문제8) Shipped, Resolved, Cancelled인 경우에서 주문별(orderNumber) 총 금액이 큰 순서로 정렬

select * from orders;
select * from orderdetails;

select 
	t2.orderNumber, sum(t2.priceEach) as sum_price
from orders as t1 inner join orderdetails as t2
on t1.orderNumber =  t2.orderNumber 
where 1=1
	and (t1.status = 'Shipped' or t1.status = 'Resolved' or t1.status = 'Cancelled')
group by t2.orderNumber 
order by sum_price desc 
;




# 문제9) Shipped, Resolved, Cancelled인 경우이면서 주문수가 5개 이상인 경우에서 주문별(orderNumber) 총 금액이 큰 city 순서로 정렬

select 
	t1.city 
	, t3.order_sum
from customers t1,
(
	select 
		orderNumber
		, customerNumber 
	from orders
	where 1=1
	# Shipped, Resolved, Cancelled인 경우이면서
	and status in ('Shipped', 'Resolved', 'Cancelled') 
) t2, 
(
	select 
		orderNumber
		, count(orderLineNumber) as order_cnt
		# 주문별(orderNumber) 총 금액이
		, sum(quantityOrdered * priceEach) as order_sum
	from orderdetails
	where 1=1
	group by orderNumber
	# 주문수가 5개 이상인 경우에서
	HAVING order_cnt >= 5
) t3
where 1=1
and t1.customerNumber = t2.customerNumber
and t2.orderNumber = t3.orderNumber
# 총 금액이 큰 city 순서로 정렬하자
order by t3.order_sum desc
;


