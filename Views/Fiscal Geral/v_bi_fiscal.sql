-- public.v_bi_fiscal source

CREATE OR REPLACE VIEW public.v_bi_fiscal
AS SELECT 'E'::text AS tipo,
    v_emitente.codigo AS empresa,
    notenti.enti_nronota_1 AS nota,
    notenti.enti_especie_1 AS especie,
    notenti.enti_natoper_1 AS cfop,
    (lpad(sintab23.ntab_codigos_23::character varying::text, 3, '0'::text) || ' - '::text) || sintab23.ntab_descric_23::text AS tipo_lancamento,
    notent.tent_datemis_1 AS data_emissao,
    notent.tent_datproc_1 AS data_lancamento,
    notent.tent_recpdat_1 AS data_entrada,
    notent.tent_fornece_1 AS emitente_destinatario,
    sincad.ncad_nomecli_2 AS nome,
    notent.tent_siglest_1 AS uf,
    notent.tent_chavnfe_1 AS chave_acesso,
    notenti.enti_totitem_1 - notenti.enti_descpro_1 + notenti.enti_valoipi_1 + notenti.enti_acrepro_1 + notenti.enti_desppro_1 + notenti.enti_valsubs_1 + notenti.enti_fretpro_1 AS valor_contabil,
    notenti.enti_codprod_1 AS codigo,
    notenti.enti_descric_1::text || notenti.enti_descri2_1::text AS descricao,
    notenti.enti_clafisc_1 AS ncm,
    notenti.enti_quantid_1 AS quantidade,
    notenti.enti_valunit_1 AS unitario,
    notenti.enti_totitem_1 AS valor_total,
    notenti.enti_descpro_1 AS desconto,
    notenti.enti_fretpro_1 AS valor_frete,
    notenti.enti_desppro_1 AS despesas__acessorias,
    notenti.enti_baseicm_1 + notenti.enti_basprop_1 AS base_icms,
    notenti.enti_naciona_1::character varying::text || notenti.enti_sitribu_1::character varying::text AS cst,
    notenti.enti_aliquot_1 AS aliq_icms,
    notenti.enti_valoicm_1 + notenti.enti_icmprop_1 AS valor_icms,
        CASE
            WHEN notenti.enti_baseicm_1 = 0::numeric OR notenti.enti_baseicm_1 < (notenti.enti_totitem_1 + notenti.enti_valoipi_1 - notenti.enti_descpro_1 + notenti.enti_desppro_1 + notenti.enti_valsubs_1 + notenti.enti_fretpro_1) THEN
            CASE
                WHEN sintab24.ntab_isenliv_24 = 1 THEN notenti.enti_totitem_1 + notenti.enti_valoipi_1 - notenti.enti_descpro_1 + notenti.enti_desppro_1 + notenti.enti_valsubs_1 + notenti.enti_fretpro_1 - notenti.enti_baseicm_1
                ELSE 0::numeric
            END
            ELSE 0::numeric
        END AS icms_isento,
        CASE
            WHEN notenti.enti_baseicm_1 = 0::numeric OR notenti.enti_baseicm_1 < (notenti.enti_totitem_1 + notenti.enti_valoipi_1 - notenti.enti_descpro_1 + notenti.enti_desppro_1 + notenti.enti_valsubs_1 + notenti.enti_fretpro_1) THEN
            CASE
                WHEN sintab24.ntab_isenliv_24 = 2 THEN notenti.enti_totitem_1 + notenti.enti_valoipi_1 - notenti.enti_descpro_1 + notenti.enti_desppro_1 + notenti.enti_valsubs_1 + notenti.enti_fretpro_1 - notenti.enti_baseicm_1
                ELSE 0::numeric
            END
            ELSE 0::numeric
        END AS icms_outros,
    notenti.enti_basesub_1 AS base_icms_st,
    notenti.enti_valsubs_1 AS valor_icms_st,
    notenti.enti_baseipi_1 AS base_ipi,
    notenti.enti_cstipii_1 AS cst_ipi,
    notenti.enti_percipi_1 AS aliq_ipi,
    notenti.enti_valoipi_1 AS valor_ipi,
    notenti.enti_basepis_1 AS base_pis,
    notenti.enti_cstpiss_1 AS cst_pis,
    notenti.enti_aliqpis_1 AS aliq_pis,
    notenti.enti_valopis_1 AS valor_pis,
    notenti.enti_basecof_1 AS base_cofins,
    notenti.enti_cstcofi_1 AS cst_cofins,
    notenti.enti_aliqcof_1 AS aliq_cofins,
    notenti.enti_valocof_1 AS valor_cofins
   FROM notenti
     LEFT JOIN notent ON notent.tent_emitent_1 = notenti.enti_emitent_1 AND notent.tent_fornece_1 = notenti.enti_fornece_1 AND notent.tent_nronota_1 = notenti.enti_nronota_1 AND notent.tent_sernota_1::text = notenti.enti_sernota_1::text AND notent.tent_especie_1::text = notenti.enti_especie_1::text
     LEFT JOIN v_emitente ON notent.tent_emitent_1 = v_emitente.codigo
     LEFT JOIN sincad ON notent.tent_fornece_1 = sincad.ncad_cgcocpf_2
     LEFT JOIN sintab01 ON sincad.ncad_codmuni_2 = sintab01.ntab_codmuni_1
     LEFT JOIN sintab24 ON notenti.enti_tiponot_1 = sintab24.ntab_tiponfs_24
     LEFT JOIN sintab23 ON sintab24.ntab_codlivr_24 = sintab23.ntab_codigos_23
  WHERE notent.tent_situaca_1::text <> 'C'::text AND (notenti.enti_emitent_1 = substr('000'::text, 1, 3)::integer OR substr('000'::text, 1, 3)::integer = 0) AND (EXISTS ( SELECT 1
           FROM ( SELECT 1 AS empresa,
                    escmv001.escm_tiporeg_1,
                    escmv001.escm_emitent_1,
                    escmv001.escm_nronota_1,
                    escmv001.escm_sernota_1,
                    escmv001.escm_espnota_1
                   FROM escmv001) escmv
          WHERE escmv.empresa = notenti.enti_emitent_1 AND escmv.escm_tiporeg_1::text = 'E'::text AND escmv.escm_emitent_1 = notenti.enti_fornece_1 AND escmv.escm_nronota_1 = notenti.enti_nronota_1 AND escmv.escm_sernota_1::text = notenti.enti_sernota_1::text AND escmv.escm_espnota_1::text = notenti.enti_especie_1::text))
