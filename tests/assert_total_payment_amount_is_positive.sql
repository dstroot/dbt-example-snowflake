-- payment amounts should be positive
select
    amount
from 
    {{ ref('stg_stripe__payments' )}}
having 
    not(amount >= 0)