WITH product_pairs AS (
    SELECT
        a.product_id AS product1,
        b.product_id AS product2,
        COUNT(DISTINCT a.order_id) AS pair_count
    FROM order_details a
    JOIN order_details b ON a.order_id = b.order_id AND a.product_id < b.product_id
    GROUP BY a.product_id, b.product_id
    HAVING COUNT(DISTINCT a.order_id) >= 5
),
product_counts AS (
    SELECT
        product_id,
        COUNT(DISTINCT order_id) AS product_count
    FROM order_details
    GROUP BY product_id
)
SELECT
    pp.product1,
    p1.product_name AS product1_name,
    pp.product2,
    p2.product_name AS product2_name,
    pp.pair_count,
    pc1.product_count AS product1_total,
    pc2.product_count AS product2_total,
    ROUND((pp.pair_count * 100.0) / pc1.product_count, 2) AS product1_lift,
    ROUND((pp.pair_count * 100.0) / pc2.product_count, 2) AS product2_lift,
    ROUND((pp.pair_count * 100.0) / 
          (SELECT COUNT(DISTINCT order_id) FROM orders WHERE order_date >= DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH)), 4) AS pair_support
FROM product_pairs pp
JOIN products p1 ON pp.product1 = p1.product_id
JOIN products p2 ON pp.product2 = p2.product_id
JOIN product_counts pc1 ON pp.product1 = pc1.product_id
JOIN product_counts pc2 ON pp.product2 = pc2.product_id
ORDER BY pair_count DESC
LIMIT 100;
