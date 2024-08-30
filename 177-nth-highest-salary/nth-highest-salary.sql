CREATE OR REPLACE FUNCTION NthHighestSalary(N INT) RETURNS TABLE (Salary INT) AS $$
BEGIN
  RETURN QUERY (
    SELECT e_2.salary
    FROM (
        SELECT
            e.salary,
            dense_rank() OVER (ORDER BY e.salary DESC) AS rank
        FROM employee e
    ) e_2
    WHERE e_2.rank = N
    LIMIT 1     
  );
END;
$$ LANGUAGE plpgsql;