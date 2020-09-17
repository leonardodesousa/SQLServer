select * from t402oper 



PRINT 
    SELECT SUM(vr_jur) FROM t402oper


Declare @SumVal decimal(15,2);
Select @SumVal=Sum(vr_jur) From t402oper;
Print @SumVal;

BEGIN 
	SET dateformat 'dmy';
DECLARE
	@@data date;
	select @@data=CAST (GETDATE() AS date3);
	print @@data;
END;

select @@VERSION



CAST ( expression AS data_type [ ( length ) ] )  

SELECT CAST(GETDATE() AS char);

select 


