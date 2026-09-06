{% macro generate_schema_name(custom_schema_name, node) -%}

    {% set custom_schema_name_cleansed = custom_schema_name | trim | upper %}
    {% set target_schema_cleansed = target.schema | trim | upper %}

    {%- if custom_schema_name is none -%}
        {# Sin custom schema: usa siempre el target schema de profiles.yml #}
        {{ target_schema_cleansed }}
    {%- else -%}

        {%- if target.name == 'prod' -%}
            {# En producción: usa únicamente el custom schema limpio (ej. MART) #}
            {{ custom_schema_name_cleansed }}
        {%- else -%}
            {# En Dev, Staging o ramas de CI: concatena con tu schema personal #}
            {{ target_schema_cleansed }}_{{ custom_schema_name_cleansed }}
        {%- endif -%}

    {%- endif -%}

{%- endmacro %}