SELECT 
    p.product_id,
    p.product_name,
    p.unit_price
FROM 
    products p
WHERE 
    p.unit_price > (SELECT AVG(unit_price) FROM products)
    AND EXISTS (
        SELECT 1 
        FROM order_details od 
        JOIN orders o ON od.order_id = o.order_id
        WHERE od.product_id = p.product_id
        AND o.order_date > DATE_SUB(CURRENT_DATE(), INTERVAL 6 MONTH)
    )
ORDER BY 
    p.unit_price DESC;
