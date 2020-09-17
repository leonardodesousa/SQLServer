-- Create table
create table T402SIMU
(
  cd_cli      NUMERIC(5) not null,
  cd_emp      NUMERIC(3) not null,
  cd_und      NUMERIC(3) not null,
  dt_sml      DATE not null,
  nr_prc      NUMERIC(3) not null,
  nr_ctr      NUMERIC(10) not null,
  nr_cic      VARCHAR(14) not null,
  tx_jur      NUMERIC(15,4),
  vr_jur      NUMERIC(15,2),
  vr_prc      NUMERIC(15,2) not null,
  vr_iof      NUMERIC(15,2),
  vr_tot_prc  NUMERIC(15,2) not null,
  dt_venc     DATE,
  id_sit_parc VARCHAR(2),
  dt_pgto     DATE,
  vr_pgo      NUMERIC(15,2)
);

-- Create/Recreate indexes 
alter table t402simu 
  add constraint pk_simu primary key(CD_CLI, NR_CTR, cd_und, cd_emp, nr_prc);
alter table t402simu 
  add constraint fk_simu_oper foreign key (CD_CLI, cd_emp, CD_UND, NR_CTR ) references t402oper(CD_CLI, CD_EMP, CD_UND, NR_CTR);
  
 




