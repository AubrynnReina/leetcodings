-- My solution: And I guess those who knows DENSE_RANK()
-- would do the same?
SELECT 
    score, 
    DENSE_RANK() OVER(ORDER BY score DESC) AS rank
FROM scores