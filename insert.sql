
INSERT INTO Users (User_ID , Name, Email, Password, Phone_Number) VALUES
('1', 'Alice', 'alice@example.com', 'password123', '1234567890'),
('2', 'Bob', 'bob@example.com', 'password456', '0987654321');


INSERT INTO Products (Product_ID, Product_Name, Price)
VALUES (1, 'Gray Cat Plushie', 350.00),
       (2, 'Light Purple Rabbit Plushie', 350.00),
       (3, 'Pink Rabbit Plushie', 350.00),
       (4, 'Orange Tiger Plushie', 350.00),
       (5, 'Brown Bear Plushie', 400.00),
       (6, 'Beige Bear Plushie', 400.00);


INSERT INTO Orders (Order_ID , User_ID, Order_Date, Total_Price, Status) VALUES
(1, 1, '2024-01-01', 300.00, 'Completed'),
(2, 2, '2024-01-05', 200.00, 'Processing');


INSERT INTO Items (Order_item_ID, Order_ID, Product_ID, Quantity, Price)
VALUES
(1, 1, 2, 1, (SELECT Price FROM Products WHERE Product_ID = 2)),
(2, 2, 1, 2, (SELECT Price FROM Products WHERE Product_ID = 1));



INSERT INTO Inventory (Product_ID, Stock_Quantity)
VALUES (1, 30),
       (2, 30),
       (3, 30),
       (4, 30),
       (5, 30),
       (6, 30);
