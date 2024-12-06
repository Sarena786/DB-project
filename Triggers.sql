-------------------------------------------------------------------------------------



-- Manage Trigger in Orders :
-- Items
-- Sales
-- Restock

------------------------Trigger for Populating Items Table from Orders----------------------------------
CREATE OR REPLACE FUNCTION populate_items_from_orders()
RETURNS TRIGGER AS $$
BEGIN
    -- Insert a corresponding row into the Items table for each new Order
    INSERT INTO Items (Order_ID, Product_ID, Branch_ID, Quantity, Price)
    VALUES (
        NEW.Order_ID,
        NEW.Product_ID, 
        NEW.Branch_ID,
        1, -- Default quantity
        (SELECT Price FROM Products WHERE Product_ID = NEW.Product_ID) -- Fetch the price
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Update the trigger
DROP TRIGGER IF EXISTS after_order_insert_items ON Orders;

CREATE TRIGGER after_order_insert_items
AFTER INSERT ON Orders
FOR EACH ROW
EXECUTE FUNCTION populate_items_from_orders();

--------------Trigger for Inserting Sales Record on Completed Orders------------------

CREATE OR REPLACE FUNCTION insert_sales_trigger()
RETURNS TRIGGER AS $$
BEGIN
    -- Insert a record into the Sales table for completed orders
    INSERT INTO Sales (Branch_ID, Product_ID, User_ID, Sale_Date, Quantity, Total_Amount)
    VALUES (
        NEW.Branch_ID,
        NEW.Product_ID,
        NEW.User_ID,
        NEW.Order_Date,
        1,  -- Default quantity
        NEW.Total_Price
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

---------------- Restock inventory if the stock is low -----------------------

INSERT INTO Restock_Orders (Branch_ID, Product_ID, Restock_Order_Date, Quantity, Status)
SELECT Branch_ID, Product_ID, CURRENT_DATE, 50, 'Pending'
FROM Inventory
WHERE Stock_Quantity < 10
  AND NOT EXISTS (
      SELECT 1
      FROM Restock_Orders
      WHERE Restock_Orders.Product_ID = Inventory.Product_ID
        AND Restock_Orders.Branch_ID = Inventory.Branch_ID
        AND Restock_Orders.Restock_Order_Date = CURRENT_DATE
  );

------------------------------------------------------------------------------