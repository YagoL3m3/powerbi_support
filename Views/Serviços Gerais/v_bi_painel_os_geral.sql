-- public.v_painel source

CREATE OR REPLACE VIEW public.v_painel
AS SELECT
        CASE sintab12.ntab_caterev_12
            WHEN 1 THEN 'Leves'::text
            WHEN 2 THEN 'Pesados'::text
            WHEN 3 THEN 'Motos'::text
            WHEN 4 THEN 'Maquinas'::text
            ELSE NULL::text
        END AS tp_nego,
    sintab12.ntab_regirev_12 AS nr_regi,
        CASE sintab12.ntab_tiporev_12
            WHEN 1 THEN 'Fiat'::text
            WHEN 2 THEN 'Volkswagen'::text
            WHEN 3 THEN 'Ford'::text
            WHEN 6 THEN 'Kia'::text
            WHEN 17 THEN 'New-Holland'::text
            ELSE NULL::text
        END AS tp_reve,
    sgvacm.vacm_emitnot_1 AS cd_empr,
    sintab12.ntab_grpemit_12 AS cd_grpe,
    sintab12.ntab_empabrv_12 AS nm_abre,
    sgvacm.vacm_codgrup_1 AS cd_grup,
    cadven.dven_nomeven_1 AS nm_vend,
    sgvacm.vacm_vendedo_1 AS cd_vend,
    sgvacm.vacm_cliente_1 AS cd_clie,
    sgvgmv.vgmv_descmod_1 AS nm_fami,
    0 AS cd_depa,
    ' '::text AS nm_depa,
    ' '::text AS cd_linh,
    sgvacm.vacm_vendinv_1 AS dt_vend,
        CASE sgvvei.vvei_tipovei_1
            WHEN 'N'::text THEN
            CASE sgvgmv.vgmv_tratore_1
                WHEN '0'::text THEN 'Veiculo'::text
                WHEN '1'::text THEN 'Trator'::text
                WHEN '2'::text THEN 'Caminhao'::text
                WHEN '3'::text THEN 'Motos'::text
                WHEN '4'::text THEN 'Implemento'::text
                WHEN '5'::text THEN 'Colheitadeira'::text
                WHEN '6'::text THEN 'Empilhadeira'::text
                WHEN '7'::text THEN 'Onibus'::text
                WHEN '8'::text THEN 'Equipamento'::text
                ELSE NULL::text
            END
            WHEN 'U'::text THEN
            CASE sgvvei.vvei_categor_1
                WHEN 'CM'::text THEN 'Caminhao'::text
                WHEN 'ON'::text THEN 'Onibus'::text
                WHEN 'CL'::text THEN 'Comercial Leve'::text
                WHEN 'CP'::text THEN 'Comercial Pesado'::text
                WHEN 'CO'::text THEN 'Colheitadeira'::text
                WHEN 'IM'::text THEN 'Implemento'::text
                WHEN 'PS'::text THEN 'Passageiro'::text
                WHEN 'EQ'::text THEN 'Equipamento'::text
                WHEN 'TR'::text THEN 'Trator'::text
                ELSE 'Veiculo'::text
            END
            ELSE NULL::text
        END AS ds_cate,
        CASE sgvacm.vacm_tipovei_1
            WHEN 'N'::text THEN
            CASE sgvvei.vvei_vendire_1
                WHEN 0 THEN 1
                ELSE 0
            END
            ELSE 0
        END AS novo_qtde,
    0::numeric AS novo_meta,
        CASE sgvacm.vacm_tipovei_1
            WHEN 'N'::text THEN sgvacm.vacm_valnota_1
            ELSE 0::numeric
        END AS novo_vend,
        CASE sgvacm.vacm_tipovei_1
            WHEN 'N'::text THEN sgvvei.vvei_valaqui_1
            ELSE 0::numeric
        END AS novo_aqui,
        CASE sgvacm.vacm_tipovei_1
            WHEN 'N'::text THEN sgvacm.vacm_partidn_1
            ELSE 0::numeric
        END AS novo_fund,
        CASE sgvacm.vacm_tipovei_1
            WHEN 'N'::text THEN sgvacm.vacm_bonufab_1
            ELSE 0::numeric
        END AS novo_bonu,
        CASE sgvacm.vacm_tipovei_1
            WHEN 'N'::text THEN f_sgv1755(
            CASE sgvvei.vvei_tipovei_1
                WHEN 'N'::text THEN
                CASE sgvvei.vvei_vendire_1
                    WHEN 0 THEN 12
                    ELSE 12
                END
                WHEN 'U'::text THEN 13
                ELSE NULL::integer
            END, sgvacm.vacm_propost_1)
            ELSE 0::numeric
        END AS novo_pven,
        CASE sgvacm.vacm_tipovei_1
            WHEN 'N'::text THEN sgvvei.vvei_valaqui_1 - sgvacm.vacm_difimpo_1 - sgvacm.vacm_valrevi_1 - sgvacm.vacm_valrepa_1 - sgvacm.vacm_custadm_1 - sgvacm.vacm_valcomi_1 - sgvacm.vacm_valmark_1 - sgvacm.vacm_jurpraz_1 - sgvacm.vacm_encfloo_1 + (sgvacm.vacm_holdbac_1 + sgvacm.vacm_bonufab_1 + sgvacm.vacm_retorno_1) - sgvacm.vacm_valbonu_1 - sgvacm.vacm_comiluc_1 - sgvacm.vacm_redhold_1 + sgvacm.vacm_florecu_1
            ELSE 0::numeric
        END AS novo_cust,
        CASE sgvacm.vacm_tipovei_1
            WHEN 'N'::text THEN sgvacm.vacm_valnota_1
            ELSE 0::numeric
        END AS novo_pcus,
        CASE sgvacm.vacm_tipovei_1
            WHEN 'N'::text THEN
            CASE sgvvei.vvei_vendire_1
                WHEN 0 THEN 0
                ELSE 1
            END
            ELSE 0
        END AS frot_qtde,
        CASE sgvacm.vacm_tipovei_1
            WHEN 'N'::text THEN
            CASE sgvvei.vvei_vendire_1
                WHEN 0 THEN 0
                ELSE sgvvei.vvei_vendire_1
            END
            ELSE 0
        END AS frot_tipo,
    0 AS frot_meta,
        CASE sgvacm.vacm_tipovei_1
            WHEN 'U'::text THEN 1
            ELSE 0
        END AS usad_qtde,
    0 AS usad_meta,
        CASE sgvacm.vacm_tipovei_1
            WHEN 'U'::text THEN sgvacm.vacm_valnota_1
            ELSE 0::numeric
        END AS usad_vend,
        CASE sgvacm.vacm_tipovei_1
            WHEN 'U'::text THEN sgvvei.vvei_valaqui_1
            ELSE 0::numeric
        END AS usad_aqui,
        CASE sgvacm.vacm_tipovei_1
            WHEN 'U'::text THEN sgvacm.vacm_valnota_1 - sgvvei.vvei_valaqui_1 - sgvacm.vacm_difimpo_1 - sgvacm.vacm_valrevi_1 - sgvacm.vacm_valrepa_1 - sgvacm.vacm_custadm_1 - sgvacm.vacm_encfina_1 - sgvacm.vacm_valmark_1 - sgvacm.vacm_comiluc_1 - sgvacm.vacm_jurpraz_1 - sgvacm.vacm_valicms_1 - sgvacm.vacm_pisconf_1 + sgvacm.vacm_retorno_1 + sgvacm.vacm_valplus_1 - sgvacm.vacm_valbonu_1 + sgvacm.vacm_descven_1 - sgvacm.vacm_acreven_1
            ELSE 0::numeric
        END AS usad_pven,
        CASE sgvacm.vacm_tipovei_1
            WHEN 'U'::text THEN sgvvei.vvei_valaqui_1 - sgvacm.vacm_difimpo_1 - sgvacm.vacm_valrevi_1 - sgvacm.vacm_valrepa_1 - sgvacm.vacm_custadm_1 - sgvacm.vacm_encfina_1 - sgvacm.vacm_valmark_1 - sgvacm.vacm_comiluc_1 - sgvacm.vacm_jurpraz_1 - sgvacm.vacm_valicms_1 - sgvacm.vacm_pisconf_1 + sgvacm.vacm_retorno_1 + sgvacm.vacm_valplus_1 - sgvacm.vacm_valbonu_1 + sgvacm.vacm_descven_1 - sgvacm.vacm_acreven_1
            ELSE 0::numeric
        END AS usad_cust,
        CASE sgvacm.vacm_tipovei_1
            WHEN 'U'::text THEN sgvacm.vacm_valnota_1
            ELSE 0::numeric
        END AS usad_pcus,
    sgvacm.vacm_retorno_1 + sgvacm.vacm_valplus_1 + sgvacm.vacm_valplu2_1 + sgvacm.vacm_tacreto_1 AS fina_valo,
    sgvacm.vacm_valfina_1 AS fina_tota,
    0 AS fina_meta,
    0 AS cons_qtde,
    0 AS cons_comi,
    0 AS cons_meta,
    0 AS conv_qtde,
    0 AS conv_meta,
    0 AS peca_valo,
    0 AS peca_ofic,
    0 AS peca_meta,
    0 AS peca_metb,
    0 AS peca_meto,
    0 AS peca_cust,
    0 AS peca_cust_ofic,
    0 AS aces_valo,
    0 AS aces_meta,
    0 AS aces_cust,
    0 AS funi_valo,
    0 AS funi_meta,
    0 AS funi_metp,
    0 AS funi_mets,
    0 AS funi_cust,
    0 AS funi_serv,
    0 AS funi_csts,
    0 AS serv_valo,
    0 AS aces_serv,
    0 AS serv_meta,
    0 AS serv_cust,
    0 AS aces_csts,
    COALESCE(( SELECT sum(sgvace.vace_liquido_1) AS sum
           FROM sgvace
          WHERE sgvace.vace_propost_1::text = sgvacm.vacm_propost_1::text AND sgvace.vace_cortesi_1 = 0), 0::numeric) AS acev_valo,
    0 AS acev_meta,
    COALESCE(( SELECT sum(sgvout.vout_valores_1) AS sum
           FROM sgvout
             LEFT JOIN sgvtab05 ON sgvtab05.vtab_coditab_05 = sgvout.vout_codigos_1
          WHERE sgvout.vout_propost_1::text = sgvacm.vacm_propost_1::text AND (sgvtab05.vtab_identif_05 = ANY (ARRAY[1, 2, 3, 4, 5]))), 0::numeric) AS agre_valo,
    0 AS agre_meta,
    0 AS pbal_valo,
    0 AS pofi_valo,
    0 AS oace_valo,
    0 AS oagr_valo,
    0 AS onib_mete,
    0 AS onib_metd,
    ' '::text AS tipo_orde,
    ' '::text AS cd_ativ,
    0 AS sr_terc,
    ' '::text AS tipo_inte,
    0 AS mg_oper,
    0 AS vr_nven,
    0 AS vr_ncus,
    0 AS mg_brut,
    0 AS taxi_meta
   FROM sgvacm
     LEFT JOIN sgvvei ON sgvvei.vvei_codivei_1::text = sgvacm.vacm_codivei_1::text
     LEFT JOIN sgvmod ON sgvmod.vmod_codimod_1::text = sgvvei.vvei_codimod_1::text AND sgvmod.vmod_anomode_1 = sgvvei.vvei_anomode_1
     LEFT JOIN sgvgmv ON sgvgmv.vgmv_grupmod_1::text = sgvmod.vmod_grupmod_1::text AND sgvgmv.vgmv_serimod_1::text = sgvmod.vmod_serimod_1::text
     LEFT JOIN sintab12 ON sintab12.ntab_emitent_12 = sgvacm.vacm_emitnot_1
     LEFT JOIN cadven ON cadven.dven_codvend_1 = sgvacm.vacm_vendedo_1
  WHERE sgvacm.vacm_situaca_1::text = 'F'::text OR sgvacm.vacm_situaca_1::text = 'C'::text AND sgvacm.vacm_motcanc_1::text = 'DEVOLUCAO DE VENDA'::text AND to_char(sgvacm.vacm_datacan_1::timestamp with time zone, 'yyyymm'::text) > to_char(sgvacm.vacm_vendinv_1::timestamp with time zone, 'yyyymm'::text)
