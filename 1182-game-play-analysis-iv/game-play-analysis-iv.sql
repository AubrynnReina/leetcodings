-- -- My solution (Used Window Function)
-- SELECT
--     ROUND(
--         CAST(COUNT(DISTINCT(player_id)) AS DECIMAL) / (
--             SELECT COUNT(DISTINCT(player_id))
--             FROM Activity
--         ), 2
--     ) AS fraction
-- FROM (
--     SELECT 
--         player_id,
--         event_date,
--         MIN(event_date) OVER(PARTITION BY player_id) first_event
--     FROM Activity
-- )
-- WHERE event_date - first_event = 1

-- -- Another solution (Used WHERE - IN)
SELECT
    ROUND(
        CAST(COUNT(*) AS DECIMAL) / (
            SELECT COUNT(DISTINCT(player_id))
            FROM Activity
        ), 2
    ) AS fraction
FROM Activity
WHERE (player_id, event_date) IN (
    SELECT 
        player_id,
        MIN(event_date) + INTERVAL '1 day' AS day_after_first
    FROM Activity
    GROUP BY player_id
)
