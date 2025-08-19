-- DROP FUNCTION public.calcular_saldo_anterior(varchar, varchar, date);

CREATE OR REPLACE FUNCTION public.calcular_saldo_anterior(p_emitente character varying, p_numero_conta character varying, p_data_referencia date)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_data_inicial DATE;
    v_meses_diferenca INTEGER;
    v_saldo_total NUMERIC := 0;
    v_coluna_atual INTEGER;
    v_debito NUMERIC;
    v_credito NUMERIC;
    v_sql TEXT;
    v_resultado RECORD;
    ctb_data_inicio VARCHAR;
    ctb_saldo VARCHAR;
BEGIN
    -- Constrói os nomes das tabelas com o emitente
    ctb_data_inicio :=  'ctbem' || p_emitente;  
    ctb_saldo :=  'ctbcs' || p_emitente; 
    
    -- Busca a data inicial da conta
    v_sql := FORMAT('SELECT 
            TO_DATE(
                RIGHT(CAST(bemp_mesanol_1 AS TEXT), 4) || ''-'' || 
                CASE 
                    WHEN LENGTH(CAST(bemp_mesanol_1 AS TEXT)) = 5 THEN 
                        LEFT(CAST(bemp_mesanol_1 AS TEXT), 1) 
                    ELSE 
                        LEFT(CAST(bemp_mesanol_1 AS TEXT), 2) 
                END, 
                ''YYYY-MM''
            ) AS initial_date 
        FROM %I
        LIMIT 1', ctb_data_inicio);
    EXECUTE v_sql INTO v_data_inicial USING p_numero_conta;

    -- Calcula a diferença em meses entre a data inicial e a data de referência
    v_meses_diferenca := EXTRACT(YEAR FROM AGE(p_data_referencia, v_data_inicial)) * 12 + 
                        EXTRACT(MONTH FROM AGE(p_data_referencia, v_data_inicial));
    
    -- Verifica se a data de referência é anterior à data inicial
    IF v_meses_diferenca < 0 THEN
        RETURN 1; -- Retorna 0 se a data for anterior ao início da conta
    END IF;
    
    -- Limita aos 144 meses disponíveis (0 a 144)
    IF v_meses_diferenca > 144 THEN
        v_meses_diferenca := 144;
    END IF;
    
    -- Loop para somar débitos e créditos até o mês de referência
    FOR v_coluna_atual IN 1..v_meses_diferenca LOOP
        -- Constrói a query dinamicamente para acessar as colunas
        v_sql := FORMAT('
			select
			ctbcs_mesdebi_1_o%s as debito,
			ctbcs_mescred_1_o%s as credito
			from %I
			where ctbcs_nrconta_1 = $1',
            v_coluna_atual, v_coluna_atual, ctb_saldo
        );
        
        -- Executa a query
        EXECUTE v_sql INTO v_resultado USING p_numero_conta;
        
        -- Se encontrou dados, calcula o saldo (débito - crédito)
        IF v_resultado IS NOT NULL THEN
            v_debito := COALESCE(v_resultado.debito, 0);
            v_credito := COALESCE(v_resultado.credito, 0);
            v_saldo_total := v_saldo_total + (v_debito - v_credito);
        END IF;
    END LOOP;
    
    RETURN v_saldo_total;
    
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Erro ao calcular saldo anterior: %', SQLERRM;
END;
$function$
;