UNION ALL
 SELECT
        CASE sintab12.ntab_caterev_12
            WHEN 1 THEN 'Leves'::text
            WHEN 2 THEN 'Pesados'::text
            WHEN 3 THEN 'Motos'::text
            WHEN 4 THEN 'Maquinas'::text
            ELSE NULL::text
        END AS tp_nego,
    sintab12.ntab_regirev_12 AS nr_regi,
        CASE sintab12.ntab_tiporev_12
            WHEN 1 THEN 'Fiat'::text
            WHEN 2 THEN 'Volkswagen'::text
            WHEN 3 THEN 'Ford'::text
            WHEN 6 THEN 'Kia'::text
            WHEN 17 THEN 'New-Holland'::text
            ELSE NULL::text
        END AS tp_reve,
    sgvcon.vcon_emitent_1 AS cd_empr,
    sintab12.ntab_grpemit_12 AS cd_grpe,
    sintab12.ntab_empabrv_12 AS nm_abre,
    cadven.dven_codgrup_1 AS cd_grup,
    cadven.dven_nomeven_1 AS nm_vend,
    cadven.dven_codvend_1 AS cd_vend,
    sgvcon.vcon_cgcocpf_1 AS cd_clie,
    ' '::character varying AS nm_fami,
    0 AS cd_depa,
    ' '::text AS nm_depa,
    ' '::text AS cd_linh,
    sgvcon.vcon_dataped_1 AS dt_vend,
    ' '::text AS ds_cate,
    0 AS novo_qtde,
    0::numeric AS novo_meta,
    0 AS novo_vend,
    0 AS novo_aqui,
    0 AS novo_fund,
    0 AS novo_bonu,
    0 AS novo_pven,
    0 AS novo_cust,
    0 AS novo_pcus,
    0 AS frot_qtde,
    0 AS frot_tipo,
    0 AS frot_meta,
    0 AS usad_qtde,
    0 AS usad_meta,
    0 AS usad_vend,
    0 AS usad_aqui,
    0 AS usad_pven,
    0 AS usad_cust,
    0 AS usad_pcus,
    0 AS fina_valo,
    0 AS fina_tota,
    0 AS fina_meta,
    1 AS cons_qtde,
    sgvcon.vcon_comissa_1 AS cons_comi,
    0 AS cons_meta,
    0 AS conv_qtde,
    0 AS conv_meta,
    0 AS peca_valo,
    0 AS peca_ofic,
    0 AS peca_meta,
    0 AS peca_metb,
    0 AS peca_meto,
    0 AS peca_cust,
    0 AS peca_cust_ofic,
    0 AS aces_valo,
    0 AS aces_meta,
    0 AS aces_cust,
    0 AS funi_valo,
    0 AS funi_meta,
    0 AS funi_metp,
    0 AS funi_mets,
    0 AS funi_cust,
    0 AS funi_serv,
    0 AS funi_csts,
    0 AS serv_valo,
    0 AS aces_serv,
    0 AS serv_meta,
    0 AS serv_cust,
    0 AS aces_csts,
    0 AS acev_valo,
    0 AS acev_meta,
    0 AS agre_valo,
    0 AS agre_meta,
    0 AS pbal_valo,
    0 AS pofi_valo,
    0 AS oace_valo,
    0 AS oagr_valo,
    0 AS onib_mete,
    0 AS onib_metd,
    ' '::text AS tipo_orde,
    ' '::text AS cd_ativ,
    0 AS sr_terc,
    ' '::text AS tipo_inte,
    0 AS mg_oper,
    0 AS vr_nven,
    0 AS vr_ncus,
    0 AS mg_brut,
    0 AS taxi_meta
   FROM sgvcon
     LEFT JOIN cadven ON cadven.dven_codvend_1 = sgvcon.vcon_vendedo_1
     LEFT JOIN sintab12 ON sintab12.ntab_emitent_12 = sgvcon.vcon_emitent_1
