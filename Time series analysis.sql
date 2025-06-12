WITH daily_sales AS (
    SELECT
        DATE_TRUNC('day', order_date) AS day,
        COUNT(DISTINCT order_id) AS order_count,
        SUM(quantity * unit_price) AS total_revenue
    FROM
        orders o
    JOIN
        order_details od ON o.order_id = od.order_id
    WHERE
        order_date BETWEEN '2023-01-01' AND '2023-12-31'
    GROUP BY
        DATE_TRUNC('day', order_date)
)
SELECT
    day,
    order_count,
    total_revenue,
    AVG(total_revenue) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS weekly_avg_revenue,
    total_revenue - LAG(total_revenue, 1) OVER (ORDER BY day) AS daily_revenue_change,
    (total_revenue - LAG(total_revenue, 7) OVER (ORDER BY day)) / 
    NULLIF(LAG(total_revenue, 7) OVER (ORDER BY day), 0) * 100 AS weekly_growth_pct
FROM
    daily_sales
ORDER BY
    day;
