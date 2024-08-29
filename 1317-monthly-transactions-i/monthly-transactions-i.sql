-- -- My solution (Used CASE WHEN as COUNTIF, SUMIF)
-- SELECT
--     TO_CHAR(trans_date, 'YYYY-MM') AS "month",
--     -- month is a keyword, should be in quotes for clarity
--     country,
--     COUNT(*) AS trans_count,
--     SUM(CASE 
--         WHEN state = 'approved' 
--         THEN 1 
--         ELSE 0 END
--     ) AS approved_count,

--     SUM(amount) AS trans_total_amount,
--     SUM(CASE 
--         WHEN state = 'approved'
--         THEN amount
--         ELSE 0 END) AS approved_total_amount

-- FROM transactions
-- GROUP BY month, country

-- Another solution (Used FILTER and COALESCE)
-- This solution is really fast (450ms compare to 750ms of mine)
SELECT
    TO_CHAR(trans_date, 'YYYY-MM') AS "month",
    -- month is a keyword, should be in quotes for clarity
    country,
    COUNT(*) AS trans_count,
    COUNT(*) FILTER (
        WHERE state = 'approved'
    ) AS approved_count,

    SUM(amount) AS trans_total_amount,
    COALESCE(
        SUM(amount) FILTER (
            WHERE state = 'approved'
        ), 0
    ) AS approved_total_amount

FROM transactions
GROUP BY month, country