UNION ALL
 SELECT
        CASE sintab12.ntab_caterev_12
            WHEN 1 THEN 'Leves'::text
            WHEN 2 THEN 'Pesados'::text
            WHEN 3 THEN 'Motos'::text
            WHEN 4 THEN 'Maquinas'::text
            ELSE NULL::text
        END AS tp_nego,
    sintab12.ntab_regirev_12 AS nr_regi,
        CASE sintab12.ntab_tiporev_12
            WHEN 1 THEN 'Fiat'::text
            WHEN 2 THEN 'Volkswagen'::text
            WHEN 3 THEN 'Ford'::text
            WHEN 6 THEN 'Kia'::text
            WHEN 17 THEN 'New-Holland'::text
            ELSE NULL::text
        END AS tp_reve,
    sinc04.sinc_emitrab_4 AS cd_empr,
    sintab12.ntab_grpemit_12 AS cd_grpe,
    sintab12.ntab_empabrv_12 AS nm_abre,
    cadven.dven_codgrup_1 AS cd_grup,
    cadven.dven_nomeven_1 AS nm_vend,
    cadven.dven_codvend_1 AS cd_vend,
    0 AS cd_clie,
    ' '::character varying AS nm_fami,
    0 AS cd_depa,
    ' '::text AS nm_depa,
    ' '::text AS cd_linh,
    sgvloj.vloj_datacon_1 AS dt_vend,
    ' '::text AS ds_cate,
    0 AS novo_qtde,
    0::numeric AS novo_meta,
    0 AS novo_vend,
    0 AS novo_aqui,
    0 AS novo_fund,
    0 AS novo_bonu,
    0 AS novo_pven,
    0 AS novo_cust,
    0 AS novo_pcus,
    0 AS frot_qtde,
    0 AS frot_tipo,
    0 AS frot_meta,
    0 AS usad_qtde,
    0 AS usad_meta,
    0 AS usad_vend,
    0 AS usad_aqui,
    0 AS usad_pven,
    0 AS usad_cust,
    0 AS usad_pcus,
    0 AS fina_valo,
    0 AS fina_tota,
    0 AS fina_meta,
    0 AS cons_qtde,
    0 AS cons_comi,
    0 AS cons_meta,
    1 AS conv_qtde,
    0 AS conv_meta,
    0 AS peca_valo,
    0 AS peca_ofic,
    0 AS peca_meta,
    0 AS peca_metb,
    0 AS peca_meto,
    0 AS peca_cust,
    0 AS peca_cust_ofic,
    0 AS aces_valo,
    0 AS aces_meta,
    0 AS aces_cust,
    0 AS funi_valo,
    0 AS funi_meta,
    0 AS funi_metp,
    0 AS funi_mets,
    0 AS funi_cust,
    0 AS funi_serv,
    0 AS funi_csts,
    0 AS serv_valo,
    0 AS aces_serv,
    0 AS serv_meta,
    0 AS serv_cust,
    0 AS aces_csts,
    0 AS acev_valo,
    0 AS acev_meta,
    0 AS agre_valo,
    0 AS agre_meta,
    0 AS pbal_valo,
    0 AS pofi_valo,
    0 AS oace_valo,
    0 AS oagr_valo,
    0 AS onib_mete,
    0 AS onib_metd,
    ' '::text AS tipo_orde,
    ' '::text AS cd_ativ,
    0 AS sr_terc,
    ' '::text AS tipo_inte,
    0 AS mg_oper,
    0 AS vr_nven,
    0 AS vr_ncus,
    0 AS mg_brut,
    0 AS taxi_meta
   FROM sgvloj
     LEFT JOIN cadven ON cadven.dven_coduser_1::text = sgvloj.vloj_coduser_1::text
     LEFT JOIN sinc04 ON sinc04.sinc_coduser_4::text = sgvloj.vloj_coduser_1::text
     LEFT JOIN sintab12 ON sintab12.ntab_emitent_12 = sinc04.sinc_emitrab_4
