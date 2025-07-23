-- public.v_bi_compras_corp source

CREATE OR REPLACE VIEW public.v_bi_compras_corp
AS SELECT ROW_NUMBER() OVER( PARTITION BY SI.SOLI_EMITENT_1,SI.SOLI_NROSOLI_1 ORDER BY SI.SOLI_EMITENT_1 , SI.SOLI_NROSOLI_1 ) AS linha,
                  COUNT(*) OVER( PARTITION BY SI.SOLI_EMITENT_1,SI.SOLI_NROSOLI_1 ) AS linhas,
              S.CSOL_EMITENT_1 AS cd_empr,
              S.CSOL_SOLICIT_1 AS cd_soli,
              US.NCAD_NOMECLI_2 AS nm_soli,
              S.CSOL_NROSOLI_1 AS nr_soli,
              ntab_nomeori_2 as nm_depart,
              CASE WHEN SI.SOLI_URGENTE_1 = 1 THEN 'Urgente' ELSE 'Normal' END AS ds_prio,
              'ITENS' AS ds_tipo,
              S.CSOL_STATSOL_1 AS cd_stsl,
              CASE S.CSOL_STATSOL_1 WHEN 1 THEN 'Aberta' 
                                    WHEN 2 THEN 'Em cotacao' 
                                    WHEN 3 THEN 'Cotacao aprovada' 
                                    WHEN 4 THEN 'Comprada' 
                                    WHEN 5 THEN 'Entregue' 
                                    WHEN 6 THEN 'Agrupada' 
                                    WHEN 9 THEN 'Cancelada' 
                                    WHEN 0 THEN 'Em digitação' 
                                           ELSE 'Outros' 
              END AS ds_stsl,
              S.CSOL_DATSOLI_1 AS dt_soli,
              CASE
	              WHEN S.csol_stataut_1 in (1,2) THEN 'Sol. Aprovada'
              	  WHEN S.csol_stataut_1 = 3 THEN 'Negado' ELSE 'Pend Aprov' END ds_apso,
              S.CSOL_CENTCUS_1 AS cd_ccus,
              PI.mpdi_qtdpedi_1 as qt_pedi,
              PI.MPDI_TOTITEM_1 AS vr_pedi,
              P.MPED_VALTOTA_1 AS vr_totalpedi,
              P.MPED_NROPEDI_1 AS nr_pedi,
              P.MPED_DATPEDI_1 AS dt_pedi,
              CASE WHEN cast(P.MPED_STATUSS_1 as varchar) IS NULL THEN 'Sem Pedido' 
                   ELSE (CASE P.MPED_STATUSS_1 WHEN 1 THEN 'Aberto' 
                                               WHEN 2 THEN 'Enviado' 
                                               WHEN 3 THEN 'Liquidado'  
                                               WHEN 5 THEN 'B.O.' 
                                               WHEN 7 THEN 'Suspenso' 
                                               WHEN 8 THEN 'Comprado'
                                               WHEN 9 THEN 'Cancelado' 
                                               WHEN 0 THEN 'SEM PEDIDO'
                                                      ELSE 'Outros' 
                         END) 
              END AS ds_stpd,
              S.CSOL_TIPOLAN_1 AS tp_lanc,
              T23.NTAB_DESCRIC_23 AS ds_lanc,
              COTA_NROCOTA_1 AS nr_cota,
              S.CSOL_DESTINO_1 AS ds_dest,
              D.DEST_DESCRIC_1 AS nm_dest,
              cast(SI.SOLI_CODPROD_1 as varchar) AS ds_prod,
              SI.SOLI_DESCPRO_1 AS ds_desc,
              P.MPED_FORNECE_1 AS ds_forn,
              F.NCAD_NOMECLI_2 AS nm_forn,
              CI.COTA_FORNECE_1_O1 as forn_01,
              F1.NCAD_NOMECLI_2 AS nm_forn1,
              CI.COTA_PRECTOT_1_O1 AS valor_01,
              CI.COTA_FORNECE_1_O2 AS forn_02,
              F2.NCAD_NOMECLI_2 AS nm_forn2,
              CI.COTA_PRECTOT_1_O2 AS valor_02,
              CI.COTA_FORNECE_1_O3 AS forn_03,
              F3.NCAD_NOMECLI_2 AS nm_forn3,
              CI.COTA_PRECTOT_1_O3 AS valor_03,
              S.CSOL_OBSERVA_1 AS ds_obse,
              SUM(CI.COTA_PRECTOT_1_O1) OVER ( PARTITION BY CI.COTA_EMITENT_1, CI.COTA_NROCOTA_1 ) AS valor_cota_01,
              SUM(CI.COTA_PRECTOT_1_O2) OVER ( PARTITION BY CI.COTA_EMITENT_1, CI.COTA_NROCOTA_1 ) AS valor_cota_02,
              SUM(CI.COTA_PRECTOT_1_O3) OVER ( PARTITION BY CI.COTA_EMITENT_1, CI.COTA_NROCOTA_1 ) AS valor_cota_03,
              AUT_S.ncad_nomecli_2 as autorizante_sol
       FROM ADCSOL S LEFT JOIN ADCSOLI     SI ON (  SI.SOLI_EMITENT_1 = S.CSOL_EMITENT_1 AND SI.SOLI_NROSOLI_1 = S.CSOL_NROSOLI_1 )
                        LEFT JOIN SINTAB23 T23 ON ( T23.NTAB_CODIGOS_23 = S.CSOL_TIPOLAN_1 )                      
                        LEFT JOIN ADCCOTS   RI ON (  RI.COTS_EMITENT_1 = SI.SOLI_EMITENT_1 AND RI.COTS_NROSOLI_1 = SI.SOLI_NROSOLI_1 AND RI.COTS_CODPROD_1 = SI.SOLI_CODPROD_1 )
                        LEFT JOIN ADCCOTA   CI ON (  CI.COTA_EMITENT_1 = RI.COTS_EMITENT_1 AND CI.COTA_NROCOTA_1 = RI.COTS_NROCOTA_1 AND CI.COTA_CODPROD_1 = RI.COTS_CODPROD_1 )
                        LEFT JOIN COMPEDAX  AX ON (  AX.PEDX_EMITENT_1 = CI.COTA_EMITENT_1 AND AX.PEDX_NROCOTA_1 = CI.COTA_NROCOTA_1 )
                        LEFT JOIN COMPED     P ON (   P.MPED_EMITENT_1 = AX.PEDX_EMITENT_1 AND P.MPED_NROPEDI_1 = AX.PEDX_NROPEDI_1 )
                        LEFT JOIN COMPEDI   PI ON (  PI.MPDI_EMITENT_1 = P.MPED_EMITENT_1 AND PI.MPDI_NROPEDI_1 = P.MPED_NROPEDI_1 AND PI.MPDI_CODPROD_1 = CI.COTA_CODPROD_1 )
                        LEFT JOIN SINCAD     F ON (   F.NCAD_CGCOCPF_2 = P.MPED_FORNECE_1)
                        LEFT JOIN SINCAD    F1 ON (  F1.NCAD_CGCOCPF_2 = CI.COTA_FORNECE_1_O1)
                        LEFT JOIN SINCAD    F2 ON (  F2.NCAD_CGCOCPF_2 = CI.COTA_FORNECE_1_O2)
                        LEFT JOIN SINCAD    F3 ON (  F3.NCAD_CGCOCPF_2 = CI.COTA_FORNECE_1_O3)
                        LEFT JOIN SINCAD    US ON (  US.NCAD_CGCOCPF_2 = S.CSOL_SOLICIT_1)
                        LEFT JOIN ADCDEST    D ON (   D.DEST_CODESTI_1 = S.CSOL_DESTINO_1)
                        LEFT JOIN SINTAB02 ON (s.csol_departa_1 = ntab_codorig_2)
                        LEFT JOIN SINCAD  AUT_S ON (  AUT_S.NCAD_CGCOCPF_2 = S.csol_autoriz_1)
       UNION ALL
       SELECT 
       ROW_NUMBER() OVER( PARTITION BY SS.SOLS_EMITENT_1, SS.SOLS_NROSOLI_1 ORDER BY SS.SOLS_EMITENT_1, SS.SOLS_NROSOLI_1 ) AS linha,
                  COUNT(*) OVER( PARTITION BY SS.SOLS_EMITENT_1, SS.SOLS_NROSOLI_1 ) AS linhas,
              S.CSOL_EMITENT_1 AS cd_empr,
              S.CSOL_SOLICIT_1 AS cd_soli,
              US.NCAD_NOMECLI_2 AS nm_soli,
              S.CSOL_NROSOLI_1 AS nr_soli,
              ntab_nomeori_2 as nm_depart,
              CASE WHEN SS.SOLS_URGENTE_1 = 1 THEN 'Urgente' ELSE 'Normal' END AS ds_prio,
              'SERVIÇOS' AS ds_tipo,
              S.CSOL_STATSOL_1 AS cd_stsl,
              CASE S.CSOL_STATSOL_1 WHEN 1 THEN 'Aberta' 
                                    WHEN 2 THEN 'Em cotacao' 
                                    WHEN 3 THEN 'Cotacao aprovada' 
                                    WHEN 4 THEN 'Comprada' 
                                    WHEN 5 THEN 'Entregue' 
                                    WHEN 0 THEN 'Em digitação' 
                                    WHEN 6 THEN 'Agrupada' 
                                    WHEN 9 THEN 'Cancelada' 
                                           ELSE 'Outros' 
              END AS ds_stsl,
              S.CSOL_DATSOLI_1 AS dt_soli,
              CASE WHEN S.CSOL_AUTORIZ_1 <> 0 THEN 'Sol. Aprovada' ELSE 'Pend Aprov' END ds_apso,
              S.CSOL_CENTCUS_1 AS cd_ccus,
              PS.mpds_qtdpedi_1 as qt_pedi,
              PS.MPDS_TOTSERV_1 AS vr_pedi,              
              P.MPED_VALTOTA_1 AS vr_totalpedi,
              P.MPED_NROPEDI_1 AS nr_pedi,
              P.MPED_DATPEDI_1 AS dt_pedi,
              CASE WHEN cast(P.MPED_STATUSS_1 as varchar) IS NULL THEN 'Sem Pedido' 
                   ELSE (CASE P.MPED_STATUSS_1 WHEN 1 THEN 'Aberto' 
                                               WHEN 2 THEN 'Enviado' 
                                               WHEN 3 THEN 'Liquidado' 
                                               WHEN 5 THEN 'B.O.' 
                                               WHEN 7 THEN 'Suspenso' 
                                               WHEN 8 THEN 'Comprado' 
                                               WHEN 9 THEN 'Cancelado' 
                                               WHEN 0 THEN 'SEM PEDIDO'
                                                      ELSE 'Outros' 
                         END) 
              END AS ds_stpd,
              S.CSOL_TIPOLAN_1 AS tp_lanc,
              T23.NTAB_DESCRIC_23 AS ds_lanc,
              COTE_NROCOTA_1 AS nr_cota,
              S.CSOL_DESTINO_1 AS ds_dest,
              D.DEST_DESCRIC_1 AS nm_dest,
              cast(SS.SOLS_CODSERV_1 as varchar) AS ds_prod,
              SS.SOLS_DESCSER_1 AS ds_desc,
              P.MPED_FORNECE_1 AS ds_forn,
              F.NCAD_NOMECLI_2 AS nm_forn,
              CS.COTE_FORNECE_1_O1 AS forn_01,
              F1.NCAD_NOMECLI_2 AS nm_forn1,
              CS.COTE_PRECTOT_1_O1 AS valor_01,
              CS.COTE_FORNECE_1_O2 AS forn_02,
              F2.NCAD_NOMECLI_2 AS nm_forn2,
              CS.COTE_PRECTOT_1_O2 AS valor_02,
              CS.COTE_FORNECE_1_O3 AS forn_03,
              F3.NCAD_NOMECLI_2 AS nm_forn3,
              CS.COTE_PRECTOT_1_O3 AS valor_03,
              S.CSOL_OBSERVA_1 AS ds_obse,
              SUM(CS.COTE_PRECTOT_1_O1) OVER ( PARTITION BY CS.COTE_EMITENT_1, CS.COTE_NROCOTA_1 ) AS valor_cota_01,
              SUM(CS.COTE_PRECTOT_1_O2) OVER ( PARTITION BY CS.COTE_EMITENT_1, CS.COTE_NROCOTA_1 ) AS valor_cota_02,
              SUM(CS.COTE_PRECTOT_1_O3) OVER ( PARTITION BY CS.COTE_EMITENT_1, CS.COTE_NROCOTA_1 ) AS valor_cota_03,
			  AUT_S.ncad_nomecli_2 as autorizante_sol
       FROM ADCSOL S LEFT JOIN ADCSOLS     SS ON (  SS.SOLS_EMITENT_1 = S.CSOL_EMITENT_1 AND SS.SOLS_NROSOLI_1 = S.CSOL_NROSOLI_1 )
                        LEFT JOIN SINTAB23 T23 ON ( T23.NTAB_CODIGOS_23 = S.CSOL_TIPOLAN_1 )
                        LEFT JOIN ADCCOTR   RS ON (  RS.COTR_EMITENT_1 = SS.SOLS_EMITENT_1 AND RS.COTR_NROSOLI_1 = SS.SOLS_NROSOLI_1 AND RS.COTR_CODSERV_1 = SS.SOLS_CODSERV_1 )
                        LEFT JOIN ADCCOTE   CS ON (  CS.COTE_EMITENT_1 = RS.COTR_EMITENT_1 AND CS.COTE_NROCOTA_1 = RS.COTR_NROCOTA_1 AND CS.COTE_CODSERV_1 = RS.COTR_CODSERV_1 )
                        LEFT JOIN COMPEDAX  AX ON (  AX.PEDX_EMITENT_1 = CS.COTE_EMITENT_1 AND AX.PEDX_NROCOTA_1 = CS.COTE_NROCOTA_1 )
                        LEFT JOIN COMPED     P ON (   P.MPED_EMITENT_1 = AX.PEDX_EMITENT_1 AND P.MPED_NROPEDI_1 = AX.PEDX_NROPEDI_1 )
                        LEFT JOIN COMPEDS   PS ON (  PS.MPDS_EMITENT_1 = P.MPED_EMITENT_1 AND PS.MPDS_NROPEDI_1 = P.MPED_NROPEDI_1 AND PS.MPDS_CODSERV_1 = CS.COTE_CODSERV_1 )
                        LEFT JOIN SINCAD     F ON (   F.NCAD_CGCOCPF_2 = P.MPED_FORNECE_1)
                        LEFT JOIN SINCAD    F1 ON (  F1.NCAD_CGCOCPF_2 = CS.COTE_FORNECE_1_O1)
                        LEFT JOIN SINCAD    F2 ON (  F2.NCAD_CGCOCPF_2 = CS.COTE_FORNECE_1_O2)
                        LEFT JOIN SINCAD    F3 ON (  F3.NCAD_CGCOCPF_2 = CS.COTE_FORNECE_1_O3)
                        LEFT JOIN SINCAD    US ON (  US.NCAD_CGCOCPF_2 = S.CSOL_SOLICIT_1)
                        LEFT JOIN ADCDEST    D ON (   D.DEST_CODESTI_1 = S.CSOL_DESTINO_1)
                        LEFT JOIN SINTAB02 ON (s.csol_departa_1 = ntab_codorig_2)
                        LEFT JOIN SINCAD  AUT_S ON (  AUT_S.NCAD_CGCOCPF_2 = S.csol_autoriz_1)