UNION ALL
 SELECT 'S'::text AS tipo,
    v_emitente.codigo AS empresa,
    notsaii.saii_nronota_1 AS nota,
    notsai.tsai_espnota_1 AS especie,
    notsaii.saii_natoper_1 AS cfop,
    (lpad(sintab23.ntab_codigos_23::character varying::text, 3, '0'::text) || ' - '::text) || sintab23.ntab_descric_23::text AS tipo_lancamento,
    notsai.tsai_emisdat_1 AS data_emissao,
    notsai.tsai_emisdat_1 AS data_lancamento,
    notsai.tsai_emisdat_1 AS data_entrada,
    notsai.tsai_cliente_1 AS emitente_destinatario,
    sincad.ncad_nomecli_2 AS nome,
    notsai.tsai_siglest_1 AS uf,
    notsai.tsai_chavnfe_1 AS chave_acesso,
    notsaii.saii_valiqui_1 + notsaii.saii_valoipi_1 - notsaii.saii_descpro_1 + notsaii.saii_segupro_1 + notsaii.saii_desppro_1 + notsaii.saii_valsubs_1 + notsaii.saii_fretpro_1 + notsaii.saii_acrepro_1 AS valor_contabil,
    notsaii.saii_codprod_1 AS codigo,
    notsaii.saii_descric_1::text || notsaii.saii_descri2_1::text AS descricao,
    notsaii.saii_clafisc_1 AS ncm,
    notsaii.saii_quantid_1 AS quantidade,
    notsaii.saii_valunit_1 AS unitario,
    notsaii.saii_valiqui_1 AS valor_total,
    notsaii.saii_descpro_1 AS desconto,
    notsaii.saii_fretpro_1 AS valor_frete,
    notsaii.saii_desppro_1 AS despesas__acessorias,
    notsaii.saii_baseicm_1 AS base_icms,
    TRIM(BOTH FROM to_char(notsaii.saii_sitribu_1, '000'::text)) AS cst,
    notsaii.saii_aliquot_1 AS aliq_icms,
    notsaii.saii_valoicm_1 AS valor_icms,
        CASE
            WHEN notsaii.saii_baseicm_1 = 0::numeric OR notsaii.saii_baseicm_1 < (notsaii.saii_valiqui_1 + notsaii.saii_valoipi_1 - notsaii.saii_descpro_1 + notsaii.saii_desppro_1 + notsaii.saii_valsubs_1 + notsaii.saii_fretpro_1) THEN
            CASE
                WHEN sintab24.ntab_isenliv_24 = 1 THEN notsaii.saii_valiqui_1 + notsaii.saii_valoipi_1 - notsaii.saii_descpro_1 + notsaii.saii_desppro_1 + notsaii.saii_valsubs_1 + notsaii.saii_fretpro_1 - notsaii.saii_baseicm_1
                ELSE 0::numeric
            END
            ELSE 0::numeric
        END AS icms_isento,
        CASE
            WHEN notsaii.saii_baseicm_1 = 0::numeric OR notsaii.saii_baseicm_1 < (notsaii.saii_valiqui_1 + notsaii.saii_valoipi_1 - notsaii.saii_descpro_1 + notsaii.saii_desppro_1 + notsaii.saii_valsubs_1 + notsaii.saii_fretpro_1) THEN
            CASE
                WHEN sintab24.ntab_isenliv_24 = 2 THEN notsaii.saii_valiqui_1 + notsaii.saii_valoipi_1 - notsaii.saii_descpro_1 + notsaii.saii_desppro_1 + notsaii.saii_valsubs_1 + notsaii.saii_fretpro_1 - notsaii.saii_baseicm_1
                ELSE 0::numeric
            END
            ELSE 0::numeric
        END AS icms_outros,
    notsaii.saii_basesub_1 AS base_icms_st,
    notsaii.saii_valsubs_1 AS valor_icms_st,
    notsaii.saii_bastrip_1 AS base_ipi,
    notsaii.saii_cstipii_1 AS cst_ipi,
    notsaii.saii_percipi_1 AS aliq_ipi,
    notsaii.saii_valoipi_1 AS valor_ipi,
    notsaii.saii_basepis_1 AS base_pis,
    notsaii.saii_cstpiss_1 AS cst_pis,
    notsaii.saii_aliqpis_1 AS aliq_pis,
    notsaii.saii_valopis_1 AS valor_pis,
    notsaii.saii_basecof_1 AS base_cofins,
    notsaii.saii_cstcofi_1 AS cst_cofins,
    notsaii.saii_aliqcof_1 AS aliq_cofins,
    notsaii.saii_valocof_1 AS valor_cofins
   FROM notsaii
     LEFT JOIN notsai ON notsai.tsai_emitent_1 = notsaii.saii_emitent_1 AND notsai.tsai_nronota_1 = notsaii.saii_nronota_1 AND notsai.tsai_sernota_1::text = notsaii.saii_sernota_1::text
     LEFT JOIN v_emitente ON notsai.tsai_emitent_1 = v_emitente.codigo
     LEFT JOIN sincad ON notsai.tsai_cliente_1 = sincad.ncad_cgcocpf_2
     LEFT JOIN sintab01 ON sincad.ncad_codmuni_2 = sintab01.ntab_codmuni_1
     LEFT JOIN sintab24 ON notsaii.saii_tiponot_1 = sintab24.ntab_tiponfs_24
     LEFT JOIN sintab23 ON sintab24.ntab_codlivr_24 = sintab23.ntab_codigos_23
  WHERE notsai.tsai_situaca_1::text <> 'C'::text AND (notsaii.saii_emitent_1 = substr('000'::text, 1, 3)::integer OR substr('000'::text, 1, 3)::integer = 0) AND notsai.tsai_situaca_1::text <> 'C'::text AND (EXISTS ( SELECT 1
           FROM ( SELECT 1 AS empresa,
                    escmv001.escm_tiporeg_1,
                    escmv001.escm_emitent_1,
                    escmv001.escm_nronota_1,
                    escmv001.escm_sernota_1,
                    escmv001.escm_espnota_1
                   FROM escmv001) escmv
          WHERE escmv.empresa = notsai.tsai_emitent_1 AND escmv.escm_tiporeg_1::text = 'S'::text AND escmv.escm_nronota_1 = notsaii.saii_nronota_1 AND escmv.escm_sernota_1::text = notsaii.saii_sernota_1::text AND escmv.escm_espnota_1::text = notsai.tsai_espnota_1::text))
