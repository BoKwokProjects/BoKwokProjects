-- Bo Kwok 22454220
-- Oracle Apex version 22.21

-- Drop tables if exist
DROP TABLE SalesFact;
DROP TABLE Theatre;
DROP TABLE Production;
DROP TABLE Performance;
DROP TABLE Customer;
DROP TABLE DateDimension;

-- Create sales fact table to record sales transactions
CREATE TABLE SalesFact(
    -- Unique identifier for each sale transaction, auto generated values when each row of data is inserted.
    SalesFactNo INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    -- Check to make sure TheatreNo are positive non-zero integers
    TheatreNo INT NOT NULL CHECK (TheatreNo > 0),
    -- Check to make sure ProductionNo are positive non-zero integers
    ProductionNo INT NOT NULL CHECK (ProductionNo > 0),
    -- Check to make sure PerformanceNo are positive non-zero integers
    PerformanceNo INT NOT NULL CHECK (PerformanceNo > 0),
    -- Check to make sure CustomerID are positive non-zero integers
    CustomerID INT NOT NULL CHECK (CustomerID > 0),
    -- Check to make sure DateID are positive non-zero integers
    DateID INT NOT NULL CHECK (DateID > 0),
    -- Check to make sure payment method are among the listed options 
    PaymentMethod VARCHAR(50) NOT NULL CHECK (PaymentMethod in ('Cash', 'PayPal', 'Debit Card', 'Credit Card')),
    -- Check to make sure delivery method are among the listed options 
    DeliveryMethod VARCHAR(50) NOT NULL CHECK (DeliveryMethod IN ('Mail', 'Email', 'Box Office')),
    -- Check to make sure total amount paid is non-negative
    TotalAmount DECIMAL(10,2) NOT NULL CHECK (TotalAmount > 0)
);
-- Create theatre table to record theatre information
CREATE TABLE Theatre (
    -- Unique identifier for each theatre, check to make sure TheatreNo are positive non-zero integers
    TheatreNo INT PRIMARY KEY CHECK (TheatreNo > 0),
    -- Theatre name must not be empty
    TheatreName VARCHAR (255) NOT NULL,
    -- Theatre address
    TheatreAddress VARCHAR (255),
    -- Theatre main telephone number must be unique
    MainTel VARCHAR (20) UNIQUE
);
-- Create production table to record production information
CREATE TABLE Production (
    -- Unique identifier for each production, check to make sure ProductionNo are positive non-zero integers
    ProductionNo INT PRIMARY KEY CHECK (ProductionNo > 0),
    -- Production name must not be empty
    ProductionTitle VARCHAR(255) NOT NULL,
    -- name of production director
    ProductionDirector VARCHAR(255),
    -- name of play author
    PlayAuthor VARCHAR(255)
);
-- Create performance table to record performance information
CREATE TABLE Performance(
    -- Unique identifier for each performance, check to make sure PerformanceNo are positive non-zero integers
    PerformanceNo INT PRIMARY KEY CHECK (PerformanceNo > 0),
    -- Unique identifier for each production, check to make sure ProductionNo are positive non-zero integers
    ProductionNo INT NOT NULL CHECK (ProductionNo > 0),
    -- Performance date must not be empty
    pDate DATE NOT NULL,
    -- Performance hour must not be empty, check to make sure performance hour is between 0 to 23
    pHour INT NOT NULL CHECK (pHour between 0 and 23),
    -- Performance minute must not be empty, check to make sure performance minute is between 0 to 59
    pMinute INT NOT NULL CHECK (pMinute between 0 and 59),
    -- Comments about the performance
    Comments VARCHAR(255)
);
-- Create customer table to record customer information
CREATE TABLE Customer(
    -- Unique identifier for each customer, check to make sure CustomerID are positive non-zero integers
    CustomerID INT PRIMARY KEY CHECK (CustomerID > 0),
    -- Title of customer
    CustomerTitle VARCHAR(10),
    -- Customer name must not be empty
    CustomerName VARCHAR(255) NOT NULL,
    -- Address of customer
    CustomerAddress VARCHAR(255),
    -- Telephone number of customer
    TelNo VARCHAR(20),
    -- Customer email must be unique for validation
    Email VARCHAR(255) UNIQUE
);
-- Create date dimension table to record date information
CREATE TABLE DateDimension (
    -- Unique identifier for each date, check to make sure DateID are positive non-zero integers
    DateID INT PRIMARY KEY CHECK (DateID > 0),
    -- Full date must not be empty
    FullDate DATE NOT NULL,
    -- Year must not be empty
    Year INT NOT NULL,
    -- Month must not be empty, check to make sure month is between 1 to 12
    Month INT NOT NULL CHECK (Month Between 1 and 12),
    -- Day must not be empty, check to make sure day is between 1 to 31
    Day INT NOT NULL CHECK (Day Between 1 and 31)  
);

