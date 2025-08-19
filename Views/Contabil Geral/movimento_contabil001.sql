-- public.movimento_contabil001 fonte

CREATE OR REPLACE VIEW public.movimento_contabil001
AS WITH movimento_base AS (
         SELECT ctbmv001.bmov_datinve_1,
            ctbmv001.bmov_sequmes_1,
            ctbmv001.bmov_nrolanc_1,
            ctbmv001.bmov_ctadebi_1,
            ctbmv001.bmov_ctacred_1,
            ctbmv001.bmov_vrlanca_1,
            ctbmv001.bmov_histori_1,
            ctbmv001.bmov_origeml_1
           FROM ctbmv001
          WHERE ctbmv001.bmov_vrlanca_1 > 0::numeric
        ), contrapartidas AS (
         SELECT DISTINCT ctbcn001.bcon_datinve_1,
            ctbcn001.bcon_sequmes_1,
            ctbcn001.bcon_nrolanc_1,
            ctbcn001.bcon_debcred_1,
            ctbcn001.bcon_contrap_1,
            ctbcn001.bcon_vrlanca_1,
            ctbcn001.bcon_histori_1
           FROM ctbcn001
          WHERE ctbcn001.bcon_vrlanca_1 > 0::numeric
        )
 SELECT 1 AS empresa,
    m.bmov_datinve_1 AS datlanc,
    'D'::character(1) AS tipomov,
    m.bmov_ctadebi_1 AS conta,
    m.bmov_vrlanca_1 AS vrlanca,
    m.bmov_histori_1 AS historico,
    m.bmov_origeml_1 AS origem
   FROM movimento_base m
  WHERE m.bmov_ctadebi_1 <> 0::numeric
UNION ALL
 SELECT 1 AS empresa,
    m.bmov_datinve_1 AS datlanc,
    'C'::character(1) AS tipomov,
    m.bmov_ctacred_1 AS conta,
    m.bmov_vrlanca_1 AS vrlanca,
    m.bmov_histori_1 AS historico,
    m.bmov_origeml_1 AS origem
   FROM movimento_base m
  WHERE m.bmov_ctacred_1 <> 0::numeric
UNION ALL
 SELECT 1 AS empresa,
    c.bcon_datinve_1 AS datlanc,
    c.bcon_debcred_1 AS tipomov,
    c.bcon_contrap_1 AS conta,
    c.bcon_vrlanca_1 AS vrlanca,
    c.bcon_histori_1 AS historico,
    m.bmov_origeml_1 AS origem
   FROM contrapartidas c
     JOIN movimento_base m ON c.bcon_datinve_1 = m.bmov_datinve_1 AND c.bcon_sequmes_1 = m.bmov_sequmes_1 AND c.bcon_nrolanc_1 = m.bmov_nrolanc_1;