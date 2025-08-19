-- public.movimento_ccusto fonte

CREATE OR REPLACE VIEW public.movimento_ccusto
AS SELECT 1 AS empresa,
    m.bmov_anomesl_1 AS ano,
    m.bmov_sequmes_1 AS sequ,
    m.bmov_dialanc_1 AS dia,
    m.bmov_nrolanc_1 AS numlan,
    ctbdc001.bdcc_datinve_1 AS datlanc,
    ctbdc001.bdcc_debcred_1 AS tipomov,
        CASE ctbdc001.bdcc_contrap_1
            WHEN 0 THEN
            CASE ctbdc001.bdcc_debcred_1
                WHEN 'C'::text THEN m.bmov_ctacred_1
                WHEN 'D'::text THEN m.bmov_ctadebi_1
                ELSE NULL::numeric
            END
            ELSE ctbdc001.bdcc_contrap_1
        END AS nrconta,
    ctbdc001.bdcc_centcus_1 AS centcus,
    ctbdc001.bdcc_sqcontr_1 AS sqcontr,
    ctbdc001.bdcc_sequenc_1 AS sequenc,
    ctbdc001.bdcc_vrlanca_1 AS vrlanca,
    COALESCE(ctbcn001.bcon_histori_1, m.bmov_histori_1) AS historico,
    m.bmov_origeml_1 AS origem
   FROM ctbdc001
     JOIN ctbmv001 m ON m.bmov_anomesl_1 = to_char(ctbdc001.bdcc_datinve_1::timestamp with time zone, 'yyyymm'::text)::integer AND m.bmov_sequmes_1 = ctbdc001.bdcc_sequmes_1 AND m.bmov_dialanc_1 = to_char(ctbdc001.bdcc_datinve_1::timestamp with time zone, 'DD'::text)::integer AND m.bmov_nrolanc_1 = ctbdc001.bdcc_nrolanc_1
     LEFT JOIN ctbcn001 ON ctbcn001.bcon_datinve_1 = ctbdc001.bdcc_datinve_1 AND ctbcn001.bcon_sequmes_1 = ctbdc001.bdcc_sequmes_1 AND ctbcn001.bcon_nrolanc_1 = ctbdc001.bdcc_nrolanc_1 AND ctbcn001.bcon_debcred_1::text = ctbdc001.bdcc_debcred_1::text AND ctbcn001.bcon_contrap_1 = ctbdc001.bdcc_contrap_1 AND ctbcn001.bcon_sqcontr_1 = ctbdc001.bdcc_sqcontr_1
UNION ALL
 SELECT 2 AS empresa,
    m.bmov_anomesl_1 AS ano,
    m.bmov_sequmes_1 AS sequ,
    m.bmov_dialanc_1 AS dia,
    m.bmov_nrolanc_1 AS numlan,
    ctbdc002.bdcc_datinve_1 AS datlanc,
    ctbdc002.bdcc_debcred_1 AS tipomov,
        CASE ctbdc002.bdcc_contrap_1
            WHEN 0 THEN
            CASE ctbdc002.bdcc_debcred_1
                WHEN 'C'::text THEN m.bmov_ctacred_1
                WHEN 'D'::text THEN m.bmov_ctadebi_1
                ELSE NULL::numeric
            END
            ELSE ctbdc002.bdcc_contrap_1
        END AS nrconta,
    ctbdc002.bdcc_centcus_1 AS centcus,
    ctbdc002.bdcc_sqcontr_1 AS sqcontr,
    ctbdc002.bdcc_sequenc_1 AS sequenc,
    ctbdc002.bdcc_vrlanca_1 AS vrlanca,
    COALESCE(ctbcn002.bcon_histori_1, m.bmov_histori_1) AS historico,
    m.bmov_origeml_1 AS origem
   FROM ctbdc002
     JOIN ctbmv002 m ON m.bmov_anomesl_1 = to_char(ctbdc002.bdcc_datinve_1::timestamp with time zone, 'yyyymm'::text)::integer AND m.bmov_sequmes_1 = ctbdc002.bdcc_sequmes_1 AND m.bmov_dialanc_1 = to_char(ctbdc002.bdcc_datinve_1::timestamp with time zone, 'DD'::text)::integer AND m.bmov_nrolanc_1 = ctbdc002.bdcc_nrolanc_1
     LEFT JOIN ctbcn002 ON ctbcn002.bcon_datinve_1 = ctbdc002.bdcc_datinve_1 AND ctbcn002.bcon_sequmes_1 = ctbdc002.bdcc_sequmes_1 AND ctbcn002.bcon_nrolanc_1 = ctbdc002.bdcc_nrolanc_1 AND ctbcn002.bcon_debcred_1::text = ctbdc002.bdcc_debcred_1::text AND ctbcn002.bcon_contrap_1 = ctbdc002.bdcc_contrap_1 AND ctbcn002.bcon_sqcontr_1 = ctbdc002.bdcc_sqcontr_1
