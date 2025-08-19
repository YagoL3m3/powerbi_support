-- public.v_bi_painel_os_geral fonte

CREATE OR REPLACE VIEW public.v_bi_painel_os_geral
AS SELECT ordsrvi.ordi_tipdeos_1 AS cd_tipo,
    ordsrv.orde_tipdeos_1 AS cd_tipc,
    substr(btrim(to_char(ordsrvi.ordi_codorig_1, '0000'::text)), 1, 2)::integer AS cd_depa,
    sintab02.ntab_nomeori_2 AS nm_depa,
    t24.ntab_descric_24 AS ds_tipo,
    t24.ntab_subdpto_24::character varying AS cd_subdp,
    ordsrvi.ordi_emitent_1 AS cd_empr,
    sintab12.ntab_grpemit_12 AS cd_grpe,
    sintab12.ntab_empabrv_12 AS nm_empr,
    ordsrvi.ordi_nrordem_1 AS nr_orde,
        CASE ordsrv.orde_statord_1
            WHEN 1 THEN 'aberta'::text
            WHEN 2 THEN 'pendente'::text
            WHEN 3 THEN 'em execução'::text
            WHEN 4 THEN 'unidade parada'::text
            WHEN 5 THEN 'interrompida parcial'::text
            WHEN 6 THEN 'concluida'::text
            WHEN 7 THEN 'faturada parcial'::text
            WHEN 8 THEN 'faturada'::text
            WHEN 9 THEN 'cancelada'::text
            ELSE NULL::text
        END AS ds_situ,
    sintab76.ntab_descric_76 AS ds_ativ,
    ordsrv.orde_orcamen_1 AS nr_orca,
    ordsrv.orde_placvei_1 AS cd_veic,
    s.gcad_categor_1 AS ds_cate,
    s.gcad_codmode_1 AS cd_mode,
    sintab21.ntab_descmod_21 AS ds_mode,
    c.dven_nomeven_1 AS nm_cons,
    p.opro_nomepro_1 AS nm_prod,
    'Pecas'::text AS tp_prod,
    ordsrv.orde_nomcli1_1 AS nm_clie,
    ordsrv.orde_databer_1 AS dt_aber,
    NULLIF(ordsrvi.ordi_fechinv_1, '1899-12-30'::date) AS dt_fech,
    ordsrvi.ordi_numnota_1 AS nr_nota,
    ordsrvi.ordi_codprod_1 AS cd_prod,
    ordsrvi.ordi_descpro_1 AS ds_prod,
    ordsrvi.ordi_qtdpedi_1 AS qt_prod,
    ordsrvi.ordi_valtota_1 + ordsrvi.ordi_acrenot_1 + ordsrvi.ordi_valoipi_1 + ordsrvi.ordi_valacre_1 + ordsrvi.ordi_fretpro_1 + ordsrvi.ordi_segupro_1 + ordsrvi.ordi_desppro_1 - ordsrvi.ordi_valdesc_1 - ordsrvi.ordi_descnot_1 AS vr_tota,
    ordsrv.orde_usuaber_1 AS cd_usua,
    ordsrvi.ordi_usuario_1 AS cd_usur,
    0 AS qt_apli,
    0 AS qt_temp,
    0 AS produtiv,
    0 AS lucrativ,
    ordsrvi.ordi_custcon_1 * ordsrvi.ordi_qtdpedi_1 AS vr_cust,
    ordsrvi.ordi_valoicm_1 + (ordsrvi.ordi_valtota_1 + ordsrvi.ordi_acrenot_1 + ordsrvi.ordi_valoipi_1 + ordsrvi.ordi_valacre_1 + ordsrvi.ordi_fretpro_1 + ordsrvi.ordi_segupro_1 + ordsrvi.ordi_desppro_1 - ordsrvi.ordi_valdesc_1 - ordsrvi.ordi_descnot_1) * (ordsrvi.ordi_aliqpis_1 + ordsrvi.ordi_aliqcof_1) / 100::numeric AS vr_impo,
    ordsrvi.ordi_produti_1 AS cd_ptiv,
    ordsrvi.ordi_codativ_1 AS cd_ativ,
    s.gcad_anomode_1 AS nr_anom,
    sintab76.ntab_tipoatv_76 AS tp_ativ,
    ordsrv.orde_codclie_1 AS cd_clie,
    sintab76.ntab_volktot_76 AS fl_volk,
    sintab76.ntab_servter_76 AS fl_terc,
    sintab76.ntab_boxrapi_76 AS fl_boxr,
    s.gcad_nrochas_1 AS nr_chas,
    ordsrv.orde_dtpreve_1 AS dt_prev
   FROM ordsrvi
     LEFT JOIN ordsrv ON ordsrvi.ordi_emitent_1 = ordsrv.orde_emitent_1 AND ordsrvi.ordi_nrordem_1 = ordsrv.orde_nrordem_1
     LEFT JOIN sintab12 ON sintab12.ntab_emitent_12 = ordsrvi.ordi_emitent_1
     LEFT JOIN sintab24 t24 ON t24.ntab_tiponfs_24 = ordsrvi.ordi_tipdeos_1
     LEFT JOIN sintab76 ON sintab76.ntab_codativ_76::text = ordsrvi.ordi_codativ_1::text
     LEFT JOIN cadven c ON c.dven_codvend_1 = ordsrv.orde_recepci_1
     LEFT JOIN apopro p ON ordsrvi.ordi_produti_1 = p.opro_produti_1::numeric
     LEFT JOIN segcad s ON s.gcad_placvei_1::text = ordsrv.orde_placvei_1::text
     LEFT JOIN sintab21 ON sintab21.ntab_codmode_21::text = s.gcad_codmode_1::text
     LEFT JOIN sintab02 ON sintab02.ntab_codorig_2 = substr(btrim(to_char(ordsrvi.ordi_codorig_1, '0000'::text)), 1, 2)::integer
