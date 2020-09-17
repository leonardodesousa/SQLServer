-- Create table
create table T402CONT
(
  cd_cli      NUMERIC(5) not null,
  cd_emp      NUMERIC(3) not null,
  cd_und    NUMERIC(3) not null,
  dt_sml      DATE not null,
  nr_prc      NUMERIC(3) not null,
  nr_ctr      NUMERIC(10) not null,
  nr_cic      VARCHAR(14) not null,
  tx_jur      NUMERIC(15,4),
  vr_jur      NUMERIC(15,2),
  vr_prc      NUMERIC(15,2) not null,
  vr_tot_prc  NUMERIC(15,2) not null,
  dt_venc     DATE not null,
  id_sit_parc VARCHAR(2) not null,
  dt_pgto     DATE,
  vr_pgo      NUMERIC(15,2),
  vr_dsc      NUMERIC(15,2),
  VR_JUR_PGO  NUMERIC(15,2),
  id_lot      CHAR,
  nr_nos_nr   numeric(15)
);


-- Create/Recreate primary, unique and foreign key constraints 
alter table T402CONT
  add constraint pk_cont primary key (cd_cli, cd_emp, cd_und ,nr_ctr, nr_prc);

alter table T402CONT
  add constraint fk_cont_oper foreign key (cd_cli, cd_emp, cd_und ,nr_ctr) references t402oper(cd_cli, cd_emp, cd_und ,nr_ctr);
  

 

