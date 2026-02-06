create database candy_distributor;
use candy_distributor;

-- 1. Create the Products Table
create table Products (
Division varchar(50),
Product_Name varchar(255),
Factory varchar(100),
Product_ID varchar(50) primary KEY,
Unit_Price decimal(10, 2),
Unit_Cost decimal(10, 2)
);

-- 2. Create the Factories Table
create table Factories (
Factory varchar(100) Primary Key,
Latitude decimal(10,6),
Longitude decimal(10,6)
);

-- 3. Create the Targets Table
create table Targets(
Division varchar(50) primary KEY,
Target_2024 int
);

-- 4. Create the  US_Zips Table
create table US_Zips (
zip varchar(10) primary key,
lat decimal(10,6),
lng decimal(10,6) ,
city varchar(100),
state_id varchar(5),
state_name varchar(100)
);

-- 5. Create the Sales Table (The "Fact" Table)
CREATE TABLE Sales (
    Row_ID INT PRIMARY KEY,
    Order_ID VARCHAR(50),
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode VARCHAR(50),
    Customer_ID INT,
    Country_Region VARCHAR(50),
    City VARCHAR(100),
    State_Province VARCHAR(100),
    Postal_Code VARCHAR(10),
    Division VARCHAR(50),
    Region VARCHAR(50),
    Product_ID VARCHAR(50),
    Product_Name VARCHAR(255),
    Sales_Amount DECIMAL(10,2),
    Units INT,
    Gross_Profit DECIMAL(10,2),
    Cost DECIMAL(10,2),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID),
    FOREIGN KEY (Division) REFERENCES Targets(Division)
);

SELECT 'US_Zips' as Table_Name, Count(*) as Total_Rows from US_Zips
union
select 'Sales' , count(*) from sales
union 
select 'Products', count(*) from Products;


CREATE OR REPLACE VIEW Sales_Analysis_View AS
SELECT 
    s.Order_ID, 
    s.Order_Date, 
    s.Ship_Date,
    s.Postal_Code,  -- We are adding this "Bridge" column back in!
    s.Division, 
    s.Product_Name, 
    s.Sales_Amount,
    s.Units,
    s.Gross_Profit,
    s.Cost,
    p.Factory,
    p.Unit_Price,
    p.Unit_Cost,
    t.Target_2024
FROM Sales s
JOIN Products p ON s.Product_ID = p.Product_ID
JOIN Targets t ON s.Division = t.Division;


select * from Sales_Analysis_View limit 10;













