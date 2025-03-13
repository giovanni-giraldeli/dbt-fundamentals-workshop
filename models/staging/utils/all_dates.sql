-- Creating a table with all the dates in a specified range

{{ 
    config (
        materialized="table"
    )
}}

{{ date_spine(
    "day",
    "to_date('01/01/2020', 'mm/dd/yyyy')",
    "to_date('12/31/2020', 'mm/dd/yyyy')"
) }}