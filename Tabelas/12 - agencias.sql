-- Create table
create table agencias
(
  empresa                      NUMERIC(3) not null,
  unidade                      NUMERIC(3) not null,
  descricaoAgencia             VARCHAR(100) not null,
  dataUltimoProcessamento      DATE not null,
  dataAtual                    DATE not null,
  dataProximoProcessamento     DATE,
  processsamentoIniciado       NUMERIC(1), 
  inicioProcessamento          DATETIME,
  fimProcessamento             DATETIME,
  usuario                      VARCHAR(50)  
);
  
alter table agencias
	add constraint pk_agencias primary key (empresa, unidade);  


 