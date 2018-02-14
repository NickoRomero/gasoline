clear all

forvalues i=1/20{
	forvalues j=1/7{
		forvalues k=1/12{
			import excel using "D:\Borrador Gasolina\Estación - Mes\Excel\\`i'\\`i'-`j'-`k'.xls", sheet("CONSULTA-PRECIO") 
			drop in 1/3
			export delimited using "D:\Borrador Gasolina\Estación - Mes\CSV_a\\`i'-`j'-`k'.csv", novarnames replace
			unicode convertfile "D:\Borrador Gasolina\Estación - Mes\CSV_a\\`i'-`j'-`k'.csv" "D:\Borrador Gasolina\Estación - Mes\CSV\\`i'-`j'-`k'.csv", dstencoding(Windows-1252) replace
			clear all
		}
	}
}

forvalues i=1/20{
	import excel "D:\Borrador Gasolina\Estación - Mes\Excel\\`i'\\`i'-8-1.xls", sheet("CONSULTA-PRECIO")
	drop in 1/3
	export delimited using "D:\Borrador Gasolina\Estación - Mes\CSV_a\\`i'-8-1.csv", novarnames replace
	unicode convertfile "D:\Borrador Gasolina\Estación - Mes\CSV_a\\`i'-8-1.csv" "D:\Borrador Gasolina\Estación - Mes\CSV\\`i'-8-1.csv", dstencoding(Windows-1252) replace
	clear all
}

