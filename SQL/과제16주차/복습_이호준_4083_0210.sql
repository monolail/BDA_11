Select * FROM products_sp;

## select 절
## 단일행 ,단일열 행과 열이 단일에 의미 오직 하나의 값을 반환

## 관계형 데이터베이스 제약이 하나 있고 카디널리티가 일치해야한다
## product name, price 행마다 값이 변하는 속성 N vector
## 스칼라 데이터 avg(price), sum(price) 전체 집합에서 도출된 하나의 상수

## 1개의 값으로 N번 복제해서 (Broadcasting)

## 상황 : 모든 상품의 리스트를 출력하되, 전체 상품의 평균가격을 모든 행에 표시하고, 각 상품 가격과의 차이를 구하라

Select
p.product_name,
p.unit_price,
(select avg(unit_price) from products_sp ) as avg_price,
p.unit_price -  (select avg(unit_price) from products_sp ) as price_deviation
from products_sp as p;

## 상관 스칼라 서브쿼리(Correlaated Scalr Subquery)
## 상황 전체 평균이 아니라, 해당 상품이 속한 카테고리의 평균 가격을 옆에 붙인다
## 전자제품은 전자제품의 평균, 의류는 의류평균

Select * from products_sp;

select 
	p1.category,
    p1.product_name,
    p1.unit_price,
    (select avg(p2.unit_price) from products_sp as p2 where p2.category = p1.category) as avg_price_category
from products_sp as p1;

## 전체 대비 비율 산출

## 각 상품의 매출액이 전체 매출액에서 차지하는 비율이 몇 %인가?
## 분자/분모 -> 전체 매출합, 분자는 부분이다.


select
	p.product_name,
	sum(oi.quantity * p.unit_price)as product_revenue, -- 분자
	(select sum(sub_oi.quantity * sub_p.unit_price) from order_items as sub_oi
		join products_sp  as sub_p on sub_p.product_id = sub_oi.product_id) as total_revenue,
	round(sum(oi.quantity*p.unit_price)/(select sum(sub_oi.quantity * sub_p.unit_price) from order_items as sub_oi
		join products_sp as sub_p on sub_p.product_id = sub_oi.product_id )* 100,2 ) as share_percentage
from order_items as oi
join products_sp as p on oi.product_id = p.product_id
Group BY p.product_name;

Select 60000 / 585000;

## Common Table Expression
## with 임시테이블 as (
## 쿼리
##)

## 가격이 50,000원 이상인 비싼 상품만 골라내서, 그 가격들의 평균을 구하고 싶다!

with exp_products as (
	Select product_name, unit_price from products_sp where unit_price > 50000
)
select * from exp_products;
