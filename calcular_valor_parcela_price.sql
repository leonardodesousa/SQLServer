Declare @Valor as Numeric(10,4)
Declare @Taxa as Numeric(10,5) --
Declare @Periodo as int
Declare @Prest as Numeric(10,4)

Set @Valor = 30000
Set @Taxa = 10 * 0.01
Set @Periodo = 12

set @Prest = @Valor * ((POWER((1+@Taxa),@Periodo)*@Taxa) / (POWER((1 + @Taxa),@Periodo)-1))
print @Prest
