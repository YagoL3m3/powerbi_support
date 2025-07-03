select 'Total dos Débitos' as linha, valor_contabil as apuracao, to_char(data_lancamento, 'mm/yyyy') as mes_ano from v_bi_fiscal vbf where tipo = 'S'
union all
select 'Total Ajuste Débitos' as linha, caju_valores_1 as apuracao ,to_char(caju_findata_1, 'mm/yyyy') as mes_ano from v_bi_ajustesfisc
where caju_descric_1 like '%débito%'
union all
select
utilização,
SUM(caju_valores_1) as apuração,
to_char(caju_findata_1, 'mm/yyyy') as mes_ano
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
where cod_util = 3
group by 1,3
union all
select
utilização,
SUM(caju_valores_1) as apuração,
to_char(caju_findata_1, 'mm/yyyy') as mes_ano
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
where cod_util = 0
group by 1,3
union all
select
utilização,
SUM(caju_valores_1) as apuração,
to_char(caju_findata_1, 'mm/yyyy') as mes_ano
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
where cod_util = 5
group by 1,3
union all
select 'Total de Créditos nas Entradas' as linha, valor_contabil as apuracao, to_char(data_lancamento, 'mm/yyyy') as data_lanc from v_bi_fiscal vbf where tipo = 'E'
union all
select 'Total Ajustes a crédito' as linha,caju_valores_1 as apuracao , to_char(caju_findata_1, 'mm/yyyy') as data_lanc from v_bi_ajustesfisc
where caju_descric_1 like '%crédito%'
union all
select
utilização,
SUM(caju_valores_1) as apuração,
to_char(caju_findata_1, 'mm/yyyy') as mes_ano
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
where cod_util = 1
group by 1,3
union all
select
utilização,
SUM(caju_valores_1) as apuração,
to_char(caju_findata_1, 'mm/yyyy') as mes_ano
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
where cod_util = 2
group by 1,3
union all
select 'Saldo credor período anterior' as linha, 0 as apuracao, null as data_lanc  from sinc00
union all
select 'Saldo devedor apurado' as linha, 0 as apuracao, null as data_lanc from sinc00
union all
select
utilização,
SUM(caju_valores_1) as apuração,
to_char(caju_findata_1, 'mm/yyyy') as mes_ano
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
where cod_util = 4
group by 1,3
union all
select 'ICMS a Recolher' as linha, 0 as apuracao, null as data_lanc from sinc00
union all
select 'Saldo a transportar' as linha, 0 as apuracao, null as data_lanc from sinc00
