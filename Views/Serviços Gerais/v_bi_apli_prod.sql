-- public.v_bi_apli_prod fonte

CREATE OR REPLACE VIEW public.v_bi_apli_prod
AS SELECT a.oapl_emitent_1 AS cd_empr,
    a.oapl_produti_1 AS cd_prod,
    apopro.opro_nomepro_1 AS nm_prod,
    a.oapl_horaven_1 AS qt_hven,
    a.oapl_horapli_1 AS qt_hapl,
    a.oapl_datinve_1 AS data_apli,
    a.oapl_codativ_1 AS codativ,
    sintab76.ntab_descric_76 AS desc_ativ,
    a.oapl_codserv_1 AS codserv,
    ordsrvs.ords_descsv1_1 AS desc_serv,
    a.oapl_nrordem_1 AS nr_os,
    a.oapl_sequenc_1 AS seque,
    a.oapl_valtmp1_1 AS vr_hora
   FROM apoapl a
     LEFT JOIN apopro ON apopro.opro_produti_1::numeric = a.oapl_produti_1
     LEFT JOIN sintab76 ON sintab76.ntab_codativ_76::text = a.oapl_codativ_1::text
     JOIN ordsrvs ON a.oapl_emitent_1 = a.oapl_emitent_1 AND ordsrvs.ords_nrordem_1 = a.oapl_nrordem_1 AND ordsrvs.ords_sequenc_1 = a.oapl_sequenc_1
  WHERE a.oapl_produti_1 > 0::numeric;