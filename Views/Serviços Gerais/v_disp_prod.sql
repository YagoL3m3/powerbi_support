-- public.v_bi_disp_prod source

CREATE OR REPLACE VIEW public.v_bi_disp_prod
AS select
x.cd_prod,
x.nom_prod,
x.data_adm,
x.data_dem,
data_series.data,
/*Esse trecho traz as jornadas de trabalho dos dias da semana*/
x.jornada_semana,
/*Esse trecho traz as informações do último dia da semana que provavelmente caira no sabado*/
x.jornada_sabado,
/*Traz as excessões Ex: Ferias, Atestados ou outros tipos de excessões*/
coalesce(( ( ( OPNT_JORNFIN_1 - OPNT_JORNINI_1 ) - ( OPNT_ALMOFIN_1 - OPNT_ALMOINI_1 ) ) / 100) - OPNT_HORTREI_1 - OPNT_FERIASS_1 - OPNT_AUSEREM_1 - OPNT_AUSNREM_1, 0) as jornada_excessao,
/*Esse case trata faz uma verificação onde se a jornada das excessões estiver em branco então buscamos da jornada convencional do Produtivo
 * ele também faz a verificação para ver se baseado na data devemos considerar convencional ou a jornada do ultimo dia da semana(Sabado ou Domingo)
 * dessa forma conseguimos a disponibilidade daquele produtivo*/
case when ( ( ( OPNT_JORNFIN_1 - OPNT_JORNINI_1 ) - ( OPNT_ALMOFIN_1 - OPNT_ALMOINI_1 ) ) / 100) - OPNT_HORTREI_1 - OPNT_FERIASS_1 - OPNT_AUSEREM_1 - OPNT_AUSNREM_1 is null
 then case when to_char(data_series.data, 'd') = '7' then x.jornada_sabado else x.jornada_semana end
 else ( ( ( OPNT_JORNFIN_1 - OPNT_JORNINI_1 ) - ( OPNT_ALMOFIN_1 - OPNT_ALMOINI_1 ) ) / 100) - OPNT_HORTREI_1 - OPNT_FERIASS_1 - OPNT_AUSEREM_1 - OPNT_AUSNREM_1 end as disp
from 
(select
opro_produti_1 as cd_prod,
opro_nomepro_1 as nom_prod,
opro_datadmi_1 as data_adm,
CASE 
    WHEN opro_datafas_1 = DATE '1899-12-30' THEN (date_trunc('month', CURRENT_DATE) + INTERVAL '1 month - 1 day')::DATE
    ELSE opro_datafas_1
END AS data_dem,
( ( OPRO_JORNSMF_1 - OPRO_JORNSMI_1) - ( OPRO_ALMOSMF_1 - OPRO_ALMOSMI_1 ) ) / 100 as jornada_semana,
( ( OPRO_JORNSBF_1 - OPRO_JORNSBI_1 ) - ( OPRO_ALMOSBF_1 - OPRO_ALMOSBI_1) ) / 100 as jornada_sabado
from apopro a) x
join lateral generate_series(x.data_adm::timestamptz, x.data_dem::timestamptz, '1 day'::interval) as data_series(data) ON TRUE
left join apopnt pnt on pnt.opnt_produti_1 = cd_prod and opnt_datinve_1 = data_series.data::date
where to_char(data_series.data, 'd') <> '1'