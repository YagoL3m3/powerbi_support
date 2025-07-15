-- public.v_bi_estoque_produtos source

CREATE OR REPLACE VIEW public.v_bi_estoque_produtos
AS SELECT a.prod_empresa_1 AS codigo_empresa,
	c.ntab_empabrv_12 AS descricao_empresa,
    a.prod_codprod_1 AS codigo_produto,
    b.tpro_descric_1 AS descricao_produto,
    b.tpro_codlinh_1 AS codigo_linha,
    b.tpro_sublinh_1 AS codigo_sub_linha,
    e.ntab_desclin_6 AS descricao_linha_sublinha,
    a.prod_txesgot_1 AS taxa_esgotamento,
    btrim(upper(b.tpro_unimedi_1::text)) AS codigo_medida,
    a.prod_qtdtota_1 AS quantidade,
    a.prod_custota_1 AS custo_total,
    a.prod_ultcust_1 AS ultimo_custo_unitario,
    a.prod_precove_1 AS preco_venda_varejo,
    a.prod_precven_1_o1 AS preco_venda_atacado,
    a.prod_locacao_1_o1 AS codigo_locacao,
    NULLIF(a.prod_dtulcom_1, '1899-12-30'::date) AS ultima_compra,
    NULLIF(a.prod_dtulven_1, '1899-12-30'::date) AS ultima_venda,
        CASE
            WHEN a.prod_cancela_1::text = 'I'::text THEN 'INATIVO'::text
            WHEN a.prod_cancela_1::text = 'S'::text THEN 'SUBSTITUIDO'::text
            WHEN a.prod_cancela_1::text = 'C'::text THEN 'CANCELADO'::text
            WHEN a.prod_cancela_1::text = 'F'::text THEN 'FORA DE LINHA'::text
            WHEN a.prod_cancela_1::text = 'B'::text THEN 'BLOQUEADO'::text
            WHEN a.prod_cancela_1::text = 'A'::text THEN 'ATIVO'::text
            ELSE NULL::text
        END AS status,
    a.prod_curvabc_1 AS curva_venda,
    a.prod_curvend_1 AS curva_demanda,
    a.prod_curvfr1_1::text || a.prod_curvfr2_1::text AS curva_frequencia
   FROM estprod a
     LEFT JOIN estpro b ON a.prod_codprod_1::text = b.tpro_codprod_1::text
     LEFT JOIN sintab12 c ON c.ntab_emitent_12 = a.prod_empresa_1
     LEFT JOIN sintab64 d ON d.ntab_grupdes_64::text = b.tpro_grupdes_1::text
     LEFT JOIN sintab06 e ON (e.ntab_codlinh_6::text || e.ntab_sublinh_6::text) = (b.tpro_codlinh_1::text || b.tpro_sublinh_1::text)
  WHERE b.tpro_codlinh_1::text <> ALL (ARRAY['VN'::character varying::text, 'VU'::character varying::text, 'IM'::character varying::text]);