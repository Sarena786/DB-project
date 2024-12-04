-- Active: 1733124735108@@dpg-ct6kb61u0jms7399gihg-a.singapore-postgres.render.com@5432
DROP TABLE IF EXISTS Items;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS User;

CREATE TABLE User (
    User_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    Password VARCHAR(100),
    Phone_Number VARCHAR(15)
);

CREATE TABLE Products (
    Product_ID INT PRIMARY KEY AUTO_INCREMENT,
    Price DECIMAL(10, 2)
);

CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY AUTO_INCREMENT,
    User_ID INT,
    Order_Date DATE,
    Total_Price DECIMAL(10, 2),
    Status VARCHAR(50),
    FOREIGN KEY (User_ID) REFERENCES User(User_ID)
);

CREATE TABLE Items (
    Order_Item_ID INT PRIMARY KEY AUTO_INCREMENT,
    Order_ID INT,
    Product_ID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

CREATE TABLE Inventory (
    Product_ID INT PRIMARY KEY,
    Stock_Quantity INT,
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

--just creating tables here 