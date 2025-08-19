-- public.movimento_contabil fonte

CREATE OR REPLACE VIEW public.movimento_contabil
AS SELECT 1 AS empresa,
    ctbmv001.bmov_datinve_1 AS datlanc,
    'D'::text AS tipomov,
    ctbmv001.bmov_ctadebi_1 AS nrconta,
    ctbmv001.bmov_vrlanca_1 AS vrlanca,
    ctbmv001.bmov_histori_1 AS historico,
    ctbmv001.bmov_origeml_1 AS origem
   FROM ctbmv001
UNION ALL
 SELECT 1 AS empresa,
    ctbmv001.bmov_datinve_1 AS datlanc,
    'C'::text AS tipomov,
    ctbmv001.bmov_ctacred_1 AS nrconta,
    ctbmv001.bmov_vrlanca_1 AS vrlanca,
    ctbmv001.bmov_histori_1 AS historico,
    ctbmv001.bmov_origeml_1 AS origem
   FROM ctbmv001
UNION ALL
 SELECT 1 AS empresa,
    ctbcn001.bcon_datinve_1 AS datlanc,
    ctbcn001.bcon_debcred_1 AS tipomov,
    ctbcn001.bcon_contrap_1 AS nrconta,
    ctbcn001.bcon_vrlanca_1 AS vrlanca,
    ctbcn001.bcon_histori_1 AS historico,
    ctbmv001.bmov_origeml_1 AS origem
   FROM ctbcn001
     LEFT JOIN ctbmv001 ON ctbcn001.bcon_datinve_1 = ctbmv001.bmov_datinve_1 AND ctbcn001.bcon_sequmes_1 = ctbmv001.bmov_sequmes_1 AND ctbcn001.bcon_nrolanc_1 = ctbmv001.bmov_nrolanc_1
UNION ALL
 SELECT 2 AS empresa,
    ctbmv002.bmov_datinve_1 AS datlanc,
    'D'::text AS tipomov,
    ctbmv002.bmov_ctadebi_1 AS nrconta,
    ctbmv002.bmov_vrlanca_1 AS vrlanca,
    ctbmv002.bmov_histori_1 AS historico,
    ctbmv002.bmov_origeml_1 AS origem
   FROM ctbmv002
UNION ALL
 SELECT 2 AS empresa,
    ctbmv002.bmov_datinve_1 AS datlanc,
    'C'::text AS tipomov,
    ctbmv002.bmov_ctacred_1 AS nrconta,
    ctbmv002.bmov_vrlanca_1 AS vrlanca,
    ctbmv002.bmov_histori_1 AS historico,
    ctbmv002.bmov_origeml_1 AS origem
   FROM ctbmv002
UNION ALL
 SELECT 2 AS empresa,
    ctbcn002.bcon_datinve_1 AS datlanc,
    ctbcn002.bcon_debcred_1 AS tipomov,
    ctbcn002.bcon_contrap_1 AS nrconta,
    ctbcn002.bcon_vrlanca_1 AS vrlanca,
    ctbcn002.bcon_histori_1 AS historico,
    ctbmv002.bmov_origeml_1 AS origem
   FROM ctbcn002
     LEFT JOIN ctbmv002 ON ctbcn002.bcon_datinve_1 = ctbmv002.bmov_datinve_1 AND ctbcn002.bcon_sequmes_1 = ctbmv002.bmov_sequmes_1 AND ctbcn002.bcon_nrolanc_1 = ctbmv002.bmov_nrolanc_1
UNION ALL
 SELECT 3 AS empresa,
    ctbmv003.bmov_datinve_1 AS datlanc,
    'D'::text AS tipomov,
    ctbmv003.bmov_ctadebi_1 AS nrconta,
    ctbmv003.bmov_vrlanca_1 AS vrlanca,
    ctbmv003.bmov_histori_1 AS historico,
    ctbmv003.bmov_origeml_1 AS origem
   FROM ctbmv003
UNION ALL
 SELECT 3 AS empresa,
    ctbmv003.bmov_datinve_1 AS datlanc,
    'C'::text AS tipomov,
    ctbmv003.bmov_ctacred_1 AS nrconta,
    ctbmv003.bmov_vrlanca_1 AS vrlanca,
    ctbmv003.bmov_histori_1 AS historico,
    ctbmv003.bmov_origeml_1 AS origem
   FROM ctbmv003
UNION ALL
 SELECT 3 AS empresa,
    ctbcn003.bcon_datinve_1 AS datlanc,
    ctbcn003.bcon_debcred_1 AS tipomov,
    ctbcn003.bcon_contrap_1 AS nrconta,
    ctbcn003.bcon_vrlanca_1 AS vrlanca,
    ctbcn003.bcon_histori_1 AS historico,
    ctbmv003.bmov_origeml_1 AS origem
   FROM ctbcn003
     LEFT JOIN ctbmv003 ON ctbcn003.bcon_datinve_1 = ctbmv003.bmov_datinve_1 AND ctbcn003.bcon_sequmes_1 = ctbmv003.bmov_sequmes_1 AND ctbcn003.bcon_nrolanc_1 = ctbmv003.bmov_nrolanc_1
UNION ALL
 SELECT 4 AS empresa,
    ctbmv004.bmov_datinve_1 AS datlanc,
    'D'::text AS tipomov,
    ctbmv004.bmov_ctadebi_1 AS nrconta,
    ctbmv004.bmov_vrlanca_1 AS vrlanca,
    ctbmv004.bmov_histori_1 AS historico,
    ctbmv004.bmov_origeml_1 AS origem
   FROM ctbmv004
UNION ALL
 SELECT 4 AS empresa,
    ctbmv004.bmov_datinve_1 AS datlanc,
    'C'::text AS tipomov,
    ctbmv004.bmov_ctacred_1 AS nrconta,
    ctbmv004.bmov_vrlanca_1 AS vrlanca,
    ctbmv004.bmov_histori_1 AS historico,
    ctbmv004.bmov_origeml_1 AS origem
   FROM ctbmv004
UNION ALL
 SELECT 4 AS empresa,
    ctbcn004.bcon_datinve_1 AS datlanc,
    ctbcn004.bcon_debcred_1 AS tipomov,
    ctbcn004.bcon_contrap_1 AS nrconta,
    ctbcn004.bcon_vrlanca_1 AS vrlanca,
    ctbcn004.bcon_histori_1 AS historico,
    ctbmv004.bmov_origeml_1 AS origem
   FROM ctbcn004
     LEFT JOIN ctbmv004 ON ctbcn004.bcon_datinve_1 = ctbmv004.bmov_datinve_1 AND ctbcn004.bcon_sequmes_1 = ctbmv004.bmov_sequmes_1 AND ctbcn004.bcon_nrolanc_1 = ctbmv004.bmov_nrolanc_1;