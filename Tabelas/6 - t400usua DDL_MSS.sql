-- Create table
create table T400USUA
(
  cd_func    NUMERIC(4) not null,
  nm_func    VARCHAR(50) not null,
  de_login   VARCHAR(25) not null,
  de_senha   VARCHAR(32) not null,
  senha_md5  VARCHAR(32) not null,
  id_sit     CHAR(1) default 'I',
  dt_criacao DATETIME,
  dt_ult_atu DATETIME,
  dt_vl      NUMERIC
);


-- Create/Recreate primary, unique and foreign key constraints 
alter table T400USUA
  add constraint pk_usua primary key (CD_FUNC, de_login);

