select
s.nota_numero,
s.empresa_grupo_descricao,
s.nota_serie,
s.nota_numero||' '||s.nota_serie as nota_numserie,
s.empresa_codigo,
s.empresa_nome_abreviado as empresa_descricao,
s.empresa_uf as uf,
s.item_linha_descricao as linha_descricao,
s.item_sublinha_descricao as sublinha_descricao,
s.nota_movimento_cfop as cfop,
s.item_descricao,
s.item_codigo,
s.cliente_nome as cliente_descricao,
extract(year from nota_faturamento_data) as ano,
extract(month from nota_faturamento_data) as mes,
extract(day from nota_faturamento_data) as dia,
nota_faturamento_data,
case when s.nota_item_quantidade = 0 then 0 else (valor_liquido - valor_desconto_proporcional + valor_desconto + valor_acrescimo_proporcional + valor_seguro + valor_despesas_acessorias + valor_frete + impostos_st + impostos_ipi )/s.nota_item_quantidade end as preco_medio,
valor_custo_ultima_compra as custo_ultima_compra,
valor_custo_reposicao as custo_reposicao,
s.nota_item_custo as custo_medio,
s.pecas_servico_veiculo as tipo,
s.nota_item_quantidade as quantidade,
(valor_liquido - valor_desconto_proporcional + valor_desconto + valor_acrescimo_proporcional + valor_seguro + valor_despesas_acessorias + valor_frete + impostos_st + impostos_ipi) as faturamento_bruto,
s.valor_desconto,
valor_desconto_proporcional,
valor_acrescimo,
valor_acrescimo_proporcional,
valor_seguro,
valor_despesas_acessorias,
valor_frete,
impostos_st,
impostos_icms,
impostos_pis,
impostos_cofins,
valor_iss,
impostos_ipi,
impostos_csll,
dven_nomeven_1,
nota_movimento_tipo,
case when nota_condicao_codigo in (4,2,3,1,5,6,7,8,9,10) then 1 else (T05.NTAB_DIAPARC_5_O1 + T05.NTAB_DIAPARC_5_O2 + T05.NTAB_DIAPARC_5_O3 + T05.NTAB_DIAPARC_5_O4 + T05.NTAB_DIAPARC_5_O5 + T05.NTAB_DIAPARC_5_O6 
+ T05.NTAB_DIAPARC_5_O7 + T05.NTAB_DIAPARC_5_O8 + T05.NTAB_DIAPARC_5_O9 + T05.NTAB_DIAPARC_5_O10) / NTAB_QTDPARC_5 end as prazo_medio
from v_bi_saidas s
left join cadven on dven_codvend_1 = vendedor_nota_codigo
LEFT JOIN SINTAB05 T05 ON (nota_condicao_codigo = T05.NTAB_CONDPGT_5)
where s.nota_faturamento_data between '2024-01-01' and '2024-12-31'

select nota_numero,
SUM(valor_liquido - valor_desconto_proporcional - valor_desconto + valor_acrescimo_proporcional + valor_seguro + valor_despesas_acessorias + valor_frete + impostos_st + impostos_ipi) as total_faturamento_bruto,
SUM(valor_liquido) as valor_liquido,
SUM(valor_desconto_proporcional) as valor_desconto_proporcional,
SUM(valor_desconto) as valor_desconto,
SUM(valor_acrescimo_proporcional) as valor_acrescimo_proporcional,
SUM(valor_seguro) as valor_seguro,
SUM(valor_despesas_acessorias) as valor_despesas_acessorias,
SUM(valor_frete) as valor_frete,
SUM(impostos_st) as impostos_st,
SUM(impostos_ipi) as impostos_ipi
from v_bi_saidas
where nota_faturamento_data between '2024-01-01' and '2024-01-02' and empresa_codigo = 1
group by 1

select SUM(valor_liquido - valor_desconto_proporcional - valor_desconto + valor_acrescimo_proporcional + valor_seguro + valor_despesas_acessorias + valor_frete + impostos_st + impostos_ipi) as total_faturamento_bruto,
SUM(valor_liquido) as valor_liquido,
SUM(valor_desconto_proporcional) as valor_desconto_proporcional,
SUM(valor_desconto) as valor_desconto,
SUM(valor_acrescimo_proporcional) as valor_acrescimo_proporcional,
SUM(valor_seguro) as valor_seguro,
SUM(valor_despesas_acessorias) as valor_despesas_acessorias,
SUM(valor_frete) as valor_frete,
SUM(impostos_st) as impostos_st,
SUM(impostos_ipi) as impostos_ipi
from v_bi_saidas
where nota_faturamento_data between '2024-01-01' and '2024-01-02' and empresa_codigo = 1


select  SUM(valor_liquido - valor_desconto_proporcional - valor_desconto + valor_acrescimo_proporcional + valor_seguro + valor_despesas_acessorias + valor_frete + impostos_st + impostos_ipi) as total_faturamento_bruto,
SUM(valor_liquido) as valor_liquido,
SUM(valor_desconto_proporcional) as valor_desconto_proporcional,
SUM(valor_desconto) as valor_desconto,
SUM(valor_acrescimo_proporcional) as valor_acrescimo_proporcional,
SUM(valor_seguro) as valor_seguro,
SUM(valor_despesas_acessorias) as valor_despesas_acessorias,
SUM(valor_frete) as valor_frete,
SUM(impostos_st) as impostos_st,
SUM(impostos_ipi) as impostos_ipi
from v_bi_saidas
where nota_faturamento_data between '2024-03-01' and '2024-03-31' and pecas_servico_veiculo = 'servico' and empresa_codigo = 1

