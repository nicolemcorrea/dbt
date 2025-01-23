with
    /* Chamada dos modelos necessários. */
    categorias as (select * from {{ ref("stg_erp__categories") }}),
    fornecedores as (select * from {{ ref("stg_erp__fornecedores") }}),
    produtos as (select * from {{ ref("stg_erp__produtos") }}),
    enriquecer_produtos as (
        select
            produtos.pk_produto,
            produtos.nm_produto,
            produtos.quantidade_por_unidade,
            produtos.preco_por_unidade,
            produtos.unidade_em_estoque,
            produtos.unidade_por_pedido,
            produtos.nivel_de_pedido,
            produtos.eh_discontinuado,
            categorias.nome_categoria,
            fornecedores.nome_fornecedor,
            fornecedores.cidade_fornecedor,
            fornecedores.pais_fornecedor
        from produtos
        left join categorias on produtos.fk_categoria = categorias.pk_categoria
        left join fornecedores on produtos.fk_fornecedor = fornecedores.pk_fornecedor
    )

select *
from enriquecer_produtos
