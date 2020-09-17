-- Create table
create table T402CPLT
(
  LOTE        NUMERIC(5) not null,
  CONTRATO    NUMERIC(5) not null,
  CLIENTE    NUMERIC(5) not null, 
 TIPO_LOTE     VARCHAR(3) not null,  
  VALOR       NUMERIC(15,2),  
  ITF_ORIGEM    VARCHAR(20)  
  
);

  
alter table T402CPLT
  add constraint pk_cplt primary key (LOTE, CONTRATO, CLIENTE);
  
alter table T402CPLT
  add check (TIPO_LOTE in ('LIQ','RNG','EFT'));
  
alter table T402CPLT
  add constraint fk_cplt_lote foreign key (LOTE, CONTRATO, CLIENTE) references t402lote(LOTE, CONTRATO, CLIENTE);
  


  

 