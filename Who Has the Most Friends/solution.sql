with q1 as (
  select 
    t1.id, 
    t1.cnt + IFNULL(t2.cnt, 0) as num 
  from 
    (
      select 
        requester_id as id, 
        count(accepter_id) as cnt 
      from 
        RequestAccepted 
      group by 
        requester_id
    ) as t1 
    left JOIN (
      select 
        accepter_id as id, 
        count(requester_id) as cnt 
      from 
        RequestAccepted 
      group by 
        accepter_id
    ) as t2 on t1.id = t2.id 
  UNION 
  select 
    t2.id, 
    IFNULL(t1.cnt, 0) + t2.cnt as num 
  from 
    (
      select 
        requester_id as id, 
        count(accepter_id) as cnt 
      from 
        RequestAccepted 
      group by 
        requester_id
    ) as t1 
    right JOIN (
      select 
        accepter_id as id, 
        count(requester_id) as cnt 
      from 
        RequestAccepted 
      group by 
        accepter_id
    ) as t2 on t1.id = t2.id
) 
select 
  * 
from 
  q1 
where 
  num = (
    select 
      max(num) 
    from 
      q1
  );
