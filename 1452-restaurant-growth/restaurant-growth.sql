-- -- My solution: I handled this problem before
-- -- I gave up, now I'm back with some knowledge of Window functions 
-- -- and picking out rows for partitions
-- -- Not likely an optimal solution, but I'm proud that I got it this time
-- -- 239ms, 30%
-- SELECT 
--     visited_on,

--     SUM(total_per_day) OVER(
--         ORDER BY visited_on
--         ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
--     ) AS amount,

--     ROUND(
--         AVG(total_per_day) OVER(
--             ORDER BY visited_on
--             ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
--         )
--     , 2) AS average_amount

-- FROM (
--     SELECT
--         visited_on,
--         SUM(amount) as total_per_day
--     FROM customer
--     GROUP BY visited_on
-- )
-- OFFSET 6

-- Another solution: 
-- This one doesn't even need a window function
-- Now I'm mad =='
-- It used CTE tho :o

WITH last_6_days AS (
    SELECT DISTINCT visited_on
    FROM customer
    ORDER BY visited_on
    OFFSET 6
)

SELECT
    cte_c.visited_on,
    SUM(c.amount) AS amount,
    ROUND(SUM(C.amount) / 7., 2) AS average_amount
FROM last_6_days AS cte_c
INNER JOIN customer as c
ON c.visited_on BETWEEN 
    cte_c.visited_on - INTERVAL '6 days' AND
    cte_c.visited_on
GROUP BY cte_c.visited_on