-- Insert data to various tables

INSERT INTO SalesFact(TheatreNo, ProductionNo, PerformanceNo, CustomerID, DateID, PaymentMethod, DeliveryMethod, TotalAmount) Values (2, 1, 4, 2, 1, 'PayPal', 'Box Office', 300);
INSERT INTO SalesFact(TheatreNo, ProductionNo, PerformanceNo, CustomerID, DateID, PaymentMethod, DeliveryMethod, TotalAmount) Values (1, 3, 2, 1, 2, 'Debit Card', 'Mail', 200);
INSERT INTO SalesFact(TheatreNo, ProductionNo, PerformanceNo, CustomerID, DateID, PaymentMethod, DeliveryMethod, TotalAmount) Values (3, 3, 2, 2, 3, 'Credit Card', 'Email', 400);
INSERT INTO SalesFact(TheatreNo, ProductionNo, PerformanceNo, CustomerID, DateID, PaymentMethod, DeliveryMethod, TotalAmount) Values (2, 2, 3, 2, 4, 'Credit Card', 'Box Office', 400);
INSERT INTO SalesFact(TheatreNo, ProductionNo, PerformanceNo, CustomerID, DateID, PaymentMethod, DeliveryMethod, TotalAmount) Values (2, 4, 1, 2, 5, 'Debit Card', 'Email', 600);

