-- public.v_bi_ajustesfisc fonte

CREATE OR REPLACE VIEW public.v_bi_ajustesfisc
AS SELECT 1 AS empresa,
    escaj001.caju_inidata_1,
    escaj001.caju_findata_1,
    escaj001.caju_codajus_1,
    escaj001.caju_sequenc_1,
    escaj001.caju_valores_1,
    escaj001.caju_descric_1,
    escaj001.caju_codigia_1,
    escaj001.caju_seqsped_1,
    escaj001.caju_prodeau_1,
    escaj001.caju_prgorig_1
   FROM escaj001
UNION ALL
 SELECT 2 AS empresa,
    escaj002.caju_inidata_1,
    escaj002.caju_findata_1,
    escaj002.caju_codajus_1,
    escaj002.caju_sequenc_1,
    escaj002.caju_valores_1,
    escaj002.caju_descric_1,
    escaj002.caju_codigia_1,
    escaj002.caju_seqsped_1,
    escaj002.caju_prodeau_1,
    escaj002.caju_prgorig_1
   FROM escaj002
UNION ALL
 SELECT 3 AS empresa,
    escaj003.caju_inidata_1,
    escaj003.caju_findata_1,
    escaj003.caju_codajus_1,
    escaj003.caju_sequenc_1,
    escaj003.caju_valores_1,
    escaj003.caju_descric_1,
    escaj003.caju_codigia_1,
    escaj003.caju_seqsped_1,
    escaj003.caju_prodeau_1,
    escaj003.caju_prgorig_1
   FROM escaj003
UNION ALL
 SELECT 4 AS empresa,
    escaj004.caju_inidata_1,
    escaj004.caju_findata_1,
    escaj004.caju_codajus_1,
    escaj004.caju_sequenc_1,
    escaj004.caju_valores_1,
    escaj004.caju_descric_1,
    escaj004.caju_codigia_1,
    escaj004.caju_seqsped_1,
    escaj004.caju_prodeau_1,
    escaj004.caju_prgorig_1
   FROM escaj004
UNION ALL
 SELECT 51 AS empresa,
    escaj051.caju_inidata_1,
    escaj051.caju_findata_1,
    escaj051.caju_codajus_1,
    escaj051.caju_sequenc_1,
    escaj051.caju_valores_1,
    escaj051.caju_descric_1,
    escaj051.caju_codigia_1,
    escaj051.caju_seqsped_1,
    escaj051.caju_prodeau_1,
    escaj051.caju_prgorig_1
   FROM escaj051
UNION ALL
 SELECT 100 AS empresa,
    escaj100.caju_inidata_1,
    escaj100.caju_findata_1,
    escaj100.caju_codajus_1,
    escaj100.caju_sequenc_1,
    escaj100.caju_valores_1,
    escaj100.caju_descric_1,
    escaj100.caju_codigia_1,
    escaj100.caju_seqsped_1,
    escaj100.caju_prodeau_1,
    escaj100.caju_prgorig_1
   FROM escaj100;