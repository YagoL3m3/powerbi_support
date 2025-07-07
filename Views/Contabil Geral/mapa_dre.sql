select btab_sequenc_4 as ordem_dre, btab_nrocont_4 as grupo_conta, bcta_nrconta_1 as nr_conta from ctbt4001
left join ctbct001 ct on left(ct.bcta_nrconta_1, btab_graucta_4) = btab_nrocont_4
where btab_nrocont_4 <> ' '
order by btab_sequenc_4 asc, bcta_nrconta_1 asc