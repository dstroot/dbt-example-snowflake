with source as (

    select * from {{ source('jaffle_shop', 'orders') }}
    
),

renamed as (

    select

        -- ids
        id as order_id,         -- rename for clarity
        user_id as customer_id, -- rename for consistency

        -- strings
        status,

        -- dates
        order_date,

        -- timestamps
        _etl_loaded_at::timestamp_ltz as loaded_timestamp

    from source

)

select * from renamed
