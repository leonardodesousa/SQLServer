-- Create table
create table T402LOTE
(
  LOTE         NUMERIC(5) not null,
  CONTRATO     NUMERIC(5) not null,
  CLIENTE      NUMERIC(5) not null,
  PARCELA      NUMERIC(3) not null,
  DESCONTO     NUMERIC(15,2),
  VALOR        NUMERIC(15,2),
  TIPO_LOTE    VARCHAR(3),
  ITF_ORIGEM   VARCHAR(20),
  NR_SEQ       NUMERIC(3),
  ID_SIT_LOT   VARCHAR(3),
  DH_ATU       DATE,
  NOSSO_NUMERO NUMERIC(15)
  
);
  
alter table T402LOTE
	add constraint pk_LOTE primary key (LOTE, CONTRATO, CLIENTE, PARCELA);
  
alter table T402LOTE
	add check (TIPO_LOTE in ('LIQ','RNG','EFT'));
	

 