UNION ALL
 SELECT
        CASE sintab12.ntab_caterev_12
            WHEN 1 THEN 'Leves'::text
            WHEN 2 THEN 'Pesados'::text
            WHEN 3 THEN 'Motos'::text
            WHEN 4 THEN 'Maquinas'::text
            ELSE NULL::text
        END AS tp_nego,
    sintab12.ntab_regirev_12 AS nr_regi,
        CASE sintab12.ntab_tiporev_12
            WHEN 1 THEN 'Fiat'::text
            WHEN 2 THEN 'Volkswagen'::text
            WHEN 3 THEN 'Ford'::text
            WHEN 6 THEN 'Kia'::text
            WHEN 17 THEN 'New-Holland'::text
            ELSE NULL::text
        END AS tp_reve,
    sintab75.ntab_emitent_75 AS cd_empr,
    sintab12.ntab_grpemit_12 AS cd_grpe,
    sintab12.ntab_empabrv_12 AS nm_abre,
    sgvobj.vobj_codgrup_1 AS cd_grup,
    ' '::character varying AS nm_vend,
    0 AS cd_vend,
    0 AS cd_clie,
    ' '::character varying AS nm_fami,
    0 AS cd_depa,
    ' '::text AS nm_depa,
    ' '::text AS cd_linh,
    to_date('01'::text || btrim(to_char(sgvobj.vobj_meseano_1, '000000'::text)), 'DDMMYYYY'::text) AS dt_vend,
    ' '::text AS ds_cate,
    0 AS novo_qtde,
    sgvobj.vobj_metnovo_1::numeric AS novo_meta,
    0 AS novo_vend,
    0 AS novo_aqui,
    0 AS novo_fund,
    0 AS novo_bonu,
    0 AS novo_pven,
    0 AS novo_cust,
    0 AS novo_pcus,
    0 AS frot_qtde,
    0 AS frot_tipo,
    sgvobj.vobj_metfatd_1::numeric AS frot_meta,
    0 AS usad_qtde,
    sgvobj.vobj_metusad_1::numeric AS usad_meta,
    0 AS usad_vend,
    0 AS usad_aqui,
    0 AS usad_pven,
    0 AS usad_cust,
    0 AS usad_pcus,
    0 AS fina_valo,
    0 AS fina_tota,
    sgvobj.vobj_metfinv_1 AS fina_meta,
    0 AS cons_qtde,
    0 AS cons_comi,
    sgvobj.vobj_metcons_1::numeric AS cons_meta,
    0 AS conv_qtde,
    0 AS conv_meta,
    0 AS peca_valo,
    0 AS peca_ofic,
    0 AS peca_meta,
    0 AS peca_metb,
    0 AS peca_meto,
    0 AS peca_cust,
    0 AS peca_cust_ofic,
    0 AS aces_valo,
    sgvobj.vobj_metaces_1 AS aces_meta,
    0 AS aces_cust,
    0 AS funi_valo,
    0 AS funi_meta,
    0 AS funi_metp,
    0 AS funi_mets,
    0 AS funi_cust,
    0 AS funi_serv,
    0 AS funi_csts,
    0 AS serv_valo,
    0 AS aces_serv,
    0 AS serv_meta,
    0 AS serv_cust,
    0 AS aces_csts,
    0 AS acev_valo,
    sgvobj.vobj_metaces_1 AS acev_meta,
    0 AS agre_valo,
    sgvobj.vobj_metsegv_1 AS agre_meta,
    0 AS pbal_valo,
    0 AS pofi_valo,
    0 AS oace_valo,
    0 AS oagr_valo,
    sgvobj.vobj_metonie_1::numeric AS onib_mete,
    sgvobj.vobj_metonid_1::numeric AS onib_metd,
    ' '::text AS tipo_orde,
    ' '::text AS cd_ativ,
    0 AS sr_terc,
    ' '::text AS tipo_inte,
    0 AS mg_oper,
    0 AS vr_nven,
    0 AS vr_ncus,
    0 AS mg_brut,
    sgvobj.vobj_mettaxi_1::numeric AS taxi_meta
   FROM sgvobj
     LEFT JOIN sintab75 ON sintab75.ntab_codgrup_75 = sgvobj.vobj_codgrup_1
     LEFT JOIN sintab12 ON sintab12.ntab_emitent_12 = sintab75.ntab_emitent_75
