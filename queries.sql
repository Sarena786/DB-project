SELECT * FROM Orders;
SELECT * FROM Items;
SELECT DISTINCT Product_ID FROM Items;
SELECT DISTINCT Product_ID FROM Inventory;
SELECT * FROM Inventory;

SELECT o.Order_ID, o.Order_Date, o.Total_Price, u.Name, u.Email
FROM Orders o
JOIN users u ON o.User_ID = u.User_ID;

UPDATE Inventory
SET Stock_Quantity = Inventory.Stock_Quantity - i.Quantity
FROM Items i
WHERE Inventory.Product_ID = i.Product_ID
  AND Inventory.Stock_Quantity >= i.Quantity;




SELECT b.Branch_Name, p.Product_ID, p.Price, i.Stock_Quantity --selecting the branch name, product id, price, and stock quantity
FROM Inventory i -- see if the branch have the stock for an item
JOIN Products p ON i.Product_ID = p.Product_ID
JOIN Branches b ON i.Branch_ID = b.Branch_ID;

SELECT o.Order_ID, o.Total_Price, o.Status, b.Branch_Name --selecting the order id, total price, status, and branch name
FROM Orders o  --shows that if the product that is ordered
JOIN Branches b ON o.Branch_ID = b.Branch_ID
WHERE b.Branch_ID = 1;

UPDATE Inventory --updating the stock quantity of product 101 in branch 1
SET Stock_Quantity = Stock_Quantity - 5
WHERE Product_ID = 101 AND Branch_ID = 1;

SELECT * FROM Orders;

SELECT * FROM Products;

SELECT * FROM Branches;