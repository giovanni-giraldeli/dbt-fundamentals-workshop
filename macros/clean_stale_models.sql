{#  
    -- let's develop a macro that 
    1. queries the information schema of a database
    2. finds objects that are > 1 week old (no longer maintained)
    3. generates automated drop statements
    4. has the ability to execute those drop statements

#}

{% macro clean_stale_models(database=target.database, schema=target.schema, days=7, dry_run=TRUE) %}
    
    {% set get_drop_commands_query %}
        SELECT
            CASE
                WHEN table_type = 'VIEW'
                    THEN 'VIEW'
                ELSE 'TABLE'
            END AS drop_type,
            'DROP ' || drop_type || ' {{database | upper}}' || table_schema || '.' || table_name || ';' AS drop_statement
        FROM
            {{ database }}.information_schema.tables
        WHERE
            table_schema = UPPER( '{{ schema }}' )
            AND last_altered <= CURRENT_DATE - {{ days }}
        ORDER BY
            last_altered DESC
    {% endset %}

    {{ log('\nGenerating cleanup queries...\n', info=True) }}

    {% set drop_queries = run_query(get_drop_commands_query).columns[1].values() %}

    {% for query in drop_queries %}
        {% if dry_run %}
            {{ log(query, info=True) }}
        {% else %}
            {{ log('Dropping object with command: ' ~ query, info=True) }}
            {% do run_query(query) %} 
        {% endif %}       
    {% endfor %}
    
{% endmacro %} 
