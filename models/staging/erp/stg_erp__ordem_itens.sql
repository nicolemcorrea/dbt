
with
    renomeado as (
        select
        -- jeito de criar uma surrogate key usando sql de concatenação. Nesse caso, por exemplo, eu teria uma NF10, produto 1, NF10, produto 2 
            orderid::varchar || '-' || productid::varchar as pk_pedido_item
            , cast(orderid as int) as fk_pedido
            , cast(productid as int) as fk_produto
            , cast(discount as numeric(18,2)) as desconto_perc
            , cast(unitprice as numeric(18,2)) as preco_da_unidade
            , cast(quantity as int) as quantidade
        from {{ source('erp', 'order_details') }}
    )

select *
from renomeado