{# // how incremental load we can use jinja to create dynamic sql query #}

{% set inc_flag = 1%}
{% set inc_last_load = 3 %}

{% set cols_list = ["sales_id", "date_sk", "gross_amount"] %}
SELECT 
{% for i in cols_list %}
{{i}}
{% if not loop.last %},{% endif %}
{% endfor %}
FROM
{{ ref('bronze_sale') }}
{% if inc_flag == 1 %}
 WHERE date_sk > {{ inc_last_load }}
{% endif %}