select
	c.category,
    sum(o.quantity)
from order_items as o
inner join products_sp as c
	on o.product_id = c.product_id
group by c.category;

select category, count(*) as total_order
from sample_orders
group by category;

##

Select 
	p.product_id,
	p.product_name,
    o.order_id
from products_sp as p
inner join order_items as o
on o.product_id = p.product_id;


Select * from order_items;
Select * from products_sp;

## left join 6개 
### products_sp : 8개
### order_items : 6개
#### prdouct_sp left 기준 left join 8개
Select 
	p.product_id,
	p.product_name,
    o.order_id
from products_sp as p
left join order_items as o
on o.product_id = p.product_id;

#### order_items left 기준 left join 6개

### left join 응용1 == Anti join
Select 
	p.product_id,
	p.product_name,
    o.order_id
from products_sp as p
left join order_items as o
on o.product_id = p.product_id
Where o.product_id is null;

### 주문한 상품들의 총 주문 금액은 얼마인가?
## 주문한 것이기에 기준 테이블은 order_itmes이다.
Select * from products_sp;
Select * from order_items;
# 1 left 조인
Select p.product_name , o.quantity * p.unit_price as order_amount
	from order_items as o
    left join products_sp as p
    on o.product_id = p.product_id;
# 2 inner 조인
Select p.product_name , o.quantity * p.unit_price as sales
	from order_items as o
    inner join products_sp as p
    on o.product_id = p.product_id;
    
# 정답
Select sum((o.quantity * p.unit_price)) as sales
	from order_items as o
    inner join products_sp as p
    on o.product_id = p.product_id;

## 주문하지 않은 상품들은 무엇인가?
## 주문하지 않은 상품의 수량은 어떻게 되는가?
## 전체 제품 중 주문하지 않은 제품의 비율을 얼마나 되는가?
## ==> 주문하지 않은 제품 / 전체 제품 -> 2/8 = 1/4 = 0.25
## 서브쿼리형태로 출력 (select 카운팅 / 전체 카운팅 분모) = 어떤 특정 비율 나올 수 있게

Select p.product_name, o.quantity
	from products_sp as p
	left join order_items as o
    on o.product_id = p.product_id
    Where o.product_id is null;
    
## right join은 잘 사용하지 않는다. -> left join이 대표적인 방식이기 때문에 잘 사용하지 않는다.


## 3개 join
## 고객 - 주문 - 상품
## 고객이 주문한 상품 내역

Select * FROM customers_sp;
Select * FROM orders_sp;
select * from order_items;
Select * FROM products_sp;