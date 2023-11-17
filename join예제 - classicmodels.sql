use classicmodels;

show tables;

# customers table and order table join
select 
	  t1.customerNumber # join할 컬럼
    , t1.customerName
    , t1.phone
    , t1.addressLine1  
from customers t1;

select 
	  t2.orderNumber
	, t2.orderDate
	, t2.status 
	, t2.customerNumber # join할 컬럼
from orders t2;

# 첫번째 join 방법
# -> 전체 고객들 중에서 주문을 한 고객들의 주문정보 및 고객정보 조회
# df1, df2
# pd.merge(df1[[customerNumber,customerName,phone]]
#	,df2[[customerNumber,customerName,phone]]
#	, on='customerNumber', how='inner')
select 
	  t1.customerNumber # join할 컬럼
    , t1.customerName
    , t1.phone
    , t1.addressLine1  
	, t2.orderNumber
	, t2.orderDate
	, t2.status 
from customers as t1 inner join orders as t2
on t1.customerNumber = t2.customerNumber 
;

# 전체 고객의 수? -> 122
select count(*) from customers;
# 전체 주문의 수? -> 326
select count(*) from orders;
# 주문을 한 고객의 수?
# -> 유니크한 고객 리스트 조회 df['customerNumber].unique();
select customerNumber from orders group by customerNumber;
# -> df['customerNumber].value_count();
select customerNumber, count(customerNumber) 
from orders group by customerNumber;
# -> 유니크한 고객 수 df['customerNumber].nunique();
select count(t1.customerNumber) from(
	select customerNumber, count(customerNumber) 
	from orders group by customerNumber
) t1;

# -> df[df['customerNumber'] > 110]
select * from customers 
where 1=1 
and customerNumber > 110;

# -> df[df['customerNumber'] > 110 & df['customerNumber'] < 130]
select * from customers 
where 1=1 
and customerNumber > 110
and customerNumber < 130;