UNION ALL
 SELECT ordsrvs.ords_tipdeos_1 AS cd_tipo,
    ordsrv.orde_tipdeos_1 AS cd_tipc,
    substr(btrim(to_char(ordsrvs.ords_codorig_1, '0000'::text)), 1, 2)::integer AS cd_depa,
    sintab02.ntab_nomeori_2 AS nm_depa,
    t24.ntab_descric_24 AS ds_tipo,
    t24.ntab_subdpto_24::character varying AS cd_subdp,
    ordsrvs.ords_emitent_1 AS cd_empr,
    sintab12.ntab_grpemit_12 AS cd_grpe,
    sintab12.ntab_empabrv_12 AS nm_empr,
    ordsrvs.ords_nrordem_1 AS nr_orde,
        CASE ordsrv.orde_statord_1
            WHEN 1 THEN 'aberta'::text
            WHEN 2 THEN 'pendente'::text
            WHEN 3 THEN 'em execução'::text
            WHEN 4 THEN 'unidade parada'::text
            WHEN 5 THEN 'interrompida parcial'::text
            WHEN 6 THEN 'concluida'::text
            WHEN 7 THEN 'faturada parcial'::text
            WHEN 8 THEN 'faturada'::text
            WHEN 9 THEN 'cancelada'::text
            ELSE NULL::text
        END AS ds_situ,
    sintab76.ntab_descric_76 AS ds_ativ,
    ordsrv.orde_orcamen_1 AS nr_orca,
    ordsrv.orde_placvei_1 AS cd_veic,
    s.gcad_categor_1 AS ds_cate,
    s.gcad_codmode_1 AS cd_mode,
    sintab21.ntab_descmod_21 AS ds_mode,
    c.dven_nomeven_1 AS nm_cons,
    p.opro_nomepro_1 AS nm_prod,
    'Servicos'::text AS tp_prod,
    ordsrv.orde_nomcli1_1 AS nm_clie,
    ordsrv.orde_databer_1 AS dt_aber,
    NULLIF(ordsrvs.ords_fechinv_1, '1899-12-30'::date) AS dt_fech,
    ordsrvs.ords_numnota_1 AS nr_nota,
    ordsrvs.ords_codserv_1 AS cd_prod,
    ordsrvs.ords_descsv1_1 AS ds_prod,
    ordsrvs.ords_tempven_1 AS qt_prod,
    ordsrvs.ords_valtota_1 + ordsrvs.ords_acrenot_1 + ordsrvs.ords_valacre_1 + ordsrvs.ords_fretpro_1 + ordsrvs.ords_segupro_1 + ordsrvs.ords_desppro_1 - ordsrvs.ords_valdesc_1 - ordsrvs.ords_descnot_1 AS vr_tota,
    ordsrv.orde_usuaber_1 AS cd_usua,
    ordsrvs.ords_usuainc_1 AS cd_usur,
    ordsrvs.ords_temprea_1 AS qt_apli,
    sintab71.ntab_tempnor_71 AS qt_temp,
    100::numeric *
        CASE
            WHEN ordsrvs.ords_temprea_1 = 0::numeric THEN 0::numeric
            ELSE sintab71.ntab_tempnor_71 / ordsrvs.ords_temprea_1
        END AS produtiv,
    ordsrvs.ords_valtota_1 + ordsrvs.ords_acrenot_1 + ordsrvs.ords_valacre_1 + ordsrvs.ords_fretpro_1 + ordsrvs.ords_segupro_1 + ordsrvs.ords_desppro_1 - ordsrvs.ords_valdesc_1 - ordsrvs.ords_descnot_1 - n.tser_customo_1 AS lucrativ,
    n.tser_customo_1 AS vr_cust,
    (ordsrvs.ords_valtota_1 + ordsrvs.ords_acrenot_1 + ordsrvs.ords_valacre_1 + ordsrvs.ords_fretpro_1 + ordsrvs.ords_segupro_1 + ordsrvs.ords_desppro_1 - ordsrvs.ords_valdesc_1 - ordsrvs.ords_descnot_1) * sintab12.ntab_percpis_12 / 100::numeric + (ordsrvs.ords_valtota_1 + ordsrvs.ords_acrenot_1 + ordsrvs.ords_valacre_1 + ordsrvs.ords_fretpro_1 + ordsrvs.ords_segupro_1 + ordsrvs.ords_desppro_1 - ordsrvs.ords_valdesc_1 - ordsrvs.ords_descnot_1) * sintab12.ntab_pcofins_12 / 100::numeric AS vr_impo,
    ordsrvs.ords_produti_1 AS cd_ptiv,
    ordsrvs.ords_codativ_1 AS cd_ativ,
    s.gcad_anomode_1 AS nr_anom,
    sintab76.ntab_tipoatv_76 AS tp_ativ,
    ordsrv.orde_codclie_1 AS cd_clie,
    sintab76.ntab_volktot_76 AS fl_volk,
    sintab76.ntab_servter_76 AS fl_terc,
    sintab76.ntab_boxrapi_76 AS fl_boxr,
    s.gcad_nrochas_1 AS nr_chas,
    ordsrv.orde_dtpreve_1 AS dt_prev
   FROM ordsrvs
     LEFT JOIN ordsrv ON ordsrvs.ords_emitent_1 = ordsrv.orde_emitent_1 AND ordsrvs.ords_nrordem_1 = ordsrv.orde_nrordem_1
     LEFT JOIN sintab12 ON sintab12.ntab_emitent_12 = ordsrvs.ords_emitent_1
     LEFT JOIN sintab24 t24 ON t24.ntab_tiponfs_24 = ordsrvs.ords_tipdeos_1
     LEFT JOIN sintab76 ON sintab76.ntab_codativ_76::text = ordsrvs.ords_codativ_1::text
     LEFT JOIN cadven c ON c.dven_codvend_1 = ordsrv.orde_recepci_1
     LEFT JOIN apopro p ON ordsrvs.ords_produti_1 = p.opro_produti_1::numeric
     LEFT JOIN segcad s ON s.gcad_placvei_1::text = ordsrv.orde_placvei_1::text
     LEFT JOIN sintab21 ON sintab21.ntab_codmode_21::text = s.gcad_codmode_1::text
     LEFT JOIN sintab02 ON sintab02.ntab_codorig_2 = substr(btrim(to_char(ordsrvs.ords_codorig_1, '0000'::text)), 1, 2)::integer
     LEFT JOIN sintab71 ON sintab71.ntab_codbrev_71::text = s.gcad_codbrev_1::text AND sintab71.ntab_codserv_71::text = ordsrvs.ords_codserv_1::text
     LEFT JOIN ( SELECT notsais.tser_numorde_1,
            notsais.tser_emitent_1,
            sum(notsais.tser_customo_1) AS tser_customo_1
           FROM notsais
          GROUP BY notsais.tser_numorde_1, notsais.tser_emitent_1) n ON n.tser_numorde_1 = ordsrvs.ords_nrordem_1 AND n.tser_emitent_1 = ordsrvs.ords_emitent_1
