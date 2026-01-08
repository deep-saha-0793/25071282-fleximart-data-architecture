-- =============================================
-- INSERT INTO dim_date (30 days Jan-Feb 2024)
-- =============================================
INSERT INTO dim_date VALUES
(20240101,'2024-01-01','Monday',1,1,'January','Q1',2024,FALSE),
(20240102,'2024-01-02','Tuesday',2,1,'January','Q1',2024,FALSE),
(20240103,'2024-01-03','Wednesday',3,1,'January','Q1',2024,FALSE),
(20240104,'2024-01-04','Thursday',4,1,'January','Q1',2024,FALSE),
(20240105,'2024-01-05','Friday',5,1,'January','Q1',2024,FALSE),
(20240106,'2024-01-06','Saturday',6,1,'January','Q1',2024,TRUE),
(20240107,'2024-01-07','Sunday',7,1,'January','Q1',2024,TRUE),
(20240108,'2024-01-08','Monday',8,1,'January','Q1',2024,FALSE),
(20240109,'2024-01-09','Tuesday',9,1,'January','Q1',2024,FALSE),
(20240110,'2024-01-10','Wednesday',10,1,'January','Q1',2024,FALSE),
(20240111,'2024-01-11','Thursday',11,1,'January','Q1',2024,FALSE),
(20240112,'2024-01-12','Friday',12,1,'January','Q1',2024,FALSE),
(20240113,'2024-01-13','Saturday',13,1,'January','Q1',2024,TRUE),
(20240114,'2024-01-14','Sunday',14,1,'January','Q1',2024,TRUE),
(20240115,'2024-01-15','Monday',15,1,'January','Q1',2024,FALSE),
(20240116,'2024-01-16','Tuesday',16,1,'January','Q1',2024,FALSE),
(20240117,'2024-01-17','Wednesday',17,1,'January','Q1',2024,FALSE),
(20240118,'2024-01-18','Thursday',18,1,'January','Q1',2024,FALSE),
(20240119,'2024-01-19','Friday',19,1,'January','Q1',2024,FALSE),
(20240120,'2024-01-20','Saturday',20,1,'January','Q1',2024,TRUE),
(20240121,'2024-01-21','Sunday',21,1,'January','Q1',2024,TRUE),
(20240122,'2024-01-22','Monday',22,1,'January','Q1',2024,FALSE),
(20240123,'2024-01-23','Tuesday',23,1,'January','Q1',2024,FALSE),
(20240124,'2024-01-24','Wednesday',24,1,'January','Q1',2024,FALSE),
(20240125,'2024-01-25','Thursday',25,1,'January','Q1',2024,FALSE),
(20240126,'2024-01-26','Friday',26,1,'January','Q1',2024,FALSE),
(20240127,'2024-01-27','Saturday',27,1,'January','Q1',2024,TRUE),
(20240128,'2024-01-28','Sunday',28,1,'January','Q1',2024,TRUE),
(20240129,'2024-01-29','Monday',29,1,'January','Q1',2024,FALSE),
(20240130,'2024-01-30','Tuesday',30,1,'January','Q1',2024,FALSE);

-- =============================================
-- INSERT INTO dim_product (15 products, 3 categories)
-- =============================================
INSERT INTO dim_product (product_id, product_name, category, subcategory, unit_price) VALUES
('P101','Laptop Pro','Electronics','Computers',82000),
('P102','Laptop Air','Electronics','Computers',65000),
('P103','Smartphone Max','Electronics','Mobiles',55000),
('P104','Smartphone Mini','Electronics','Mobiles',28000),
('P105','Bluetooth Earbuds','Electronics','Audio',4000),
('P106','Gaming Mouse','Electronics','Accessories',1500),
('P107','Mechanical Keyboard','Electronics','Accessories',4500),
('P108','Office Chair','Furniture','Chairs',12000),
('P109','Standing Desk','Furniture','Desks',25000),
('P110','Conference Table','Furniture','Tables',35000),
('P111','Water Bottle','Lifestyle','Accessories',600),
('P112','Yoga Mat','Lifestyle','Fitness',1200),
('P113','Running Shoes','Lifestyle','Footwear',3500),
('P114','Smart Watch','Electronics','Wearables',18000),
('P115','Tablet Pro','Electronics','Tablets',48000);

-- =============================================
-- INSERT INTO dim_customer (12 customers)
-- =============================================
INSERT INTO dim_customer (customer_id, customer_name, city, state, customer_segment) VALUES
('C001','Amit Sharma','Mumbai','Maharashtra','Retail'),
('C002','Neha Singh','Delhi','Delhi','Retail'),
('C003','Ravi Kumar','Bengaluru','Karnataka','Corporate'),
('C004','Sneha Patel','Ahmedabad','Gujarat','SMB'),
('C005','Vikram Rao','Hyderabad','Telangana','Retail'),
('C006','Karan Shah','Pune','Maharashtra','Corporate'),
('C007','Meera Joshi','Nagpur','Maharashtra','Retail'),
('C008','Tarun Mehta','Jaipur','Rajasthan','SMB'),
('C009','Rohan Das','Kolkata','West Bengal','Corporate'),
('C010','Simran Kaur','Chandigarh','Punjab','Retail'),
('C011','Aditya Verma','Lucknow','UP','SMB'),
('C012','John Doe','Mumbai','Maharashtra','Corporate');

-- =============================================
-- fact_sales (40 realistic sales)
-- Weekends have higher quantities
-- =============================================
INSERT INTO fact_sales (date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount) VALUES
(20240101,1,1,1,82000,0,82000),
(20240102,3,2,1,55000,0,55000),
(20240103,5,3,2,4000,0,8000),
(20240104,14,4,1,18000,0,18000),
(20240105,6,5,1,1500,0,1500),
(20240106,1,6,2,82000,2000,162000),
(20240106,3,7,3,55000,0,165000),
(20240106,5,8,4,4000,0,16000),
(20240107,4,9,2,28000,0,56000),
(20240107,2,10,1,65000,0,65000),
(20240108,12,11,1,1200,0,1200),
(20240109,9,12,1,25000,0,25000),
(20240110,10,1,1,35000,0,35000),
(20240111,13,2,1,3500,0,3500),
(20240112,15,3,1,48000,0,48000),
(20240113,2,4,2,65000,5000,125000),
(20240113,6,5,3,1500,0,4500),
(20240113,7,6,2,4500,0,9000),
(20240114,1,7,1,82000,0,82000),
(20240114,3,8,2,55000,0,110000),
(20240115,14,9,1,18000,0,18000),
(20240116,5,10,1,4000,0,4000),
(20240117,8,11,1,12000,0,12000),
(20240118,11,12,1,600,0,600),
(20240119,1,1,1,82000,0,82000),
(20240120,3,2,3,55000,0,165000),
(20240120,4,3,2,28000,0,56000),
(20240121,2,4,1,65000,0,65000),
(20240121,3,5,2,55000,0,110000),
(20240122,6,6,1,1500,0,1500),
(20240123,7,7,1,4500,0,4500),
(20240124,8,8,1,12000,0,12000),
(20240125,14,9,1,18000,0,18000),
(20240126,9,10,1,25000,0,25000),
(20240127,1,11,2,82000,2000,162000),
(20240127,3,12,3,55000,0,165000),
(20240128,5,1,4,4000,0,16000),
(20240128,4,2,2,28000,0,56000),
(20240129,11,3,1,600,0,600),
(20240130,15,4,1,48000,0,48000);
