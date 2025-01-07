with cte1 as (select player_id,sum(total) as final_score 
from (select first_player as player_id, first_score as total from Matches
union all
select second_player as player_id ,second_score as total from Matches) as cte
group by player_id),

cte2 as(select p.player_id, p.group_id , rank () over( partition by p.group_id order by ifnull(c.final_score,0) desc, p.player_id ) as rnk 
from players p left join cte1 c 
on p.player_id=c.player_id )

select group_id, player_id from cte2 where rnk =1 