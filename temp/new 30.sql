

date

create function fn_existe_cliente (@id numeric(3))
returns varchar(50)
as
begin
DECLARE
@final varchar(50)
	if not exists (select nome from clientes where id = @id)	
	BEGIN
		--return 'Cliente não encontrado'	;
		set @final = 'Cliente não encontrado';
	END
	else
	BEGIN
		select @final = nome from clientes where id = @id;
	END
	return @final;
END


create function fn_feriado (@data date)
returns int
as
begin
declare
@retorno int
	if not exists(select 1 from t400feri where desc_data = @data)
	begin
		set @retorno = 0;
	end
	else
	begin
		set @retorno = 1;
	end
	return @retorno;
end;
------------------- FUNCTION DIA UTIL ---------------------------
create function  fn_dia_util(@data date)
returns date
as
begin
declare
@dia_semana int,
@feriado int,
@retorno date
	begin	
		EXECUTE @feriado = fn_feriado @data;
		set @data = dateadd(day,@feriado, @data);
		set @dia_semana = Datepart(dw,@data);
		
		set @data =
		CASE @dia_semana	
			WHEN  1 THEN dateadd(day, 1, @data) 
			WHEN  7 THEN dateadd(day, 2, @data) 
		END;
		
		EXECUTE @feriado = fn_feriado @data;
		set @retorno = DATEADD(day, @feriado, @data);
	end
	return @retorno;
END;
begin
EXECUTE sp_insere_oper 100, 6, 4, 0, 1500
end
use crediblaster;
go
sp_help t402oper

begin
declare
@result date,
@data date
set @data = '20200410'
EXECUTE @result = fn_dia_util @data
print concat('Resultado ',  @result)
end

select Datepart(dw,'20200101')



SELECT datepart(d ,EOMONTH(GETDATE()))

delete from T402OPER



select *
into t402clie_temp 
from T400CLIE;


drop table t402clie_temp

sp_help t400clie