-- public.v_veiculo_pesados fonte

CREATE OR REPLACE VIEW public.v_veiculo_pesados
AS SELECT sintab12.ntab_empabrv_12 AS ds_fili,
    sintab12.ntab_grpemit_12 AS cd_grpe,
    sinc13.sinc_descric_13 AS ds_grpe,
    sgvacm.vacm_emitnot_1 AS cd_empr,
        CASE
            WHEN sgvvei.vvei_tipovei_1::text = 'N'::text THEN
            CASE sgvgmv.vgmv_tratore_1
                WHEN '0'::text THEN 'Veículo'::text
                WHEN '1'::text THEN 'Trator'::text
                WHEN '2'::text THEN 'Caminhão'::text
                WHEN '3'::text THEN 'Moto'::text
                WHEN '4'::text THEN 'Implemento'::text
                WHEN '5'::text THEN 'Colheitadeira'::text
                WHEN '6'::text THEN 'Empilhadeira'::text
                WHEN '7'::text THEN 'Onibus'::text
                ELSE NULL::text
            END
            WHEN sgvvei.vvei_tipovei_1::text = 'U'::text THEN
            CASE sgvvei.vvei_categor_1
                WHEN 'CL'::text THEN 'Comercial leve'::text
                WHEN 'CM'::text THEN 'Caminhão'::text
                WHEN 'CO'::text THEN 'Colheitadeira'::text
                WHEN 'CP'::text THEN 'Comercial pesado'::text
                WHEN 'IM'::text THEN 'Implemento'::text
                WHEN 'ON'::text THEN 'Onibus'::text
                WHEN 'PS'::text THEN 'Passageiro'::text
                WHEN 'TR'::text THEN 'Trator'::text
                WHEN 'UT'::text THEN 'Utilitário'::text
                WHEN 'EM'::text THEN 'Empilhadeira'::text
                WHEN 'SR'::text THEN 'Semi-Reboque'::text
                WHEN 'MO'::text THEN 'Motocicleta'::text
                WHEN 'MP'::text THEN 'Motores de popa'::text
                WHEN 'AE'::text THEN 'Aeronave'::text
                ELSE NULL::text
            END
            ELSE NULL::text
        END AS ds_cate,
        CASE sgvvei.vvei_escolar_1
            WHEN 1 THEN 'Escolar'::text
            ELSE ' '::text
        END AS tp_cate,
    sgvvei.vvei_montado_1 AS nm_mont,
        CASE sgvacm.vacm_comunic_1
            WHEN '0'::text THEN '0-Vontade própria'::text
            WHEN '1'::text THEN '1-Bus door'::text
            WHEN '2'::text THEN '2-Out door'::text
            WHEN '3'::text THEN '3-Mala direta'::text
            WHEN '4'::text THEN '4-Internet'::text
            WHEN '5'::text THEN '5-Jornais'::text
            WHEN '6'::text THEN '6-Revistas'::text
            WHEN '7'::text THEN '7-Radio'::text
            WHEN '8'::text THEN '8-Televisão'::text
            WHEN '9'::text THEN '9-Show room'::text
            WHEN 'A'::text THEN 'A-Site Montadora'::text
            WHEN 'B'::text THEN 'B-Indicação'::text
            WHEN 'C'::text THEN 'C-Visita do Vendedor'::text
            WHEN 'D'::text THEN 'D-Telefone'::text
            ELSE NULL::text
        END AS ds_comu,
    sgvacm.vacm_tipovei_1 AS tp_veic,
    sgvvei.vvei_vendire_1 AS tp_vend,
    sgvacm.vacm_vendinv_1 AS dt_vend,
    sgvacm.vacm_propost_1 AS nr_prop,
    sgvacm.vacm_sequenc_1 AS nr_sequ,
    sgvacm.vacm_numnota_1 AS nr_nfvd,
    notsai.tsai_departa_1 AS cd_dpto,
    sgvacm.vacm_codivei_1 AS cd_veic,
    sgvvei.vvei_chassis_1 AS cd_chas,
        CASE sgvacm.vacm_tipovei_1
            WHEN 'U'::text THEN sgvvei.vvei_descmod_1
            ELSE sgvmod.vmod_descmod_1
        END AS ds_mode,
    sgvvei.vvei_codimod_1 AS cd_mode,
    sgvmod.vmod_grupmod_1 AS cd_brev,
    sgvacm.vacm_nomecli_1 AS nm_clie,
        CASE sgvacm.vacm_arrenda_1
            WHEN 0 THEN sgvacm.vacm_cliente_1
            ELSE sgvacm.vacm_arrenda_1
        END AS cd_clie,
    v.ncad_nomecli_2 AS nm_vend,
    v.ncad_nomecli_2 AS nm_venf,
    sgvacm.vacm_vendedo_1 AS cd_vend,
    sgvacm.vacm_valnota_1 AS vr_vend,
    sgvacm.vacm_cmsiven_1 AS vr_cmsi,
    sgvvei.vvei_valaqui_1 AS vr_aqui,
        CASE sgvvei.vvei_vendire_1
            WHEN 0 THEN sgvvei.vvei_valaqui_1 * 0.12 - sgvvei.vvei_valaqui_1 * 0.12 * 0.047618
            ELSE 0::numeric
        END AS vr_icmc,
        CASE
            WHEN sgvacm.vacm_tipovei_1::text = 'U'::text AND sgvacm.vacm_emitnot_1 = 401 THEN sgvacm.vacm_valnota_1 * 0.02
            ELSE 0::numeric
        END AS vr_pgar,
    0 AS vr_cust,
    0 AS vr_cstc,
    sgvacm.vacm_bonufab_1 AS vr_bonf,
    sgvacm.vacm_valoutv_1 AS vr_orec,
        CASE sgvvei.vvei_vendire_1
            WHEN 0 THEN sgvacm.vacm_valfret_1
            ELSE 0::numeric
        END AS vr_fret,
        CASE sgvacm.vacm_tipovei_1
            WHEN 'N'::text THEN 0
            ELSE 0
        END AS vr_repa,
    sgvacm.vacm_valrevi_1 AS vr_revi,
    sgvvei.vvei_qcratea_1 AS vr_varq,
    sgvacm.vacm_difimpo_1 AS vr_outd,
        CASE
            WHEN sgvvei.vvei_vendire_1 > 0 THEN 0::numeric
            ELSE sgvacm.vacm_valsuge_1 * 0.12
        END AS vr_dicm,
        CASE sgvacm.vacm_tipovei_1
            WHEN 'U'::text THEN 0::numeric
            ELSE sgvvei.vvei_valaqui_1 *
            CASE sgvvei.vvei_vendire_1
                WHEN 0 THEN 0.001
                ELSE 0.001
            END
        END AS vr_acav,
    sgvacm.vacm_bonufab_1 * 0.0925 AS vr_pisb,
        CASE sgvacm.vacm_tipovei_1
            WHEN 'U'::text THEN sgvacm.vacm_pisconf_1
            ELSE 0::numeric
        END AS vr_pisu,
        CASE sgvvei.vvei_vendire_1
            WHEN 0 THEN 0::numeric
            ELSE (sgvacm.vacm_cmsiven_1 + sgvacm.vacm_valoutv_1) * 0.015
        END AS vr_irrf,
        CASE sgvvei.vvei_vendire_1
            WHEN 0 THEN 0::numeric
            ELSE (sgvacm.vacm_cmsiven_1 + sgvacm.vacm_valoutv_1) * sintab12.ntab_perciss_12 / 100::numeric
        END AS vr_iss,
        CASE sgvvei.vvei_vendire_1
            WHEN 0 THEN 0::numeric
            ELSE (sgvacm.vacm_cmsiven_1 + sgvacm.vacm_valoutv_1) * 0.0925
        END AS vr_pisc,
    sgvvei.vvei_vendire_1 AS cd_tpven,
    0 AS vr_comi,
    0 AS vr_coms,
    0 AS vr_coma,
    0 AS vr_comass,
    0 AS vr_admi,
    round(sgvacm.vacm_valnota_1 * 0.01, 2) AS vr_desa,
    sgvacm.vacm_situaca_1 AS ds_situ,
    sgvacm.vacm_motcanc_1 AS ds_motc,
    sgvacm.vacm_datacan_1 AS dt_canc,
    COALESCE(sgvton.vton_descric_1, 'Tonelagem não cadastrada'::character varying) AS ds_tone,
    sgvvei.vvei_dnaquis_1 AS cd_dnaq,
    sgvacm.vacm_codgrup_1 AS cd_grup,
    sgvgmv.vgmv_codlinh_1 AS cd_linh,
    sgvgmv.vgmv_sublinh_1 AS cd_subl,
    l.ntab_desclin_6 AS ds_linh,
    s.ntab_desclin_6 AS ds_subl,
    sgvvei.vvei_anofabr_1 AS nr_anof,
    sgvvei.vvei_anomode_1 AS nr_anom,
    round(sgvacm.vacm_valnota_1 + sgvacm.vacm_bonufab_1 + sgvacm.vacm_valoutv_1 +
        CASE sgvvei.vvei_vendire_1
            WHEN 2 THEN 0::numeric
            ELSE sgvacm.vacm_valbnde_1 * 1.5 / 100::numeric
        END +
        CASE sgvvei.vvei_vendire_1
            WHEN 0 THEN sgvvei.vvei_valaqui_1 * 0.07 - sgvvei.vvei_valaqui_1 * 0.07 * 0.047618
            ELSE 0::numeric
        END + sgvacm.vacm_cmsiven_1 - sgvvei.vvei_valaqui_1 -
        CASE
            WHEN sgvvei.vvei_vendire_1 > 0 THEN 0::numeric
            ELSE sgvacm.vacm_valsuge_1 * 0.12
        END -
        CASE sgvvei.vvei_vendire_1
            WHEN 0 THEN sgvacm.vacm_bonufab_1 + sgvacm.vacm_valbnde_1 * 1.5 / 100::numeric
            ELSE 0::numeric
        END * 0.0925 -
        CASE sgvacm.vacm_tipovei_1
            WHEN 'U'::text THEN 0::numeric
            ELSE sgvvei.vvei_valaqui_1 *
            CASE sgvvei.vvei_vendire_1
                WHEN 0 THEN 0.001
                ELSE 0.001
            END
        END - sgvacm.vacm_difimpo_1 - (sgvacm.vacm_encfina_1 + sgvacm.vacm_encfloo_1) -
        CASE sgvvei.vvei_vendire_1
            WHEN 2 THEN 0::numeric
            ELSE sgvacm.vacm_valbnde_1 * 2.2 / 100::numeric
        END -
        CASE sgvvei.vvei_vendire_1
            WHEN 0 THEN 0::numeric
            ELSE (sgvacm.vacm_cmsiven_1 + sgvacm.vacm_valoutv_1) * sintab12.ntab_perciss_12 / 100::numeric
        END -
        CASE sgvvei.vvei_vendire_1
            WHEN 0 THEN 0::numeric
            ELSE (sgvacm.vacm_cmsiven_1 + sgvacm.vacm_valoutv_1) * 0.015
        END -
        CASE sgvvei.vvei_vendire_1
            WHEN 0 THEN 0::numeric
            ELSE (sgvacm.vacm_cmsiven_1 + sgvacm.vacm_valoutv_1) * 0.0925
        END, 2) AS vr_lucr,
        CASE sgvacm.vacm_atacado_1
            WHEN 0 THEN 'Varejo'::text
            WHEN 1 THEN 'Atacado'::text
            WHEN 2 THEN 'Licitação'::text
            ELSE NULL::text
        END AS tp_clie,
    sgvvei.vvei_numeave_1 AS nr_if,
    sgvacm.vacm_datasim_1 AS dt_simu,
    sgvacm.vacm_percluc_1 AS pc_lucr,
        CASE
            WHEN sgvcfg.vcfg_exiglib_1 = 1 AND sgvacm.vacm_usuamin_1::text <> ' '::text THEN 'Aprovado'::text
            WHEN sgvcfg.vcfg_exiglib_1 = 1 AND sgvacm.vacm_usuamin_1::text = ' '::text THEN 'Sem Aprovação'::text
            WHEN sgvcfg.vcfg_exiglib_1 IS NULL AND sgvacm.vacm_usuamin_1::text <> ' '::text THEN 'Aprovado'::text
            WHEN sgvcfg.vcfg_exiglib_1 IS NULL AND sgvacm.vacm_usuamin_1::text = ' '::text THEN 'Sem Aprovação'::text
            ELSE 'Não Necessita de Aprovação'::text
        END AS ds_aprov,
        CASE
            WHEN sgvacm.vacm_usuamin_1::text <> ' '::text THEN sgvacm.vacm_datfatu_1
            ELSE NULL::date
        END AS dt_fatu,
    sgvloc.vloc_emitent_1
   FROM sgvacm
     LEFT JOIN sgvvei ON sgvvei.vvei_codivei_1::text = sgvacm.vacm_codivei_1::text
     LEFT JOIN sgvmod ON sgvmod.vmod_codimod_1::text = sgvvei.vvei_codimod_1::text AND sgvmod.vmod_anomode_1 = sgvvei.vvei_anomode_1
     LEFT JOIN sgvgmv ON sgvgmv.vgmv_grupmod_1::text = sgvmod.vmod_grupmod_1::text AND sgvgmv.vgmv_serimod_1::text = sgvmod.vmod_serimod_1::text
     LEFT JOIN sgvton ON sgvton.vton_coditon_1 = sgvgmv.vgmv_coditon_1
     LEFT JOIN sgvloc ON sgvloc.vloc_codiloc_1::text = sgvvei.vvei_locorig_1::text
     LEFT JOIN cadven ON cadven.dven_codvend_1 = sgvacm.vacm_vendedo_1
     LEFT JOIN sincad v ON v.ncad_cgcocpf_2 = sgvacm.vacm_vendedo_1
     LEFT JOIN sintab75 ON sgvacm.vacm_codgrup_1 = sintab75.ntab_codgrup_75
     LEFT JOIN sintab12 ON sintab12.ntab_emitent_12 = sgvacm.vacm_emitnot_1
     LEFT JOIN sinc13 ON sinc13.sinc_grpemit_13 = sintab12.ntab_grpemit_12
     LEFT JOIN sintab06 l ON l.ntab_codlinh_6::text = sgvgmv.vgmv_codlinh_1::text AND l.ntab_sublinh_6::text = ' '::text
     LEFT JOIN sintab06 s ON s.ntab_codlinh_6::text = sgvgmv.vgmv_codlinh_1::text AND s.ntab_sublinh_6::text = sgvgmv.vgmv_sublinh_1::text
     LEFT JOIN notsai ON notsai.tsai_emitent_1 = sgvacm.vacm_emitnot_1 AND notsai.tsai_nronota_1 = sgvacm.vacm_numnota_1 AND notsai.tsai_sernota_1::text = sgvacm.vacm_sernota_1::text
     LEFT JOIN sgvcfg ON sgvcfg.vcfg_empresa_1 = sintab12.ntab_emitent_12
  WHERE sgvvei.vvei_tipovei_1::text = 'N'::text OR sgvvei.vvei_tipovei_1::text = 'U'::text AND sgvvei.vvei_sublinh_1::text <> 'AT'::text;