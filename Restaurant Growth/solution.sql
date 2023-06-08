WITH CTE AS (
  SELECT 
    visited_on, 
    COUNT(visited_on) OVER W as day_cnt, 
    SUM(
      SUM(amount)
    ) OVER W AS amount, 
    ROUND(
      AVG(
        sum(amount)
      ) OVER W, 
      2
    ) AS average_amount 
  FROM 
    customer 
  GROUP BY 
    1 WINDOW W AS (
      ORDER BY 
        visited_on ROWS BETWEEN 6 PRECEDING 
        and CURRENT ROW
    )
) 
SELECT 
  visited_on, 
  amount, 
  average_amount 
from 
  cte 
WHERE 
  day_cnt = 7;
