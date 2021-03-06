CREATE PROCEDURE sp_contrato_simu
@pcd_cli NUMERIC(5),
@pnr_ctr NUMERIC(5)

AS
DECLARE
@dia_semana         TINYINT,
@data               DATE,
@qt_parcela         NUMERIC(3),
@carencia           NUMERIC(3),
@data_temp          DATE,
@ultimo_dia         DATE,
@add_mes			TINYINT,
@vl_pcl             NUMERIC(18,2),
@nr_ctr             NUMERIC(5),
@nr_cic             varchar(14),
@vl_ori             NUMERIC(18,2),
@vl_prc_sjur        NUMERIC(18,2),
@vl_jur_por_prc     NUMERIC(18,2),
@tx_jur             NUMERIC(10,7),
@data_ori           DATE,
@id_sit_parc        VARCHAR(2),
@contador           NUMERIC(2)

BEGIN      
    DELETE FROM t402simu WHERE nr_ctr = @pnr_ctr and cd_cli = @pcd_cli;    
    
    SET @id_sit_parc = 'AB';
    SET @nr_ctr = @pnr_ctr;

    SELECT @data = CAST(dt_inc AS DATE) FROM t402oper WHERE cd_cli = @pcd_cli AND nr_ctr = @pnr_ctr;

    SELECT @nr_cic = nr_cic FROM t400clie WHERE cd_cli = @pcd_cli;
   
    SELECT @dia_semana = DATEPART(DAY, dt_inc) 
      FROM t402oper
     WHERE cd_cli = @pcd_cli
       AND nr_ctr = @pnr_ctr;
    
    SELECT @qt_parcela = qt_amo
      FROM t402oper
     WHERE cd_cli = @pcd_cli
       AND nr_ctr = @pnr_ctr; 

    SELECT @vl_ori = vl_ori
      FROM t402oper
     WHERE cd_cli = @pcd_cli
       AND nr_ctr = @pnr_ctr;

    SET @vl_ori = @vl_ori / @qt_parcela;

    SELECT @tx_jur = tx_jur
      FROM t402oper
     WHERE cd_cli = @pcd_cli
       AND nr_ctr = @pnr_ctr;

    SELECT @vl_prc_sjur = vr_jur / @qt_parcela
      FROM t402oper
     WHERE cd_cli = @pcd_cli
       AND nr_ctr = @pnr_ctr;

    SELECT @vl_pcl = ROUND(vl_liq / qt_amo,2)
      FROM t402oper
     WHERE cd_cli = @pcd_cli
       AND nr_ctr = @pnr_ctr; 
    
    SELECT @carencia = carencia
      FROM t402oper
     WHERE cd_cli = @pcd_cli
       AND nr_ctr = @pnr_ctr;  

    SELECT @vl_jur_por_prc = vr_jur / @qt_parcela
      FROM t402oper
     WHERE cd_cli = @pcd_cli
       AND nr_ctr = @pnr_ctr; 

    SET @data = DATEADD(DAY, @carencia, @data) ;
    SET @data_temp = @data;
    SET @data_ori = @data; 

    SET @contador = 1;
    
        WHILE @contador <= @qt_parcela
        BEGIN
        
            SET @ultimo_dia = EOMONTH(DATEADD(MONTH,@contador-1, @data_ori));
		    SET @add_mes = DATEPART(d,@ultimo_dia);
            SET @data_temp = DATEADD(MONTH, @contador -1, @data_ori);
            SET @data = DATEADD(DAY, @add_mes, @data_temp);

            INSERT INTO t402simu 
            VALUES(
                @pcd_cli,
                1,
                1,
                GETDATE(),
                @contador,
                @nr_ctr,
                @nr_cic,
                @tx_jur,
                @vl_jur_por_prc,
                @vl_ori,
                NULL,
                @vl_pcl,
                @data,
                @id_sit_parc,
                NULL,
                NULL
            );

        SET @contador =  @contador + 1;
        END;
    
END;