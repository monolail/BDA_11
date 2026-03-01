## Cross Join
## 모든 경우의 수를 다 구한다.

select * from customers_sp;

select * from products_sp;

## cross join을 통해서 -> 실제 구매가 된 것과 구매하지 않은 미구매에 대한 것을 확인하고, 구매수량을 체크하는 쿼리alter

Select 
	*
From customers_sp as c
cross join products_sp as p;

## cross join은 보이지 않은 것으 보게 해주는 기회를 우리에게 열어주는 개념
## 일반 inner join은 팔린 것만 보여준다. => '지영이가 청바지를 구매했다.' 만 가능
## cross join은 지영이는 청바지는 샀지만, 모니터와 키보드는 사지 않았다. 

## inner join을 바라보면 유저가 구매한 것만 보여주고 끝난다.
## 하지만 cross join을 하면, 마우스랑 키보드를 사지 않았음에도 분석을 위한 포인트로 넘어갈 수 있다.alter

## 서브쿼리 (subquery)
## join과의 차이 -> join은 테이블 옆으로 붙이는 느낌, 서브쿼리는 질문안에 질문을 삼는 느낌
## 대표적인 where 사용하는 where 절의 서브쿼리alter
## 질문 속에 질문이 있다.alter

## 하나의 SQL문 (Main Query) -> 그 안의 포함된 또 다른 SQL문 (Subquery)
# () 소괄호로 보통 감싸져 있따.alter
# 작동원리
# 안쪽(subquery) 먼저 실행되어 결과를 내놓는다.
# 바깥쪽(main query) 그 결과를 받아서 -> 최종 실행을 한다.alter
## 반 평균 점수보다 높은 사람은 누구인가? => 1. 반평균, 2. 평균보다 높은 사람

## 우리반 전체 테이블
## 반평균을 구할 수 없다.
## select name, score from st
## where score >= 반평균
## 반평균이라는 것도 -> 결국 쿼리를 통해 값을 만들어야한다.

Select 
	name,
	score
from studnet
where score > (select avg(score) from student);

## 평균보다 비싼 프러덕트를 출력하라.
## 평균 -> 50000 -> where price > 50000

select avg(unit_price) from products_sp;

select * from products_sp
where unit_price > (select avg(unit_price) from products_sp);

## payment_method 현금을 결제한 고객의 이름과 아이디와 등급을 알고 싶다.alter


Select * from customers_sp;
Select * from orders_sp;

select o.customer_id, c.customer_name,c.customer_grade from orders_sp as o
inner join customers_sp as c
on o.customer_id = c.customer_id
where o.payment_method = "현금";

## 서브쿼리를 이용해서 접근을 해보자!

Select 
	customer_id, customer_name, customer_grade
    from customers_sp
where customer_id in (select customer_id
	from orders_sp
    where payment_method = "현금"); -- 필터링을 해주면 그게 결국에는 현글 결제한 사람만 가지고 오는 것!

## sql where 절이 있는데 -> 내부에 중첩 되어 존재한다. -> 중첩 쿼리
## 서브쿼리는 why -> 데이터가 변해도 쿼리가 계속 살아남게 만드는 것alter
## subquery
## 단일행 서브쿼리 (single row)
## avg 평균 값 1개 -> 빅 할 값이 하나의 값이면 된다.
## 단일행 서브쿼리는 하나의 값만 나온다. 평균 , 전체 썸, 카운트 등
## 비교하는 연산자가 다르다. = < > >= <= <> 단일 값 비교 연산자

## 다중해 서비쿼리 (multi - row)
## 하나의 값이 아니라 여러 개의 값이 나올 때 말한다.
## 비교하는 연산자가 다르다.
## 집합연산자 -> in, not in, any , all