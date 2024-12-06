-- Active: 1733124735108@@dpg-ct6kb61u0jms7399gihg-a.singapore-postgres.render.com@5432@my_database@public
Drop Table branches;
DROP Table users;
DROP Table products;
DROP Table inventory;
DROP Table orders;
DROP Table items;
Drop Table user_total_spent;
DROP TABLE restock_orders;
Drop TABLE sales;

CREATE TABLE Branches  (
    Branch_ID INT PRIMARY KEY ,
    Branch_Name VARCHAR(100),
    Location VARCHAR(255),
    Manager VARCHAR(100),
    Phone_Number VARCHAR(15)
);

CREATE TABLE Users (
    User_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    Password VARCHAR(100),
    Phone_Number VARCHAR(15),
    Address VARCHAR(255)
);

    
CREATE TABLE Products (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(255),
    Price DECIMAL(10, 2)
);

CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    User_ID INT,
    Branch_ID INT,
    Order_Date DATE,
    Product_ID INT,
    Total_Price DECIMAL(10, 2),
    Status VARCHAR(50),
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID),
    Foreign Key (Branch_ID) REFERENCES Branches(Branch_ID)
);

CREATE TABLE Items (
    Order_Item_ID INT PRIMARY KEY,
    Order_ID INT,
    Product_ID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

CREATE TABLE Inventory (
    Product_ID INT PRIMARY KEY,
    Branch_ID Int,
    Stock_Quantity INT,
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID),
    Foreign Key (Branch_ID) REFERENCES Branches(Branch_ID)
);
ALTER TABLE Inventory
ADD CONSTRAINT unique_product_branch UNIQUE (Product_ID, Branch_ID);


CREATE TABLE User_Total_Spent (
    User_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone_Number VARCHAR(15),
    Address VARCHAR(255),
    Total_Spent DECIMAL(10, 2)
);

CREATE TABLE Restock_Orders (
    Restock_Order_ID INT PRIMARY KEY,
    Branch_ID INT,  
    Product_ID INT,                 
    Restock_Order_Date DATE,                 
    Quantity INT,                     
    Status VARCHAR(50),
    FOREIGN KEY (Branch_ID) REFERENCES Branches(Branch_ID),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

CREATE SEQUENCE IF NOT EXISTS sales_sale_id_seq START 1; -- Create a sequence to auto-generate Sale_ID values
CREATE TABLE Sales (
    Sale_ID INT DEFAULT nextval('sales_sale_id_seq') PRIMARY KEY,
    Branch_ID INT,
    Product_ID INT,
    User_ID INT,
    Sale_Date DATE,
    Quantity INT,                           -- Quantity sold
    Total_Amount DECIMAL(10, 2),            -- Total amount for the sale (quantity * price)
    FOREIGN KEY (Branch_ID) REFERENCES Branches(Branch_ID),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID),
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID)
);




