{%- macro union_relations_by_prefix(database, schema, prefix) -%}

    {%- set tables=dbt_utils.get_relations_by_prefix(DATABASE=database, SCHEMA=schema, PREFIX=prefix) -%}
    
        {% for table in tables %}
        
            {%- if not loop.first -%}
                UNION ALL
            {%- endif %}

            SELECT * FROM {{ table.database }}.{{ table.schema }}.{{ table.name }}

        {% endfor -%}

{%- endmacro -%}