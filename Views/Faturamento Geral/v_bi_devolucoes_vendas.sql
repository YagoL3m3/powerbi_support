-- public.v_bi_devolucoes_vendas source

CREATE OR REPLACE VIEW public.v_bi_devolucoes_vendas
AS SELECT
        CASE sintab12.ntab_caterev_12
            WHEN 1 THEN 'LEVES'::text
            WHEN 2 THEN 'PESADOS'::text
            WHEN 3 THEN 'MOTOS'::text
            WHEN 4 THEN 'MAQUINAS'::text
            ELSE NULL::text
        END AS negocio_descricao,
    sintab12.ntab_regirev_12 AS numero_regiao,
        CASE sintab12.ntab_tiporev_12
            WHEN 1 THEN 'FIAT'::text
            WHEN 2 THEN 'VOLKSWAGEN'::text
            WHEN 3 THEN 'FORD'::text
            WHEN 6 THEN 'KIA'::text
            WHEN 17 THEN 'NEW-HOLLAND'::text
            ELSE NULL::text
        END AS tipo_empresa,
    notenti.enti_emitent_1 AS empresa_codigo,
    notenti.enti_nronota_1 AS nota_numero,
    notenti.enti_sernota_1 AS nota_serie,
    sintab12.ntab_empabrv_12 AS empresa_nome_abreviado,
    sintab12.ntab_grpemit_12 AS empresa_grupo_codigo,
    sinc13.sinc_descric_13 AS empresa_grupo_descricao,
    notenti.enti_recpdat_1 AS nota_data,
    sintab24.ntab_tipomov_24 AS nota_movimento_tipo,
    e.ncad_siglest_2 AS empresa_uf,
    notsaii.saii_departa_1 AS nota_departamento_codigo,
    sintab02.ntab_nomeori_2 AS nota_departamento_descricao,
    notsaii.saii_subdept_1 AS nota_subdepartamento_codigo,
    estpro.tpro_codlinh_1 AS item_linha_codigo,
    l.ntab_desclin_6 AS item_linha_descricao,
    estpro.tpro_sublinh_1 AS item_sublinha_codigo,
    s.ntab_desclin_6 AS item_sublinha_descricao,
    notenti.enti_natoper_1 AS nota_movimento_cfop,
    notenti.enti_codprod_1 AS item_codigo,
    estpro.tpro_descric_1 AS item_descricao,
        CASE
            WHEN estpro.tpro_veiculo_1 = 0 THEN 'VEICULO'::text
            ELSE 'PECAS'::text
        END AS pecas_servico_veiculo,
    notsaii.saii_vendedo_1 AS vendedor_item_codigo,
    ve.dven_nomeven_1 AS vendedor_descricao_por_item,
    notenti.enti_valoicm_1::numeric(15,2) AS impostos_icms,
    notenti.enti_valopis_1::numeric(15,2) AS impostos_pis,
    notenti.enti_valocof_1::numeric(15,2) AS impostos_cofins,
    notenti.enti_custota_1::numeric(15,2) AS nota_item_custo,
    notenti.enti_quantid_1::numeric(15,2) AS nota_item_quantidade,
    notenti.enti_totitem_1 + round(notenti.enti_totitem_1 * (notent.tent_valfret_1 / notent.tent_totmerc_1), 2) AS valor_devolucao_liquido,
    notenti.enti_tiponot_1 AS nota_tiponota_codigo,
    notent.tent_fornece_1 AS cliente_codigo,
    c.ncad_nomecli_2 AS cliente_nome,
    c.ncad_tipocad_2 AS cliente_tipo_codigo,
    notsai.tsai_notavis_1 AS nota_movimentacao_avista,
    c.ncad_siglest_2 AS cliente_uf,
    sintab24.ntab_descric_24 AS nota_tiponota_descricao,
    notsaii.saii_emitent_1 AS referencia_saida_empresa,
    notsaii.saii_nronota_1 AS referencia_saida_nota,
    notsaii.saii_sernota_1 AS referencia_saida_serie,
    notsaii.saii_codprod_1 AS referencia_saida_produto,
    notsaii.saii_seqnota_1 AS referencia_saida_produto_sequencia
   FROM notenti
     LEFT JOIN notent ON notent.tent_fornece_1 = notenti.enti_fornece_1 AND notent.tent_nronota_1 = notenti.enti_nronota_1 AND notent.tent_sernota_1::text = notenti.enti_sernota_1::text AND notent.tent_especie_1::text = notenti.enti_especie_1::text AND notent.tent_emitent_1 = notenti.enti_emitent_1
     LEFT JOIN notdevv ON notdevv.devv_emitent_1 = notenti.enti_emitent_1 AND notdevv.devv_notaent_1 = notenti.enti_nronota_1 AND notdevv.devv_serient_1::text = notenti.enti_sernota_1::text AND notdevv.devv_espeent_1::text = notenti.enti_especie_1::text AND notdevv.devv_fornece_1 = notenti.enti_fornece_1 AND notdevv.devv_codprod_1::text = notenti.enti_codprod_1::text AND notdevv.devv_emiprod_1 = notenti.enti_emiprod_1 AND notdevv.devv_seqnent_1 = notenti.enti_seqnota_1
     LEFT JOIN notsaii ON notsaii.saii_emitent_1 = notdevv.devv_emitsai_1 AND notsaii.saii_nronota_1 = notdevv.devv_notasai_1 AND notsaii.saii_sernota_1::text = notdevv.devv_serisai_1::text AND notsaii.saii_codprod_1::text = notdevv.devv_codprod_1::text AND notsaii.saii_emiprod_1 = notdevv.devv_emiprod_1 AND notsaii.saii_seqnota_1 = notdevv.devv_seqnsai_1
     LEFT JOIN notsai ON notsai.tsai_emitent_1 = notsaii.saii_emitent_1 AND notsai.tsai_nronota_1 = notsaii.saii_nronota_1 AND notsai.tsai_sernota_1::text = notsaii.saii_sernota_1::text
     LEFT JOIN estpro ON estpro.tpro_codprod_1::text = notenti.enti_codprod_1::text
     LEFT JOIN estprod ON estprod.prod_empresa_1 = notenti.enti_emitent_1 AND estprod.prod_codprod_1::text = notenti.enti_codprod_1::text
     LEFT JOIN sintab12 ON sintab12.ntab_emitent_12 = notenti.enti_emitent_1
     LEFT JOIN sincad e ON e.ncad_cgcocpf_2 = sintab12.ntab_cgcemit_12
     LEFT JOIN sinc13 ON sinc13.sinc_grpemit_13 = sintab12.ntab_grpemit_12
     LEFT JOIN sintab24 ON sintab24.ntab_tiponfs_24 = notenti.enti_tiponot_1
     LEFT JOIN sintab02 ON sintab02.ntab_codorig_2 =
        CASE COALESCE(notsaii.saii_departa_1, 0)
            WHEN 0 THEN notent.tent_departa_1
            ELSE notsaii.saii_departa_1
        END
     LEFT JOIN sintab06 l ON l.ntab_codlinh_6::text = estpro.tpro_codlinh_1::text AND l.ntab_sublinh_6::text = ' '::text
     LEFT JOIN sintab06 s ON s.ntab_codlinh_6::text = estpro.tpro_codlinh_1::text AND s.ntab_sublinh_6::text = estpro.tpro_sublinh_1::text
     LEFT JOIN cadven ve ON ve.dven_codvend_1 = notsai.tsai_vendedo_1
     LEFT JOIN sincad c ON c.ncad_cgcocpf_2 = notent.tent_fornece_1
     LEFT JOIN cadcom m ON c.ncad_cgcocpf_2 = m.dcom_cgcocpf_1
  WHERE notent.tent_situaca_1::text <> 'C'::text AND sintab24.ntab_tipomov_24 = 3 AND notenti.enti_custoss_1 = 1;