--CASE FUNCTION 
-- create
CREATE TABLE Products (
  pro_id int primary key,
  pro_name varchar(50),
  category varchar(50),
  price numeric (10,2),
  quantity int,
  purchase_date date not null,
  discount_rate numeric(5,2)
);


-- insert data into table 
INSERT INTO Products (pro_id,pro_name,category,price,quantity,purchase_date,discount_rate)
VALUES (1,'Laptop','Electronics',75000.00,10,'2024-01-15',10.00),
       (2,'Smartphone','Electronics',45000.99,25,'2024-02-20',5.00),
       (3,'Headphone','Accessories',1500.75,5,'2024-03-05',15.00),
       (4,'Office chair','Furniture',5500.00,20,'2023-12-01',20.00),
       (5,'Desk','Furniture',8000.00,3,'2023-11-20',12.00),
       (6,'Monitor','Electronics',12000.00,8,'2024-01-10',8.00),
       (7,'Printer','Electronics',9500.55,5,'2024-02-01',7.50),
       (8,'Mouse','Accessories',750.00,4,'2024-03-18',10.00),
       (9,'Keybord','Accessories',1250.00,8,'2024-03-18',10.00),
       (10,'Tablet','Electronics',30000.00,12,'2024-02-28',5.00);
       
--fetch data
select * from Products;

/*Q.1 categorize products into price ranges:
      a.Expensive if the price is greater than or equal to 50,000.
      b Moderate if the price is between 10,000 and 49,999.
      c.Affordable if the price is less than 10,000.
*/ 
SELECT pro_name,category,price,
    CASE
	WHEN price>=50000 Then 'Expensive'
	WHEN price>=10000 AND price<=49999 Then 'Moderate'
	ELSE 'Affordable'
    END AS price_category
FROM products;

/*Q.2 classify products based on quantity available 
      a. In stock - if quantity is 10 or more.
      b. Limited stock - if quantity is between 5 to 10.
      c. Out of stock - if quantity is less than 5.
*/
SELECT pro_name,category,quantity,
    CASE
        WHEN quantity>=10 Then 'In stock'
        WHEN quantity between 5 AND 9 Then 'Limited stock'
        ELSE 'Out of stock soon'
    END AS qty_status
FROM Products;

/*Q.3 check if the category name contains 'Electronics'
      or 'Furniture' using like
      a. Ele-Item - if category is Electronic.
      b. Fur-Item - if category is Furniture.
      c. Acc-Item - if category is Accessories.
*/
SELECT pro_name,category,quantity,
    CASE
        WHEN category like 'Ele%'  Then 'Ele-Item'
        WHEN category like 'Fur%' Then 'Fur-Item'
        ELSE 'Acc-Item'
    END AS category_item
FROM Products;


--COALESCE FUNCTION 
--Add Total_discount & discounted_price column 
Alter table Products
ADD column discount numeric(10,2),
ADD column discount_price numeric(10,2);

--Calculate discount on price except laptop & smartphone 
update Products
set discount = price*discount_rate/100
where pro_name NOT IN ('Laptop','Smartphone');


--Calculate discounted_price except laptop & smartphone 
update Products
set discount_price = price-discount
where pro_name NOT IN ('Laptop','Smartphone');


--fetch data from products table 
select pro_name,price, discount_rate,discount_price
FROM Products;

--Merge discount_price & price column 
SELECT pro_name,price,discount_rate,discount,
    coalesce (discount_price,price) AS final_price
FROM Products;

