with source as (

    select * from {{ source('jaffle_shop', 'customers') }}
    
),

renamed as (

    select

         -- ids
        id as customer_id,  -- rename for clarity

        -- strings
        first_name,
        last_name

    from source

)

select * from renamed