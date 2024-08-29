-- My solution: I kept it as simple as it is,
-- augment the query til I get the right answer
-- (LEFT JOIN --> GROUP BY --> AGGREGATION --> ROUNDING --> COALESCE)
-- 192ms - 95.72%
SELECT 
    p.product_id,
    COALESCE(
        ROUND(
            CAST(SUM(p.price * u.units) AS DECIMAL) /
            SUM(u.units)
        , 2)
    , 0) AS average_price
FROM Prices p
LEFT JOIN UnitsSold u
ON (
    p.product_id = u.product_id AND
    u.purchase_date BETWEEN p.start_date AND p.end_date
)
GROUP BY p.product_id
