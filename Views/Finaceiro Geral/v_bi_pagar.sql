-- public.v_bi_pagar source

CREATE OR REPLACE VIEW public.v_bi_pagar
AS SELECT pagdup.pdup_empresa_1 AS codigo_empresa,
    sintab12.ntab_empabrv_12 AS nome_abreviado,
    sintab12.ntab_grpemit_12 AS codigo_emitente,
    pagdup.pdup_tipodoc_1 as cod_tipodoc,
    sintab07.ntab_descdoc_7 AS descricao_documento,
    pagdup.pdup_fornece_1 AS cnpj_fornecedor,
    sincad.ncad_nomecli_2 AS nome_cliente,
    pagdup.pdup_numdupl_1 AS numero_duplicata,
    pagdup.pdup_parcela_1 AS numero_parcela,
    pagdup.pdup_valdupl_1 AS valor_documento,
    pdup_valpgto_1 as valor_pago,
    CASE
        WHEN pagdup.pdup_valdupl_1 - pagdup.pdup_valpgto_1 - pagdup.pdup_impreti_1 < 0::numeric THEN 0::numeric
        ELSE pagdup.pdup_valdupl_1 - pagdup.pdup_valpgto_1 - pagdup.pdup_impreti_1
    END AS valor_pendente,
    pagdup.pdup_datvenc_1 AS data_vencimento,
    pagdup.pdup_datemis_1 AS data_emissao,
    r.ppgd_datapag_1 AS data_pagamento,
        CASE
            WHEN pagdup.pdup_vencinv_1 > 'now'::text::date THEN pagdup.pdup_vencinv_1 - 'now'::text::date
            WHEN pagdup.pdup_vencinv_1 <= 'now'::text::date THEN 'now'::text::date - pagdup.pdup_vencinv_1
            ELSE NULL::integer
        END AS numero_dias,
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
        END AS status_do_vencimento,
        CASE
            WHEN current_date > pagdup.pdup_datvenc_1 and (pagdup.pdup_valdupl_1 - pagdup.pdup_valpgto_1 - pagdup.pdup_impreti_1) > 0 THEN current_date - pagdup.pdup_datvenc_1
            ELSE 0
        END AS dias_vencido
   FROM pagdup
     LEFT JOIN pagpgd r ON r.ppgd_empresa_1 = pagdup.pdup_empresa_1 AND r.ppgd_fornece_1 = pagdup.pdup_fornece_1 AND r.ppgd_numdupl_1::text = pagdup.pdup_numdupl_1::text AND r.ppgd_parcela_1::text = pagdup.pdup_parcela_1::text
     LEFT JOIN sintab12 ON sintab12.ntab_emitent_12 = pagdup.pdup_empresa_1
     LEFT JOIN sintab07 ON sintab07.ntab_tipodoc_7 = pagdup.pdup_tipodoc_1
     LEFT JOIN sincad ON sincad.ncad_cgcocpf_2 = pagdup.pdup_fornece_1;