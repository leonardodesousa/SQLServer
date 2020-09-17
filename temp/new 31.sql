create procedure sp_cadastra_clientes 
@id numeric(3),
@nome varchar(50),
@sobrenome varchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT id FROM clientes WHERE id = @id)
BEGIN
	INSERT INTO clientes VALUES (@id, @nome, @sobrenome)
END
	ELSE
	BEGIN
		RAISERROR('Usuário já cadastrado', 16,1)
	END
END

EXEC sp_cadastra_clientes 1, 'Leonardo', 'Sousa'



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



begin 
declare @nome varchar(50)
begin
	@nome = exec fn_existe_cliente 2
print @nome
end
end
	


begin
declare
@result varchar(50),
@id numeric(3)
set @id=4
EXECUTE @result = fn_existe_cliente @id
print @result
end


select count(cd_cli), cd_cli from T400CLIE
group by cd_cli
having count(cd_cli)>1


select * from t400feri order by desc_data


insert into t400feri values ('Corpus Christi', '20200611')


begin 
declare 
@var int,
@data date,
@final date
	begin
		set @data = '20200102';
		set @var = 1;
		set @final = dateadd(DAY,@var,@data);
		print @final;
	end
end
