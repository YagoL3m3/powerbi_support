-- public.v_bi_ajustes source

CREATE OR REPLACE VIEW public.v_bi_ajustes
AS select
utilização,
SUM(caju_valores_1) as apuração,
to_char(caju_findata_1, 'mm/yyyy') as mes_ano,
cod_util
from v_bi_ajustesfisc vba 
left join (select 	
ctab_siglest_23	|| ctab_tipoapu_23 || ctab_utiliza_23 || CASE
		WHEN length(ctab_sequenc_23::text) = 1 THEN '000' || ctab_sequenc_23::text
	    WHEN length(ctab_sequenc_23::text) = 2 THEN '00' || ctab_sequenc_23::text
	    WHEN length(ctab_sequenc_23::text) = 3 THEN '0' || ctab_sequenc_23::text
	    ELSE ctab_sequenc_23::text
	END AS cod_ajuste,
ctab_siglest_23,
ctab_utiliza_23 as cod_util,
case 
	when ctab_utiliza_23 = 0 then 'Outros Débitos'
	when ctab_utiliza_23 = 1 then 'Estorno de Créditos'
	when ctab_utiliza_23 = 2 then 'Outros Créditos'
	when ctab_utiliza_23 = 3 then 'Estornos de Débitos'
	when ctab_utiliza_23 = 4 then 'Deduções'
	when ctab_utiliza_23 = 5 then 'Débitos Especiais'
end utilização
from esctab23) ca on ca.cod_ajuste = caju_codajus_1
group by 1,3,4