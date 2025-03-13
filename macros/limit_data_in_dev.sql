-- Creating a macro to add filtering conditions in dev environment so that we retrieve less data when running in dev
{%- macro limit_data_in_dev( column_name, dev_days_of_data=3 ) %}
    {%- if target.name == 'dev' -%}
        WHERE {{ column_name }} >= DATEADD('day', -{{ dev_days_of_data }}, CURRENT_TIMESTAMP)
    {% endif %}
{%- endmacro %}