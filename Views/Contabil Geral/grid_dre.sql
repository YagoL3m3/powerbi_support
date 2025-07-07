select
1 as emitente,
btab_sequenc_4 as ordem_dre,
btab_nrocont_4 as grupo_conta,
btab_sequenc_4 || ' - ' || btab_literal_4 as nome_grupo,
case when ct.bcta_nomecta_1 is null then btab_nrocont_4 else ct.bcta_nrconta_1 end as nr_conta,
case when ct.bcta_nomecta_1 is null then btab_nrocont_4 else ct.bcta_nrconta_1 end || ' - ' || case when ct.bcta_nomecta_1 is null then btab_nrocont_4 else ct.bcta_nomecta_1 end as nome_conta,
--coalesce(cts6.bcta_nrconta_1,cts5.bcta_nrconta_1,cts4.bcta_nrconta_1,cts3.bcta_nrconta_1,cts.bcta_nrconta_1) as grupo_pai,
ct.bcta_nrconta_1 as q1,
cts1.bcta_nrconta_1 as q11,
cts2.bcta_nrconta_1 as q2,
cts3.bcta_nrconta_1 as q3,
cts4.bcta_nrconta_1 as q4,
cts5.bcta_nrconta_1 as q5,
cts6.bcta_nrconta_1 as q6,
--coalesce(cts6.bcta_nrconta_1,cts5.bcta_nrconta_1,cts4.bcta_nrconta_1,cts3.bcta_nrconta_1,cts.bcta_nrconta_1) || ' - ' || coalesce(cts6.bcta_nomecta_1,cts5.bcta_nomecta_1,cts4.bcta_nomecta_1,cts3.bcta_nomecta_1,cts.bcta_nomecta_1) as nome_conta_pai,
ct.bcta_graucta_1 as grau_conta
from ctbt4001
left join ctbct001 ct on left(ct.bcta_nrconta_1, btab_graucta_4) = btab_nrocont_4
left join ctbct001 cts1 on ct.bcta_graucta_1 = 1 and left(ct.bcta_nrconta_1, 1) = cts1.bcta_nrconta_1
left join ctbct001 cts2 on ct.bcta_graucta_1 = 2 and left(ct.bcta_nrconta_1, 2) = cts2.bcta_nrconta_1
left join ctbct001 cts3 on ct.bcta_graucta_1 = 3 and left(ct.bcta_nrconta_1, 3) = cts3.bcta_nrconta_1
left join ctbct001 cts4 on ct.bcta_graucta_1 = 4 and left(ct.bcta_nrconta_1, 5) = cts4.bcta_nrconta_1
left join ctbct001 cts5 on ct.bcta_graucta_1 = 5 and left(ct.bcta_nrconta_1, 7) = cts5.bcta_nrconta_1
left join ctbct001 cts6 on ct.bcta_graucta_1 = 6 and left(ct.bcta_nrconta_1, 10) = cts6.bcta_nrconta_1
/*left join ctbct001 cts on ct.bcta_graucta_1 = 2 and left(ct.bcta_nrconta_1, ) = cts.bcta_nrconta_1
left join ctbct001 cts3 on ct.bcta_graucta_1 = 3 and left(ct.bcta_nrconta_1, 2) = cts3.bcta_nrconta_1
left join ctbct001 cts4 on ct.bcta_graucta_1 = 4 and left(ct.bcta_nrconta_1, 3) = cts4.bcta_nrconta_1
left join ctbct001 cts5 on ct.bcta_graucta_1 = 5 and left(ct.bcta_nrconta_1, 5) = cts5.bcta_nrconta_1
left join ctbct001 cts6 on ct.bcta_graucta_1 = 6 and left(ct.bcta_nrconta_1, 7) = cts6.bcta_nrconta_1*/
where btab_nrocont_4 <> ' '
order by btab_sequenc_4 asc, ct.bcta_nrconta_1 asc