UNION ALL
 SELECT
        CASE sintab12.ntab_caterev_12
            WHEN 1 THEN 'Leves'::text
            WHEN 2 THEN 'Pesados'::text
            WHEN 3 THEN 'Motos'::text
            WHEN 4 THEN 'Maquinas'::text
            ELSE NULL::text
        END AS tp_nego,
    sintab12.ntab_regirev_12 AS nr_regi,
        CASE sintab12.ntab_tiporev_12
            WHEN 1 THEN 'Fiat'::text
            WHEN 2 THEN 'Volkswagen'::text
            WHEN 3 THEN 'Ford'::text
            WHEN 6 THEN 'Kia'::text
            WHEN 17 THEN 'New-Holland'::text
            ELSE NULL::text
        END AS tp_reve,
    v_notsai.cd_empr,
    sintab12.ntab_grpemit_12 AS cd_grpe,
    sintab12.ntab_empabrv_12 AS nm_abre,
    v_notsai.cd_empr AS cd_grup,
    v_notsai.nm_vend,
    v_notsai.cd_venn AS cd_vend,
    v_notsai.cd_clie,
        CASE v_notsai.nr_orde
            WHEN 0 THEN 'Balcao'::text
            ELSE 'Oficina'::text
        END AS nm_fami,
    v_notsai.cd_depa,
    v_notsai.nm_depa,
    v_notsai.cd_linh,
    v_notsai.dt_vend,
    ' '::text AS ds_cate,
    0 AS novo_qtde,
    0::numeric AS novo_meta,
    0 AS novo_vend,
    0 AS novo_aqui,
    0 AS novo_fund,
    0 AS novo_bonu,
    0 AS novo_pven,
    0 AS novo_cust,
    0 AS novo_pcus,
    0 AS frot_qtde,
    0 AS frot_tipo,
    0 AS frot_meta,
    0 AS usad_qtde,
    0 AS usad_meta,
    0 AS usad_vend,
    0 AS usad_aqui,
    0 AS usad_pven,
    0 AS usad_cust,
    0 AS usad_pcus,
    0 AS fina_valo,
    0 AS fina_tota,
    0 AS fina_meta,
    0 AS cons_qtde,
    0 AS cons_comi,
    0 AS cons_meta,
    0 AS conv_qtde,
    0 AS conv_meta,
        CASE v_notsai.tp_item
            WHEN 'Pecas'::text THEN v_notsai.vr_liqu
            ELSE 0::numeric
        END AS peca_valo,
        CASE
            WHEN v_notsai.tp_item = 'Pecas'::text AND v_notsai.nr_orde > 0 THEN v_notsai.vr_liqu
            ELSE 0::numeric
        END AS peca_ofic,
    0 AS peca_meta,
    0 AS peca_metb,
    0 AS peca_meto,
        CASE v_notsai.tp_item
            WHEN 'Pecas'::text THEN v_notsai.vr_cust + v_notsai.vr_impo
            ELSE 0::numeric
        END AS peca_cust,
        CASE
            WHEN v_notsai.tp_item = 'Pecas'::text AND v_notsai.nr_orde > 0 THEN v_notsai.vr_cust + v_notsai.vr_impo
            ELSE 0::numeric
        END AS peca_cust_ofic,
        CASE v_notsai.tp_item
            WHEN 'Pecas'::text THEN
            CASE
                WHEN v_notsai.cd_depa = 55 THEN v_notsai.vr_liqu
                ELSE 0::numeric
            END
            ELSE 0::numeric
        END AS aces_valo,
    0 AS aces_meta,
        CASE v_notsai.tp_item
            WHEN 'Pecas'::text THEN
            CASE
                WHEN v_notsai.cd_depa = 55 THEN v_notsai.vr_cust + v_notsai.vr_impo
                ELSE 0::numeric
            END
            ELSE 0::numeric
        END AS aces_cust,
        CASE v_notsai.tp_item
            WHEN 'Pecas'::text THEN
            CASE
                WHEN v_notsai.cd_depa = ANY (ARRAY[50, 62, 60, 63]) THEN v_notsai.vr_liqu
                ELSE 0::numeric
            END
            ELSE 0::numeric
        END AS funi_valo,
    0 AS funi_meta,
    0 AS funi_metp,
    0 AS funi_mets,
        CASE v_notsai.tp_item
            WHEN 'Pecas'::text THEN
            CASE
                WHEN v_notsai.cd_depa = ANY (ARRAY[50, 62, 60, 63]) THEN v_notsai.vr_cust + v_notsai.vr_impo
                ELSE 0::numeric
            END
            ELSE 0::numeric
        END AS funi_cust,
        CASE v_notsai.tp_item
            WHEN 'Servico'::text THEN
            CASE
                WHEN v_notsai.cd_depa = ANY (ARRAY[50, 62, 60, 63]) THEN v_notsai.vr_liqu
                ELSE 0::numeric
            END
            ELSE NULL::numeric
        END AS funi_serv,
        CASE v_notsai.tp_item
            WHEN 'Servico'::text THEN
            CASE
                WHEN v_notsai.cd_depa = ANY (ARRAY[50, 62, 60, 63]) THEN v_notsai.vr_cust
                ELSE 0::numeric
            END
            ELSE NULL::numeric
        END AS funi_csts,
        CASE v_notsai.tp_item
            WHEN 'Servico'::text THEN v_notsai.vr_liqu
            ELSE NULL::numeric
        END AS serv_valo,
        CASE v_notsai.tp_item
            WHEN 'Servico'::text THEN 0::numeric
            ELSE NULL::numeric
        END AS aces_serv,
    0 AS serv_meta,
        CASE v_notsai.tp_item
            WHEN 'Servico'::text THEN 0::numeric
            ELSE NULL::numeric
        END AS serv_cust,
        CASE v_notsai.tp_item
            WHEN 'Servico'::text THEN 0::numeric
            ELSE NULL::numeric
        END AS aces_csts,
    0 AS acev_valo,
    0 AS acev_meta,
    0 AS agre_valo,
    0 AS agre_meta,
        CASE
            WHEN v_notsai.tp_item = 'Pecas'::text AND v_notsai.nr_orde = 0 THEN v_notsai.vr_liqu
            ELSE 0::numeric
        END AS pbal_valo,
        CASE
            WHEN v_notsai.tp_item = 'Pecas'::text AND v_notsai.nr_orde > 0 THEN v_notsai.vr_liqu
            ELSE 0::numeric
        END AS pofi_valo,
        CASE
            WHEN v_notsai.cd_prod::text = ANY (ARRAY['OUTSTPKT0513'::character varying::text, '8888808'::character varying::text, 'OXAR'::character varying::text, 'LIMPSISTIN'::character varying::text]) THEN v_notsai.vr_liqu
            ELSE 0::numeric
        END AS oace_valo,
        CASE
            WHEN v_notsai.cd_linh::text = sintab74.ntab_linhace_74_o1::text THEN v_notsai.vr_liqu
            ELSE 0::numeric
        END AS oagr_valo,
    0 AS onib_mete,
    0 AS onib_metd,
        CASE
            WHEN t.otip_revisao_1 = 1 THEN 'REVISÃO'::text
            WHEN t.otip_segurad_1 = 1 THEN 'SEGURADORA'::text
            WHEN t.otip_tiposer_1 = 1 THEN 'CLIENTE'::text
            WHEN t.otip_tiposer_1 = 2 THEN 'GARANTIA'::text
            WHEN t.otip_tiposer_1 = 3 THEN 'INTERNA'::text
            ELSE NULL::text
        END AS tipo_orde,
    sintab76.ntab_codativ_76 AS cd_ativ,
    sintab76.ntab_servter_76 AS sr_terc,
        CASE
            WHEN v_notsai.cd_depa = 56 THEN 'S'::text
            ELSE 'N'::text
        END AS tipo_inte,
    0 AS mg_oper,
    0 AS vr_nven,
    0 AS vr_ncus,
    0 AS mg_brut,
    0 AS taxi_meta
   FROM v_notsai
     LEFT JOIN sintab12 ON sintab12.ntab_emitent_12 = v_notsai.cd_empr
     LEFT JOIN sintab74 ON sintab74.ntab_codempr_74 = v_notsai.cd_empr
     LEFT JOIN sintab24 ON sintab24.ntab_tiponfs_24 = v_notsai.tp_nota
     LEFT JOIN ordsrv ON ordsrv.orde_emitent_1 = v_notsai.cd_empr AND ordsrv.orde_nrordem_1 = v_notsai.nr_orde
     LEFT JOIN sintab76 ON sintab76.ntab_codativ_76::text = ordsrv.orde_ativida_1_o1::text
     LEFT JOIN ordtip t ON t.otip_empresa_1 = v_notsai.cd_empr AND t.otip_tiporde_1 = v_notsai.tp_nota
  WHERE (v_notsai.tp_item = 'Pecas'::text OR v_notsai.tp_item = 'Servico'::text AND v_notsai.nr_orde > 0) AND (v_notsai.tp_movi = 1 OR v_notsai.cd_depa = 56 OR (t.otip_tiposer_1 = ANY (ARRAY[1, 2, 3])) AND v_notsai.nr_orde > 0)
