
create procedure sp_cadastra_clientes
@id numeric(3),
@nome varchar(50),
@sobrenome varchar(50)
as
begin
if not exists (select 1 from clientes where id = @id)	
	insert into clientes values (@id, @nome, @sobrenome);	
end
else
begin
RAISEERROR (15600, 16, 1,'Id já utilizado');
end


else
begin transaction
insert into clientes values (@id, @nome, @sobrenome);
commit

exec pr_cadastra_clientes @id = 3, @nome = 'Rafaela', @sobrenome = 'Soares';

select * from clientes


RAISERROR (15600,-1,-1, 'mysp_CreateCustomer'); 