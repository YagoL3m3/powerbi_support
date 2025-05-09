-- public.v_bi_pagar_receber source

CREATE OR REPLACE VIEW public.v_bi_pagar_receber
AS SELECT 'PAGAR'::text AS origem,
    pagdup.pdup_empresa_1 AS codigo_empresa,
    sintab12.ntab_empabrv_12 AS nome_abreviado,
    sintab07.ntab_descdoc_7 AS descricao_documento,
    pagdup.pdup_fornece_1 AS cnpj_cliente_fornecedor,
    sincad.ncad_nomecli_2 AS nome_cliente_fornecedor,
    pagdup.pdup_numdupl_1 AS numero_duplicata,
    pagdup.pdup_parcela_1 AS referencia_parcela,
    pagdup.pdup_valdupl_1 AS valor_documento,
    pagdup.pdup_valpgto_1 - sum(pagpgd.ppgd_vrdesco_1) + sum(pagpgd.ppgd_acresci_1) AS valor_pago,
    pagdup.pdup_impreti_1 AS imposto_retido,
    sum(pagpgd.ppgd_acresci_1) AS valor_acrescimos,
    sum(pagpgd.ppgd_vrdesco_1) AS valor_descontos,
        CASE
            WHEN (pagdup.pdup_valdupl_1 - pagdup.pdup_valpgto_1 - pagdup.pdup_impreti_1) < 0::numeric THEN 0::numeric
            ELSE pagdup.pdup_valdupl_1 - pagdup.pdup_valpgto_1 - pagdup.pdup_impreti_1
        END AS valor_pendente,
    pagdup.pdup_datemis_1 AS data_emissao,
    pagdup.pdup_datvenc_1 AS data_vencimento,
    pagdup.pdup_tipodoc_1 AS codigo_documento,
    sintab07.ntab_descdoc_7 AS tipo_documento,
        CASE
            WHEN (pagdup.pdup_valdupl_1 - pagdup.pdup_valpgto_1 - pagdup.pdup_impreti_1) <= 0::numeric THEN 'LIQUIDADO'::text
            WHEN (pagdup.pdup_valdupl_1 - pagdup.pdup_valpgto_1 - pagdup.pdup_impreti_1) = pagdup.pdup_valdupl_1 THEN 'EM ABERTO'::text
            ELSE 'PARCIALMENTE LIQUIDADO'::text
        END AS status_do_documento,
        CASE
            WHEN (pagdup.pdup_valdupl_1 - pagdup.pdup_valpgto_1 - pagdup.pdup_impreti_1) <= 0::numeric THEN 'LIQUIDADO'::text
            WHEN pagdup.pdup_datvenc_1 >= 'now'::text::date THEN 'DISPONIVEL'::text
            WHEN pagdup.pdup_datvenc_1 < 'now'::text::date THEN 'VENCIDO'::text
            ELSE NULL::text
        END AS status_do_vencimento
   FROM pagdup
     LEFT JOIN pagpgd ON pagpgd.ppgd_empresa_1 = pagdup.pdup_empresa_1 AND pagpgd.ppgd_fornece_1 = pagdup.pdup_fornece_1 AND pagpgd.ppgd_numdupl_1::text = pagdup.pdup_numdupl_1::text AND pagpgd.ppgd_parcela_1::text = pagdup.pdup_parcela_1::text
     LEFT JOIN sintab12 ON sintab12.ntab_emitent_12 = pagdup.pdup_empresa_1
     LEFT JOIN sintab07 ON sintab07.ntab_tipodoc_7 = pagdup.pdup_tipodoc_1
     LEFT JOIN sincad ON sincad.ncad_cgcocpf_2 = pagdup.pdup_fornece_1
  GROUP BY 'PAGAR'::text, pagdup.pdup_empresa_1, sintab12.ntab_empabrv_12, sintab07.ntab_descdoc_7, pagdup.pdup_fornece_1, sincad.ncad_nomecli_2, pagdup.pdup_numdupl_1, pagdup.pdup_parcela_1, pagdup.pdup_valdupl_1, pagdup.pdup_impreti_1, (
        CASE
            WHEN (pagdup.pdup_valdupl_1 - pagdup.pdup_valpgto_1 - pagdup.pdup_impreti_1) < 0::numeric THEN 0::numeric
            ELSE pagdup.pdup_valdupl_1 - pagdup.pdup_valpgto_1 - pagdup.pdup_impreti_1
        END), pagdup.pdup_datemis_1, pagdup.pdup_datvenc_1, pagdup.pdup_tipodoc_1
UNION ALL
 SELECT 'RECEBER'::text AS origem,
    recdup.recd_empresa_1 AS codigo_empresa,
    sintab12.ntab_empabrv_12 AS nome_abreviado,
    sintab07.ntab_descdoc_7 AS descricao_documento,
    recdup.recd_cliente_1 AS cnpj_cliente_fornecedor,
    sincad.ncad_nomecli_2 AS nome_cliente_fornecedor,
    recdup.recd_numdupl_1 AS numero_duplicata,
    recdup.recd_parcela_1 AS referencia_parcela,
    recdup.recd_valdupl_1 AS valor_documento,
    recdup.recd_valpgto_1 - sum(recpgd.rpgd_vrdesco_1) + sum(recpgd.rpgd_acresci_1) AS valor_pago,
    recdup.recd_impreti_1 AS imposto_retido,
    sum(recpgd.rpgd_acresci_1) AS valor_acrescimos,
    sum(recpgd.rpgd_vrdesco_1) AS valor_descontos,
        CASE
            WHEN (recdup.recd_valdupl_1 - recdup.recd_valpgto_1 - recdup.recd_impreti_1) < 0::numeric THEN 0::numeric
            ELSE recdup.recd_valdupl_1 - recdup.recd_valpgto_1 - recdup.recd_impreti_1
        END AS valor_pendente,
    recdup.recd_datemis_1 AS data_emissao,
    recdup.recd_datvenc_1 AS data_vencimento,
    recdup.recd_tipodoc_1 AS codigo_documento,
    sintab07.ntab_descdoc_7 AS tipo_documento,
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
        END AS status_do_vencimento
   FROM recdup
     LEFT JOIN recpgd ON recpgd.rpgd_empresa_1 = recdup.recd_empresa_1 AND recpgd.rpgd_cliente_1 = recdup.recd_cliente_1 AND recpgd.rpgd_numdupl_1::text = recdup.recd_numdupl_1::text AND recpgd.rpgd_parcela_1::text = recdup.recd_parcela_1::text
     LEFT JOIN sintab12 ON sintab12.ntab_emitent_12 = recdup.recd_empresa_1
     LEFT JOIN sintab07 ON sintab07.ntab_tipodoc_7 = recdup.recd_tipodoc_1
     LEFT JOIN sincad ON sincad.ncad_cgcocpf_2 = recdup.recd_cliente_1
  GROUP BY 'RECEBER'::text, recdup.recd_empresa_1, sintab12.ntab_empabrv_12, sintab07.ntab_descdoc_7, recdup.recd_cliente_1, sincad.ncad_nomecli_2, recdup.recd_numdupl_1, recdup.recd_parcela_1, recdup.recd_valdupl_1, recdup.recd_impreti_1, (
        CASE
            WHEN (recdup.recd_valdupl_1 - recdup.recd_valpgto_1 - recdup.recd_impreti_1) < 0::numeric THEN 0::numeric
            ELSE recdup.recd_valdupl_1 - recdup.recd_valpgto_1 - recdup.recd_impreti_1
        END), recdup.recd_datemis_1, recdup.recd_datvenc_1, recdup.recd_tipodoc_1;