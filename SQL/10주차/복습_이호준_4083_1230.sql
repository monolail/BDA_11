-- 1. 테이블 생성
CREATE TABLE sample_orders (
    id INT PRIMARY KEY,
    category VARCHAR(20),      -- 카테고리 (전자제품, 의류, 식품)
    product_name VARCHAR(50),  -- 상품명
    price INT,                 -- 가격
    quantity INT,              -- 주문 수량
    payment_method VARCHAR(10) -- 결제 방식 (카드, 현금)
);

-- 2. 데이터 삽입
INSERT INTO sample_orders VALUES
(1, '전자제품', '무선마우스', 30000, 2, '카드'),
(2, '의류', '티셔츠', 15000, 5, '카드'),
(3, '식품', '사과', 20000, 10, '현금'),
(4, '전자제품', '키보드', 120000, 1, '카드'),
(5, '의류', '청바지', 50000, 2, '현금'),
(6, '전자제품', '모니터', 300000, 1, '카드'),
(7, '식품', '바나나', 5000, 20, '현금'),
(8, '의류', '모자', 10000, 3, '카드');

## 집계함수 카테고리 별로 주문이 몇 건들어 왓을까요? 질문 -> 답변1
## sample orders

## 집계함수
## Count() : 행의 개수 (주문 건수)
## sum() : 합계 총 매출액
## avg() : 평균 구매액. 매출액
## max(), min() 최댓값, 최솟값

select * from sample_orders;

select category, count(category) from sample_orders group by category;

select category, count(*) as total_order, count(price), count(product_name)
from sample_orders
group by category;

## 카테고리 별 총 판매금액은 얼마인가?
## 총 판매금액은 = price * quantity = 총합

## 정답
select
	price,
    quantity,
    price * quantity
from sample_orders;

select
sum(price),
sum(quantity),
sum(price * quantity)
from sample_orders;

## 내 정답

select category, count(*) as total_order, sum(price*quantity) as total_price
from sample_orders
group by category;

## 결제 방식

select * from sample_orders;

## 결제방식의 평균 금액은?
## price * quantity 로 결제금액을 잡는다.

select payment_method,  sum(price*quantity) as total_price , avg(price*quantity) as average_amount
from sample_orders
group by payment_method;


## Having 절
## where having의 차이
## where : 그룹을 하기전에 필터링한다. 특정 컬럼의 값만 추출한다.
## having : 그룹화 후에 집계뙨 결과를 필터링하는 것 ( 다 그룹핑한 group by 결과에다 where를 쓴다.)

select
	category,
	sum(price*quantity)
from
	sample_orders
group by category
having sum(price*quantity) > 30;

## 카테고리별로 묶고 그 다음 결제 방식으로 다시 묶어서 쪼깨서 보고싶으면?
select category, payment_method, sum(price) 
from sample_orders
group by category, payment_method;