UNION ALL
 SELECT x.tipo,
    x.cd_emitente AS empresa,
    x.nota,
    x.especie,
    x.cfop,
    (lpad(x.tp_lanc::character varying::text, 3, '0'::text) || ' - '::text) || sintab23.ntab_descric_23::text AS tipo_lancamento,
    x.data_emissao,
    x.data_lancamento,
    x.data_entrada,
        CASE
            WHEN x.tipo::text = 'S'::text THEN x.destinatario
            ELSE x.cd_emitente
        END AS emitente_destinatario,
    sincad.ncad_nomecli_2 AS nome,
    x.uf,
    x.chave_nfe AS chave_acesso,
    x.valor_contabil,
    x.codigo,
    x.descricao,
    x.ncm,
    x.quantidade,
        CASE
            WHEN x.quantidade = 0::numeric THEN 0::numeric
            ELSE x.valor_total / x.quantidade
        END AS unitario,
    x.valor_total,
    0 AS desconto,
    0 AS valor_frete,
    0 AS despesas__acessorias,
    x.base_icms,
    x.cst,
    x.aliq_icms,
    x.valor_icms,
    x.icms_isento,
    x.icms_outros,
    0 AS base_icms_st,
    0 AS valor_icms_st,
    0 AS base_ipi,
    ' '::character varying AS cst_ipi,
    0 AS aliq_ipi,
    x.valor_ipi,
    x.base_pis,
    x.cst_pis,
    x.aliq_pis,
    x.valor_pis,
    x.base_cofins,
    x.cst_cofins,
    x.aliq_cofins,
    x.valor_cofins
   FROM ( SELECT 4 AS empresa,
            escmv004.escm_usuario_1 AS cd_user,
            escmv004.escm_tiporeg_1 AS tipo,
            escmv004.escm_nronota_1 AS nota,
            escmv004.escm_sernota_1 AS serie,
            escmv004.escm_espnota_1 AS especie,
            escmv004.escm_natoper_1 AS cfop,
            escmv004.escm_emitent_1 AS cd_emitente,
            escmv004.escm_destina_1 AS destinatario,
            escmv004.escm_nomemde_1 AS nome,
            escmv004.escm_inscric_1 AS ie,
            escmv004.escm_siglest_1 AS uf,
            escmv004.escm_datlanc_1 AS data_lancamento,
            escmv004.escm_datemis_1 AS data_emissao,
            escmv004.escm_datentr_1 AS data_entrada,
            escmv004.escm_tipolan_1 AS tp_lanc,
            escit004.cite_seqnota_1 AS sequencia,
            escit004.cite_codprod_1 AS codigo,
            escit004.cite_descric_1 AS descricao,
            lpad(escit004.cite_codtrib_1::character varying::text, 3, '0'::text) AS cst,
            escit004.cite_codinbm_1 AS ncm,
            escit004.cite_quantid_1 AS quantidade,
            escit004.cite_valtota_1 + 0::numeric + 0::numeric - escit004.cite_descont_1 AS valor_total,
            escit004.cite_baseicm_1 AS base_icms,
            escit004.cite_aliqicm_1 AS aliq_icms,
            round(escit004.cite_baseicm_1 * escit004.cite_aliqicm_1 / 100::numeric, 2) + escit004.cite_icmmono_1 AS valor_icms,
                CASE
                    WHEN escmv004.escm_isenicm_1 > 0::numeric THEN escit004.cite_valtota_1 + escit004.cite_valoipi_1 + 0::numeric - escit004.cite_descont_1 - escit004.cite_baseicm_1
                    ELSE 0::numeric
                END AS icms_isento,
                CASE
                    WHEN escmv004.escm_outricm_1 > 0::numeric THEN escit004.cite_valtota_1 + escit004.cite_valoipi_1 + 0::numeric - escit004.cite_descont_1 - escit004.cite_baseicm_1
                    ELSE 0::numeric
                END AS icms_outros,
            escit004.cite_basesub_1 AS base_icms_st,
            0 AS mva,
            0 AS valor_icms_st,
            escit004.cite_percipi_1 AS aliquota_ipi,
            escit004.cite_valoipi_1 AS valor_ipi,
            escit004.cite_valtota_1 + escit004.cite_valoipi_1 + 0::numeric - escit004.cite_descont_1 AS valor_contabil,
            escit004.cite_cstcofi_1::character varying AS cst_cofins,
            escit004.cite_basecof_1 AS base_cofins,
            escit004.cite_aliqcof_1 AS aliq_cofins,
            escit004.cite_valocof_1 AS valor_cofins,
            escit004.cite_cstpiss_1::character varying AS cst_pis,
            escit004.cite_basepis_1 AS base_pis,
            escit004.cite_aliqpis_1 AS aliq_pis,
            escit004.cite_valopis_1 AS valor_pis,
            escid004.ited_vbcufdest_1 AS base_dif_dest,
            escid004.ited_vicmsufdest_1 AS difal_dest,
            escid004.ited_vbcufdest_1 AS base_dif_remet,
            escid004.ited_vicmsufremet_1 AS difal_remet,
            escid004.ited_vbcufdest_1 AS base_fcp,
            escid004.ited_vfcpufdest_1 AS valor_fcp,
            escmv004.escm_chavnfe_1 AS chave_nfe,
            escit004.cite_natbcre_1 AS cd_nbcr
           FROM escmv004
             LEFT JOIN escit004 ON escmv004.escm_situnot_1::text = escit004.cite_situnot_1::text AND escmv004.escm_tiporeg_1::text = escit004.cite_tiporeg_1::text AND escmv004.escm_nronota_1 = escit004.cite_nronota_1 AND escmv004.escm_sernota_1::text = escit004.cite_sernota_1::text AND escmv004.escm_espnota_1::text = escit004.cite_espnota_1::text AND escmv004.escm_natoper_1 = escit004.cite_natoper_1 AND escmv004.escm_emitent_1 = escit004.cite_emitent_1
             LEFT JOIN escid004 ON escit004.cite_situnot_1::text = escid004.ited_situnot_1::text AND escit004.cite_tiporeg_1::text = escid004.ited_tiporeg_1::text AND escit004.cite_nronota_1 = escid004.ited_nronota_1 AND escit004.cite_sernota_1::text = escid004.ited_sernota_1::text AND escit004.cite_espnota_1::text = escid004.ited_espnota_1::text AND escit004.cite_natoper_1 = escid004.ited_natoper_1 AND escit004.cite_emitent_1 = escid004.ited_emitent_1 AND escit004.cite_seqnota_1 = escid004.ited_seqnota_1
          WHERE escmv004.escm_situnot_1::text <> 'C'::text AND escit004.cite_seqnota_1 < 900 AND escmv004.escm_servico_1 = 0::numeric
        UNION ALL
         SELECT 2 AS empresa,
            escmv002.escm_usuario_1 AS cd_user,
            escmv002.escm_tiporeg_1 AS tipo,
            escmv002.escm_nronota_1 AS nota,
            escmv002.escm_sernota_1 AS serie,
            escmv002.escm_espnota_1 AS especie,
            escmv002.escm_natoper_1 AS cfop,
            escmv002.escm_emitent_1 AS cd_emitente,
            escmv002.escm_destina_1 AS destinatario,
            escmv002.escm_nomemde_1 AS nome,
            escmv002.escm_inscric_1 AS ie,
            escmv002.escm_siglest_1 AS uf,
            escmv002.escm_datlanc_1 AS data_lancamento,
            escmv002.escm_datemis_1 AS data_emissao,
            escmv002.escm_datentr_1 AS data_entrada,
            escmv002.escm_tipolan_1 AS tp_lanc,
            escit002.cite_seqnota_1 AS sequencia,
            escit002.cite_codprod_1 AS codigo,
            escit002.cite_descric_1 AS descricao,
            lpad(escit002.cite_codtrib_1::character varying::text, 3, '0'::text) AS cst,
            escit002.cite_codinbm_1 AS ncm,
            escit002.cite_quantid_1 AS quantidade,
            escit002.cite_valtota_1 + 0::numeric + 0::numeric - escit002.cite_descont_1 AS valor_total,
            escit002.cite_baseicm_1 AS base_icms,
            escit002.cite_aliqicm_1 AS aliq_icms,
            round(escit002.cite_baseicm_1 * escit002.cite_aliqicm_1 / 100::numeric, 2) + escit002.cite_icmmono_1 AS valor_icms,
                CASE
                    WHEN escmv002.escm_isenicm_1 > 0::numeric THEN escit002.cite_valtota_1 + escit002.cite_valoipi_1 + 0::numeric - escit002.cite_descont_1 - escit002.cite_baseicm_1
                    ELSE 0::numeric
                END AS icms_isento,
                CASE
                    WHEN escmv002.escm_outricm_1 > 0::numeric THEN escit002.cite_valtota_1 + escit002.cite_valoipi_1 + 0::numeric - escit002.cite_descont_1 - escit002.cite_baseicm_1
                    ELSE 0::numeric
                END AS icms_outros,
            escit002.cite_basesub_1 AS base_icms_st,
            0 AS mva,
            0 AS valor_icms_st,
            escit002.cite_percipi_1 AS aliquota_ipi,
            escit002.cite_valoipi_1 AS valor_ipi,
            escit002.cite_valtota_1 + escit002.cite_valoipi_1 + 0::numeric - escit002.cite_descont_1 AS valor_contabil,
            escit002.cite_cstcofi_1::character varying AS cst_cofins,
            escit002.cite_basecof_1 AS base_cofins,
            escit002.cite_aliqcof_1 AS aliq_cofins,
            escit002.cite_valocof_1 AS valor_cofins,
            escit002.cite_cstpiss_1::character varying AS cst_pis,
            escit002.cite_basepis_1 AS base_pis,
            escit002.cite_aliqpis_1 AS aliq_pis,
            escit002.cite_valopis_1 AS valor_pis,
            escid002.ited_vbcufdest_1 AS base_dif_dest,
            escid002.ited_vicmsufdest_1 AS difal_dest,
            escid002.ited_vbcufdest_1 AS base_dif_remet,
            escid002.ited_vicmsufremet_1 AS difal_remet,
            escid002.ited_vbcufdest_1 AS base_fcp,
            escid002.ited_vfcpufdest_1 AS valor_fcp,
            escmv002.escm_chavnfe_1 AS chave_nfe,
            escit002.cite_natbcre_1 AS cd_nbcr
           FROM escmv002
             LEFT JOIN escit002 ON escmv002.escm_situnot_1::text = escit002.cite_situnot_1::text AND escmv002.escm_tiporeg_1::text = escit002.cite_tiporeg_1::text AND escmv002.escm_nronota_1 = escit002.cite_nronota_1 AND escmv002.escm_sernota_1::text = escit002.cite_sernota_1::text AND escmv002.escm_espnota_1::text = escit002.cite_espnota_1::text AND escmv002.escm_natoper_1 = escit002.cite_natoper_1 AND escmv002.escm_emitent_1 = escit002.cite_emitent_1
             LEFT JOIN escid002 ON escit002.cite_situnot_1::text = escid002.ited_situnot_1::text AND escit002.cite_tiporeg_1::text = escid002.ited_tiporeg_1::text AND escit002.cite_nronota_1 = escid002.ited_nronota_1 AND escit002.cite_sernota_1::text = escid002.ited_sernota_1::text AND escit002.cite_espnota_1::text = escid002.ited_espnota_1::text AND escit002.cite_natoper_1 = escid002.ited_natoper_1 AND escit002.cite_emitent_1 = escid002.ited_emitent_1 AND escit002.cite_seqnota_1 = escid002.ited_seqnota_1
          WHERE escmv002.escm_situnot_1::text <> 'C'::text AND escit002.cite_seqnota_1 < 900 AND escmv002.escm_servico_1 = 0::numeric
        UNION ALL
         SELECT 51 AS empresa,
            escmv051.escm_usuario_1 AS cd_user,
            escmv051.escm_tiporeg_1 AS tipo,
            escmv051.escm_nronota_1 AS nota,
            escmv051.escm_sernota_1 AS serie,
            escmv051.escm_espnota_1 AS especie,
            escmv051.escm_natoper_1 AS cfop,
            escmv051.escm_emitent_1 AS cd_emitente,
            escmv051.escm_destina_1 AS destinatario,
            escmv051.escm_nomemde_1 AS nome,
            escmv051.escm_inscric_1 AS ie,
            escmv051.escm_siglest_1 AS uf,
            escmv051.escm_datlanc_1 AS data_lancamento,
            escmv051.escm_datemis_1 AS data_emissao,
            escmv051.escm_datentr_1 AS data_entrada,
            escmv051.escm_tipolan_1 AS tp_lanc,
            escit051.cite_seqnota_1 AS sequencia,
            escit051.cite_codprod_1 AS codigo,
            escit051.cite_descric_1 AS descricao,
            lpad(escit051.cite_codtrib_1::character varying::text, 3, '0'::text) AS cst,
            escit051.cite_codinbm_1 AS ncm,
            escit051.cite_quantid_1 AS quantidade,
            escit051.cite_valtota_1 + 0::numeric + 0::numeric - escit051.cite_descont_1 AS valor_total,
            escit051.cite_baseicm_1 AS base_icms,
            escit051.cite_aliqicm_1 AS aliq_icms,
            round(escit051.cite_baseicm_1 * escit051.cite_aliqicm_1 / 100::numeric, 2) + escit051.cite_icmmono_1 AS valor_icms,
                CASE
                    WHEN escmv051.escm_isenicm_1 > 0::numeric THEN escit051.cite_valtota_1 + escit051.cite_valoipi_1 + 0::numeric - escit051.cite_descont_1 - escit051.cite_baseicm_1
                    ELSE 0::numeric
                END AS icms_isento,
                CASE
                    WHEN escmv051.escm_outricm_1 > 0::numeric THEN escit051.cite_valtota_1 + escit051.cite_valoipi_1 + 0::numeric - escit051.cite_descont_1 - escit051.cite_baseicm_1
                    ELSE 0::numeric
                END AS icms_outros,
            escit051.cite_basesub_1 AS base_icms_st,
            0 AS mva,
            0 AS valor_icms_st,
            escit051.cite_percipi_1 AS aliquota_ipi,
            escit051.cite_valoipi_1 AS valor_ipi,
            escit051.cite_valtota_1 + escit051.cite_valoipi_1 + 0::numeric - escit051.cite_descont_1 AS valor_contabil,
            escit051.cite_cstcofi_1::character varying AS cst_cofins,
            escit051.cite_basecof_1 AS base_cofins,
            escit051.cite_aliqcof_1 AS aliq_cofins,
            escit051.cite_valocof_1 AS valor_cofins,
            escit051.cite_cstpiss_1::character varying AS cst_pis,
            escit051.cite_basepis_1 AS base_pis,
            escit051.cite_aliqpis_1 AS aliq_pis,
            escit051.cite_valopis_1 AS valor_pis,
            escid051.ited_vbcufdest_1 AS base_dif_dest,
            escid051.ited_vicmsufdest_1 AS difal_dest,
            escid051.ited_vbcufdest_1 AS base_dif_remet,
            escid051.ited_vicmsufremet_1 AS difal_remet,
            escid051.ited_vbcufdest_1 AS base_fcp,
            escid051.ited_vfcpufdest_1 AS valor_fcp,
            escmv051.escm_chavnfe_1 AS chave_nfe,
            escit051.cite_natbcre_1 AS cd_nbcr
           FROM escmv051
             LEFT JOIN escit051 ON escmv051.escm_situnot_1::text = escit051.cite_situnot_1::text AND escmv051.escm_tiporeg_1::text = escit051.cite_tiporeg_1::text AND escmv051.escm_nronota_1 = escit051.cite_nronota_1 AND escmv051.escm_sernota_1::text = escit051.cite_sernota_1::text AND escmv051.escm_espnota_1::text = escit051.cite_espnota_1::text AND escmv051.escm_natoper_1 = escit051.cite_natoper_1 AND escmv051.escm_emitent_1 = escit051.cite_emitent_1
             LEFT JOIN escid051 ON escit051.cite_situnot_1::text = escid051.ited_situnot_1::text AND escit051.cite_tiporeg_1::text = escid051.ited_tiporeg_1::text AND escit051.cite_nronota_1 = escid051.ited_nronota_1 AND escit051.cite_sernota_1::text = escid051.ited_sernota_1::text AND escit051.cite_espnota_1::text = escid051.ited_espnota_1::text AND escit051.cite_natoper_1 = escid051.ited_natoper_1 AND escit051.cite_emitent_1 = escid051.ited_emitent_1 AND escit051.cite_seqnota_1 = escid051.ited_seqnota_1
          WHERE escmv051.escm_situnot_1::text <> 'C'::text AND escit051.cite_seqnota_1 < 900 AND escmv051.escm_servico_1 = 0::numeric
        UNION ALL
         SELECT 100 AS empresa,
            escmv100.escm_usuario_1 AS cd_user,
            escmv100.escm_tiporeg_1 AS tipo,
            escmv100.escm_nronota_1 AS nota,
            escmv100.escm_sernota_1 AS serie,
            escmv100.escm_espnota_1 AS especie,
            escmv100.escm_natoper_1 AS cfop,
            escmv100.escm_emitent_1 AS cd_emitente,
            escmv100.escm_destina_1 AS destinatario,
            escmv100.escm_nomemde_1 AS nome,
            escmv100.escm_inscric_1 AS ie,
            escmv100.escm_siglest_1 AS uf,
            escmv100.escm_datlanc_1 AS data_lancamento,
            escmv100.escm_datemis_1 AS data_emissao,
            escmv100.escm_datentr_1 AS data_entrada,
            escmv100.escm_tipolan_1 AS tp_lanc,
            escit100.cite_seqnota_1 AS sequencia,
            escit100.cite_codprod_1 AS codigo,
            escit100.cite_descric_1 AS descricao,
            lpad(escit100.cite_codtrib_1::character varying::text, 3, '0'::text) AS cst,
            escit100.cite_codinbm_1 AS ncm,
            escit100.cite_quantid_1 AS quantidade,
            escit100.cite_valtota_1 + 0::numeric + 0::numeric - escit100.cite_descont_1 AS valor_total,
            escit100.cite_baseicm_1 AS base_icms,
            escit100.cite_aliqicm_1 AS aliq_icms,
            round(escit100.cite_baseicm_1 * escit100.cite_aliqicm_1 / 100::numeric, 2) + escit100.cite_icmmono_1 AS valor_icms,
                CASE
                    WHEN escmv100.escm_isenicm_1 > 0::numeric THEN escit100.cite_valtota_1 + escit100.cite_valoipi_1 + 0::numeric - escit100.cite_descont_1 - escit100.cite_baseicm_1
                    ELSE 0::numeric
                END AS icms_isento,
                CASE
                    WHEN escmv100.escm_outricm_1 > 0::numeric THEN escit100.cite_valtota_1 + escit100.cite_valoipi_1 + 0::numeric - escit100.cite_descont_1 - escit100.cite_baseicm_1
                    ELSE 0::numeric
                END AS icms_outros,
            escit100.cite_basesub_1 AS base_icms_st,
            0 AS mva,
            0 AS valor_icms_st,
            escit100.cite_percipi_1 AS aliquota_ipi,
            escit100.cite_valoipi_1 AS valor_ipi,
            escit100.cite_valtota_1 + escit100.cite_valoipi_1 + 0::numeric - escit100.cite_descont_1 AS valor_contabil,
            escit100.cite_cstcofi_1::character varying AS cst_cofins,
            escit100.cite_basecof_1 AS base_cofins,
            escit100.cite_aliqcof_1 AS aliq_cofins,
            escit100.cite_valocof_1 AS valor_cofins,
            escit100.cite_cstpiss_1::character varying AS cst_pis,
            escit100.cite_basepis_1 AS base_pis,
            escit100.cite_aliqpis_1 AS aliq_pis,
            escit100.cite_valopis_1 AS valor_pis,
            escid100.ited_vbcufdest_1 AS base_dif_dest,
            escid100.ited_vicmsufdest_1 AS difal_dest,
            escid100.ited_vbcufdest_1 AS base_dif_remet,
            escid100.ited_vicmsufremet_1 AS difal_remet,
            escid100.ited_vbcufdest_1 AS base_fcp,
            escid100.ited_vfcpufdest_1 AS valor_fcp,
            escmv100.escm_chavnfe_1 AS chave_nfe,
            escit100.cite_natbcre_1 AS cd_nbcr
           FROM escmv100
             LEFT JOIN escit100 ON escmv100.escm_situnot_1::text = escit100.cite_situnot_1::text AND escmv100.escm_tiporeg_1::text = escit100.cite_tiporeg_1::text AND escmv100.escm_nronota_1 = escit100.cite_nronota_1 AND escmv100.escm_sernota_1::text = escit100.cite_sernota_1::text AND escmv100.escm_espnota_1::text = escit100.cite_espnota_1::text AND escmv100.escm_natoper_1 = escit100.cite_natoper_1 AND escmv100.escm_emitent_1 = escit100.cite_emitent_1
             LEFT JOIN escid100 ON escit100.cite_situnot_1::text = escid100.ited_situnot_1::text AND escit100.cite_tiporeg_1::text = escid100.ited_tiporeg_1::text AND escit100.cite_nronota_1 = escid100.ited_nronota_1 AND escit100.cite_sernota_1::text = escid100.ited_sernota_1::text AND escit100.cite_espnota_1::text = escid100.ited_espnota_1::text AND escit100.cite_natoper_1 = escid100.ited_natoper_1 AND escit100.cite_emitent_1 = escid100.ited_emitent_1 AND escit100.cite_seqnota_1 = escid100.ited_seqnota_1
          WHERE escmv100.escm_situnot_1::text <> 'C'::text AND escit100.cite_seqnota_1 < 900 AND escmv100.escm_servico_1 = 0::numeric
        UNION ALL
         SELECT 3 AS empresa,
            escmv003.escm_usuario_1 AS cd_user,
            escmv003.escm_tiporeg_1 AS tipo,
            escmv003.escm_nronota_1 AS nota,
            escmv003.escm_sernota_1 AS serie,
            escmv003.escm_espnota_1 AS especie,
            escmv003.escm_natoper_1 AS cfop,
            escmv003.escm_emitent_1 AS cd_emitente,
            escmv003.escm_destina_1 AS destinatario,
            escmv003.escm_nomemde_1 AS nome,
            escmv003.escm_inscric_1 AS ie,
            escmv003.escm_siglest_1 AS uf,
            escmv003.escm_datlanc_1 AS data_lancamento,
            escmv003.escm_datemis_1 AS data_emissao,
            escmv003.escm_datentr_1 AS data_entrada,
            escmv003.escm_tipolan_1 AS tp_lanc,
            escit003.cite_seqnota_1 AS sequencia,
            escit003.cite_codprod_1 AS codigo,
            escit003.cite_descric_1 AS descricao,
            lpad(escit003.cite_codtrib_1::character varying::text, 3, '0'::text) AS cst,
            escit003.cite_codinbm_1 AS ncm,
            escit003.cite_quantid_1 AS quantidade,
            escit003.cite_valtota_1 + 0::numeric + 0::numeric - escit003.cite_descont_1 AS valor_total,
            escit003.cite_baseicm_1 AS base_icms,
            escit003.cite_aliqicm_1 AS aliq_icms,
            round(escit003.cite_baseicm_1 * escit003.cite_aliqicm_1 / 100::numeric, 2) + escit003.cite_icmmono_1 AS valor_icms,
                CASE
                    WHEN escmv003.escm_isenicm_1 > 0::numeric THEN escit003.cite_valtota_1 + escit003.cite_valoipi_1 + 0::numeric - escit003.cite_descont_1 - escit003.cite_baseicm_1
                    ELSE 0::numeric
                END AS icms_isento,
                CASE
                    WHEN escmv003.escm_outricm_1 > 0::numeric THEN escit003.cite_valtota_1 + escit003.cite_valoipi_1 + 0::numeric - escit003.cite_descont_1 - escit003.cite_baseicm_1
                    ELSE 0::numeric
                END AS icms_outros,
            escit003.cite_basesub_1 AS base_icms_st,
            0 AS mva,
            0 AS valor_icms_st,
            escit003.cite_percipi_1 AS aliquota_ipi,
            escit003.cite_valoipi_1 AS valor_ipi,
            escit003.cite_valtota_1 + escit003.cite_valoipi_1 + 0::numeric - escit003.cite_descont_1 AS valor_contabil,
            escit003.cite_cstcofi_1::character varying AS cst_cofins,
            escit003.cite_basecof_1 AS base_cofins,
            escit003.cite_aliqcof_1 AS aliq_cofins,
            escit003.cite_valocof_1 AS valor_cofins,
            escit003.cite_cstpiss_1::character varying AS cst_pis,
            escit003.cite_basepis_1 AS base_pis,
            escit003.cite_aliqpis_1 AS aliq_pis,
            escit003.cite_valopis_1 AS valor_pis,
            escid003.ited_vbcufdest_1 AS base_dif_dest,
            escid003.ited_vicmsufdest_1 AS difal_dest,
            escid003.ited_vbcufdest_1 AS base_dif_remet,
            escid003.ited_vicmsufremet_1 AS difal_remet,
            escid003.ited_vbcufdest_1 AS base_fcp,
            escid003.ited_vfcpufdest_1 AS valor_fcp,
            escmv003.escm_chavnfe_1 AS chave_nfe,
            escit003.cite_natbcre_1 AS cd_nbcr
           FROM escmv003
             LEFT JOIN escit003 ON escmv003.escm_situnot_1::text = escit003.cite_situnot_1::text AND escmv003.escm_tiporeg_1::text = escit003.cite_tiporeg_1::text AND escmv003.escm_nronota_1 = escit003.cite_nronota_1 AND escmv003.escm_sernota_1::text = escit003.cite_sernota_1::text AND escmv003.escm_espnota_1::text = escit003.cite_espnota_1::text AND escmv003.escm_natoper_1 = escit003.cite_natoper_1 AND escmv003.escm_emitent_1 = escit003.cite_emitent_1
             LEFT JOIN escid003 ON escit003.cite_situnot_1::text = escid003.ited_situnot_1::text AND escit003.cite_tiporeg_1::text = escid003.ited_tiporeg_1::text AND escit003.cite_nronota_1 = escid003.ited_nronota_1 AND escit003.cite_sernota_1::text = escid003.ited_sernota_1::text AND escit003.cite_espnota_1::text = escid003.ited_espnota_1::text AND escit003.cite_natoper_1 = escid003.ited_natoper_1 AND escit003.cite_emitent_1 = escid003.ited_emitent_1 AND escit003.cite_seqnota_1 = escid003.ited_seqnota_1
          WHERE escmv003.escm_situnot_1::text <> 'C'::text AND escit003.cite_seqnota_1 < 900 AND escmv003.escm_servico_1 = 0::numeric
        UNION ALL
         SELECT 1 AS empresa,
            escmv001.escm_usuario_1 AS cd_user,
            escmv001.escm_tiporeg_1 AS tipo,
            escmv001.escm_nronota_1 AS nota,
            escmv001.escm_sernota_1 AS serie,
            escmv001.escm_espnota_1 AS especie,
            escmv001.escm_natoper_1 AS cfop,
            escmv001.escm_emitent_1 AS cd_emitente,
            escmv001.escm_destina_1 AS destinatario,
            escmv001.escm_nomemde_1 AS nome,
            escmv001.escm_inscric_1 AS ie,
            escmv001.escm_siglest_1 AS uf,
            escmv001.escm_datlanc_1 AS data_lancamento,
            escmv001.escm_datemis_1 AS data_emissao,
            escmv001.escm_datentr_1 AS data_entrada,
            escmv001.escm_tipolan_1 AS tp_lanc,
            escit001.cite_seqnota_1 AS sequencia,
            escit001.cite_codprod_1 AS codigo,
            escit001.cite_descric_1 AS descricao,
            lpad(escit001.cite_codtrib_1::character varying::text, 3, '0'::text) AS cst,
            escit001.cite_codinbm_1 AS ncm,
            escit001.cite_quantid_1 AS quantidade,
            escit001.cite_valtota_1 + 0::numeric + 0::numeric - escit001.cite_descont_1 AS valor_total,
            escit001.cite_baseicm_1 AS base_icms,
            escit001.cite_aliqicm_1 AS aliq_icms,
            round(escit001.cite_baseicm_1 * escit001.cite_aliqicm_1 / 100::numeric, 2) + escit001.cite_icmmono_1 AS valor_icms,
                CASE
                    WHEN escmv001.escm_isenicm_1 > 0::numeric THEN escit001.cite_valtota_1 + escit001.cite_valoipi_1 + 0::numeric - escit001.cite_descont_1 - escit001.cite_baseicm_1
                    ELSE 0::numeric
                END AS icms_isento,
                CASE
                    WHEN escmv001.escm_outricm_1 > 0::numeric THEN escit001.cite_valtota_1 + escit001.cite_valoipi_1 + 0::numeric - escit001.cite_descont_1 - escit001.cite_baseicm_1
                    ELSE 0::numeric
                END AS icms_outros,
            escit001.cite_basesub_1 AS base_icms_st,
            0 AS mva,
            0 AS valor_icms_st,
            escit001.cite_percipi_1 AS aliquota_ipi,
            escit001.cite_valoipi_1 AS valor_ipi,
            escit001.cite_valtota_1 + escit001.cite_valoipi_1 + 0::numeric - escit001.cite_descont_1 AS valor_contabil,
            escit001.cite_cstcofi_1::character varying AS cst_cofins,
            escit001.cite_basecof_1 AS base_cofins,
            escit001.cite_aliqcof_1 AS aliq_cofins,
            escit001.cite_valocof_1 AS valor_cofins,
            escit001.cite_cstpiss_1::character varying AS cst_pis,
            escit001.cite_basepis_1 AS base_pis,
            escit001.cite_aliqpis_1 AS aliq_pis,
            escit001.cite_valopis_1 AS valor_pis,
            escid001.ited_vbcufdest_1 AS base_dif_dest,
            escid001.ited_vicmsufdest_1 AS difal_dest,
            escid001.ited_vbcufdest_1 AS base_dif_remet,
            escid001.ited_vicmsufremet_1 AS difal_remet,
            escid001.ited_vbcufdest_1 AS base_fcp,
            escid001.ited_vfcpufdest_1 AS valor_fcp,
            escmv001.escm_chavnfe_1 AS chave_nfe,
            escit001.cite_natbcre_1 AS cd_nbcr
           FROM escmv001
             LEFT JOIN escit001 ON escmv001.escm_situnot_1::text = escit001.cite_situnot_1::text AND escmv001.escm_tiporeg_1::text = escit001.cite_tiporeg_1::text AND escmv001.escm_nronota_1 = escit001.cite_nronota_1 AND escmv001.escm_sernota_1::text = escit001.cite_sernota_1::text AND escmv001.escm_espnota_1::text = escit001.cite_espnota_1::text AND escmv001.escm_natoper_1 = escit001.cite_natoper_1 AND escmv001.escm_emitent_1 = escit001.cite_emitent_1
             LEFT JOIN escid001 ON escit001.cite_situnot_1::text = escid001.ited_situnot_1::text AND escit001.cite_tiporeg_1::text = escid001.ited_tiporeg_1::text AND escit001.cite_nronota_1 = escid001.ited_nronota_1 AND escit001.cite_sernota_1::text = escid001.ited_sernota_1::text AND escit001.cite_espnota_1::text = escid001.ited_espnota_1::text AND escit001.cite_natoper_1 = escid001.ited_natoper_1 AND escit001.cite_emitent_1 = escid001.ited_emitent_1 AND escit001.cite_seqnota_1 = escid001.ited_seqnota_1
          WHERE escmv001.escm_situnot_1::text <> 'C'::text AND escit001.cite_seqnota_1 < 900 AND escmv001.escm_servico_1 = 0::numeric) x
     LEFT JOIN v_emitente c ON x.empresa = c.codigo
     LEFT JOIN sincad ON
        CASE
            WHEN x.tipo::text = 'S'::text THEN x.destinatario
            ELSE x.cd_emitente
        END = sincad.ncad_cgcocpf_2
     LEFT JOIN sintab01 ON sincad.ncad_codmuni_2 = sintab01.ntab_codmuni_1
     LEFT JOIN sintab23 ON x.tp_lanc = sintab23.ntab_codigos_23
  WHERE NOT (EXISTS ( SELECT 1
           FROM notenti
          WHERE x.empresa = notenti.enti_emitent_1 AND x.tipo::text = 'E'::text AND x.cd_emitente = notenti.enti_fornece_1 AND x.nota = notenti.enti_nronota_1 AND x.serie::text = notenti.enti_sernota_1::text AND x.especie::text = notenti.enti_especie_1::text)) AND NOT (EXISTS ( SELECT 1
           FROM notsaii
             JOIN notsai ON notsai.tsai_emitent_1 = notsaii.saii_emitent_1 AND notsai.tsai_nronota_1 = notsaii.saii_nronota_1 AND notsai.tsai_sernota_1::text = notsaii.saii_sernota_1::text
          WHERE x.empresa = notsai.tsai_emitent_1 AND x.tipo::text = 'S'::text AND x.nota = notsai.tsai_nronota_1 AND x.serie::text = notsai.tsai_sernota_1::text AND x.especie::text = notsai.tsai_espnota_1::text)) AND x.tipo::text = substr('ENTRADA'::text, 1, 1) AND (x.empresa = substr('000'::text, 1, 3)::integer OR substr('000'::text, 1, 3)::integer = 0);