INSERT INTO Theatre (TheatreNo, TheatreName, TheatreAddress, MainTel) VALUES (1, 'Craven Cottage', '6 Stevenage Rd', 02210252147);
INSERT INTO Theatre (TheatreNo, TheatreName, TheatreAddress, MainTel) VALUES (2, 'Emirates Stadium', '10 Emile Smith Rd', 02223584222);
INSERT INTO Theatre (TheatreNo, TheatreName, TheatreAddress, MainTel) VALUES (3, 'Old Trafford', '10 Hag Eric Street', 01614204899);
INSERT INTO Theatre (TheatreNo, TheatreName, TheatreAddress, MainTel) VALUES (4, 'Stamford Bridge', '443 Bohely Street', 01249467897);
INSERT INTO Theatre (TheatreNo, TheatreName, TheatreAddress, MainTel) VALUES (5, 'White Hart Lane', '1 Trophless Road', 01245671432);
INSERT INTO Production (ProductionNo, ProductionTitle, ProductionDirector, PlayAuthor) VALUES (1, 'Titanic', 'James Cameron', 'James Cameron');
INSERT INTO Production (ProductionNo, ProductionTitle, ProductionDirector, PlayAuthor) VALUES (2, 'Avengers: Endgame', 'Anthony Russo', 'Stan Lee');
INSERT INTO Production (ProductionNo, ProductionTitle, ProductionDirector, PlayAuthor) VALUES (3, 'The Matrix', 'The Wachowskis', 'The Wachowskis');
INSERT INTO Production (ProductionNo, ProductionTitle, ProductionDirector, PlayAuthor) VALUES (4, 'Top Gun', 'Tony Scott', 'Jim Cash');
INSERT INTO Production (ProductionNo, ProductionTitle, ProductionDirector, PlayAuthor) VALUES (5, 'First Blood', 'Ted Kotcheff', 'David Morrell');
INSERT INTO Performance (PerformanceNo, ProductionNo, pDate, pHour, pMinute, Comments) Values (1, 4, '24-JAN-2024', 3, 15, 'Romantic film');
INSERT INTO Performance (PerformanceNo, ProductionNo, pDate, pHour, pMinute, Comments) Values (2, 3, '4-MAR-2024', 3, 1, 'Superhero film');
INSERT INTO Performance (PerformanceNo, ProductionNo, pDate, pHour, pMinute, Comments) Values (3, 2, '20-MAY-2024', 1, 49, 'Action Drama film');
INSERT INTO Performance (PerformanceNo, ProductionNo, pDate, pHour, pMinute, Comments) Values (4, 1, '24-JUN-2024', 3, 15, 'Science fiction action film');
INSERT INTO Performance (PerformanceNo, ProductionNo, pDate, pHour, pMinute, Comments) Values (5, 5, '24-DEC-2024', 3, 15, 'Action film');
INSERT INTO Customer (CustomerID, CustomerTitle, CustomerName, CustomerAddress, TelNo, Email) VALUES (1, 'Ms', 'Erling Haaland', '6 Gabriel Road', '01152385414', 'StayHumble@gmail.com');
INSERT INTO Customer (CustomerID, CustomerTitle, CustomerName, CustomerAddress, TelNo, Email) VALUES (2, 'Mr', 'Christiano Ronaldo', '7 Trafford Road', '01552001469', 'Ronaldosiu@gmail.com');
INSERT INTO Customer (CustomerID, CustomerTitle, CustomerName, CustomerAddress, TelNo, Email) VALUES (3, 'Mr', 'Jose Mourinho', '1 Porto St', '01146521345', 'TheSpecialOne@hotmail.com');
INSERT INTO Customer (CustomerID, CustomerTitle, CustomerName, CustomerAddress, TelNo, Email) VALUES (4, 'Ms', 'Mikel Arteta', '12 Hornsey Rd', '07998458712', 'MikelArteta@hotmail.com');
INSERT INTO Customer (CustomerID, CustomerTitle, CustomerName, CustomerAddress, TelNo, Email) VALUES (5, 'Ms', 'Eric Ten Hag', '14 Manchester Rd', '03321456987', 'WeNeverLose@gmail.com');
INSERT INTO DateDimension(DateID, FullDate, Year, Month, Day) VALUES (1, '1-DEC-2024', 2024, 12, 1);
INSERT INTO DateDimension(DateID, FullDate, Year, Month, Day) VALUES (2, '2-DEC-2024', 2024, 12, 2);
INSERT INTO DateDimension(DateID, FullDate, Year, Month, Day) VALUES (3, '24-NOV-2024', 2024, 11, 24);
INSERT INTO DateDimension(DateID, FullDate, Year, Month, Day) VALUES (4, '7-FEB-2024', 2024, 2, 7);
INSERT INTO DateDimension(DateID, FullDate, Year, Month, Day) VALUES (5, '6-APR-2024', 2024, 4, 6);
INSERT INTO DateDimension(DateID, FullDate, Year, Month, Day) VALUES (6, '16-MAY-2024', 2024, 5, 16);
INSERT INTO DateDimension(DateID, FullDate, Year, Month, Day) VALUES (7, '19-AUG-2024', 2024, 8, 19);
INSERT INTO DateDimension(DateID, FullDate, Year, Month, Day) VALUES (8, '23-SEP-2024', 2024, 9, 23);

