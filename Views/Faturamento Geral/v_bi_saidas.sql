-- public.v_bi_saidas fonte

CREATE OR REPLACE VIEW public.v_bi_saidas
AS SELECT
        CASE sintab12.ntab_caterev_12
            WHEN 1 THEN 'Leves'::text
            WHEN 2 THEN 'Pesados'::text
            WHEN 3 THEN 'Motos'::text
            WHEN 4 THEN 'Maquinas'::text
            ELSE NULL::text
        END AS negocio_descricao,
    sintab12.ntab_regirev_12 AS numero_regiao,
        CASE sintab12.ntab_tiporev_12
            WHEN 1 THEN 'Fiat'::text
            WHEN 2 THEN 'Volkswagen'::text
            WHEN 3 THEN 'Ford'::text
            WHEN 6 THEN 'Kia'::text
            WHEN 17 THEN 'New-Holland'::text
            ELSE NULL::text
        END AS tipo_empresa,
    notsaii.saii_emitent_1 AS empresa_codigo,
    notsaii.saii_nronota_1 AS nota_numero,
    notsaii.saii_sernota_1 AS nota_serie,
    sintab12.ntab_empabrv_12 AS empresa_nome_abreviado,
    sintab12.ntab_grpemit_12 AS empresa_grupo_codigo,
    sinc13.sinc_descric_13 AS empresa_grupo_descricao,
    notsaii.saii_procdat_1 AS nota_faturamento_data,
    sintab24.ntab_tipomov_24 AS nota_movimento_tipo,
    e.ncad_siglest_2 AS empresa_uf,
    notsaii.saii_departa_1 AS nota_departamento_codigo,
    sintab02.ntab_nomeori_2 AS nota_departamento_descricao,
    notsaii.saii_subdept_1 AS nota_subdepartamento_codigo,
    estpro.tpro_codlinh_1 AS item_linha_codigo,
    l.ntab_desclin_6 AS item_linha_descricao,
    estpro.tpro_sublinh_1 AS item_sublinha_codigo,
    s.ntab_desclin_6 AS item_sublinha_descricao,
    notsaii.saii_natoper_1 AS nota_movimento_cfop,
    notsaii.saii_codprod_1 AS item_codigo,
    estpro.tpro_descric_1 AS item_descricao,
    notsaii.saii_quantid_1::numeric(15,4) AS nota_item_quantidade,
    notsaii.saii_valiqui_1::numeric(15,2) AS valor_liquido,
    0::numeric(15,2) AS valor_desconto,
    notsaii.saii_descpro_1::numeric(15,2) AS valor_desconto_proporcional,
    0::numeric(15,2) AS valor_acrescimo,
    notsaii.saii_acrepro_1::numeric(15,2) AS valor_acrescimo_proporcional,
    notsaii.saii_segupro_1::numeric(15,2) AS valor_seguro,
    notsaii.saii_desppro_1::numeric(15,2) AS valor_despesas_acessorias,
    notsaii.saii_fretpro_1::numeric(15,2) AS valor_frete,
    notsaii.saii_valsubs_1::numeric(15,2) AS impostos_st,
        CASE
            WHEN estpro.tpro_veiculo_1 = 0 THEN 'veiculo'::text
            ELSE 'pecas'::text
        END AS pecas_servico_veiculo,
    ve.dven_nomeven_1 AS vendedor_descricao_por_item,
    notsaii.saii_valoicm_1::numeric(15,2) AS impostos_icms,
    0::numeric(15,2) AS valor_iss,
    notsaii.saii_valopis_1::numeric(15,2) AS impostos_pis,
    notsaii.saii_valocof_1::numeric(15,2) AS impostos_cofins,
    notsaii.saii_custota_1::numeric(15,2) AS nota_item_custo,
    notsai.tsai_nrordem_1 AS nota_ordem_servico,
    notsaii.saii_tiponot_1 AS nota_tiponota_codigo,
    notsai.tsai_cliente_1 AS cliente_codigo,
    c.ncad_nomecli_2 AS cliente_nome,
    c.ncad_tipocad_2 AS cliente_tipo_codigo,
    notsai.tsai_notavis_1 AS nota_movimentacao_avista,
    c.ncad_siglest_2 AS cliente_uf,
    sintab24.ntab_descric_24 AS nota_tiponota_descricao,
    notsai.tsai_condpgt_1 AS nota_condicao_codigo,
    notsaii.saii_vendedo_1 AS vendedor_item_codigo,
    notsai.tsai_vendedo_1 AS vendedor_nota_codigo,
    notsaii.saii_valoipi_1::numeric(15,2) AS impostos_ipi,
    notsaii.saii_cslreti_1::numeric(15,2) AS impostos_csll,
    notsaii.saii_precrep_1::numeric(15,2) AS valor_custo_reposicao,
    estprod.prod_cstucom_1::numeric(15,2) AS valor_custo_ultima_compra,
    sintab01.ntab_nomemun_1 AS desc_municipio,
    sintab00.ntab_nomesta_0 AS uf_nota,
    notsai.tsai_pedido1_1 AS num_pedido
   FROM notsaii
     LEFT JOIN notsai ON notsai.tsai_emitent_1 = notsaii.saii_emitent_1 AND notsai.tsai_nronota_1 = notsaii.saii_nronota_1 AND notsai.tsai_sernota_1::text = notsaii.saii_sernota_1::text
     LEFT JOIN estpro ON estpro.tpro_codprod_1::text = notsaii.saii_codprod_1::text
     LEFT JOIN estprod ON estprod.prod_empresa_1 = notsaii.saii_emitent_1 AND estprod.prod_codprod_1::text = notsaii.saii_codprod_1::text
     LEFT JOIN sintab12 ON sintab12.ntab_emitent_12 = notsaii.saii_emitent_1
     LEFT JOIN sincad e ON e.ncad_cgcocpf_2 = sintab12.ntab_cgcemit_12
     LEFT JOIN sinc13 ON sinc13.sinc_grpemit_13 = sintab12.ntab_grpemit_12
     LEFT JOIN sintab24 ON sintab24.ntab_tiponfs_24 = notsaii.saii_tiponot_1
     LEFT JOIN sintab02 ON sintab02.ntab_codorig_2 = notsaii.saii_departa_1
     LEFT JOIN sintab06 l ON l.ntab_codlinh_6::text = estpro.tpro_codlinh_1::text AND l.ntab_sublinh_6::text = ' '::text
     LEFT JOIN sintab06 s ON s.ntab_codlinh_6::text = estpro.tpro_codlinh_1::text AND s.ntab_sublinh_6::text = estpro.tpro_sublinh_1::text
     LEFT JOIN cadven ve ON ve.dven_codvend_1 = notsai.tsai_vendedo_1
     LEFT JOIN cadven co ON co.dven_codvend_1 = notsai.tsai_vendedo_1
     LEFT JOIN sincad c ON c.ncad_cgcocpf_2 = notsai.tsai_cliente_1
     LEFT JOIN cadcom m ON c.ncad_cgcocpf_2 = m.dcom_cgcocpf_1
     LEFT JOIN notender ON notsai.tsai_emitent_1 = notender.nder_emitent_1 AND notender.nder_nronota_1 = notsai.tsai_nronota_1 AND notsai.tsai_sernota_1::text = notender.nder_sernota_1::text AND notender.nder_espnota_1::text = notsai.tsai_espnota_1::text
     LEFT JOIN sintab01 ON notender.nder_codmuni_1 = sintab01.ntab_codmuni_1
     LEFT JOIN sintab00 ON sintab00.ntab_siglest_0::text = notsai.tsai_siglest_1::text
  WHERE notsai.tsai_situaca_1::text <> 'C'::text AND sintab24.ntab_tribicm_24 = 1 AND (sintab24.ntab_comissa_24 = 1 OR sintab24.ntab_tipomov_24 = 1)
