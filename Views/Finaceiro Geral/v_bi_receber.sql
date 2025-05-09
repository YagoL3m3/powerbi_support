-- public.v_bi_receber source

CREATE OR REPLACE VIEW public.v_bi_receber
AS SELECT recdup.recd_empresa_1 AS codigo_empresa,
    sintab12.ntab_empabrv_12 AS nome_abreviado,
    sintab12.ntab_grpemit_12 AS codigo_emitente,
    recd_tipodoc_1 AS cod_tipodoc,
    sintab07.ntab_descdoc_7 AS descricao_documento,
    recdup.recd_cliente_1 AS cnpj_cliente,
    sincad.ncad_nomecli_2 AS nome_cliente,
    recdup.recd_numdupl_1 AS numero_duplicata,
    recdup.recd_parcela_1 AS numero_parcela,
    recd_valdupl_1 AS valor_documento,
    recd_valpgto_1 as valor_pago,
    CASE
        WHEN (recdup.recd_valdupl_1 - recdup.recd_valpgto_1 - recdup.recd_impreti_1) < 0::numeric THEN 0::numeric
        ELSE recdup.recd_valdupl_1 - recdup.recd_valpgto_1 - recdup.recd_impreti_1
    END AS valor_pendente,
    recdup.recd_datvenc_1 AS data_vencimento,
    recdup.recd_datemis_1 AS data_emissao,
        CASE
            WHEN recdup.recd_vencinv_1 > 'now'::text::date THEN recdup.recd_vencinv_1 - 'now'::text::date
            WHEN recdup.recd_vencinv_1 <= 'now'::text::date THEN 'now'::text::date - recdup.recd_vencinv_1
            ELSE NULL::integer
        END AS numero_dias,
        CASE
            WHEN (recdup.recd_valdupl_1 - recdup.recd_valpgto_1 - recdup.recd_impreti_1) <= 0::numeric THEN 'LIQUIDADO'::text
            WHEN (recdup.recd_valdupl_1 - recdup.recd_valpgto_1 - recdup.recd_impreti_1) = recdup.recd_valdupl_1 THEN 'EM ABERTO'::text
            ELSE 'PARCIALMENTE LIQUIDADO'::text
        END AS status_do_documento,
        CASE
            WHEN (recdup.recd_valdupl_1 - recdup.recd_valpgto_1 - recdup.recd_impreti_1) <= 0::numeric THEN 'LIQUIDADO'::text
            WHEN recdup.recd_datvenc_1 >= 'now'::text::date THEN 'DISPONIVEL'::text
            WHEN recdup.recd_datvenc_1 < 'now'::text::date THEN 'VENCIDO'::text
            ELSE NULL::text
        END AS status_do_vencimento,
        CASE
            WHEN current_date > recdup.recd_datvenc_1 and (recdup.recd_valdupl_1 - recdup.recd_valpgto_1 - recdup.recd_impreti_1) > 0 THEN current_date - recdup.recd_datvenc_1
            ELSE 0
        END AS dias_vencido
   FROM recdup
     LEFT JOIN sintab12 ON sintab12.ntab_emitent_12 = recdup.recd_empresa_1
     LEFT JOIN sintab07 ON sintab07.ntab_tipodoc_7 = recdup.recd_tipodoc_1
     LEFT JOIN sincad ON sincad.ncad_cgcocpf_2 = recdup.recd_cliente_1;
     
    