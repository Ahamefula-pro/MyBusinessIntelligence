
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='view', bind=False) }}

with sales as (

    select * from {{ ref('stg_sales') }}

),

users as (

    select * from {{ ref('stg_users') }}

),

first_purchase as (
    select commission, buyer_id
    from sales

),

final as (

    select distinct
        u.userid,
        u.username,
        cast((u.lastname||', '||u.firstname) as varchar(100)) as full_name,
        city,
        state,
        email,
        phone,
        likebroadway,
        likeclassical,
        likeconcerts,
        likejazz,
        likemusicals,
        likeopera,
        likerock,
        likesports,
        liketheatre,
        likevegas
    from 
        sales as s
            join users as u on u.userid = s.buyer_id
            join first_purchase as f on f.buyer_id = s.buyer_id
    order by 
        userid

)

select * from final

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
