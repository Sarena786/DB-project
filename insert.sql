
INSERT INTO User (Name, Email, Password, Phone_Number) VALUES
('Alice', 'alice@example.com', 'password123', '1234567890'),
('Bob', 'bob@example.com', 'password456', '0987654321');


INSERT INTO Products (Price) VALUES
(100.00), (200.00), (300.00);


INSERT INTO Orders (User_ID, Order_Date, Total_Price, Status) VALUES
(1, '2024-01-01', 300.00, 'Completed'),
(2, '2024-01-05', 200.00, 'Processing');


INSERT INTO Items (Order_ID, Product_ID, Quantity, Price) VALUES
(1, 1, 2, 100.00),
(2, 2, 1, 200.00);


INSERT INTO Inventory (Product_ID, Stock_Quantity) VALUES
(1, 50), (2, 30), (3, 20);
