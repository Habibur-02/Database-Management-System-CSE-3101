SELECT
    p.product_id,
    p.product_name,
    p.category_id,
    c.category_name,
    p.unit_price,
    p.units_in_stock,
    p.units_on_order,
    p.reorder_level,
    p.units_in_stock - p.reorder_level AS above_reorder_level,
    CASE
        WHEN p.discontinued = 1 THEN 'Discontinued'
        WHEN p.units_in_stock <= 0 THEN 'Out of Stock'
        WHEN p.units_in_stock <= p.reorder_level THEN 'Reorder Now'
        WHEN p.units_in_stock <= (p.reorder_level * 1.5) THEN 'Monitor Closely'
        ELSE 'Adequate Stock'
    END AS inventory_status,
    SUM(od.quantity) AS units_sold_last_quarter,
    AVG(od.quantity) AS avg_order_quantity,
    p.units_in_stock / NULLIF(SUM(od.quantity)/90, 0) AS days_of_inventory
FROM
    products p
JOIN
    categories c ON p.category_id = c.category_id
LEFT JOIN
    order_details od ON p.product_id = od.product_id
LEFT JOIN
    orders o ON od.order_id = o.order_id
    AND o.order_date BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 90 DAY) AND CURRENT_DATE
GROUP BY
    p.product_id, p.product_name, p.category_id, c.category_name, 
    p.unit_price, p.units_in_stock, p.units_on_order, p.reorder_level, p.discontinued
HAVING
    p.discontinued = 0
ORDER BY
    inventory_status, days_of_inventory ASC;
