##
# 카테고리별로 주문의 개수를 구하자.
select category, count(*) as total_order
from sample_orders
group by category;

# 
select * from sample_orders;

CREATE TABLE customers_sp (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(50) NOT NULL,
customer_grade VARCHAR(20) NOT NULL
);

INSERT INTO customers_sp (customer_id, customer_name, customer_grade) VALUES
(1, '지민', 'SILVER'),
(2, '서연', 'GOLD'),
(3, '민수', 'BRONZE');

CREATE TABLE products_sp (
product_id INT PRIMARY KEY,
category VARCHAR(20) NOT NULL,
product_name VARCHAR(50) NOT NULL,
unit_price INT NOT NULL
);

INSERT INTO products_sp (product_id, category, product_name, unit_price) VALUES
(101, '전자제품', '무선마우스', 30000),
(102, '전자제품', '키보드', 120000),
(103, '전자제품', '모니터', 300000),
(201, '의류', '티셔츠', 15000),
(202, '의류', '청바지', 50000),
(203, '의류', '모자', 10000),
(301, '식품', '사과', 20000),
(302, '식품', '바나나', 5000);

CREATE TABLE orders_sp (
order_id INT PRIMARY KEY,
customer_id INT NOT NULL,
payment_method VARCHAR(10) NOT NULL,
order_ts DATE NOT NULL,
FOREIGN KEY (customer_id) REFERENCES customers_sp(customer_id)
);


INSERT INTO orders_sp (order_id, customer_id, payment_method, order_ts) VALUES
(1, 1, '카드', '2026-01-01'),
(2, 1, '카드', '2026-01-02'),
(3, 2, '현금', '2026-01-02'),
(4, 2, '카드', '2026-01-03'),
(5, 3, '현금', '2026-01-03');


CREATE TABLE order_items (
order_id INT NOT NULL,
product_id INT NOT NULL,
quantity INT NOT NULL,
PRIMARY KEY (order_id, product_id),
FOREIGN KEY (order_id) REFERENCES orders_sp(order_id),
FOREIGN KEY (product_id) REFERENCES products_sp(product_id)
);

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 101, 2), -- 무선마우스 2
(2, 201, 5), -- 티셔츠 5
(3, 301, 10), -- 사과 10
(4, 102, 1), -- 키보드 1
(4, 203, 3), -- 모자 3 (한 주문에 여러 상품)
(5, 302, 20); -- 바나나 20

-- 단일, 다중, where 비교, having, distinct count들, case + group by 사용
-- 비율, 리포트 계싼할때 사용
-- join과도 응용시 사용한다.

select * from products_sp;

# join으로 테이블을 연결
## 관계형 모델
## 테이블(관계, relation) 키(key)
## Primary key 테이블에서 각 행을 유일하게 식별
## Foreign key 다른 테이블의 pk를 참조해서 관계를 만듦

## join은 두 관계 사이의 공통 키를 기준으로 튜플을 합친다. 결합한다.
## Cartesian Proudct -> 다 곱을 하고 -> join으로 의미가 있는 조합들만 남긴다.

## inner join A x B 모든 조합에서 -> A.key = B.key 같은 것들만 조합만 남긴다.
## 왜 join 

select * from customers_sp;

select * from orders_sp;

## orders

## 예제1) 주문별 고객 등급/이름 붙이기alter
## orders_sp 주문자 이름과 주문자의 등급이 같이 붙는 것을 보고 싶다.

## 연결하고자 하는 키는 무엇인가? -> customer_id (참조되는 키)
## orders_sp, customers_sp를 연결하자

## inner join의 문법
## 기준테이블
## join할 테이블 적는다.
## join할 컬럼을 적는다.

## from orders_sp 기준
## inner join customers_sp
## on orders_sp.customer_id = customers_sp.customer_id

## 조인된 것 중 customer_id만을 보고 싶다.

select
	o.order_id,
    o.customer_id,
    o.payment_method,
    o.order_ts,
    c.customer_name,
    c.customer_grade,
    c.customer_id
from orders_sp as o
inner join customers_sp as c
	on o.customer_id = c.customer_id
where o.payment_method = '카드';

## order by o.customer_id desc;

## 만약 두 개의 컬럼이 같은 경우 (컬럼명이 같다.)

select
	o.order_id,
    o.customer_id,
    o.payment_method,
    o.order_ts,
    c.customer_name,
    c.customer_grade,
    c.customer_id
from orders_sp as o
inner join customers_sp as c
	using(customer_id)
where o.payment_method = '카드';

## 

select * from order_items;

select * from products_sp;

select
	o.order_id,
    o.product_id,
    o.quantity,
    c.category
from order_items as o
inner join products_sp as c
	using(product_id);


## category 별로 주문수량은 몇 개인가? 
select
	c.category,
    sum(o.quantity)
from order_items as o
inner join products_sp as c
	on o.product_id = c.product_id
group by c.category;