UNION ALL
 SELECT
        CASE sintab12.ntab_caterev_12
            WHEN 1 THEN 'Leves'::text
            WHEN 2 THEN 'Pesados'::text
            WHEN 3 THEN 'Motos'::text
            WHEN 4 THEN 'Maquinas'::text
            ELSE NULL::text
        END AS negocio_descricao,
    sintab12.ntab_regirev_12 AS numero_regiao,
        CASE sintab12.ntab_tiporev_12
            WHEN 1 THEN 'Fiat'::text
            WHEN 2 THEN 'Volkswagen'::text
            WHEN 3 THEN 'Ford'::text
            WHEN 6 THEN 'Kia'::text
            WHEN 17 THEN 'New-Holland'::text
            ELSE NULL::text
        END AS tipo_empresa,
    notsais.tser_emitent_1 AS empresa_codigo,
    notsais.tser_nronota_1 AS nota_numero,
    notsais.tser_sernota_1 AS nota_serie,
    sintab12.ntab_empabrv_12 AS empresa_nome_abreviado,
    sintab12.ntab_grpemit_12 AS empresa_grupo_codigo,
    sinc13.sinc_descric_13 AS empresa_grupo_descricao,
    notsai.tsai_procdat_1 AS nota_faturamento_data,
    sintab24.ntab_tipomov_24 AS nota_movimento_tipo,
    e.ncad_siglest_2 AS empresa_uf,
    notsais.tser_departa_1 AS nota_departamento_codigo,
    sintab02.ntab_nomeori_2 AS nota_departamento_descricao,
    notsais.tser_subdept_1 AS nota_subdepartamento_codigo,
    notsais.tser_codlinh_1 AS item_linha_codigo,
    l.ntab_desclin_6 AS item_linha_descricao,
    notsais.tser_sublinh_1 AS item_sublinha_codigo,
    s.ntab_desclin_6 AS item_sublinha_descricao,
    notsais.tser_natoper_1 AS nota_movimento_cfop,
    notsais.tser_codserv_1::character varying(20) AS item_codigo,
    cadser.dser_descri1_1 AS item_descricao,
    notsais.tser_quantid_1::numeric(15,4) AS nota_item_quantidade,
    notsais.tser_valserv_1::numeric(15,2) AS valor_liquido,
    notsais.tser_descser_1::numeric(15,2) AS valor_desconto,
    notsais.tser_descpro_1::numeric(15,2) AS valor_desconto_proporcional,
    notsais.tser_acreser_1::numeric(15,2) AS valor_acrescimo,
    notsais.tser_acrepro_1::numeric(15,2) AS valor_acrescimo_proporcional,
    notsais.tser_segupro_1::numeric(15,2) AS valor_seguro,
    notsais.tser_desppro_1::numeric(15,2) AS valor_despesas_acessorias,
    notsais.tser_fretpro_1::numeric(15,2) AS valor_frete,
    0::numeric(15,2) AS impostos_st,
    'servico'::text AS pecas_servico_veiculo,
    ve.dven_nomeven_1 AS vendedor_descricao_por_item,
    0::numeric(15,2) AS impostos_icms,
    notsais.tser_valoiss_1::numeric(15,2) AS valor_iss,
    round(notsais.tser_valserv_1 * sintab12.ntab_percpis_12 / 100::numeric, 2)::numeric(15,2) AS impostos_pis,
    round(notsais.tser_valserv_1 * sintab12.ntab_pcofins_12 / 100::numeric, 2)::numeric(15,2) AS impostos_cofins,
    notsais.tser_customo_1::numeric(15,2) AS nota_item_custo,
    notsai.tsai_nrordem_1 AS nota_ordem_servico,
    notsais.tser_tiponot_1 AS nota_tiponota_codigo,
    notsai.tsai_cliente_1 AS cliente_codigo,
    c.ncad_nomecli_2 AS cliente_nome,
    c.ncad_tipocad_2 AS cliente_tipo_codigo,
    notsai.tsai_notavis_1 AS nota_movimentacao_avista,
    c.ncad_siglest_2 AS cliente_uf,
    sintab24.ntab_descric_24 AS nota_tiponota_descricao,
    notsai.tsai_condpgt_1 AS nota_condicao_codigo,
    notsais.tser_vendedo_1 AS vendedor_item_codigo,
    notsai.tsai_vendedo_1 AS vendedor_nota_codigo,
    0::numeric(15,2) AS impostos_ipi,
    notsais.tser_valocsl_1::numeric(15,2) AS impostos_csll,
    0::numeric(15,2) AS valor_custo_reposicao,
    0::numeric(15,2) AS valor_custo_ultima_compra,
    sintab01.ntab_nomemun_1 AS desc_municipio,
    sintab00.ntab_nomesta_0 AS uf_nota,
    notsai.tsai_pedido1_1 AS num_pedido
   FROM notsais
     LEFT JOIN notsai ON notsai.tsai_emitent_1 = notsais.tser_emitent_1 AND notsai.tsai_nronota_1 = notsais.tser_nronota_1 AND notsai.tsai_sernota_1::text = notsais.tser_sernota_1::text
     LEFT JOIN cadser ON cadser.dser_codserv_1 = notsais.tser_codserv_1
     LEFT JOIN sintab12 ON sintab12.ntab_emitent_12 = notsais.tser_emitent_1
     LEFT JOIN sincad e ON e.ncad_cgcocpf_2 = sintab12.ntab_cgcemit_12
     LEFT JOIN sinc13 ON sinc13.sinc_grpemit_13 = sintab12.ntab_grpemit_12
     LEFT JOIN sintab24 ON sintab24.ntab_tiponfs_24 = notsais.tser_tiponot_1
     LEFT JOIN sintab02 ON sintab02.ntab_codorig_2 = notsais.tser_departa_1
     LEFT JOIN sintab06 l ON l.ntab_codlinh_6::text = notsais.tser_codlinh_1::text AND l.ntab_sublinh_6::text = ' '::text
     LEFT JOIN sintab06 s ON s.ntab_codlinh_6::text = notsais.tser_codlinh_1::text AND s.ntab_sublinh_6::text = notsais.tser_sublinh_1::text
     LEFT JOIN cadven ve ON ve.dven_codvend_1 = notsai.tsai_vendedo_1
     LEFT JOIN cadven co ON co.dven_codvend_1 = notsai.tsai_vendedo_1
     LEFT JOIN sincad c ON c.ncad_cgcocpf_2 = notsai.tsai_cliente_1
     LEFT JOIN cadcom m ON c.ncad_cgcocpf_2 = m.dcom_cgcocpf_1
     LEFT JOIN notender ON notsai.tsai_emitent_1 = notender.nder_emitent_1 AND notender.nder_nronota_1 = notsai.tsai_nronota_1 AND notsai.tsai_sernota_1::text = notender.nder_sernota_1::text AND notender.nder_espnota_1::text = notsai.tsai_espnota_1::text
     LEFT JOIN sintab01 ON notender.nder_codmuni_1 = sintab01.ntab_codmuni_1
     LEFT JOIN sintab00 ON sintab00.ntab_siglest_0::text = notsai.tsai_siglest_1::text
  WHERE notsai.tsai_situaca_1::text <> 'C'::text AND sintab24.ntab_tribicm_24 = 1 AND notsai.tsai_espnota_1::text <> 'LIB'::text;