Select * from products_sp;

## 서브 쿼리
## sql
## main query -> 쿼리 안의 쿼리 -> Nested query

## 위치에 따른 분류
## Where 중첩 서브 쿼리
## where / having
## 역할 : 조건절의 필터링
## 반환 값 : 단일 값 ex). 가장 높은 상품 금액 / 다중값(In,Exists)
## 용도 : 동적인 값을 만든다. -> 데이터를 필터링한다.

## 인라인뷰 From절
## 역할 : 가상의 테이블을 만든다.
## 반환 : 다중 컬럼이 사용 가능하게 만든다.
## 용도 : 이미 집계 하거나, 필터링 된 집합을 대상으로 다시 조인하거나, 연산할 때 사용

## 스킬의 서브쿼리 (select 절)
## 역할 : 하나의 컬럼의 값이 도는 것
## 반환 : 단일행, 단일값
## 용도 : 각 행마다 다른 테이블 간의 값의 집계값을 붙이거나 보여줄때 사용.

## 

select * from products_sp;
## 프러덕트의 가장 높은 값을 찾는다.
## 비교 대상의 데이터가 계속 바뀐다.

## 메인쿼리. 서브쿼리 상관 서브쿼리를 풀어서 진행
## where 안에 비교 기준을 넣었다.
## 반평균 Max등등
## 비교 (Comparsion) 주 쿼리랑 비교를 했다.


select product_name,
	product_id,
	unit_price
from 
	products_sp as p1
where
	unit_price = (select max(unit_price) 
	from 
    products_sp as p2
	where p1.category = p2.category);


select max(unit_price) 
	from 
    products_sp as p2;
    
    
select * from customers_sp;
select * from orders_sp;
select * from order_items;
select * from products_sp;

## 서브쿼리 문제 상황
## 단가가 50,000원 이상인 고가 상품을 단 한 번이라도 주문한 이력이 있는 고개긔 이름과 등급을 조회해서 알려주세요.

select sp.customer_name, sp.customer_grade,sum((ps.unit_price*oi.quantity)) total_sales from customers_sp as sp
join orders_sp as op
on sp.customer_id = op.customer_id
join order_items as oi
on op.order_id = oi.order_id
join products_sp as ps
on ps.product_id = oi.product_id
group by 1,2
having sum((ps.unit_price*oi.quantity)) > 50000;

## unit_price가 50,000원 이상인 사람

select 
	sp.customer_name, 
    sp.customer_grade 
from customers_sp as sp
where customer_id in (
	select
		o.customer_id
	from orders_sp as o
    join order_items as oi on o.order_id = oi.order_id
    join products_sp as p on p.product_id = oi.product_id
    where p.unit_price > 50000);
    
    
    ## in any all 다중행을 바라보는 함수
    ## any 
    ## any(..) : 괄호 안의 값들 중 최소값(min) 크면 True
    ## unit_price ( 30,000 , 120,000 , 300,000)
    ## any를 쓰면 30,000원 보다 크면 조건을 만족한다.
    
    ## 카테고리가 '전자제품' 중에서 어떤 상품보다 더 비싼 (비) 전자제품을 구하고 싶다.
    ## 전자제품 중에서 가장 싼 것보다 비싸면 리스트에 포함되는것
    ## any를 사용해서 진행하면 전자제품의 unit_price중 최솟값을 기준으로 잡고 -> 이상인 애들만 출력해서 짤 수 있다.
    ## -> any (최소값 보다 큰 값들)
    
    ## any 는 or의 논리와 같다 .3만원 보다 크거나, 12만원 보다 크거나, 30만원 보다 크거나 통과
    ## 집합 내에서 최솟값 (min)만 통과해면 OK;
    
    select 
		product_name,
        unit_price,
        category
	from products_sp
	where category <> "전자제품" -- 전자제품 제외
    and unit_price > any (
		select unit_price
        from products_sp
        where category = "전자제품");

select unit_price
from products_sp
where category = "전자제품";