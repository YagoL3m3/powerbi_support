select bcta_nrconta_1 as nr_conta, case when bcta_nomecta_1 is null then btab_literal_4 else bcta_nomecta_1 end as nome_conta, bcta_graucta_1 as grau_conta from ctbt4001
left join ctbct001 ct on left(ct.bcta_nrconta_1, btab_graucta_4) = btab_nrocont_4
where btab_nrocont_4 <> ' '
order by btab_sequenc_4 asc, bcta_nrconta_1 asc