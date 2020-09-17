CREATE PROCEDURE sp_baixa_parcelas
@cd_cli         NUMERIC(5),
@nr_ctr         NUMERIC(5),
@nr_parcela     NUMERIC(5),
@vr_desconto    NUMERIC(18,2)
AS
DECLARE
@qt_dias        NUMERIC(10),
@vr_juros       NUMERIC(18,2),
@vr_parcela     NUMERIC(18,2),
@periodo        NUMERIC(10),
@fl_ult_parc    TINYINT,
@dt_venc        DATE,
@dt_eft         DATE

BEGIN
    SELECT @dt_venc = dt_venc FROM t402cont WHERE nr_prc = @nr_parcela  AND nr_ctr = @nr_ctr AND cd_cli = @cd_cli;
    SET @qt_dias = DATEDIFF(DAY, @dt_venc, GETDATE());

    IF @qt_dias <= 0
    BEGIN
        SELECT @vr_parcela = vr_tot_prc
          FROM t402cont
         WHERE nr_prc = @nr_parcela 
           AND nr_ctr = @nr_ctr 
           AND cd_cli = @cd_cli;

        UPDATE t402cont
           SET id_sit_parc = 'PG', vr_pgo = @vr_parcela, dt_pgto = GETDATE()
         WHERE nr_prc = @nr_parcela 
           AND nr_ctr = @nr_ctr 
           AND cd_cli = @cd_cli;

           EXECUTE @fl_ult_parc = fn_ultima_parcela @cd_cli, @nr_ctr, @nr_parcela;
           IF @fl_ult_parc = 1
           BEGIN
                UPDATE t402oper SET id_st = 'LQ' WHERE nr_ctr = @nr_ctr AND cd_cli = @cd_cli; 
           END
    END
    ELSE
    BEGIN
        SELECT @vr_juros = vr_jur FROM t402oper WHERE nr_ctr = @nr_ctr AND cd_cli = @cd_cli;

        SELECT @dt_venc = MAX(dt_venc) FROM t402cont WHERE nr_ctr = @nr_ctr AND cd_cli = @cd_cli;
        SELECT @dt_eft = dt_eft FROM t402oper WHERE nr_ctr = @nr_ctr  AND cd_cli = @cd_cli;

        SET @periodo = DATEDIFF(DAY, @dt_eft, @dt_venc);

    SET @vr_juros = ROUND(@vr_juros / @periodo,2);
    SET @vr_juros = @vr_juros * @qt_dias;

    SELECT @vr_parcela = vr_tot_prc 
      FROM t402cont
     WHERE nr_ctr = @nr_ctr 
       AND cd_cli = @cd_cli
       AND nr_prc = @nr_parcela;
    
    SET @vr_parcela = @vr_parcela + @vr_juros - @vr_desconto;

    UPDATE t402cont 
       SET id_sit_parc = 'PG', vr_pgo = @vr_parcela, dt_pgto = GETDATE(), vr_dsc = @vr_desconto, vr_jur_pgo =  @vr_juros
     WHERE nr_ctr = @nr_ctr 
       AND cd_cli = @cd_cli
       AND nr_prc = @nr_parcela;

       EXECUTE @fl_ult_parc = fn_ultima_parcela @cd_cli, @nr_ctr, @nr_parcela;
        IF @fl_ult_parc = 1
           BEGIN
                UPDATE t402oper SET id_st = 'LQ' WHERE nr_ctr = @nr_ctr AND cd_cli = @cd_cli; 
           END
    END
END;