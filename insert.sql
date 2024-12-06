-- Active: 1733294799547@@dpg-ct6kb61u0jms7399gihg-a@5432
INSERT INTO Branches (Branch_ID, Branch_Name, Location, Manager, Phone_Number)
VALUES
    (1, 'Teddy4U Central', '123 Main St, Teddy, IL 62701', 'Alice Johnson', '123-456-7890'),
    (2, 'Teddy4U West', '456 Elm St, Teddy, IL 62702', 'Bob Smith', '098-765-4321'),
    (3, 'Teddy4U East', '789 Oak St, Teddy, IL 62703', 'Carol Davis', '112-233-4455'),
    (4, 'Teddy4U South', '321 Pine St, Teddy, IL 62704', 'David Thompson', '998-877-6655');

INSERT INTO Users (User_ID , Name, Email, Password, Phone_Number, address) 
VALUES
    (1, 'Kayla', 'kayla@example.com', 'password123', '1234567890', '123 Main St, Springfield, IL 62701'),
    (2, 'Ken', 'Ken@example.com', 'password456', '0987654321', '456 Elm St, Springfield, IL 62702'),
    (3, 'Bobby', 'bobby@example.com', 'password789', '1122334455', '789 Oak St, Springfield, IL 62703'),
    (4, 'Katie', 'katie@example.com', 'password101', '9988776655', '321 Pine St, Springfield, IL 62704');

INSERT INTO Products (Product_ID, Product_Name, Price)
VALUES (1, 'Gray Cat Plushie', 350.00),
       (2, 'Light Purple Rabbit Plushie', 350.00),
       (3, 'Pink Rabbit Plushie', 350.00),
       (4, 'Orange Tiger Plushie', 350.00),
       (5, 'Brown Bear Plushie', 400.00),
       (6, 'Beige Bear Plushie', 400.00);

INSERT INTO inventory (Product_ID, Branch_ID, Stock_quantity)
VALUES
    (1, 1, 9), (1, 2, 30), (1, 3, 30), (1, 4, 30),
    (2, 1, 30), (2, 2, 30), (2, 3, 30), (2, 4, 30),
    (3, 1, 30), (3, 2, 30), (3, 3, 30), (3, 4, 30),
    (4, 1, 30), (4, 2, 30), (4, 3, 30), (4, 4, 30),
    (5, 1, 30), (5, 2, 30), (5, 3, 30), (5, 4, 30),
    (6, 1, 30), (6, 2, 30), (6, 3, 30), (6, 4, 30)
ON CONFLICT (Product_ID, Branch_ID)
DO UPDATE
SET Stock_Quantity = EXCLUDED.Stock_Quantity;
-- Insert products in Inventory in all branches

SELECT * FROM inventory;

--Trigger before placing orders

-- Place orders

INSERT INTO Orders (Order_ID, User_ID, Branch_ID, Order_Date, Product_ID, Total_Price, Status) -- Now, insert data into Orders table
VALUES
    (1, 1, 1, '2024-01-01', 1, 350.00, 'Completed'),    -- Order from 'Teddy4U Central'
    (2, 1, 2, '2024-01-02', 2, 350.00, 'Processing'),   -- Order from 'Teddy4U West'
    (3, 2, 3, '2024-01-03', 3, 400.00, 'Completed'),    -- Order from 'Teddy4U East'
    (4, 2, 4, '2024-01-04', 4, 400.00, 'Processing'),   -- Order from 'Teddy4U South'
    (5, 3, 1, '2024-01-05', 5, 350.00, 'Completed'),    -- Order from 'Teddy4U Central'
    (6, 3, 2, '2024-01-06', 6, 350.00, 'Completed'),    -- Order from 'Teddy4U West'
    (7, 4, 3, '2024-01-07', 1, 400.00, 'Completed'),    -- Order from 'Teddy4U East'
    (8, 4, 4, '2024-01-08', 2, 400.00, 'Processing');   -- Order from 'Teddy4U South'


----------------------- ------------ TEST -----------------------------------------


SELECT * From items;
SELECT * FROM orders;
SELECT * FROM Sales;
SELECT * FROM restock_orders;
SELECT * FROM inventory;

---------------------------adjusted inventory based on sales----------------------
UPDATE Inventory
SET Stock_Quantity = Stock_Quantity - s.Quantity
FROM Sales s
WHERE Inventory.Product_ID = s.Product_ID
  AND Inventory.Branch_ID = s.Branch_ID;


SELECT * FROM inventory;



----------------- Reset Sequence of Order_Item_ID-------------------------
ALTER SEQUENCE sales_sale_id_seq RESTART WITH 1; --reset sales table
ALTER SEQUENCE restock_order_id_seq RESTART WITH 1;


-- Reset Data in Orders Table
DELETE From orders;
DELETE FROM inventory;
DELETE FROM sales;
DELETE FROM items;
DELETE FROM restock_orders;
--------------------------------------------------------------------------
DELETE FROM User_Total_Spent
WHERE User_ID IN (
    SELECT u.User_ID
    FROM Users u
    JOIN Orders o ON u.User_ID = o.User_ID
    GROUP BY u.User_ID
);

INSERT INTO User_Total_Spent (User_ID, Name, Email, Phone_Number, Address, Branch_ID, Total_Spent)
SELECT 
    u.User_ID,
    u.Name,
    u.Email,
    u.Phone_Number,
    u.Address,
    o.Branch_ID,
    SUM(o.Total_Price) AS Total_Spent
FROM 
    Users u
JOIN 
    Orders o ON u.User_ID = o.User_ID
GROUP BY 
    u.User_ID, u.Name, u.Email, u.Phone_Number, u.Address, o.Branch_ID;


SELECT * FROM user_total_spent;


INSERT INTO Payment (Order_ID, User_ID, Payment_Date, Payment_Method)
SELECT 
    O.Order_ID,
    O.User_ID,
    CURRENT_DATE, 
    'Credit Card'
FROM Orders O
JOIN Users U ON O.User_ID = U.User_ID
WHERE O.Order_ID = 1;

INSERT INTO Payment (Order_ID, User_ID, Payment_Date, Payment_Method)
SELECT 
    O.Order_ID,
    O.User_ID,
    CURRENT_DATE,
    'PayPal'
FROM Orders O
JOIN Users U ON O.User_ID = U.User_ID
WHERE O.Order_ID = 2;

INSERT INTO Payment (Order_ID, User_ID, Payment_Date, Payment_Method)
SELECT 
    O.Order_ID,
    O.User_ID,
    CURRENT_DATE,
    'Bank Transfer' 
FROM Orders O
JOIN Users U ON O.User_ID = U.User_ID
WHERE O.Order_ID = 2;