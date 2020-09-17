CREATE PROCEDURE sp_atualiza_capa_lote
@lote               NUMERIC(5),
@tipo_lote          VARCHAR(3)

AS
DECLARE
@contrato           NUMERIC(5),
@cliente            NUMERIC(5),
@valor_calculado    NUMERIC(5),
@interface_origem   VARCHAR(20),
@valor              NUMERIC(18,2),
@desconto           NUMERIC(18,2)

BEGIN
SELECT @valor = sum(valor), @desconto = sum(desconto)
  FROM t402lote
 WHERE lote = @lote
   AND tipo_lote = @tipo_lote;

SET @valor_calculado = @valor - @desconto;

/*SELECT @interface_origem = DISTINCT(itf_origem)
  FROM t402lote
 WHERE lote = @lote
   AND tipo_lote = @tipo_lote;*/

 SET @interface_origem = 'proc_lote_liquidacao' ;

DELETE FROM t402cptl WHERE lote= @lote AND tipo_lote = @tipo_lote;

INSERT INTO t402cptl
    VALUES 
        (
            @lote,
            @tipo_lote,
            @valor_calculado,
            @interface_origem,
            'FEC',
            GETDATE()
        )

END