-- public.v_bi_ajustesfisc source

CREATE OR REPLACE VIEW public.v_bi_ajustesfisc
AS SELECT
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
 SELECT escaj002.caju_inidata_1,
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
 SELECT escaj003.caju_inidata_1,
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
 SELECT escaj004.caju_inidata_1,
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
 SELECT escaj051.caju_inidata_1,
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
 SELECT escaj100.caju_inidata_1,
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