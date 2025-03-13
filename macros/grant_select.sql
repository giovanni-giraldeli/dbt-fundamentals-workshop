{% macro grant_select(schema=target.schema, role=target.role) %}
    
    {% set query %}
        GRANT USAGE ON SCHEMA {{ schema }} TO ROLE {{ role }};
        GRANT SELECT TO ALL TABLES IN SCHEMA {{ schema }} TO ROLE {{ role }};
        GRANT SELECT TO ALL VIEWS IN SCHEMA {{ schema }} TO ROLE {{ role }};
    {% endset %}

    {{ log('Granting select on all tables and views in schema ' ~ schema ~ ' to role ' ~ role, info=True) }}
    {% do run_query(query) %}
    {{ log('Privileges granted!', info=True) }}

{% endmacro %}