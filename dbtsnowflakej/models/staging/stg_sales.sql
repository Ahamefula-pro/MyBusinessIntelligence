
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='view', bind=False) }}

with source as (

    select * from {{ source('tickets', 'sales') }}

),

renamed as (

    select
        salesid as sale_id,
        listid as list_id,
        sellerid as seller_id,
        buyerid as buyer_id,
        eventid as event_id,
        dateid as date_id,
        qtysold as qty_sold,
        round (pricepaid / qtysold, 2) as ticket_price,
        pricepaid as price_paid,
        round((commission / pricepaid) * 100, 2) as commission_prcnt,
        commission,
        (pricepaid - commission) as earnings,
        salestime as sale_time
    from
        source
    where
        sale_id IS NOT NULL
    order by
        sale_id

)

select * from renamed

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
