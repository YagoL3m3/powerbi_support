-- DROP FUNCTION public.f_sbi_sugestao_dias_pedido(varchar, varchar, int4, int4, varchar, int4, int4, int4, int4, varchar, varchar, varchar);

CREATE OR REPLACE FUNCTION public.f_sbi_sugestao_dias_pedido(p_estado character varying, p_tipo_relatorio character varying, p_empresa_origem integer, p_empresa_destino integer, p_linha character varying, p_meses_calculo integer, p_meses_sugestao integer, p_frequencias integer, p_pontuacao integer, p_tipo_emissao character varying, p_mes_atual character varying, p_ds_colunas character varying)
 RETURNS text
 LANGUAGE plpgsql
AS $function$ DECLARE

   v_result  text;
   v_soma_meses text;
   v_count_meses INTEGER; 
   v_anobase integer;
   v_mesbase INTEGER ;
   v_ds_colunas varchar(50);
   v_ds_negocio varchar(50);
   i_meses integer ;
   v_data_max date ;
   v_data_min date ;
   v_meses_calculo integer ;
    V_ESTADO VARCHAR(2) ;
   c_emp record ;
   V_FABRICANTE VARCHAR(30);
   
   
  
begin
 
  V_FABRICANTE :=  TRIM(SPLIT_PART( p_linha, '-' , 1) );
  V_ESTADO := upper(  p_estado );
  
    select ncad_siglest_2 into V_ESTADO  from sincad
        inner  join sintab12 on sincad.ncad_cgcocpf_2 = sintab12.ntab_cgcemit_12 
        where ntab_emitent_12 = p_empresa_origem 
         and ntab_emitent_12 in (1,2) ;
  

	
	
   v_meses_calculo := p_meses_calculo ;
   v_count_meses := 1 ;	 
   v_result := ' ' ;
