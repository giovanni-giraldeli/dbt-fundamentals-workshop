{# -- Comenting because this package was calling a Snowflake function, while I'm developing in Redshift -- keeping for studying purposes

-- Would union every table that starts with 'orders__' in their names
{{
    union_tables_by_prefix(
      database='raw',
      schema='dbt_learn_jinja', 
      prefix='orders__' 
      )
}}

#}

SELECT 1