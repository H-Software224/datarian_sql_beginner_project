# 프로젝트 제목
데이터리안 SQL 43기 입문반 프로젝트: RFM을 이용한 분석

## 문제 정의
Delivery APP 서비스를 이용하는 고객들이 이 앱을 통하여 주문을 통해서 최근 얼마 동안 이 주문 앱을 사용하였는지, 그리고 이 서비스를 사용하는 데 얼마나 일정 기준 이상동안 주문을 하였는지 그리고 이 주문 금액을 사용하는 데에 얼마나 주문에 많은 금액을 소비하였는지 확인을 하면서 일정 수준 이상에 따라서 너무 상대적이다 보니, 상대적으로 고르게 신용등급을 분포할 수 있을지가 어렵다는 점입니다.

## 데이터 접근 방법
Deliver APP 서비스에 대하여 고객, 주문 현황, 그리고 결제 방법 현황에 대해서 데이터에 대해서 준비를 해야 하며, 각 데이터 마다 데이터 속성 요소에 대해서 준비를 해야 된다.

1. customers

|Attribute(속성)|Description(설명)|
|---------------|-----------------|
|id|상품 고객에 대한 고유한 ID(1~15)|
|grades|상품 고객에 대한 현재 등급 상태(신용 등급이 아닌 각 상품을 많이만 사용하면 등급이 높아진다.)('gold', 'silver', 'vip', 'new', 'bronze')|
|created_at|서비스를 통해 상품을 살 때의 날짜 형태 이용 (년/월/일 시:분:초) 형식|
2. orders

|Attribute(속성)|Description(설명)|
|---------------|-----------------|
|id|고객이 주문한 내역에 대한 고유한 ID(1~30)|
|customer_id|주문한 내역에 해당하는 고객의 고유 id(1~15)|
|restaurant_id|주문한 것에 해당하는 식당 장소 id(1~30)|
|order_type|주문한 것에 대해서 고객이 주문한 방법 유형('배달', '포장')|
|paid_at|고객이 주문한 시점 (년/월/일 시:분:초) 형식|
|approved_at|음식점에서 고객이 신청한 주문이 수락한 시 (년/월/일 시:분:초) 형식|
|delivered_at|주문 최종 완료 시점 (년/월/일 시:분:초) 형식|

3. payments

|Attribute(속성)|Description(설명)|
|---------------|-----------------|
|id|결제되었던 고유한 id(1~30)|
|order_id|고객이 주문한 내역에 대한 고유한 id(1~30)|
|payment_type|고객이 주문한 것에 지불한 방법 유형('신용/체크카드', '만나서 카드결제', '휴대폰결제', '네이버페이', '카카오페이', '만나서 현금결제')|
|payment_value|고객이 주문하였을 때의 총 결제 금액|
|paid_at|고객이 주문하였을 때 지불완료한 시점|

## 데이터 준비

### 사전적 EDA 데이터 경향 분석
질문
:one: orders 테이블에 어떤 데이터들이 들어있는가?
```
SELECT *
FROM orders
LIMIT 10
```
![orders_EDA](https://github.com/H-Software224/datarian_sql_beginner_project/blob/main/images/orders_10.png)
:two: customers 테이블에서도 어떤 데이터들이 있는가?
```
SELECT *
FROM customers
LIMIT 10
```
![customers_EDA](https://github.com/H-Software224/datarian_sql_beginner_project/blob/main/images/customers_10.png)
:three: orders 테이블에 들어있는 1인 고객의 데이터를 확인해 봅시다.  해당 고객이 주문한 횟수는 몇 번인가요?
```
SELECT COUNT(DISTINCT id) AS order_cnt
FROM orders
WHERE customer_id = 1
```
![q3_EDA](https://github.com/H-Software224/datarian_sql_beginner_project/blob/main/images/q3_eda.png)
:four: orders 테이블에 들어있는 1인 고객이 주문한 총금액은 얼마인가요?
```
SELECT SUM(payments.payment_value) AS sum_sales
FROM orders
INNER JOIN payments ON orders.id = payments.order_id
WHERE customer_id = 1
```
![q4_EDA](https://github.com/H-Software224/datarian_sql_beginner_project/blob/main/images/q4_eda.png)
:five: orders 테이블에 들어있는 1인 고객이 가장 마지막으로 주문했던 날짜는 언제였나요?
```
SELECT MAX(paid_at) AS final_paid_at
FROM orders
WHERE customer_id = 1
```
![q5_EDA](https://github.com/H-Software224/datarian_sql_beginner_project/blob/main/images/q5_eda.png)

우선 customers, orders, payment을 이용하여 고객에 관해 필요한 데이터들의 
가설 설정에 있어서 세 가지 관점에 대해서 가설 설정을 해야 한다.
R: 최근 시점에 대해서 어떠한 것을 기준해야 할지?
최근 1년 시점에 대해서 해야 할지? 최근 2년 시점에 대해서 해야 할지?

