
INSERT INTO Users (User_ID , Name, Email, Password, Phone_Number,Address) VALUES
('1', 'Alice', 'alice@example.com', 'password123', '1234567890','123 Main St, Springfield, IL 62701'),
('2', 'Bob', 'bob@example.com', 'password456', '0987654321','456 Elm St, Springfield, IL 62702'),
('3', 'Carol', 'carol@example.com', 'password789', '1122334455', '789 Oak St, Springfield, IL 62703'),
('4', 'David', 'david@example.com', 'password101', '9988776655', '321 Pine St, Springfield, IL 62704');


INSERT INTO Products (Product_ID, Product_Name, Price)
VALUES (1, 'Gray Cat Plushie', 350.00),
       (2, 'Light Purple Rabbit Plushie', 350.00),
       (3, 'Pink Rabbit Plushie', 350.00),
       (4, 'Orange Tiger Plushie', 350.00),
       (5, 'Brown Bear Plushie', 400.00),
       (6, 'Beige Bear Plushie', 400.00);


INSERT INTO Orders (Order_ID, User_ID, Branch_ID, Order_Date, Total_Price, Status)
VALUES
    (1, 1, 1, '2024-01-01', 350.00, 'Completed'),
    (2, 1, 1, '2024-01-02', 350.00, 'Processing'),
    (3, 2, 1, '2024-01-03', 400.00, 'Completed'),
    (4, 2, 1, '2024-01-04', 400.00, 'Processing'),
    (5, 3, 1, '2024-01-05', 350.00, 'Completed'),
    (6, 3, 1, '2024-01-06', 350.00, 'Completed'),
    (7, 4, 1, '2024-01-07', 400.00, 'Completed'),
    (8, 4, 1, '2024-01-08', 400.00, 'Processing');




INSERT INTO Items (Order_item_ID, Order_ID, Product_ID, Quantity, Price)
VALUES
(1, 1, 2, 1, (SELECT Price FROM Products WHERE Product_ID = 2)),
(2, 2, 1, 2, (SELECT Price FROM Products WHERE Product_ID = 1));



INSERT INTO Inventory (Product_ID, Branch_ID, Stock_Quantity)
VALUES
    (1, 1, 50),  
    (2, 2, 30),  
    (3, 3, 40), 
    (4, 4, 20), 
    (5, 5, 10), 
    (6, 1, 15);


INSERT INTO User_Total_Spent (User_ID, Name, Email, Phone_Number, Address, Total_Spent)
SELECT 
    u.User_ID,
    u.Name,
    u.Email,
    u.Phone_Number,
    u.Address,
    SUM(o.Total_Price) AS Total_Spent
FROM 
    Users u
JOIN 
    Orders o ON u.User_ID = o.User_ID
GROUP BY 
    u.User_ID, u.Name, u.Email, u.Phone_Number, u.Address;
--to find the total price of the orders for each user

INSERT INTO Branches (Branch_ID,Branch_Name, Location, Manager, Phone_Number)
VALUES ('1','Chiang Mai', 'Maya Lifestyle Mall', 'John Doe', '098-765-4321'),
         ('2','Bangkok', 'Siam Paragon', 'Jane Doe', '098-765-4321'),
         ('3','Phuket', 'Jungceylon', 'John Smith', '098-765-4321'),
         ('4','Pattaya', 'Central Festival', 'Jane Smith', '098-765-4321');
