-- public.v_bi_ajustes fonte

CREATE OR REPLACE VIEW public.v_bi_ajustes
AS SELECT ca."utilização",
    sum(vba.caju_valores_1) AS "apuração",
    to_char(vba.caju_findata_1::timestamp with time zone, 'mm/yyyy'::text) AS mes_ano,
    ca.cod_util,
    vba.caju_descric_1
   FROM v_bi_ajustesfisc vba
     LEFT JOIN ( SELECT ((esctab23.ctab_siglest_23::text || esctab23.ctab_tipoapu_23) || esctab23.ctab_utiliza_23) ||
                CASE
                    WHEN length(esctab23.ctab_sequenc_23::text) = 1 THEN '000'::text || esctab23.ctab_sequenc_23::text
                    WHEN length(esctab23.ctab_sequenc_23::text) = 2 THEN '00'::text || esctab23.ctab_sequenc_23::text
                    WHEN length(esctab23.ctab_sequenc_23::text) = 3 THEN '0'::text || esctab23.ctab_sequenc_23::text
                    ELSE esctab23.ctab_sequenc_23::text
                END AS cod_ajuste,
            esctab23.ctab_siglest_23,
            esctab23.ctab_utiliza_23 AS cod_util,
                CASE
                    WHEN esctab23.ctab_utiliza_23 = 0 THEN 'Outros Débitos'::text
                    WHEN esctab23.ctab_utiliza_23 = 1 THEN 'Estorno de Créditos'::text
                    WHEN esctab23.ctab_utiliza_23 = 2 THEN 'Outros Créditos'::text
                    WHEN esctab23.ctab_utiliza_23 = 3 THEN 'Estornos de Débitos'::text
                    WHEN esctab23.ctab_utiliza_23 = 4 THEN 'Deduções'::text
                    WHEN esctab23.ctab_utiliza_23 = 5 THEN 'Débitos Especiais'::text
                    ELSE NULL::text
                END AS "utilização"
           FROM esctab23) ca ON ca.cod_ajuste = vba.caju_codajus_1::text
  GROUP BY ca."utilização", (to_char(vba.caju_findata_1::timestamp with time zone, 'mm/yyyy'::text)), ca.cod_util, vba.caju_descric_1;