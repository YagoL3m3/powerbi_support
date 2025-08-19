-- public.v_saldo_estoque fonte

CREATE OR REPLACE VIEW public.v_saldo_estoque
AS WITH meses_pivot AS (
         SELECT estsal.tsal_empresa_1 AS cd_empr,
            estsal.tsal_codprod_1 AS cd_prod,
            estsal.tsal_anorefe_1 AS nr_anos,
                CASE
                    WHEN estsal.tsal_qtdfinl_1_o1 > 0::numeric THEN json_build_object('nr_mess', 1, 'qtde', estsal.tsal_qtdfinl_1_o1, 'vr_cust', estsal.tsal_cstfinl_1_o1, 'dt_ultc', estsal.tsal_dtulcom_1_o1, 'vr_vend', estsal.tsal_valvend_1_o1, 'dt_ultv', estsal.tsal_dtulven_1_o1, 'cod_linh', estsal.tsal_codlinh_1_o1, 'cod_sublin', estsal.tsal_sublinh_1_o1, 'curva_demanda', estsal.tsal_curvabc_1_o1, 'curva_venda', estsal.tsal_curvend_1_o1, 'curva_frequ', estsal.tsal_curvfr1_1_o1, 'preco_vend', estsal.tsal_precven_1_o1)
                    ELSE NULL::json
                END AS mes_01,
                CASE
                    WHEN estsal.tsal_qtdfinl_1_o2 > 0::numeric THEN json_build_object('nr_mess', 2, 'qtde', estsal.tsal_qtdfinl_1_o2, 'vr_cust', estsal.tsal_cstfinl_1_o2, 'dt_ultc', estsal.tsal_dtulcom_1_o2, 'vr_vend', estsal.tsal_valvend_1_o2, 'dt_ultv', estsal.tsal_dtulven_1_o2, 'cod_linh', estsal.tsal_codlinh_1_o2, 'cod_sublin', estsal.tsal_sublinh_1_o2, 'curva_demanda', estsal.tsal_curvabc_1_o2, 'curva_venda', estsal.tsal_curvend_1_o2, 'curva_frequ', estsal.tsal_curvfr1_1_o2, 'preco_vend', estsal.tsal_precven_1_o2)
                    ELSE NULL::json
                END AS mes_02,
                CASE
                    WHEN estsal.tsal_qtdfinl_1_o3 > 0::numeric THEN json_build_object('nr_mess', 3, 'qtde', estsal.tsal_qtdfinl_1_o3, 'vr_cust', estsal.tsal_cstfinl_1_o3, 'dt_ultc', estsal.tsal_dtulcom_1_o3, 'vr_vend', estsal.tsal_valvend_1_o3, 'dt_ultv', estsal.tsal_dtulven_1_o3, 'cod_linh', estsal.tsal_codlinh_1_o3, 'cod_sublin', estsal.tsal_sublinh_1_o3, 'curva_demanda', estsal.tsal_curvabc_1_o3, 'curva_venda', estsal.tsal_curvend_1_o3, 'curva_frequ', estsal.tsal_curvfr1_1_o3, 'preco_vend', estsal.tsal_precven_1_o3)
                    ELSE NULL::json
                END AS mes_03,
                CASE
                    WHEN estsal.tsal_qtdfinl_1_o4 > 0::numeric THEN json_build_object('nr_mess', 4, 'qtde', estsal.tsal_qtdfinl_1_o4, 'vr_cust', estsal.tsal_cstfinl_1_o4, 'dt_ultc', estsal.tsal_dtulcom_1_o4, 'vr_vend', estsal.tsal_valvend_1_o4, 'dt_ultv', estsal.tsal_dtulven_1_o4, 'cod_linh', estsal.tsal_codlinh_1_o4, 'cod_sublin', estsal.tsal_sublinh_1_o4, 'curva_demanda', estsal.tsal_curvabc_1_o4, 'curva_venda', estsal.tsal_curvend_1_o4, 'curva_frequ', estsal.tsal_curvfr1_1_o4, 'preco_vend', estsal.tsal_precven_1_o4)
                    ELSE NULL::json
                END AS mes_04,
                CASE
                    WHEN estsal.tsal_qtdfinl_1_o5 > 0::numeric THEN json_build_object('nr_mess', 5, 'qtde', estsal.tsal_qtdfinl_1_o5, 'vr_cust', estsal.tsal_cstfinl_1_o5, 'dt_ultc', estsal.tsal_dtulcom_1_o5, 'vr_vend', estsal.tsal_valvend_1_o5, 'dt_ultv', estsal.tsal_dtulven_1_o5, 'cod_linh', estsal.tsal_codlinh_1_o5, 'cod_sublin', estsal.tsal_sublinh_1_o5, 'curva_demanda', estsal.tsal_curvabc_1_o5, 'curva_venda', estsal.tsal_curvend_1_o5, 'curva_frequ', estsal.tsal_curvfr1_1_o5, 'preco_vend', estsal.tsal_precven_1_o5)
                    ELSE NULL::json
                END AS mes_05,
                CASE
                    WHEN estsal.tsal_qtdfinl_1_o6 > 0::numeric THEN json_build_object('nr_mess', 6, 'qtde', estsal.tsal_qtdfinl_1_o6, 'vr_cust', estsal.tsal_cstfinl_1_o6, 'dt_ultc', estsal.tsal_dtulcom_1_o6, 'vr_vend', estsal.tsal_valvend_1_o6, 'dt_ultv', estsal.tsal_dtulven_1_o6, 'cod_linh', estsal.tsal_codlinh_1_o6, 'cod_sublin', estsal.tsal_sublinh_1_o6, 'curva_demanda', estsal.tsal_curvabc_1_o6, 'curva_venda', estsal.tsal_curvend_1_o6, 'curva_frequ', estsal.tsal_curvfr1_1_o6, 'preco_vend', estsal.tsal_precven_1_o6)
                    ELSE NULL::json
                END AS mes_06,
                CASE
                    WHEN estsal.tsal_qtdfinl_1_o7 > 0::numeric THEN json_build_object('nr_mess', 7, 'qtde', estsal.tsal_qtdfinl_1_o7, 'vr_cust', estsal.tsal_cstfinl_1_o7, 'dt_ultc', estsal.tsal_dtulcom_1_o7, 'vr_vend', estsal.tsal_valvend_1_o7, 'dt_ultv', estsal.tsal_dtulven_1_o7, 'cod_linh', estsal.tsal_codlinh_1_o7, 'cod_sublin', estsal.tsal_sublinh_1_o7, 'curva_demanda', estsal.tsal_curvabc_1_o7, 'curva_venda', estsal.tsal_curvend_1_o7, 'curva_frequ', estsal.tsal_curvfr1_1_o7, 'preco_vend', estsal.tsal_precven_1_o7)
                    ELSE NULL::json
                END AS mes_07,
                CASE
                    WHEN estsal.tsal_qtdfinl_1_o8 > 0::numeric THEN json_build_object('nr_mess', 8, 'qtde', estsal.tsal_qtdfinl_1_o8, 'vr_cust', estsal.tsal_cstfinl_1_o8, 'dt_ultc', estsal.tsal_dtulcom_1_o8, 'vr_vend', estsal.tsal_valvend_1_o8, 'dt_ultv', estsal.tsal_dtulven_1_o8, 'cod_linh', estsal.tsal_codlinh_1_o8, 'cod_sublin', estsal.tsal_sublinh_1_o8, 'curva_demanda', estsal.tsal_curvabc_1_o8, 'curva_venda', estsal.tsal_curvend_1_o8, 'curva_frequ', estsal.tsal_curvfr1_1_o8, 'preco_vend', estsal.tsal_precven_1_o8)
                    ELSE NULL::json
                END AS mes_08,
                CASE
                    WHEN estsal.tsal_qtdfinl_1_o9 > 0::numeric THEN json_build_object('nr_mess', 9, 'qtde', estsal.tsal_qtdfinl_1_o9, 'vr_cust', estsal.tsal_cstfinl_1_o9, 'dt_ultc', estsal.tsal_dtulcom_1_o9, 'vr_vend', estsal.tsal_valvend_1_o9, 'dt_ultv', estsal.tsal_dtulven_1_o9, 'cod_linh', estsal.tsal_codlinh_1_o9, 'cod_sublin', estsal.tsal_sublinh_1_o9, 'curva_demanda', estsal.tsal_curvabc_1_o9, 'curva_venda', estsal.tsal_curvend_1_o9, 'curva_frequ', estsal.tsal_curvfr1_1_o9, 'preco_vend', estsal.tsal_precven_1_o9)
                    ELSE NULL::json
                END AS mes_09,
                CASE
                    WHEN estsal.tsal_qtdfinl_1_o10 > 0::numeric THEN json_build_object('nr_mess', 10, 'qtde', estsal.tsal_qtdfinl_1_o10, 'vr_cust', estsal.tsal_cstfinl_1_o10, 'dt_ultc', estsal.tsal_dtulcom_1_o10, 'vr_vend', estsal.tsal_valvend_1_o10, 'dt_ultv', estsal.tsal_dtulven_1_o10, 'cod_linh', estsal.tsal_codlinh_1_o10, 'cod_sublin', estsal.tsal_sublinh_1_o10, 'curva_demanda', estsal.tsal_curvabc_1_o10, 'curva_venda', estsal.tsal_curvend_1_o10, 'curva_frequ', estsal.tsal_curvfr1_1_o10, 'preco_vend', estsal.tsal_precven_1_o10)
                    ELSE NULL::json
                END AS mes_10,
                CASE
                    WHEN estsal.tsal_qtdfinl_1_o11 > 0::numeric THEN json_build_object('nr_mess', 11, 'qtde', estsal.tsal_qtdfinl_1_o11, 'vr_cust', estsal.tsal_cstfinl_1_o11, 'dt_ultc', estsal.tsal_dtulcom_1_o11, 'vr_vend', estsal.tsal_valvend_1_o11, 'dt_ultv', estsal.tsal_dtulven_1_o11, 'cod_linh', estsal.tsal_codlinh_1_o11, 'cod_sublin', estsal.tsal_sublinh_1_o11, 'curva_demanda', estsal.tsal_curvabc_1_o11, 'curva_venda', estsal.tsal_curvend_1_o11, 'curva_frequ', estsal.tsal_curvfr1_1_o11, 'preco_vend', estsal.tsal_precven_1_o11)
                    ELSE NULL::json
                END AS mes_11,
                CASE
                    WHEN estsal.tsal_qtdfinl_1_o12 > 0::numeric THEN json_build_object('nr_mess', 12, 'qtde', estsal.tsal_qtdfinl_1_o12, 'vr_cust', estsal.tsal_cstfinl_1_o12, 'dt_ultc', estsal.tsal_dtulcom_1_o12, 'vr_vend', estsal.tsal_valvend_1_o12, 'dt_ultv', estsal.tsal_dtulven_1_o12, 'cod_linh', estsal.tsal_codlinh_1_o12, 'cod_sublin', estsal.tsal_sublinh_1_o12, 'curva_demanda', estsal.tsal_curvabc_1_o12, 'curva_venda', estsal.tsal_curvend_1_o12, 'curva_frequ', estsal.tsal_curvfr1_1_o12, 'preco_vend', estsal.tsal_precven_1_o12)
                    ELSE NULL::json
                END AS mes_12
           FROM estsal
          WHERE estsal.tsal_qtdfinl_1_o1 > 0::numeric OR estsal.tsal_qtdfinl_1_o2 > 0::numeric OR estsal.tsal_qtdfinl_1_o3 > 0::numeric OR estsal.tsal_qtdfinl_1_o4 > 0::numeric OR estsal.tsal_qtdfinl_1_o5 > 0::numeric OR estsal.tsal_qtdfinl_1_o6 > 0::numeric OR estsal.tsal_qtdfinl_1_o7 > 0::numeric OR estsal.tsal_qtdfinl_1_o8 > 0::numeric OR estsal.tsal_qtdfinl_1_o9 > 0::numeric OR estsal.tsal_qtdfinl_1_o10 > 0::numeric OR estsal.tsal_qtdfinl_1_o11 > 0::numeric OR estsal.tsal_qtdfinl_1_o12 > 0::numeric
        )
 SELECT meses_pivot.cd_empr,
    meses_pivot.cd_prod,
    meses_pivot.nr_anos,
    (meses.mes_data ->> 'nr_mess'::text)::integer AS nr_mess,
    (meses.mes_data ->> 'qtde'::text)::numeric AS qtde,
    (meses.mes_data ->> 'vr_cust'::text)::numeric AS vr_cust,
    (meses.mes_data ->> 'dt_ultc'::text)::date AS dt_ultc,
    (meses.mes_data ->> 'vr_vend'::text)::numeric AS vr_vend,
    (meses.mes_data ->> 'dt_ultv'::text)::date AS dt_ultv,
    meses.mes_data ->> 'cod_linh'::text AS cod_linh,
    meses.mes_data ->> 'cod_sublin'::text AS cod_sublin,
    meses.mes_data ->> 'curva_demanda'::text AS curva_demanda,
    meses.mes_data ->> 'curva_venda'::text AS curva_venda,
    meses.mes_data ->> 'curva_frequ'::text AS curva_frequ,
    (meses.mes_data ->> 'preco_vend'::text)::numeric AS preco_vend
   FROM meses_pivot
     CROSS JOIN LATERAL ( VALUES (meses_pivot.mes_01), (meses_pivot.mes_02), (meses_pivot.mes_03), (meses_pivot.mes_04), (meses_pivot.mes_05), (meses_pivot.mes_06), (meses_pivot.mes_07), (meses_pivot.mes_08), (meses_pivot.mes_09), (meses_pivot.mes_10), (meses_pivot.mes_11), (meses_pivot.mes_12)) meses(mes_data)
  WHERE meses.mes_data IS NOT NULL AND meses_pivot.nr_anos > 2022;