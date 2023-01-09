
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table', sort='sales_id', dist='sales_id') }}

with categories as (

    select * from {{ ref('stg_category') }}

),


events as (

    select * from {{ ref('stg_events') }}

),

listings as (

    select * from {{ ref('stg_listing') }}

),

sales as (

    select * from {{ ref('stg_sales') }}

),










buyers as (

    select * from {{ ref('sat_buyers_from_users') }}

),

event_categories as (

	select 
        e.eventid,
        e.eventname,
		c.catgroup,
		c.catname
	from events as e
		join categories as c on c.catid = e.catid

),

final as (

    select
        s.sale_id,
        ec.catgroup,
        ec.catname,
        ec.eventname,
        b.username as buyer_username,
        b.full_name as buyer_name,
        b.state as buyer_state,
        
        s.ticket_price,
        s.qty_sold,
        s.price_paid,
        s.commission_prcnt,
        s.commission,
        s.earnings
    from 
        sales as s
            join listings as l on l.listid = s.list_id
            join buyers as b on b.userid = s.buyer_id

            join event_categories as ec on ec.eventid = s.event_id
    
    order by
        sale_id
)

select * from final

/*
    Uncomment the line below to remove records with null `id` values
*/
