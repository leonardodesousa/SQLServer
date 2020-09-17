-- Create table
create table T400CLIE
(
  cd_cli     NUMERIC(5) not null,
  cd_emp     NUMERIC(3)not null, 
  cd_und     NUMERIC(3) not null, 
  nm_cli     VARCHAR(70) not null,
  email      VARCHAR(50),
  id_sit     CHAR(1) not null,
  dt_cad     DATETIME not null,
  dt_ult_atu DATETIME not null,
  nr_cic     VARCHAR(14) not null,
  id_tp_pes  VARCHAR(1) not null  
);


-- Create/Recreate primary, unique and foreign key constraints 
alter table T400CLIE
  add constraint pk_clie primary key (CD_CLI, CD_UND, CD_EMP);
  
-- Create/Recreate check constraints 
alter table T400CLIE
  add check (id_tp_pes in ('F','J'));

