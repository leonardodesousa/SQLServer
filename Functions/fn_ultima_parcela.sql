CREATE FUNCTION fn_ultima_parcela (@cd_cli NUMERIC(5), @nr_ctr NUMERIC(5), @nr_prc NUMERIC(5)) RETURNS TINYINT
AS
BEGIN
DECLARE @retorno TINYINT
BEGIN
    IF NOT EXISTS(SELECT 1 FROM t402cont WHERE nr_ctr = @nr_ctr AND cd_cli = @cd_cli AND nr_prc = @nr_prc + 1)
        BEGIN
            SET @retorno = 1;
        END
        ELSE
        BEGIN
            SET @retorno = 0;
        END
    RETURN @retorno;
    END
END