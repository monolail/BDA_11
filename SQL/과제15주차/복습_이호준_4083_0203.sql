## from 절 서브쿼리 : 인라인 뷰 (inline View)

## Select
## from -> 오늘 할 내용
## where -> 중첩서브쿼리

## from -> 테이블

select * from products_sp;
## From 절 서브쿼리는 내가 만든 결과물 -> 내가 가지고 온 테이블에서 만들겠다.
## 쿼리 실행시간동아만 메모리에 존재하는 뷰를 가지고 온다. 동작 뷰를 가지고 온다.

## 파생 테이블
## from 절에 위치한 서브쿼리는 -> 파생 테이블 -> 인라인 뷰

## 고객별로 주문을 몇 번 했는지 세어보고, 주문 표를 보고 싶다.

select
	customer_id,
    count(*) as order_count
from
	orders_sp
group by customer_id;

select
	summary.customer_id,
    summary.order_count
from
	(select
	customer_id,
    count(*) as order_count
from
	orders_sp
group by customer_id) as summary;

## from 절에 왜 사용하나?
## 데이터 정합심 -> 중복 과대 계상 방지하는 것
## N관계 customers Orders join한다. -> sum(주문금액)
## 만약 customers 테이블에 다른 1:M 테이블 (고객 쿠폰 것들이랑) 먼저 조인이 된다. -> 조인을 하게 되어서 -> M배로 복제가 된다.(Duplicated)

## 위의 상황 가정
## 예시 인수 1ㅁ명
## 주문 2건 (10만원, 20만원 ) -> 총 매출 30만원
## 쿠폰 3장 (10%, 20%, 무료배송쿠폰)

## 잘못된 접근
## 주문이랑 쿠폰이랑 고객이랑 그냥 다 붙여

## 고객 1명을 기준으로, 주문이 2건이 있는데, 쿠폰이 3장이 들어간다.

## 1번 : 10만원 주문, 쿠폰 3장
## 2번 : 20만원에 주문 쿠폰이 3장

## 2+3 = 5개 2*3 = 6개 -> sum() 잘못된 금액이 나온다.

## (10만원 x 3번) + (20만원 x 3번) = 90만원


## 인라인 뷰를 사용해서 -> 조인하기 전의 압축을 한다, 요약 압축 -> 중복 이슈를 제거한다.
## 솔류션
## 쿠폰 테이블은 신경을 안 쓰는 것
## -> 고객 민수 테이블 주문 테이블
## 고객 민수 -> 30만원 -> 1을 데이터로 만든다.
## 고객 1명 x 주문 1건 x 쿠폰 3장 = 3줄 만들어지는 것

## 각 카테고리별로 상품이 몇 개인지 세어보고, 앞에 전체 상품의 개수도 한 번 세어보자!

select
	category_sales.category,
    category_sales.cnt,
	(select count(*) from  products_sp) as total
from (
select category,
		count(*) as cnt
from products_sp
group by category) as category_sales;

## 고객별 총 주문금액을 산출하고, 이를 바탕으로 고객의 등급을 부여해서 고객 정보랑 결합하라!
# -> 인라인 뷰의 개념을 떠올려야한다.

Select * from customers_sp; -- 고객
select * from orders_sp; -- 주문 id
select * from orders_items; -- quantity
select * from products_sp; -- unit price

select *
from customers_sp as c
inner join (
	select 
		o.customer_id,
		sum(oi.quantity * p.unit_price) as total_spent
	from orders_sp as o
	join order_items as oi on o.order_id = oi.order_id
	join products_sp as p on oi.product_id = p.product_id
	group by o.customer_id
) as sales_stat
on c.customer_id = sales_stat.customer_id;