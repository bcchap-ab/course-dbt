{%- macro pct_formatter(numerator, denominator) -%}

round({{ dbt_utils.safe_divide(numerator, denominator) }} * 100, 2)

 
{%- endmacro -%}