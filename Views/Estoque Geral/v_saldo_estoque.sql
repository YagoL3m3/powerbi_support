select
s.nota_numero,
s.empresa_grupo_descricao,
s.nota_serie,
s.nota_numero||' '||s.nota_serie as nota_numserie,
s.empresa_codigo,
s.empresa_codigo || ' - ' || nota_faturamento_data as cod_data,
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
,desc_municipio
,uf_nota
,saii_valiqui_1
from v_bi_saidas s
left join cadven on dven_codvend_1 = vendedor_nota_codigo
LEFT JOIN SINTAB05 T05 ON (nota_condicao_codigo = T05.NTAB_CONDPGT_5)
where s.nota_faturamento_data between '2024-01-01' and '2024-12-31'

SELECT  T.NTAB_EMPABRV_12 AS "EMPRESA"
       ,TO_CHAR(A.TPED_DATEMIS_1,'DD/MM') AS "DATA"
       ,(SELECT SUM(TAUX_VALOMED_1* C.PEDI_QUANTID_1) FROM NOTPEDI C
        INNER JOIN ESTAUX ON ( TAUX_CODINTE_1 = C.PEDI_CODPROD_1) 
         WHERE C.PEDI_EMITENT_1 = A.TPED_EMITENT_1 
           AND C.PEDI_NRONOTA_1 = A.TPED_NRONOTA_1 
           AND C.PEDI_SERNOTA_1 = A.TPED_SERNOTA_1 ) AS "LITROS"
       ,A.TPED_NOMECLI_1 AS "NOME"
       ,A.TPED_TOTNOTA_1 AS "VALOR"
       ,A.TPED_NRONOTA_1 AS "NR_PEDIDO",
       dven_nomeven_1 as "VENDEDOR",
       tsai_pedido1_1
   FROM NOTPED A
   JOIN notsai on tsai_pedido1_1 = A.TPED_NRONOTA_1 and tsai_datproc_1 between '2024-01-01' AND '2024-12-31' 
   LEFT JOIN SINTAB12 T ON (A.TPED_EMITENT_1 = T.NTAB_EMITENT_12)
   LEFT JOIN CADVEN on dven_codvend_1 = tped_vendedo_1
   WHERE A.TPED_DATEMIS_1 BETWEEN '2024-01-01' AND '2024-12-31'
     AND A.TPED_SERNOTA_1 = 'PED'
     AND A.TPED_SITUACA_1 NOT IN ('C','N')
ORDER BY 1,5


select ntab_tipomov_24 from sintab24


select tsai_pedido1_1, tsai_pedido2_1, * from notsai

select * from sintab01

select  *from sintab00 s 

select tsai_datproc_1 from notsai

select * from notender n

select  *from sintab01



