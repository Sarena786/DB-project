DELIMITER //

CREATE PROCEDURE CalculateTotalPrice(IN orderID INT, OUT totalPrice DECIMAL(10,2))
BEGIN
    SELECT SUM(Price * Quantity) INTO totalPrice
    FROM Items
    WHERE Order_ID = orderID;
END //

DELIMITER ;
