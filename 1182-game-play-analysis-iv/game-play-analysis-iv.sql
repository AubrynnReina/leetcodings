SELECT
    ROUND(
        CAST(COUNT(DISTINCT(player_id)) AS DECIMAL) / (
            SELECT COUNT(DISTINCT(player_id))
            FROM Activity
        ), 2
    ) AS fraction
FROM (
    SELECT 
        player_id,
        event_date,
        MIN(event_date) OVER(PARTITION BY player_id) first_event
    FROM activity
)
WHERE event_date - first_event = 1
