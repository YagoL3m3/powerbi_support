select
linha,
linhas,
cd_empr,
cd_soli,
nm_soli,
nr_soli,
nm_depart,
ds_prio,
ds_tipo,
cd_stsl,
ds_stsl,
dt_soli,
ds_apso,
cd_cus,
qt_pedi,
vr_pedi,
vr_totalpedi,
nr_pedi,
dt_pedi,
ds_stpd,
tp_lanc,
ds_lanc,
nr_cota,
ds_dest,
nm_dest,
ds_prod, 
ds_desc,
ds_forn,
nm_forn,
forn_01,
nm_forn1,
valor_01,
forn_02,
nm_forn2,
valor_02,
forn_03,
nm_forn3,
valor_03,
ds_obse,
valor_cota_01,
valor_cota_02,
valor_cota_03
from v_bi_compras_corp

select * from adccotl where cotl_tipoaut_1 = 1

select * from SINTAB23

case cotl_statuss_1
		when 1 then ''
		when 9 then 'Cotação reprovada'
		when 3 then 'Cotação aprovada'