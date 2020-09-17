CREATE PROCEDURE sp_calculo_liquidacao
@lote     NUMERIC(5),
@cliente  NUMERIC(5),
@contrato NUMERIC(5),
@parcela   NUMERIC(5),
@desconto  NUMERIC(18,2),
@nr_seq   NUMERIC(5)
AS
DECLARE
@valor_calculado  NUMERIC(18,2),
@nr_nosso_nr      NUMERIC(11)

BEGIN
SELECT @nr_nosso_nr = nr_nos_nr 
  FROM t402cont 
 WHERE cd_cli = @cliente 
   AND nr_ctr = @contrato
   AND nr_ctr = @contrato;


INSERT INTO t402lote
VALUES 
    (
        @lote,
        @contrato,
        @cliente,
        @parcela,
        @desconto,
        @valor_calculado,
        'LIQ',
        'proc_lote_liquidacao',
        @nr_seq,
        'FEC',
        GETDATE(),
        @nr_nosso_nr
    );

    EXECUTE sp_atualiza_capa_lote @lote, 'LIQ';
    UPDATE t402cont set id_lot = 'S' WHERE nr_ctr = @contrato AND cd_cli = @cliente AND nr_prc = @parcela;
END