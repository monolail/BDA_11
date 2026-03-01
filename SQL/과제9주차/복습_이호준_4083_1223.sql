select * from buy;
select * from member;

## select from where -> 데이터를 조회를 쉽게 진행할 수 있다.
## select - 보고 싶은 컬럼(열)
## 전체 컬럼은 *
## as 별칭 
select 
	*
from
	buy;
    
select 
	num as buy_number,
    mem_id
from
	buy;     

## 컬럼에서 중복이 제거된 값을 보는 방법 : distinct

select 
	distinct mem_id
 from buy;

## where 를 사용하여 여러 조건을 -> 내가 원하는 조건에 맞는 행(레코드)가지고 옴 (구체적인 조건)
## select 컬럼들
## from 테이블들
## where 조건;

## amount 3개 이상 구매한 mem_id는?
## 필요한 것은 mem_id // 조건 : 3개이상

select 
	mem_id
from 
	buy
where 
	amount >= 3;

## 컬럼 -  필요한 건 mem_id ? select mem_id
## 조건 - amount 3개 이상인 경우 where amount 3개 이상을 써야 한다.
## 3개 이상 비교를 하는 것 amount >= 3  비교
## 테이블은 member
select 
	mem_id 
from 
	buy
where
	amount >= 3; 

## where 연산자가 >= <= > < 그외 연산자
## 논리 연산자 and, or, not

## 멤버 넘버가 5명 이상, 키가 164 이상인 경우의 멤버 name은?
select
	mem_name
from
	member
where
	mem_number >= 5 and height >=164;


## 정답
## select mem_name
## from member 
## where 멤버 넘버가 5명 이상, 키가 164 이상 -> and 조건 5명 이상 이고, 키가 164 이상 둘 다 참이어야 하는 케이스
## 만약 멤버 넘버가 5명 이상 이거나 키가 164 이상 -> or 조건 멤버 넘버가 5명 이상 이거나 키가 164 이상 케이스 둘 중 하나만 참이어도 되는 케이스
select 
	mem_name
from 
	member
where 
	mem_number >=5 
	and height >=164; 
select * from member;

-- '에이핑크'
-- '소녀시대'
-- '잇지'
-- '트와이스'
-- '여자친구'

# or 조건

select 
	mem_name
from 
	member
where 
	mem_number >=5 
	or height >=164; 

-- '에이핑크'
-- '소녀시대'
-- '잇지'
-- '오마이걸'
-- '트와이스'
-- '여자친구'
select * from member;

## between 조건 이상, 이하 조건으로 포함된다.

select *
from
	member
where mem_number between 5 and 7;

## 정답
select
	*
from
	member
where mem_number between 5 and 7;

select
	*
from
	member;
    
## in(여러 값 중 하나)
## in 을 쓰는 경우와 쓰지 않는 경우
## 만약 서울에 사는 멤버는?
## 만약 서울, 경기 두 곳에 사는 멤버?

select 
	*
from
	member
where
	addr = '경기' or addr = '서울';

## 정답
select 
	* 
from 
	member
where 
	addr in ('서울','경기');
    
-- select 
-- 	* 
-- from 
-- 	member
-- where 
-- 	addr = '서울' or addr ='경기';
--     
    

## is null /is not null
## 휴대전화번호 Phone1 이 있는 사람들의 명단이 필요한 것
select
	*
from
	member
where
	Phone1 is not null;

## 정답
select 
	* 
from 
	member
where phone1 is null;

select 
	* 
from 
	member
where phone1 is not null;

## 날짜 조건들

select * from member
where debut_date >= '2016-03-01';


## 와일드카드 문법
## %핑크% --> 핑크가 있는 모든 이름
## 핑크% --> 핑크로 시작하고 뒤에 어떤 문자가 와도된다. 
## %핑크 --> 어떤 문자로 시작하더라도, 끝은 핑크로 끝난다.

select
	*
from
	member
where
	mem_name like '%핑크%'; 
    
select
	*
from
	member
where
	mem_name like '핑크%'; 
    
