-- with source as (
    
--     {#-
--     Normally we would select from the table here, but we are using seeds to load
--     our data in this project
--     #}
--     select * from {{ ref('raw_payments') }}

-- ),

-- renamed as (

--     select
--         id as payment_id,
--         order_id,
--         payment_method,

--         -- `amount` is currently stored in cents, so we convert it to dollars
--         amount / 100 as amount

--     from source

-- )

-- select * from renamed

-- ===============================================================

-- stg_stripe__payments.sql

-- Normally we would select from the table here, but we are 
-- using seeds to load our data in this project

with source as (

    -- select * from {{ source('stripe', 'payments') }}
    select * from {{ ref('raw_payments') }}

),

renamed as (

    select
        -- ids
        id as payment_id,
        orderid as order_id,

        -- strings
        paymentmethod as payment_method,
        case
            when payment_method in ('stripe', 'paypal', 'credit_card', 'gift_card') then 'credit'
            else 'cash'
        end as payment_type,
        status,

        -- numerics
         -- `amount` is currently stored in cents, so we convert it to dollars
        amount as amount_cents,
        amount / 100.0 as amount,
        
        -- booleans
        case
            when status = 'successful' then true
            else false
        end as is_completed_payment,

        -- dates
        date_trunc('day', created) as created_date,

        -- timestamps
        created::timestamp_ltz as created_at

    from source

)

select * from renamed