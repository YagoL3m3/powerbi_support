-- public.v_bi_apli_prod source

CREATE OR REPLACE VIEW public.v_bi_apli_prod
AS select 
	   oapl_emitent_1 as cd_empr,
       oapl_produti_1 as cd_prod,
       opro_nomepro_1 as nm_prod,
       oapl_horaven_1 as qt_hven,
       oapl_horapli_1 as qt_hapl,
       oapl_datinve_1 as data_apli,
       oapl_codativ_1 as codativ,
       ntab_descric_76 as desc_ativ,
       oapl_codserv_1 as codserv,
       ords_descsv1_1 as desc_serv,
       oapl_nrordem_1 as nr_os,
       oapl_sequenc_1 as seque
 from apoapl a
 left join apopro on opro_produti_1 = a.oapl_produti_1
 left join sintab76 on ntab_codativ_76 = oapl_codativ_1
 join ordsrvs on oapl_emitent_1 = oapl_emitent_1 and  ords_nrordem_1 = oapl_nrordem_1 and ords_sequenc_1 = oapl_sequenc_1
   WHERE a.oapl_produti_1 > 0

