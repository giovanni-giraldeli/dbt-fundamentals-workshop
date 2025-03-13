-- Creating a macro to convert cents to dollars and round it by default for 2 decimal places

{%- macro cents_to_dollars(column_name, decimal_places=2) -%}
    ROUND( {{ column_name }} * 1.0 / 100, {{decimal_places}} )
{%- endmacro %}