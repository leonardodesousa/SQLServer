CREATE PROCEDURE sp_processamentoDiario
AS
DECLARE 
@cliente                NUMERIC(5), 
@contrato               NUMERIC(5),
@parcela                NUMERIC(5),
@dataProcessamento      DATE,
@quantidadeDias         NUMERIC(5),
@dataVencimento         DATE,
@vr_parcela             NUMERIC(18,2),
@dataEfetivacao         DATE,
@vr_juros               NUMERIC(18,2), 
@vr_desconto            NUMERIC(18,2) = 0,
@valorTotalContrato     NUMERIC(18,2),
@periodo				INT,
@saldoAtualCalculado	NUMERIC(18,2),
@contador				INT = 1,
@numeroParcelas			INT

UPDATE agencias SET processsamentoIniciado = 1, inicioProcessamento = GETDATE() WHERE unidade = 1 AND empresa = 1;

DROP TABLE IF EXISTS #temp_contratos_efetivados 
DROP TABLE IF EXISTS #valorTotalParcelas 

SELECT @dataProcessamento = dataAtual 
  FROM agencias
 WHERE unidade = 1;

CREATE TABLE #valorTotalParcelas
    (
     contrato NUMERIC(5),   
     parcela  NUMERIC(5),
     valor    NUMERIC(18,2)     
    )
SELECT *
INTO #temp_contratos_efetivados
FROM t402cont 
WHERE id_sit_parc = 'AB'


WHILE EXISTS (SELECT 1 FROM #temp_contratos_efetivados)
BEGIN
	 SELECT TOP 1 @cliente = cd_cli ,@contrato = nr_ctr, @parcela = nr_prc
       FROM #temp_contratos_efetivados
	 
	 SELECT @numeroParcelas = COUNT(1) FROM #temp_contratos_efetivados where nr_ctr = @contrato

	 WHILE @contador <= @numeroParcelas 
		BEGIN
		 SELECT TOP 1 @cliente = cd_cli ,@contrato = nr_ctr, @parcela = nr_prc
           FROM #temp_contratos_efetivados
		   SELECT @dataVencimento = dt_venc FROM #temp_contratos_efetivados WHERE nr_prc = @parcela  AND nr_ctr = @contrato  AND cd_cli = @cliente;
             SET @quantidadeDias = DATEDIFF(DAY, @dataVencimento, @dataProcessamento);

			  IF @quantidadeDias <= 0
			  BEGIN
				SELECT @vr_parcela = vr_tot_prc
				  FROM #temp_contratos_efetivados
				 WHERE nr_prc = @parcela   
				   AND nr_ctr = @contrato
                   AND cd_cli = @cliente;

			
                INSERT INTO #valorTotalParcelas VALUES (@contrato, @parcela, @vr_parcela)
				SET @contador = @contador + 1
				IF(@contador = @numeroParcelas)
					BEGIN
						SELECT @saldoAtualCalculado = SUM(tp.valor) FROM #valorTotalParcelas tp 
						INSERT INTO contabilizacaoContratos VALUES(@cliente,1, 1, @contrato, 0,@saldoAtualCalculado, @dataProcessamento)
						DELETE FROM #temp_contratos_efetivados where nr_ctr = @contrato
					END			
				END						
				ELSE
        BEGIN
            SELECT @vr_juros = vr_jur FROM t402oper WHERE nr_ctr = @contrato AND cd_cli =  @cliente;

            SELECT @dataVencimento  = MAX(dt_venc) FROM #temp_contratos_efetivados WHERE nr_ctr = @contrato AND cd_cli = @cliente;
            SELECT @dataEfetivacao = dt_eft FROM t402oper WHERE nr_ctr = @contrato  AND cd_cli =  @cliente;

            SET @periodo = DATEDIFF(DAY,@dataEfetivacao, @dataVencimento);   

            SET @vr_juros = ROUND(@vr_juros / @periodo,2);
            SET @vr_juros = @vr_juros * @quantidadeDias;

            SELECT @vr_parcela = vr_tot_prc 
            FROM #temp_contratos_efetivados
            WHERE nr_ctr = @contrato
              AND cd_cli =  @cliente
              AND nr_prc =  @parcela;    
              SET @vr_parcela = @vr_parcela + @vr_juros - @vr_desconto;
            INSERT INTO #valorTotalParcelas VALUES (@contrato, @parcela, @vr_parcela)                
			  SET @contador = @contador + 1
				IF(@contador = @numeroParcelas)
					BEGIN
						SELECT @saldoAtualCalculado = SUM(tp.valor) FROM #valorTotalParcelas tp 
						INSERT INTO contabilizacaoContratos VALUES(@cliente,1, 1, @contrato, 0,@saldoAtualCalculado, @dataProcessamento)
						DELETE FROM #temp_contratos_efetivados where nr_ctr = @contrato
					END     
			 
        END		
    END 	
	UPDATE agencias SET dataAtual = DATEADD(DAY, 1, dataAtual), 
		   dataUltimoProcessamento = DATEADD(day, 1,dataUltimoProcessamento ),
		   dataProximoProcessamento = DATEADD(day, 1,dataProximoProcessamento), 
		   processsamentoIniciado = 0, fimProcessamento = GETDATE() 
	 WHERE empresa = 1 AND unidade = 1;
END


