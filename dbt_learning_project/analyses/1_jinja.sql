{%- set my_var = "Hellow worldss" -%} {{my_var -}}

{%- set color = ['blue', 'green', 'red'] -%}

{% for i in color %} 
{% if i != 'blue' %}
{{i}}
{{else}}
{{i}} is not allowed
{% endif %}
{% endfor %}