UNION ALL
 SELECT ordsrv.orde_tipdeos_1 AS cd_tipo,
    ordsrv.orde_tipdeos_1 AS cd_tipc,
    t24.ntab_departa_24 AS cd_depa,
    t24.ntab_subdpto_24::character varying AS nm_depa,
    sintab02.ntab_nomeori_2 AS ds_tipo,
        CASE
            WHEN ordsrv.orde_tipdeos_1 = 0 THEN 'O.S. sem pecas / mo'::character varying
            ELSE t24.ntab_descric_24
        END AS cd_subdp,
    ordsrv.orde_emitent_1 AS cd_empr,
    sintab12.ntab_grpemit_12 AS cd_grpe,
    sintab12.ntab_empabrv_12 AS nm_empr,
    ordsrv.orde_nrordem_1 AS nr_orde,
        CASE ordsrv.orde_statord_1
            WHEN 1 THEN 'aberta'::text
            WHEN 2 THEN 'pendente'::text
            WHEN 3 THEN 'em execução'::text
            WHEN 4 THEN 'unidade parada'::text
            WHEN 5 THEN 'interrompida parcial'::text
            WHEN 6 THEN 'concluida'::text
            WHEN 7 THEN 'faturada parcial'::text
            WHEN 8 THEN 'faturada'::text
            WHEN 9 THEN 'cancelada'::text
            ELSE NULL::text
        END AS ds_situ,
    sintab76.ntab_descric_76 AS ds_ativ,
    ordsrv.orde_orcamen_1 AS nr_orca,
    ordsrv.orde_placvei_1 AS cd_veic,
    s.gcad_categor_1 AS ds_cate,
    s.gcad_codmode_1 AS cd_mode,
    sintab21.ntab_descmod_21 AS ds_mode,
    c.dven_nomeven_1 AS nm_cons,
    p.opro_nomepro_1 AS nm_prod,
    ' '::text AS tp_prod,
    ordsrv.orde_nomcli1_1 AS nm_clie,
    ordsrv.orde_databer_1 AS dt_aber,
    NULLIF(ordsrv.orde_fechinv_1, '1899-12-30'::date) AS dt_fech,
    0 AS nr_nota,
    ' '::character varying AS cd_prod,
    ' '::character varying AS ds_prod,
    0 AS qt_prod,
    0 AS vr_tota,
    ordsrv.orde_usuaber_1 AS cd_usua,
    ' '::character varying AS cd_usur,
    0 AS qt_apli,
    0 AS qt_temp,
    0 AS produtiv,
    0 AS lucrativ,
    0 AS vr_cust,
    0 AS vr_impo,
    0 AS cd_ptiv,
    ordsrv.orde_ativida_1_o1 AS cd_ativ,
    s.gcad_anomode_1 AS nr_anom,
    sintab76.ntab_tipoatv_76 AS tp_ativ,
    ordsrv.orde_codclie_1 AS cd_clie,
    sintab76.ntab_volktot_76 AS fl_volk,
    sintab76.ntab_servter_76 AS fl_terc,
    sintab76.ntab_boxrapi_76 AS fl_boxr,
    s.gcad_nrochas_1 AS nr_chas,
    ordsrv.orde_dtpreve_1 AS dt_prev
   FROM ordsrv
     LEFT JOIN sintab12 ON sintab12.ntab_emitent_12 = ordsrv.orde_emitent_1
     LEFT JOIN sintab24 t24 ON t24.ntab_tiponfs_24 = ordsrv.orde_tipdeos_1
     LEFT JOIN sintab76 ON sintab76.ntab_codativ_76::text = ordsrv.orde_ativida_1_o1::text
     LEFT JOIN cadven c ON c.dven_codvend_1 = ordsrv.orde_recepci_1
     LEFT JOIN apopro p ON p.opro_produti_1::numeric = 0::numeric
     LEFT JOIN segcad s ON s.gcad_placvei_1::text = ordsrv.orde_placvei_1::text
     LEFT JOIN sintab21 ON sintab21.ntab_codmode_21::text = s.gcad_codmode_1::text
     LEFT JOIN sintab02 ON sintab02.ntab_codorig_2 = t24.ntab_departa_24
     LEFT JOIN ordsrvi i ON i.ordi_emitent_1 = ordsrv.orde_emitent_1 AND i.ordi_nrordem_1 = ordsrv.orde_nrordem_1
     LEFT JOIN ordsrvs srv ON srv.ords_emitent_1 = ordsrv.orde_emitent_1 AND srv.ords_nrordem_1 = ordsrv.orde_nrordem_1
  WHERE i.ordi_emitent_1 IS NULL AND srv.ords_emitent_1 IS NULL AND ordsrv.orde_statord_1 <> 8;