-- Create table
create table T400ENDE
(
  cd_cli     NUMERIC(5) not null,
  cd_emp     NUMERIC(3) not null,
  cd_und     NUMERIC(3) not null,
  nm_rua     VARCHAR(50) not null,
  id_num     NUMERIC(6) not null,
  id_compl   VARCHAR(50),
  nm_bair    VARCHAR(100),
  nm_cdd     VARCHAR(25),
  sg_est     VARCHAR(2),
  cep        VARCHAR(10),
  ddd        NUMERIC(3),
  nm_tel     VARCHAR(20),
  nm_rua2    VARCHAR(50),
  id_num2    NUMERIC(6),
  id_compl2  VARCHAR(50),
  nm_bair2   VARCHAR(20),
  nm_cdd2    VARCHAR(20),
  sg_est2    VARCHAR(2),
  cep2       NUMERIC(10),
  ddd2       NUMERIC(3),
  nm_tel2    VARCHAR(20),
  dt_cad     DATETIME not null,
  dt_ult_atu DATETIME
);


-- Create/Recreate primary, unique and foreign key constraints 
alter table T400ENDE
  add constraint pk_ende primary key (CD_CLI, CD_UND, cd_emp);
  
alter table T400ENDE 
  add constraint fk_ende_clie foreign key (cd_cli, cd_und, cd_emp) references t400clie(cd_cli, cd_und, cd_emp);
