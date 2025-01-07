with cte as (select order_date,item_brand , seller_id , rank() over ( partition by o.seller_id  order by o.order_date) as 'rnk'
from orders o join items i on o.item_id=i.item_id )

, cte2 as ( select * from cte where rnk=2)
select user_id as 'seller_id', case
when rnk=2 and  item_brand = favorite_brand then 'yes'
else 'no'
end as '2nd_item_fav_brand'
 from users left join cte2 on cte2.seller_id=users.user_id 