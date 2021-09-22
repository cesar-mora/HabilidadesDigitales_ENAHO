/*
Actualizado al: 16/09/21

Dofile - Indicadores de habilidades digitales con ENAHO

Este dofile calcula algunos indicadores de habilidades digitales usando el 
modulo 300 de la ENAHO 2019, para obtener gráficos de utilidad
*/

clear
global enaho19 cd "F:\Laptop2016\Bases\ENAHO\2019"
global enaho20 cd "F:\Laptop2016\Bases\ENAHO\2020\Bases"
global output cd "D:\Trabajo\Consultoria\USE_MINEDU\Set-Nov21\Set-Habilidades digitales\Proyecto_ENAHO\Bases_output"
global graph cd "D:\Trabajo\Consultoria\USE_MINEDU\Set-Nov21\Set-Habilidades digitales\Proyecto_ENAHO\Graficos"


***************************
* ENAHO 2019 - Modulo 300 *
***************************

/*
$enaho19
use ubigeo dominio estrato p208a p308a p314a p314b1_1- p314b1_9 p316_1- p316_8 p316_12 p316b- p316c9 factor07 using "enaho01a-2019-300.dta",clear
keep if p208a>=6 & p208a<=25

foreach x of varlist p314a p316_1-p316c9{
replace `x'=0 if `x'==2
}

rename (p308a p314a p314b1_1-p314b1_9 p316_1- p316_12 p316b p316c1- p316c9 p208a) (nivel_matriculado uso_internet int_compu int_laptop int_tablet int_otro int_celularnodatos int_celulardatos i_info i_mail i_comprar i_banca i_educ i_interact i_entreten i_vender i_descarga uso_dispositivo copiar_archivo copiar_pegar enviar_mails usar_formulas instalar software crear_ppt transferir_archivos programar edad)

foreach x of varlist int_laptop-int_celulardatos{
replace `x'=1 if `x'>=2 & `x'!=.
}
* Regiones:
gen departamento=substr(ubigeo,1,2)
gen provincia=substr(ubigeo,3,2)
destring departamento provincia, replace
order departamento provincia,after(ubigeo)
replace departamento=26 if dominio==8

#delimit ;
label define dpto
1 "Amazonas"
2 "Ancash"
3 "Apurímac"
4 "Arequipa"
5 "Ayacucho"
6 "Cajamarca"
7 "Callao"
8 "Cusco"
9 "Huancavelica"
10 "Huánuco"
11 "Ica"
12 "Junín"
13 "La Libertad"
14 "Lambayeque"
15 "Lima Provincias"
16 "Loreto"
17 "Madre de Dios"
18 "Moquegua"
19 "Pasco"
20 "Piura"
21 "Puno"
22 "San Martín"
23 "Tacna"
24 "Tumbes"
25 "Ucayali" 
26 "Lima Metropolitana y Callao" ;
#delimit cr
label values departamento  dpto

* Indicadores
gen grupo_edad=1 if edad>=6 & edad<14
replace grupo_edad=2 if edad>=14 & edad<=19
replace grupo_edad=3 if edad>=20 & edad<=25

* Etiquetas
label var grupo_edad "Grupos de edad"
label define grupo_edad 1 "6-13 años" 2 "14-19 años" 3 "20-25 años"
label values grupo_edad grupo_edad
tab grupo_edad,gen(grupo_edad)

$output
save "resumen_habdig_2019.dta",replace
*/

********************************
* Graficos por grupos de edad **
********************************

$output
use "resumen_habdig_2019.dta",clear

* Información sobre uso de Internet: uso; dispositivo usado; objetivo del uso
collapse (mean) uso_internet int_compu int_laptop int_tablet int_otro int_celularnodatos int_celulardatos i_info- i_descarga uso_dispositivo-programar [iw=factor07],by(grupo_edad)
foreach x of varlist uso_internet- programar{
replace `x'=`x'*100
}

tab grupo_edad uso_internet

** Grafico 1: Uso de internet y dispositivos **
preserve
keep grupo_edad uso_internet- int_celulardatos
rename (uso_internet- int_celulardatos) (inte1 inte2 inte3 inte4 inte5 inte6 inte7)
reshape long inte, i(grupo_edad)
rename _j internet
label define internet 1 "Usó Internet" 2 "Computadora" 3 "Laptop" 4 "Tablet" 5 "Otros" 6 "Celu-No Plan" 7 "Celu-Plan" 
label values internet internet

* Graficando
keep if internet>=2
$graph
graph hbar (asis) inte, ///
over(internet,sort(inte) label(labsize(small))) by(grupo_edad, title("Dispositivo usado para acceder a Internet",size(medium)) note("Fuente: Encuesta Nacional de Hogares 2019",size(vsmall))) ///
blabel(bar, position(inside) format(%2.1f) color(white) size(vsmall)) ytitle("") ylabel(#8,labsize(2))
graph export "acceso_internet_2019.png", width (1000)replace
restore


** Grafico 2: Motivo de uso de internet **
preserve
keep grupo_edad i_info- i_descarga
rename (i_info- i_descarga) (i_1 i_2 i_3 i_4 i_5 i_6 i_7 i_8 i_9)
reshape long i_, i(grupo_edad)
rename _j usodeinternet
label define usodeinternet 1 "Buscar información" 2 "Comunicarse(mail,redes sociales)" 3 "Compras" 4 "Banca"5 "Fines educativos" 6 "Interacción con entidades" 7 "Entretenimiento" 8 "Ventas" 9 "Gestionar software"
label values usodeinternet usodeinternet

* Graficando
$graph
graph hbar (asis) i_, ///
over(usodeinternet,sort(i_) label(labsize(small))) by(grupo_edad, title("Motivo para acceder a Internet",size(medium)) note("Fuente: Encuesta Nacional de Hogares 2019",size(vsmall))) ///
blabel(bar, position(inside) format(%2.1f) color(white) size(vsmall)) ytitle("") ylabel(#8,labsize(2))
graph export "motivo_acceso_internet_2019.png", width (1000)replace
restore


** Grafico 3: Habilidades digitales **
tab grupo_edad uso_dispositivo

preserve
drop if grupo_edad==1
rename (copiar_archivo-programar) (hab1 hab2 hab3 hab4 hab5 hab6 hab7 hab8 hab9)
reshape long hab,i(grupo_edad)
rename _j habilidad 
label define habilidad 1 "Copiar/mover archivos" 2 "Usar función copiar/pegar" 3 "Enviar emails con adjuntos" 4 "Usar fórmulas básicas en Excel" 5 "Conectar Hardware" 6 "Instalar/configurar Software" 7 "Crear presentaciones" 8 "Transferir archivos entre equipos" 9 "Programar"
label values habilidad habilidad


* Graficando
$graph
graph hbar (asis) hab, ///
over(habilidad,sort(hab) label(labsize(small))) by(grupo_edad, title("Habilidades digitales de personas que usan dispositivos tecnológicos",size(medium)) note("Fuente: Encuesta Nacional de Hogares 2019",size(vsmall))) ///
blabel(bar, position(inside) format(%2.1f) color(white) size(vsmall)) ytitle("") ylabel(#8,labsize(2))
graph export "habilidades_digitales_2019.png", width (1000)replace
restore



