SELECT * FROM Orders WHERE User_ID = 1;


SELECT * FROM Items WHERE Order_ID = 1;


SELECT * FROM Inventory;


SELECT o.Order_ID, o.Order_Date, o.Total_Price, u.Name, u.Email
FROM Orders o
JOIN User u ON o.User_ID = u.User_ID;