select
	*
from
	member
where
	mem_name like '%핑크'; 

## 정리
## like
## %핑크% -> 핑크가 있는 애들 모두 다 찾는다.
## 핑크% -> 핑크로 시작하고 뒤에 어떤 문자가 와도 된다. 에이핑크 블랙핑크 -> 핑크 다음에 문자가 오는 것도 아니고, 핑크로 끝난다.
## %핑크 -> 어떤문자와 함께 끝이 핑크로 끝나는 것 -> 에이핑크, 블랙핑크

select * from member
where mem_name like '%핑크%';

select * from member
where mem_name like '핑크%'; # null 

select * from member
where mem_name like '%핑크'; #둘 다 나온다.

## order by 
## 정렬 --> 테이블 간의 최종적으로 나온 후 이 부분을 정렬하는 것
select
	*
from
	member
Order  by
	mem_number;

## 내림차순
select
	*
from
	member
Order  by
	mem_number desc;

## 정리
## 정렬 -> 테이블의 값이 최종적으로 나온 후 이 부분을 정렬하는 것 
## 내림차순, 오름차순
## 디폴트는 오름차순 asc
## 내림차순 desc

select * from member
Order by mem_number desc;


select * from member
Order by mem_number desc, phone2 desc;

select * from member
Order by mem_number desc, phone2 asc;


select * from buy;
## 간단한 문제
## price 50 이상이고, amount가 1개 이상 구매한 prod_name 중에서 맥북프로를 구매한 mem_id는 누구인가?

select mem_id from buy
	where price >= 50 and amount >= 1 and prod_name = '맥북프로';

## 정답
select mem_id from buy where price>=50 and amount >= 1 and prod_name= '맥북프로';
select mem_id from buy where price >= 50 and amount >= 1 and prod_name = '맥북프로';
select * from buy;
-- select mem_id from buy where price>=50 and prod_name ='맥북프로' and amount>=1;


## select 열이름 
## from 테이블 
## where 조건식
## group by 열 이름
## having 조건식
## order by 열 이름 
## limit 숫자

### group by 
### where는 필터 조건이라 해서 원하는 행에서 추출하는 형태
### group by 는 집계 함수를 통해 그룹을 묶어서 계산을 한다.
### 내가 원하는 묶을 컬럼(그룹)이 필요하다.
### 통계치로 보는 것이 중요하다.
select * from buy;

select sum(price)
from 
	buy
group by
	mem_id;


## 정리
### where 필터 조건이라 해서 내가 원하는 행(레코드) 추출하는 형 -> 찾는다. 제외하는 개념도 된다.
### group by 는 집계 함수 ( aggregate ) 그룹을 묶어서 계산을 한다.
### 내가 원하는 묶을 그룹 (컬럼)이 필요하다. -> mem_id 
### 내가 집계해서 살펴볼 (컬럼)이 필요하다. -> 그 컬럼을 어떤 통계치로 볼 것인가~? prcie / sum
### 통계치로 본다라는 것 정말 중요하다!

select 
	sum(price)
from 
	buy
group by
	mem_id;
    

### 대표적인 문법 오류
### 어떤 식으로 집계할 것인가 통계치를 적지 않은 경우 
select 
	price
from 
	buy
group by
	mem_id;

-- Error Code: 1055. Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'classicmodels.buy.price' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by
select 
	*
from 
	buy
group by
	mem_id;
    
## 두 번째 그룹바이에 없는 컬럼을 적게 되면 에러가 난다.
-- select * from buy;
-- Error Code: 1055. Expression #2 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'classicmodels.buy.prod_name' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by

select 
	sum(price),
    prod_name
from 
	buy
group by
	mem_id;

-- 그룹바이에 묶인 컬럼 쓸 수 있어?

select 
	mem_id,
    prod_name,
	sum(price)
from 
	buy
group by
	mem_id,  prod_name;



select 
	mem_id,
	sum(price),
    count(amount)
from 
	buy
group by
	mem_id
    
## group by 를 하면 중복이 사라진다->!
    
    ;