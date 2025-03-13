-- Creating a macro to add filtering conditions in dev environment so that we retrieve less data when running in dev
---- The 'default' value for "target.name" was set when setting up the connection with the database and it can be modified in the settings
{%- macro limit_data_in_dev( column_name, dev_days_of_data=3 ) %}
    {%- if target.name == 'default' -%}
        WHERE {{ column_name }} >= DATEADD(day, -{{ dev_days_of_data }}, CURRENT_DATE)
    {% endif %}
{%- endmacro %}