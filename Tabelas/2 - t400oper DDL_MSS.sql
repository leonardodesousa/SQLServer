
create table T402OPER
(
  cd_cli   NUMERIC(5) not null,
  cd_emp   NUMERIC(3) not null,
  cd_und   NUMERIC(3) not null, 
  nm_cli   VARCHAR(70) not null,
  dt_inc   DATE not null,
  qt_amo   NUMERIC(3) not null,
  nr_ctr   NUMERIC(10) not null,
  nr_cic   VARCHAR(14) not null,
  tx_jur   NUMERIC(15,5),
  vr_jur   NUMERIC(15,2),
  carencia NUMERIC(1),
  vl_ori   NUMERIC(15,2) not null,
  vl_liq   NUMERIC(15,2) not null,
  id_st    VARCHAR(2),
  dt_eft   DATE
);

-- Create/Recreate primary, unique and foreign key constraints 
alter table T402OPER
  add constraint pk_oper primary key (cd_cli, cd_emp, cd_und, nr_ctr);

  
 


