CREATE PROCEDURE sp_insere_oper
	@cd_cli numeric(5),
	@qt_parcelas numeric(5),
	@tx_jurs numeric(10,7),
	@carencia numeric(5),
	@valor_original numeric(18,2)
as
DECLARE
	@nm_cliente varchar(100),
	@nr_contrato numeric(5),
	@nr_cic numeric(14),
	@vr_jur numeric(18,2),
	@vr_liq numeric(18,2),
	@id_st varchar(2)
BEGIN
	SELECT @nm_cliente = nm_cli, @nr_cic = nr_cic
	  FROM T400CLIE
	 WHERE cd_cli = @cd_cli;

	 SELECT @nr_contrato = MAX(nr_ctr) + 1
	  FROM T402OPER;

	  SET @id_st = 'AB';
	  SET @vr_jur = (@tx_jurs / 100) * @valor_original;
	  SET @vr_liq = @vr_jur + @valor_original;

	  BEGIN TRANSACTION
		INSERT INTO T402OPER
		VALUES
			(@cd_cli,
			 1,
			 1,
			 @nm_cliente,
			 GETDATE(),
			 @qt_parcelas,
			 --@nr_contrato,
			 1000,
			 @nr_cic,
			 @tx_jurs,
			 @vr_jur,
			 @carencia,
			 @valor_original,
			 @vr_liq,
			 @id_st,			 
			 NULL);
	  COMMIT;
END;


	

