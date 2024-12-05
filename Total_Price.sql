SELECT 
    o.Order_ID,
    o.Order_Date,
    o.Total_Price,
    u.User_ID,
    u.Name,
    u.Email,
    u.Phone_Number,
    u.Address
FROM 
    Orders o
JOIN 
    Users u ON o.User_ID = u.User_ID;
