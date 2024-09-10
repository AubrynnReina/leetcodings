WITH rows_with_over_100_people AS (
    SELECT 
        id, 
        visit_date, 
        people, 
        id - ROW_NUMBER() OVER (ORDER BY id) AS diff
    FROM Stadium
    WHERE people >= 100
)
SELECT
    id,
    visit_date,
    people
FROM rows_with_over_100_people
WHERE diff IN (
    SELECT diff
    FROM rows_with_over_100_people
    GROUP BY diff
    HAVING COUNT(*) >= 3
)
ORDER BY visit_date;