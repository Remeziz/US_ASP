{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "main",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('na_get_fba_fulfillmen_1_replacement_data_ab3') }}
select
    quantity,
    {{ adapter.quote('original-amazon-order-id') }},
    {{ adapter.quote('replacement-amazon-order-id') }},
    {{ adapter.quote('fulfillment-center-id') }},
    {{ adapter.quote('shipment-date') }},
    {{ adapter.quote('replacement-reason-code') }},
    asin,
    sku,
    {{ adapter.quote('original-fulfillment-center-id') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_na_get_fba_f__placement_data_hashid
from {{ ref('na_get_fba_fulfillmen_1_replacement_data_ab3') }}
-- na_get_fba_fulfillmen__ment_replacement_data from {{ source('main', '_airbyte_raw_na_get_f__ment_replacement_data') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