--   v_anobase := extract(year from current_date) ;
 --  v_mesbase := extract(month from current_date) ; 
   if 	p_tipo_relatorio = 'TRANSFERENCIA' then 
   	v_result := v_result || 
		' with SUGESTAO as ( '||chr(13) ;

  /* MOVIMENTO DIARIO DEMANDA */ 
       V_RESULT := V_RESULT || '  select '|| p_meses_calculo || ' AS DIAS_DEMANDA , '||chr(13)||
                                         p_meses_sugestao ||' AS DIAS_COBERTURA , '||chr(13)||
                               '         EMPRESA , ' ||chr(13)||
		                       '         CODIGO ,' ||chr(13)||
								'		 SUM(VENDAS) VENDAS ,'||chr(13)||
								'		 SUM(CONTABIL) CONTABIL ,'||chr(13)||
								'		 SUM(DISPONIVEL) DISPONIVEL ,'||chr(13)||
								'		 SUM(PEDIDOS_COMPRA) PEDIDOS_COMPRA, '||chr(13)||
								'		 SUM(VENDAS_PERDIDAS) VENDAS_PERDIDAS,   '||chr(13)||                                     
                              '          SUM(VENDAS) / '|| p_meses_calculo ||' AS MEDIA_DIARIA ,'||chr(13)||
                             ' ( ( ' || 'SUM(VENDAS)'||  ' / '||  p_meses_calculo || ' ) * '|| p_meses_sugestao ||' )  as SUGESTAO , '||chr(13)||
				             ' case when ( ( ' || 'SUM(VENDAS)'||  ' / '||  p_meses_calculo || ' ) *  '|| p_meses_sugestao ||' ) '||'  -  sum(DISPONIVEL) - sum(PEDIDOS_COMPRA)  <= 0 then 0 else '||
				             ' ( ( ' || 'SUM(VENDAS)'||  ' / '||  p_meses_calculo || ' ) *  '|| p_meses_sugestao ||' ) '||'  -  sum(DISPONIVEL) - sum(PEDIDOS_COMPRA)  end  as NECESSIDADE , '|| chr(13)||         
				             ' case when sum(PEDIDOS_COMPRA) + sum(DISPONIVEL)   -  ( ( ' || 'SUM(VENDAS)' ||  ' / '||  p_meses_calculo  ||  ' ) *  '|| p_meses_sugestao ||' ) <= 0 then 0 else ' ||
				             ' sum(PEDIDOS_COMPRA) + sum(DISPONIVEL)   -  ( ( ' || 'SUM(VENDAS)' ||  ' / '||  p_meses_calculo ||  ' ) *  '|| p_meses_sugestao ||' )  end as EXCESSO  ' ||chr(13)||
                                        
	' from ( '||chr(13)||
							'	select '||chr(13)||
								'	    pedi_emitent_1 AS EMPRESA,'||chr(13)||
								'	    pedi_codprod_1 AS CODIGO,'||chr(13)||
								'	    SUM(pedi_quantid_1 ) AS VENDAS,'||chr(13)||
								'	     0 CONTABIL , '||chr(13)||
								'	     0 as DISPONIVEL,'||chr(13)||
								 '	    0 as PEDIDOS_COMPRA ,'||chr(13)||
								 '	    0 as VENDAS_PERDIDAS '||chr(13)||
								'	     FROM notpedi'||chr(13)||
								'	     LEFT JOIN notped ON notped.tped_emitent_1 = notpedi.pedi_emitent_1 AND notped.tped_nronota_1 = notpedi.pedi_nronota_1 AND notped.tped_sernota_1  = notpedi.pedi_sernota_1  '||chr(13)||
								'	     LEFT JOIN estpro ON estpro.tpro_codprod_1  = notpedi.pedi_codprod_1  '||chr(13)||
								'	     left join estaux on estpro.tpro_codprod_1 = estaux.taux_codinte_1  '||chr(13)||
								'	     LEFT JOIN sintab12 ON sintab12.ntab_emitent_12 = notpedi.pedi_emitent_1 '||chr(13)||
								'	     LEFT JOIN sincad e ON e.ncad_cgcocpf_2 = sintab12.ntab_cgcemit_12 '||chr(13)||
                                 '       left join sintab64 on tpro_grupdes_1  = ntab_grupdes_64    '||chr(13)||
								'	  WHERE notped.tped_situaca_1  <> ''C'' '||chr(13)||
								'	    and tpro_veiculo_1 = 1  '||chr(13)||
					---			'	    and notpedi.pedi_tipomov_1 = 1 '||chr(13)||
					---			'	    and notpedi.pedi_custoss_1 = 1 '||chr(13)||
					---			'	    and notpedi.pedi_movesto_1 = 1 '||chr(13)||
					---			'	    and notpedi.pedi_estatis_1 = 1 '||chr(13)||
								'	    and pedi_procdat_1 >= current_date - interval ''1 day'' * '||  p_meses_calculo  ||chr(13)||
								'	    and pedi_procdat_1 <= current_date  '||chr(13)||
								'	    and pedi_emitent_1 in (1,2) and tped_cliente_1 not in (45415091000164, 22774132000103) '||chr(13);

    if p_linha <> '00 - TODAS' THEN 
         V_RESULT := V_RESULT ||   '        and  tpro_codlinh_1 =  '|| '''' || V_FABRICANTE ||'''' || chr(13);
    END IF;

    V_RESULT := V_RESULT ||		'	   group by PEDI_codprod_1, PEDI_emitent_1  '||chr(13)||
								'	 union all  '||chr(13)||
								'	   select   '||chr(13)||
								'	    prod_empresa_1 , '||chr(13)||
								'	    prod_codprod_1 , '||chr(13)||
								'	    0 VENDAS , '||chr(13)||
								'	    PROD_QTDTOTA_1 QTDE_CONTABIL ,  '||chr(13)||
								'	     PROD_QTDTOTA_1 - PROD_PENDOFI_1 - PROD_PENDORC_1 - PROD_PENDPED_1 as QTDE_DISPONIVEL, '||chr(13)||
								'	     coalesce( ( select  '||chr(13)||
								'												sum( tbeo_qtdpedi_1 - tbeo_entrega_1) '||chr(13)||
								'												from  estbeo  '||chr(13)||
								'												where tbeo_qtdpedi_1 > tbeo_entrega_1  '||chr(13)||
								'												   and tbeo_empresa_1 = PROD_EMPRESA_1 and tbeo_codprod_1 =  PROD_CODPROD_1   ) , 0 ) PEDIDOS_COMPRA,  '||chr(13)||
																			   
								'	    0 as VENDAS_PERDIDAS 		  '||chr(13)||							   
								 '	   from estprod  '||chr(13)||
								'	    left join ESTPRO on PROD_CODPROD_1 = TPRO_CODPROD_1  '||chr(13)||
								'	    left join estaux on estpro.tpro_codprod_1 = estaux.taux_codinte_1   '||chr(13)||
                                '       left join sintab64 on tpro_grupdes_1  = ntab_grupdes_64   '||chr(13)||
								'	    where    '||chr(13)||
								'	    tpro_veiculo_1 = 1   '||chr(13)||
								'	    and prod_empresa_1 in (1,2)  '||chr(13);

    if p_linha <> '00 - TODAS' THEN 
         V_RESULT := V_RESULT ||   '        and  tpro_codlinh_1 =  '|| '''' || V_FABRICANTE ||'''' || chr(13) ;
    END IF;
								    
		V_RESULT := V_RESULT ||	'	    union all   '||chr(13)||
								     
								'	    select    '||chr(13)||
								'	    perl_emitent_1,   '||chr(13)||
								'	    perl_codprod_1,  '||chr(13)||
								'	    0 AS VENDAS,  '||chr(13)||
								'	    0 QTDE_CONTABIL ,   '||chr(13)||
								'	    0 as QTDE_DISPONIVEL,  '||chr(13)||
								'	    0 as PEDIDOS_COMPRA ,  '||chr(13)||
								'	    SUM(perl_quantid_1) VENDAS_PERDIDAS  '||chr(13)||
								'	    from perlog   '||chr(13)||
                                '	    left join ESTPRO on perl_codprod_1 = TPRO_CODPROD_1  '||chr(13)||
                                '	    left join estaux on estpro.tpro_codprod_1 = estaux.taux_codinte_1  '||chr(13)||
                                '        left join sintab64 on tpro_grupdes_1  = ntab_grupdes_64   '||chr(13)||
								'	    where perl_motivos_1 in (''Indisponibilidade'', ''Indisp. ass. cliente'' )  '||chr(13)||
								'	      and perl_datproc_1 >= current_date - interval ''1 day'' * '||  p_meses_calculo  ||chr(13)||
								'	      and perl_datproc_1 <= current_date   '||chr(13)||
								'	      and perl_codprod_1 > '' ''  '||chr(13)||
								'	      and perl_emitent_1 in (1,2)  '||chr(13);
 
    if p_linha <> '00 - TODAS' THEN 
         V_RESULT := V_RESULT ||   '        and  tpro_codlinh_1 =  '|| '''' || V_FABRICANTE ||'''' || chr(13);
    END IF;
				
		V_RESULT := V_RESULT ||	'	      group by perl_codprod_1,  perl_emitent_1  '||chr(13)||
								'	      ) X   '||chr(13)||
							'		group by     CODIGO , EMPRESA '   ||chr(13)
                                 ;

      
       v_result := v_result||                       ' ) '||CHR(13) ;

               
		v_result := v_result|| 	'  select '||CHR(13) ;
	
				if p_tipo_emissao = 'ANALISE' then 	
				 v_result := v_result || 
						---	'     e.EMPRESA as "EMPRESA*", '||CHR(13) || 
                       --     '     ntab_grupdes_64 || ''-'' || ntab_descdes_64 as "FABRICANTE", '||CHR(13) || 
							'     tpro_codlinh_1 ||''-''||ntab_desclin_6 as "LINHA*" , '||CHR(13) || 
							'     TPRO_SUBLINH_1 as "SUBLINHA|PRODUTO", '||CHR(13) || 
							'     E.CODIGO as "PARTNUMBER+|PRODUTO", '||CHR(13) || 
							'     TPRO_DESCRIC_1 as "DESCRIÇÃO>|PRODUTO", '||CHR(13) ||
						    '     E.VENDAS as "DEMANDA TOTAL$SUM|PRODUTO",  '||CHR(13)||  
						     '     MAX(prod_precore_1) AS "VALOR REPOSIÇÃO$|PRODUTO" '||CHR(13) 
					--		'     E.DISPONIVEL as "DISPONIVEL$SUM", '||CHR(13) || 
				--			'     ROUND( E.MEDIA_MENSAL, 2) as "MEDIA" ,'||CHR(13) || 
				--			'     E.PEDIDOS_COMPRA as "PEDIDO_COMPRA$SUM" , '||CHR(13) || 
				--			'     E.EXCESSO as "EXCESSO$SUM" , '||CHR(13) ||							
			    --		    '     D.EMPRESA as "EMPRESA DESTINO" , '||CHR(13) || 
				--			'     D.DISPONIVEL as "DISPONIVEL DESTINO" , '||CHR(13) || 
			    --   		'     D.NECESSIDADE as "NECESSIDADE" , '||CHR(13) || 
				--			'     least( D.NECESSIDADE , E.EXCESSO ) as "SUGESTÃO TRANSFERENCIA" ,'||CHR(13) ||
			    --     		'     e.PONTUACAO as "PONTUACAO"  '||CHR(13) 
			         							
							;
						
				
				 
			    else 
			     v_result := v_result || 
			                 '     E.CODIGO as "PARTNUMBER" , '||CHR(13) ||
			                 '     TPRO_DESCRIC_1 as "DESCRIÇÃO>" , '||CHR(13) || 
			              
			--               '     least( D.NECESSIDADE , E.EXCESSO ) as "SUGESTÃO TRANSFERENCIA" ,'||CHR(13) ||
			                 '     0 as "VALOR$" '||CHR(13) ; 
			                 
				end if;	
			
		
			
	    V_RESULT := V_RESULT  || ' , ' || ' SUM( CASE WHEN  E.EMPRESA = '|| p_empresa_origem || ' THEN  E.CONTABIL ELSE 0 END )  AS "#CONTABIL$SUM|'|| trim(to_char(p_empresa_origem ,'000'))||'"'||CHR(13) ;
		V_RESULT := V_RESULT  || ' , ' || ' SUM( CASE WHEN  E.EMPRESA = '|| p_empresa_origem || ' THEN  E.DISPONIVEL ELSE 0 END )  AS "DISPONIVEL$SUM|'|| trim(to_char(p_empresa_origem ,'000'))||'"'||CHR(13) ;	 
		V_RESULT := V_RESULT  || ' , ' || ' SUM( CASE WHEN  E.EMPRESA = '|| p_empresa_origem || ' THEN  ROUND( E.MEDIA_DIARIA, 2) ELSE 0 END )  AS "MEDIA DIARIA$SUM|'|| trim(to_char(p_empresa_origem ,'000'))||'"'||CHR(13) ;
	    V_RESULT := V_RESULT  || ' , ' || ' ceil(SUM( CASE WHEN  E.EMPRESA = '|| p_empresa_origem || ' THEN  E.SUGESTAO ELSE 0 END ))  AS "SUGESTAO '|| p_meses_sugestao ||' Dias$SUM|'|| trim(to_char(p_empresa_origem ,'000'))||'"'||CHR(13) ;
	   -- V_RESULT := V_RESULT  || ' , ' || ' SUM( CASE WHEN  E.EMPRESA = '|| p_empresa_origem || ' THEN  ROUND( E.PEDIDOS_COMPRA, 2) ELSE 0 END )  AS "PEDIDO COMPRA$SUM|'|| trim(to_char(p_empresa_origem,'000'))||'"'||CHR(13) ;
	--	V_RESULT := V_RESULT  || ' , ' || ' SUM( CASE WHEN  E.EMPRESA = '|| p_empresa_origem || ' THEN  E.EXCESSO ELSE 0 END )  AS "EXCESSO|'|| trim(to_char(p_empresa_origem ,'000'))||'"'||CHR(13) ;
		V_RESULT := V_RESULT  || ' , ' || ' ceil(SUM( CASE WHEN  E.EMPRESA = '|| p_empresa_origem || ' THEN  E.NECESSIDADE ELSE 0 END ))  AS "NECESSIDADE$SUM|'|| trim(to_char(p_empresa_origem,'000'))||'"'||CHR(13) ;
	   V_RESULT := V_RESULT  || ' , ' || ' ceil(SUM( CASE WHEN  E.EMPRESA = '|| p_empresa_origem || ' THEN  E.NECESSIDADE ELSE 0 END )) * MAX(prod_precore_1) AS "VALOR REPOSIÇÃO NECESSÁRIA$SUM|'|| trim(to_char(p_empresa_origem,'000'))||'"'||CHR(13) ;
		
	
    for c_emp in (  select  ntab_emitent_12 from SINTAB12  
							   inner join SINCAD on ntab_cgcemit_12 = ncad_cgcocpf_2  
							    where ncad_siglest_2 = upper(  p_estado )
							    and ntab_emitent_12 <> p_empresa_origem
							    and ntab_emitent_12 in (1,2) 
							    order by  ntab_emitent_12 )	
   
   loop  							     
			
	
		V_RESULT := V_RESULT  || ' , ' || ' SUM( CASE WHEN  e.EMPRESA = '||c_emp.ntab_emitent_12 || ' THEN  e.DISPONIVEL ELSE 0 END )  AS "DISPONIVEL|'|| trim(to_char(c_emp.ntab_emitent_12 ,'000'))||'"'||CHR(13) ;
	 --   V_RESULT := V_RESULT  || ' , ' || ' SUM( CASE WHEN  E.EMPRESA = '||c_emp.ntab_emitent_12|| ' THEN  ROUND( E.PEDIDOS_COMPRA, 2) ELSE 0 END )  AS "PEDIDO COMPRA|'|| trim(to_char(c_emp.ntab_emitent_12,'000'))||'"'||CHR(13) ;
		V_RESULT := V_RESULT  || ' , ' || ' ceil(round(SUM( CASE WHEN  e.EMPRESA = '||c_emp.ntab_emitent_12 || ' THEN  e.EXCESSO ELSE 0 END ),2))  AS "EXCESSO|'|| trim(to_char(c_emp.ntab_emitent_12 ,'000'))||'"'||CHR(13) ;
	

   end loop;
	v_result := v_result ||	'  from SUGESTAO E '||CHR(13) || 
			--	'     LEFT  join sugestao d on e.codigo = d.codigo and d.EXCESSO > 0 and d.empresa <>  ' || p_empresa_origem  ||CHR(13) || 
			--	'      and E.frequencias >= '||  p_frequencias  ||CHR(13)||' and E.PONTUACAO >= '|| p_pontuacao ||CHR(13) || 
				'     left join estpro on e.codigo = tpro_codprod_1 '||CHR(13) || 
				'     left join estprod on e.codigo = prod_codprod_1 and E.EMPRESA = prod_empresa_1 '||CHR(13) ||
                '	  left join estaux on estpro.tpro_codprod_1 = estaux.taux_codinte_1  '||chr(13)||
                '     left join sintab64 on tpro_grupdes_1  = ntab_grupdes_64    '||chr(13)||
				'     left join sintab06 l on l.ntab_codlinh_6 = tpro_codlinh_1 and l.ntab_sublinh_6 = '' '' ' ||CHR(13) || 
				'     inner join sintab12 on E.EMPRESA = ntab_emitent_12  '||CHR(13) || 
		    '      inner join SINCAD on ntab_cgcemit_12 = ncad_cgcocpf_2 '||CHR(13) || 
				'      where  (    ( e.necessidade >= 0  AND E.EMPRESA = '|| p_empresa_origem  ||' )  '||CHR(13) || /*Mudando pois eu estou */
				 '         OR (e.EXCESSO > 0  and  E.EMPRESA <> '|| p_empresa_origem  ||' ) )'||CHR(13) ||
				   '     and ncad_siglest_2 = '||''''|| V_ESTADO ||''''  ||CHR(13)
               --   '      AND e.EMPRESA   in (101,103,104,105,201,300,400,600,700,750,751)   ' 
				;

			
	
  
			 v_result := v_result  ||' group by E.VENDAS ,ntab_grupdes_64 || ''-'' || ntab_descdes_64 , tpro_codlinh_1 ||''-''||ntab_desclin_6  , TPRO_SUBLINH_1 , E.CODIGO , TPRO_DESCRIC_1 '	;	
	         V_RESULT := V_RESULT  || '  ' || ' HAVING SUM( CASE WHEN  E.EMPRESA = '|| p_empresa_origem || ' THEN  E.NECESSIDADE ELSE 0 END ) > 0 AND SUM( CASE WHEN  E.EMPRESA = '|| p_empresa_origem || ' THEN  ROUND( E.MEDIA_DIARIA, 2) ELSE 0 END ) >= 1 ';
	 

   end if ;
  
  
	
   RETURN v_result;

end $function$
;