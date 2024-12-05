-- Active: 1733294799547@@dpg-ct6kb61u0jms7399gihg-a@5432

CREATE TABLE Users (
    User_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    Password VARCHAR(100),
    Phone_Number VARCHAR(15),
    Address VARCHAR(255)
);
        
DROP TABLE products;
CREATE TABLE Products (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(255),
    Price DECIMAL(10, 2)
);

CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    User_ID INT,
    Order_Date DATE,
    Total_Price DECIMAL(10, 2),
    Status VARCHAR(50),
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID)
);

CREATE TABLE Items (
    Order_Item_ID INT PRIMARY KEY,
    Order_ID INT,
    Product_ID INT,
    Product_Name VARCHAR(255),
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

CREATE TABLE User_Total_Spent (
    User_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone_Number VARCHAR(15),
    Address VARCHAR(255),
    Total_Spent DECIMAL(10, 2)
);

