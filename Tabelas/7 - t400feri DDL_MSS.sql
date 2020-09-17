create table t400feri 
(
desc_feriado varchar(50)not null,
desc_data date not null
);

create index IDX_FERI 
       on t400feri (desc_feriado, desc_data);
