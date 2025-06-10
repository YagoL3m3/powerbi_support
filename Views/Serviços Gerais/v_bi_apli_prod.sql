/* HTML */
SELECT U.SINC_NOMUSER_4 AS "Usuario*",
       Q.TQLM_CODPROD_1 AS "Codigo Produto+",
       E.TPRO_DESCRIC_1 AS "Descricao",
       Q.TQLM_LOCACAO_1 AS "Locacao Origem",
       Q.TQLM_LOCCORR_1 AS "Locacao Destino",         
      COALESCE( CAST((select SUM(M.FIM - M.INICIO)
        from WMS_MOVIMENTACAO_LOG M
        where M.ID_PRODUTO = Q.tqlm_codprod_1
          and cast(M.INICIO as date) BETWEEN  :DATA_INICIAL_D AND :DATA_FINAL_D           
          and USUARIO = Q.tqlm_usuario_1
          and M.id_locacao_destino = Q.tqlm_loccorr_1
          and cast(lpad(cast(Q.tqlm_horamov_1 as text), 8, '0') as varchar(4)) = lpad(cast( extract(HOUR FROM M.FIM) as text), 2, '0') || lpad(cast(extract(MINUTE FROM M.FIM) as text), 2, '0')) AS TEXT), 'N/A')  AS "Tempo",      
       Q.TQLM_QUANTID_1 AS "Quantidade$SUM"
FROM ESTQLM Q
INNER JOIN SINC04 U ON (Q.TQLM_USUARIO_1 = U.SINC_CODUSER_4) 
INNER JOIN ESTPRO E ON (Q.TQLM_CODPROD_1 = E.TPRO_CODPROD_1)
WHERE cast(Q.TQLM_DATAMOV_1 as date) BETWEEN :DATA_INICIAL_D AND :DATA_FINAL_D
AND Q.TQLM_PROGRAM_1 = 'WMS'
AND TQLM_TIPOMOV_1 = 'Saida'