UNION ALL
 SELECT
        CASE sintab12.ntab_caterev_12
            WHEN 1 THEN 'Leves'::text
            WHEN 2 THEN 'Pesados'::text
            WHEN 3 THEN 'Motos'::text
            WHEN 4 THEN 'Maquinas'::text
            ELSE NULL::text
        END AS tp_nego,
    sintab12.ntab_regirev_12 AS nr_regi,
        CASE sintab12.ntab_tiporev_12
            WHEN 1 THEN 'Fiat'::text
            WHEN 2 THEN 'Volkswagen'::text
            WHEN 3 THEN 'Ford'::text
            WHEN 6 THEN 'Kia'::text
            WHEN 17 THEN 'New-Holland'::text
            ELSE NULL::text
        END AS tp_reve,
    sintab12.ntab_emitent_12 AS cd_empr,
    sintab12.ntab_grpemit_12 AS cd_grpe,
    sintab12.ntab_empabrv_12 AS nm_abre,
    sintab12.ntab_emitent_12 AS cd_grup,
    ' '::character varying AS nm_vend,
    0 AS cd_vend,
    0 AS cd_clie,
    ' '::character varying AS nm_fami,
    0 AS cd_depa,
    ' '::text AS nm_depa,
    ' '::text AS cd_linh,
    to_date('01'::text || btrim(to_char(c.parc_meseano_1, '000000'::text)), 'DDMMYYYY'::text) AS dt_vend,
    ' '::text AS ds_cate,
    0 AS novo_qtde,
    0::numeric AS novo_meta,
    0 AS novo_vend,
    0 AS novo_aqui,
    0 AS novo_fund,
    0 AS novo_bonu,
    0 AS novo_pven,
    0 AS novo_cust,
    0 AS novo_pcus,
    0 AS frot_qtde,
    0 AS frot_tipo,
    0 AS frot_meta,
    0 AS usad_qtde,
    0 AS usad_meta,
    0 AS usad_vend,
    0 AS usad_aqui,
    0 AS usad_pven,
    0 AS usad_cust,
    0 AS usad_pcus,
    0 AS fina_valo,
    0 AS fina_tota,
    0 AS fina_meta,
    0 AS cons_qtde,
    0 AS cons_comi,
    0 AS cons_meta,
    0 AS conv_qtde,
    0 AS conv_meta,
    0 AS peca_valo,
    0 AS peca_ofic,
    c.parc_vendbal_1 + c.parc_vendofi_1 AS peca_meta,
    c.parc_vendbal_1 AS peca_metb,
    c.parc_vendofi_1 AS peca_meto,
    0 AS peca_cust,
    0 AS peca_cust_ofic,
    0 AS aces_valo,
    0 AS aces_meta,
    0 AS aces_cust,
    0 AS funi_valo,
    c.parc_funipec_1 + c.parc_funimao_1 AS funi_meta,
    c.parc_funipec_1 AS funi_metp,
    c.parc_funimao_1 AS funi_mets,
    0 AS funi_cust,
    0 AS funi_serv,
    0 AS funi_csts,
    0 AS serv_valo,
    0 AS aces_serv,
    c.parc_vendser_1 AS serv_meta,
    0 AS serv_cust,
    0 AS aces_csts,
    0 AS acev_valo,
    0 AS acev_meta,
    0 AS agre_valo,
    0 AS agre_meta,
    0 AS pbal_valo,
    0 AS pofi_valo,
    0 AS oace_valo,
    0 AS oagr_valo,
    0 AS onib_mete,
    0 AS onib_metd,
    ' '::text AS tipo_orde,
    ' '::text AS cd_ativ,
    0 AS sr_terc,
    ' '::text AS tipo_inte,
    0 AS mg_oper,
    0 AS vr_nven,
    0 AS vr_ncus,
    0 AS mg_brut,
    0 AS taxi_meta
   FROM sigparc c
     LEFT JOIN sintab12 ON sintab12.ntab_emitent_12 = c.parc_emitent_1;