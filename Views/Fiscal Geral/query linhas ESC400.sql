select * from 
(select 1 as id, '1 - Total dos Débitos' as linha, SUM(valor_contabil) *-1 as apuracao, to_char(data_lancamento, 'mm/yyyy') as mes_ano from v_bi_fiscal vbf where tipo = 'S'
group by 2,4,1
union all
select 2 id, '2 - Total Ajuste Débitos' as linha, SUM(caju_valores_1) *-1 as apuracao ,to_char(caju_findata_1, 'mm/yyyy') as mes_ano from v_bi_ajustesfisc
where caju_descric_1 like '%débito%'
group by 2,4,1
union all
select 3 as id, 3 || ' - ' || utilização, apuração*-1, mes_ano from v_bi_ajustes
where cod_util = 3
union all
select 4 as id, 4 || ' - ' || utilização, apuração*-1, mes_ano from v_bi_ajustes
where cod_util = 0
union all
select 5 as id, 5 || ' - ' || utilização, apuração*-1, mes_ano from v_bi_ajustes
where cod_util = 5
union all
select 6 as id, '6 - Total de Créditos nas Entradas' as linha, SUM(valor_contabil) as apuracao, to_char(data_lancamento, 'mm/yyyy') as data_lanc from v_bi_fiscal vbf where tipo = 'E'
group by 2,4,1
union all
select 7 as id, '7 - Total Ajustes a crédito' as linha, SUM(caju_valores_1) as apuracao , to_char(caju_findata_1, 'mm/yyyy') as data_lanc from v_bi_ajustesfisc
where caju_descric_1 like '%crédito%'
group by 2,4,1
union all
select 8 as id, 8 || ' - ' || utilização, apuração, mes_ano from v_bi_ajustes
where cod_util = 1
union all
select 9  as id, 9 || ' - ' || utilização, apuração, mes_ano from v_bi_ajustes
where cod_util = 2
union all
select 10 as id, 10 || ' - ' || utilização, apuração, mes_ano from v_bi_ajustes
where cod_util = 4
union all
select 11 as id, '11 - ICMS a Recolher' as linha, 0 as apuracao, null as data_lanc from sinc00
union all
select
12 as id, '12 - Saldo a transportar' as utilizacao,
SUM(cscr_saldcr1_1 + cscr_saldcr2_1 + cscr_saldcr3_1) as apuração,
     CASE WHEN cscr_mesrefe_1 = 1 then '12' || '/' || (cscr_anorefe_1 - 1)  else
     CASE
        WHEN length(cscr_mesrefe_1::text) = 1 THEN '0' || (cscr_mesrefe_1 - 1)::text || '/' || cscr_anorefe_1
        ELSE (cscr_mesrefe_1 - 1)::text || '/' || cscr_anorefe_1
    END end  AS data_lanc
from escsc001
group by 2,4,1) x
order by 4, 1
