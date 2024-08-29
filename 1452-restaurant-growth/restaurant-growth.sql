-- Write your PostgreSQL query statement below
SELECT 
    visited_on,

    SUM(total_per_day) OVER(
        ORDER BY visited_on
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS amount,

    ROUND(
        AVG(total_per_day) OVER(
            ORDER BY visited_on
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        )
    , 2) AS average_amount
    
FROM (
    SELECT
        visited_on,
        SUM(amount) as total_per_day
    FROM customer
    GROUP BY visited_on
)
OFFSET 6