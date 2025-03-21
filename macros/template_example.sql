{% macro template_example() %}
    {% set query %}
        SELECT TRUE AS bool
    {% endset %}
    {% if execute %}
        {% set results = run_query(query).columns[0].values()[0] %}
        {{ log('SQL results ' ~ results, info=True) }}

        SELECT
            {{results}} AS is_real

    {% endif %}
{% endmacro %}