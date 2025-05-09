-- Versão otimizada da view public.v_saldo_estoque
CREATE OR REPLACE VIEW public.v_saldo_estoque AS
WITH meses_pivot AS (
    SELECT 
        tsal_empresa_1 AS cd_empr,
        tsal_codprod_1 AS cd_prod,
        tsal_anorefe_1 AS nr_anos,
        CASE WHEN tsal_qtdfinl_1_o1 > 0 THEN 
            json_build_object(
                'nr_mess', 1,
                'qtde', tsal_qtdfinl_1_o1,
                'vr_cust', tsal_cstfinl_1_o1,
                'dt_ultc', tsal_dtulcom_1_o1,
                'vr_vend', tsal_valvend_1_o1,
                'dt_ultv', tsal_dtulven_1_o1
            )
        ELSE NULL END AS mes_01,
        
        CASE WHEN tsal_qtdfinl_1_o2 > 0 THEN 
            json_build_object(
                'nr_mess', 2,
                'qtde', tsal_qtdfinl_1_o2,
                'vr_cust', tsal_cstfinl_1_o2,
                'dt_ultc', tsal_dtulcom_1_o2,
                'vr_vend', tsal_valvend_1_o2,
                'dt_ultv', tsal_dtulven_1_o2
            )
        ELSE NULL END AS mes_02,
        
        CASE WHEN tsal_qtdfinl_1_o3 > 0 THEN 
            json_build_object(
                'nr_mess', 3,
                'qtde', tsal_qtdfinl_1_o3,
                'vr_cust', tsal_cstfinl_1_o3,
                'dt_ultc', tsal_dtulcom_1_o3,
                'vr_vend', tsal_valvend_1_o3,
                'dt_ultv', tsal_dtulven_1_o3
            )
        ELSE NULL END AS mes_03,
        
        CASE WHEN tsal_qtdfinl_1_o4 > 0 THEN 
            json_build_object(
                'nr_mess', 4,
                'qtde', tsal_qtdfinl_1_o4,
                'vr_cust', tsal_cstfinl_1_o4,
                'dt_ultc', tsal_dtulcom_1_o4,
                'vr_vend', tsal_valvend_1_o4,
                'dt_ultv', tsal_dtulven_1_o4
            )
        ELSE NULL END AS mes_04,
        
        CASE WHEN tsal_qtdfinl_1_o5 > 0 THEN 
            json_build_object(
                'nr_mess', 5,
                'qtde', tsal_qtdfinl_1_o5,
                'vr_cust', tsal_cstfinl_1_o5,
                'dt_ultc', tsal_dtulcom_1_o5,
                'vr_vend', tsal_valvend_1_o5,
                'dt_ultv', tsal_dtulven_1_o5
            )
        ELSE NULL END AS mes_05,
        
        CASE WHEN tsal_qtdfinl_1_o6 > 0 THEN 
            json_build_object(
                'nr_mess', 6,
                'qtde', tsal_qtdfinl_1_o6,
                'vr_cust', tsal_cstfinl_1_o6,
                'dt_ultc', tsal_dtulcom_1_o6,
                'vr_vend', tsal_valvend_1_o6,
                'dt_ultv', tsal_dtulven_1_o6
            )
        ELSE NULL END AS mes_06,
        
        CASE WHEN tsal_qtdfinl_1_o7 > 0 THEN 
            json_build_object(
                'nr_mess', 7,
                'qtde', tsal_qtdfinl_1_o7,
                'vr_cust', tsal_cstfinl_1_o7,
                'dt_ultc', tsal_dtulcom_1_o7,
                'vr_vend', tsal_valvend_1_o7,
                'dt_ultv', tsal_dtulven_1_o7
            )
        ELSE NULL END AS mes_07,
        
        CASE WHEN tsal_qtdfinl_1_o8 > 0 THEN 
            json_build_object(
                'nr_mess', 8,
                'qtde', tsal_qtdfinl_1_o8,
                'vr_cust', tsal_cstfinl_1_o8,
                'dt_ultc', tsal_dtulcom_1_o8,
                'vr_vend', tsal_valvend_1_o8,
                'dt_ultv', tsal_dtulven_1_o8
            )
        ELSE NULL END AS mes_08,
        
        CASE WHEN tsal_qtdfinl_1_o9 > 0 THEN 
            json_build_object(
                'nr_mess', 9,
                'qtde', tsal_qtdfinl_1_o9,
                'vr_cust', tsal_cstfinl_1_o9,
                'dt_ultc', tsal_dtulcom_1_o9,
                'vr_vend', tsal_valvend_1_o9,
                'dt_ultv', tsal_dtulven_1_o9
            )
        ELSE NULL END AS mes_09,
        
        CASE WHEN tsal_qtdfinl_1_o10 > 0 THEN 
            json_build_object(
                'nr_mess', 10,
                'qtde', tsal_qtdfinl_1_o10,
                'vr_cust', tsal_cstfinl_1_o10,
                'dt_ultc', tsal_dtulcom_1_o10,
                'vr_vend', tsal_valvend_1_o10,
                'dt_ultv', tsal_dtulven_1_o10
            )
        ELSE NULL END AS mes_10,
        
        CASE WHEN tsal_qtdfinl_1_o11 > 0 THEN 
            json_build_object(
                'nr_mess', 11,
                'qtde', tsal_qtdfinl_1_o11,
                'vr_cust', tsal_cstfinl_1_o11,
                'dt_ultc', tsal_dtulcom_1_o11,
                'vr_vend', tsal_valvend_1_o11,
                'dt_ultv', tsal_dtulven_1_o11
            )
        ELSE NULL END AS mes_11,
        
        CASE WHEN tsal_qtdfinl_1_o12 > 0 THEN 
            json_build_object(
                'nr_mess', 12,
                'qtde', tsal_qtdfinl_1_o12,
                'vr_cust', tsal_cstfinl_1_o12,
                'dt_ultc', tsal_dtulcom_1_o12,
                'vr_vend', tsal_valvend_1_o12,
                'dt_ultv', tsal_dtulven_1_o12
            )
        ELSE NULL END AS mes_12
    FROM 
        estsal
    WHERE 
        tsal_qtdfinl_1_o1 > 0 OR tsal_qtdfinl_1_o2 > 0 OR 
        tsal_qtdfinl_1_o3 > 0 OR tsal_qtdfinl_1_o4 > 0 OR 
        tsal_qtdfinl_1_o5 > 0 OR tsal_qtdfinl_1_o6 > 0 OR 
        tsal_qtdfinl_1_o7 > 0 OR tsal_qtdfinl_1_o8 > 0 OR 
        tsal_qtdfinl_1_o9 > 0 OR tsal_qtdfinl_1_o10 > 0 OR 
        tsal_qtdfinl_1_o11 > 0 OR tsal_qtdfinl_1_o12 > 0
)
SELECT 
    cd_empr,
    cd_prod,
    nr_anos,
    (mes_data->>'nr_mess')::int AS nr_mess,
    (mes_data->>'qtde')::numeric AS qtde,
    (mes_data->>'vr_cust')::numeric AS vr_cust,
    (mes_data->>'dt_ultc')::date AS dt_ultc,
    (mes_data->>'vr_vend')::numeric AS vr_vend,
    (mes_data->>'dt_ultv')::date AS dt_ultv
FROM 
    meses_pivot
CROSS JOIN LATERAL (
    VALUES 
        (mes_01), (mes_02), (mes_03), (mes_04),
        (mes_05), (mes_06), (mes_07), (mes_08),
        (mes_09), (mes_10), (mes_11), (mes_12)
) AS meses(mes_data)
WHERE 
    mes_data IS NOT NULL;