-- 1. Yearly total sale for each theatre. 
-- Select theatre name, extract the year from performance date in performance table and name it as year, sum of sales total amount and name it as TotalSales
SELECT the.TheatreName,EXTRACT(Year FROM per.pDate) AS Year, SUM(sf.TotalAmount) AS TotalSales
-- from SalesFact table with sf in short form
FROM SalesFact sf
-- Join Performance table by PerformanceNo
JOIN Performance per on sf.PerformanceNo = per.PerformanceNo
-- Join Theatre table by TheatreNo
JOIN Theatre the on sf.TheatreNo = the.TheatreNo
-- Results grouping by theatre name and year, using ROLLUP to calculate the standard aggregate values specified in the GROUP BY clause, creates progressively higher-level subtotals and creates a grand total
Group By ROLLUP (the.TheatreName, Extract(YEAR from per.pDate))
-- Order the result by theatre name, and then year in ascending
Order by the.TheatreName, Year;

-- 2. Average sales across each month for each theatre.  
SELECT TheatreName, TO_CHAR(per.pDate, 'YYYY-MM') as Month, avg(TotalAmount)
-- from SalesFact table with sf in short form
from SalesFact sf
-- Join Performance table by PerformanceNo
join Performance per on sf.PerformanceNo = per.PerformanceNo
-- Join Theatre table by TheatreNo
join Theatre the on sf.TheatreNo = the.TheatreNo
-- grouping theatre name and performance name, create all combinations of them by using CUBE
Group by CUBE (the.TheatreName, per.pDate)
-- Order the result by theatre name, and then month in ascending
order by TheatreName, Month;

-- 3. All clients who visited LTC theatres in at least 4 different months in a year.  
-- select distinct customerID and their name
select distinct CustomerID, CustomerName
-- subquery to calculate visit year, month and rankings for customers
from (
-- select customerID and name, extract year from performance date and name as visited Year, format the performance date and extract Month as string, 
-- Using DENSE_RANK to rank over each unique month in a year, partition by customerID and visit year from performancce date, ordered by month
SELECT cu.CustomerID, cu.CustomerName, extract(YEAR from per.pDate) as VisitedYear, TO_Char(per.pDate, 'MM') AS Month, DENSE_RANK() over (Partition by cu.CustomerID, extract (year from per.pDate) order by to_char (per.pDate, 'MM')) as MonthRanking
-- from SalesFact table with sf in short form
From SalesFact sf
-- Join Performance table by PerformanceNo
join Performance per on sf.PerformanceNo = per.PerformanceNo
-- Join Theatre table by TheatreNo
join Theatre the on sf.TheatreNo = the.TheatreNo
-- Join Customer table by CustomerID
join Customer cu on sf.CustomerID = cu.CustomerID)
-- Group by CustomerID, after that Customer Name and visited year
Group by CustomerID, CustomerName, VisitedYear
-- only display 4 or above distinct months 
having COUNT (Distinct Month)>=4;

-- 4. List of the titles, production directors and play authors of all products with the highest total sale.  
-- Select production title, director and play author
SELECT ProductionTitle, ProductionDirector, PlayAuthor
-- subquery to calculate the sum of total sales, and to rank productions by total sales
from (
-- Select production title, director and play author, calculate total sale of each production, rank over productions by total sales and named as SalesRanking
select pro.ProductionTitle, pro.ProductionDirector, pro.PlayAuthor, SUM(sf.TotalAmount) as TotalSale, RANK() OVER (Order by SUM(sf.TotalAmount)DESC) AS SalesRanking
-- from SalesFact table with sf in short form
From SalesFact sf
-- Join Performance table by PerformanceNo
Join Performance per on sf.PerformanceNo = per.PerformanceNo
-- Join Production table by ProductionNo
join Production pro on per.ProductionNo = pro.ProductionNo
-- group by production title, then director and play author
group by pro.ProductionTitle, pro.ProductionDirector, pro.PlayAuthor)
-- find the highest total sales of production
where SalesRanking = 1;