UNION ALL
 SELECT 3 AS empresa,
    m.bmov_anomesl_1 AS ano,
    m.bmov_sequmes_1 AS sequ,
    m.bmov_dialanc_1 AS dia,
    m.bmov_nrolanc_1 AS numlan,
    ctbdc003.bdcc_datinve_1 AS datlanc,
    ctbdc003.bdcc_debcred_1 AS tipomov,
        CASE ctbdc003.bdcc_contrap_1
            WHEN 0 THEN
            CASE ctbdc003.bdcc_debcred_1
                WHEN 'C'::text THEN m.bmov_ctacred_1
                WHEN 'D'::text THEN m.bmov_ctadebi_1
                ELSE NULL::numeric
            END
            ELSE ctbdc003.bdcc_contrap_1
        END AS nrconta,
    ctbdc003.bdcc_centcus_1 AS centcus,
    ctbdc003.bdcc_sqcontr_1 AS sqcontr,
    ctbdc003.bdcc_sequenc_1 AS sequenc,
    ctbdc003.bdcc_vrlanca_1 AS vrlanca,
    COALESCE(ctbcn003.bcon_histori_1, m.bmov_histori_1) AS historico,
    m.bmov_origeml_1 AS origem
   FROM ctbdc003
     JOIN ctbmv003 m ON m.bmov_anomesl_1 = to_char(ctbdc003.bdcc_datinve_1::timestamp with time zone, 'yyyymm'::text)::integer AND m.bmov_sequmes_1 = ctbdc003.bdcc_sequmes_1 AND m.bmov_dialanc_1 = to_char(ctbdc003.bdcc_datinve_1::timestamp with time zone, 'DD'::text)::integer AND m.bmov_nrolanc_1 = ctbdc003.bdcc_nrolanc_1
     LEFT JOIN ctbcn003 ON ctbcn003.bcon_datinve_1 = ctbdc003.bdcc_datinve_1 AND ctbcn003.bcon_sequmes_1 = ctbdc003.bdcc_sequmes_1 AND ctbcn003.bcon_nrolanc_1 = ctbdc003.bdcc_nrolanc_1 AND ctbcn003.bcon_debcred_1::text = ctbdc003.bdcc_debcred_1::text AND ctbcn003.bcon_contrap_1 = ctbdc003.bdcc_contrap_1 AND ctbcn003.bcon_sqcontr_1 = ctbdc003.bdcc_sqcontr_1
UNION ALL
 SELECT 4 AS empresa,
    m.bmov_anomesl_1 AS ano,
    m.bmov_sequmes_1 AS sequ,
    m.bmov_dialanc_1 AS dia,
    m.bmov_nrolanc_1 AS numlan,
    ctbdc004.bdcc_datinve_1 AS datlanc,
    ctbdc004.bdcc_debcred_1 AS tipomov,
        CASE ctbdc004.bdcc_contrap_1
            WHEN 0 THEN
            CASE ctbdc004.bdcc_debcred_1
                WHEN 'C'::text THEN m.bmov_ctacred_1
                WHEN 'D'::text THEN m.bmov_ctadebi_1
                ELSE NULL::numeric
            END
            ELSE ctbdc004.bdcc_contrap_1
        END AS nrconta,
    ctbdc004.bdcc_centcus_1 AS centcus,
    ctbdc004.bdcc_sqcontr_1 AS sqcontr,
    ctbdc004.bdcc_sequenc_1 AS sequenc,
    ctbdc004.bdcc_vrlanca_1 AS vrlanca,
    COALESCE(ctbcn004.bcon_histori_1, m.bmov_histori_1) AS historico,
    m.bmov_origeml_1 AS origem
   FROM ctbdc004
     JOIN ctbmv004 m ON m.bmov_anomesl_1 = to_char(ctbdc004.bdcc_datinve_1::timestamp with time zone, 'yyyymm'::text)::integer AND m.bmov_sequmes_1 = ctbdc004.bdcc_sequmes_1 AND m.bmov_dialanc_1 = to_char(ctbdc004.bdcc_datinve_1::timestamp with time zone, 'DD'::text)::integer AND m.bmov_nrolanc_1 = ctbdc004.bdcc_nrolanc_1
     LEFT JOIN ctbcn004 ON ctbcn004.bcon_datinve_1 = ctbdc004.bdcc_datinve_1 AND ctbcn004.bcon_sequmes_1 = ctbdc004.bdcc_sequmes_1 AND ctbcn004.bcon_nrolanc_1 = ctbdc004.bdcc_nrolanc_1 AND ctbcn004.bcon_debcred_1::text = ctbdc004.bdcc_debcred_1::text AND ctbcn004.bcon_contrap_1 = ctbdc004.bdcc_contrap_1 AND ctbcn004.bcon_sqcontr_1 = ctbdc004.bdcc_sqcontr_1;