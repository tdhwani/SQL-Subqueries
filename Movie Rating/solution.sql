select 
  name as results 
from 
  (
    select 
      t1.user_id, 
      name, 
      count(movie_id) as movies 
    from 
      Users as t1 
      left join MovieRating as t2 on t1.user_id = t2.user_id 
    group by 
      t1.user_id 
    order by 
      movies desc, 
      name asc 
    limit 
      1
  ) as q1 
UNION ALL 
select 
  title as results 
from 
  (
    select 
      t3.movie_id, 
      title, 
      avg(rating) as avgrate 
    from 
      Movies as t3 
      left join MovieRating as t4 on t3.movie_id = t4.movie_id 
    where 
      year(created_at) = '2020' 
      and month(created_at) = '2' 
    group by 
      t3.movie_id 
    order by 
      avgrate desc, 
      title asc 
    limit 
      1
  ) as q2;
