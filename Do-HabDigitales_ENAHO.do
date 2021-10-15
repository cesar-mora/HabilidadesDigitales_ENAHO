/*
Actualizado al: 06/10/21

Dofile - Indicadores de habilidades digitales con ENAHO

Este dofile calcula algunos indicadores de habilidades digitales usando el 
modulo 300 de la ENAHO 2017-2020, para obtener gráficos de utilidad
*/

clear
global enaho10 "F:\Laptop2016\Bases\ENAHO\2010\Originales"
global enaho11 "F:\Laptop2016\Bases\ENAHO\2011\Originales"
global enaho12 "F:\Laptop2016\Bases\ENAHO\2012\Originales"
global enaho13 "F:\Laptop2016\Bases\ENAHO\2013\Originales"
global enaho14 "F:\Laptop2016\Bases\ENAHO\2014\Originales"
global enaho15 "F:\Laptop2016\Bases\ENAHO\2015\Originales"
global enaho16 "F:\Laptop2016\Bases\ENAHO\2016\Originales"
global enaho17 "F:\Laptop2016\Bases\ENAHO\2017\Originales"
global enaho18 "F:\Laptop2016\Bases\ENAHO\2018\Originales"
global enaho19 "F:\Laptop2016\Bases\ENAHO\2019\Originales"
global enaho20 "F:\Laptop2016\Bases\ENAHO\2020\Bases"
global output cd "D:\Trabajo\Consultoria\USE_MINEDU\Set-Nov21\Set-Habilidades digitales\Proyecto_ENAHO\Bases_output"
global graph cd "D:\Trabajo\Consultoria\USE_MINEDU\Set-Nov21\Set-Habilidades digitales\Proyecto_ENAHO\Graficos"

* DISPONIBILIDAD:
** Habilidades digitales (uso de computadora, tablet o similar): desde ENAHO 2018
** Uso de Internet (dispositivo usado y motivo): se usará desde ENAHO 2010
**--> Extraer información para estudiantes en general y estudiantes de educación básica

*********************************************************************
* Indicadores de uso de equipos, internet y habilidades digitales** *
*********************************************************************

* Del 2010 al..., solo se preguntaba si se hacia uso de internet, el lugar, y el motivo
* A partir del..., se pregunto por el dispositivo para acceder
* A partir del 2018 se preguntó por las habilidades digitales


/*
* Rutina válida para 2010, 2011, 2012, 2013, 2014 *

foreach y in 10 11 12 13 14{
cd "F:\Laptop2016\Bases\ENAHO\20`y'\Originales"
use ubigeo dominio estrato p208a p308a p314a p314b_1 p314b_3 p314b_4 p314d p316_1 p316_2 p316_3 p316_4 p316_5 p316_6 p316_7 factor07 using "enaho01a-20`y'-300.dta",clear
keep if (p308a<=3 & p308a!=.) & p208a<=25

foreach x of varlist p314a p316_1-p316_7{
replace `x'=0 if `x'>=2 & `x'!=.
}
foreach x of varlist  p314b_1- p314b_4{
replace `x'=1 if `x'>=1 & `x'!=.
}
summarize
rename (p208a p308a p314a p314b_1 p314b_3 p314b_4 p314d p316_1 p316_2 p316_3 p316_4 p316_5 p316_6 p316_7) /*
*/ (edad nivel_asiste uso_internet internet_hogar internet_escuela internet_cabina frecuencia_internet i_info i_mail i_comprar i_banca i_educ i_gestiones i_entreten)

* Otras variables:
gen primaria=(nivel_asiste==1 | nivel_asiste==2)
gen secundaria=(nivel_asiste==3)

gen grupo_edad=1 if edad>=6 & edad<14
replace grupo_edad=2 if edad>=14 & edad<=19
replace grupo_edad=3 if edad>=20 & edad<=25

* Etiquetas
label var grupo_edad "Grupos de edad"
label define grupo_edad 1 "6-13 años" 2 "14-19 años" 3 "20-25 años"
label values grupo_edad grupo_edad
tab grupo_edad,gen(grupo_edad)

gen year=2000+`y'
order year

$output
save "resumen_habdig_20`y'.dta",replace
}

***********************
***********************

* Rutina válida para 2015
foreach y in 15{
cd "F:\Laptop2016\Bases\ENAHO\20`y'\Originales"
use ubigeo dominio estrato p208a p308a p314a p314b_1 p314b_3 p314b_4 p314d p316_1 p316_2 p316_3 p316_4 p316_5 p316_6 p316_7 p316_8 factor07 using "enaho01a-20`y'-300.dta",clear
keep if (p308a<=3 & p308a!=.) & p208a<=25

foreach x of varlist p314a p316_1-p316_8{
replace `x'=0 if `x'>=2 & `x'!=.
}
foreach x of varlist  p314b_1- p314b_4{
replace `x'=1 if `x'>=1 & `x'!=.
}
summarize

rename (p208a p308a p314a p314b_1 p314b_3 p314b_4 p314d p316_1 p316_2 p316_3 p316_4 p316_5 p316_6 p316_7 p316_8) /*
*/ (edad nivel_asiste uso_internet internet_hogar internet_escuela internet_cabina frecuencia_internet i_info i_mail i_comprar i_banca i_educ i_gestiones i_entreten i_vender)

* Otras variables:
gen primaria=(nivel_asiste==1 | nivel_asiste==2)
gen secundaria=(nivel_asiste==3)

gen grupo_edad=1 if edad>=6 & edad<14
replace grupo_edad=2 if edad>=14 & edad<=19
replace grupo_edad=3 if edad>=20 & edad<=25

* Etiquetas
label var grupo_edad "Grupos de edad"
label define grupo_edad 1 "6-13 años" 2 "14-19 años" 3 "20-25 años"
label values grupo_edad grupo_edad
tab grupo_edad,gen(grupo_edad)

gen year=2000+`y'
order year

$output
save "resumen_habdig_20`y'.dta",replace
}

*****************
*****************

* Rutina válida para 2016,2017

foreach y in 16 17{
cd "F:\Laptop2016\Bases\ENAHO\20`y'\Originales"
use ubigeo dominio estrato p208a p308a p314a p314b_1 p314b_3 p314b_4 p314d p314b1_1-p314b1_6 p316_1 p316_2 p316_3 p316_4 p316_5 p316_6 p316_7 p316_8 factor07 using "enaho01a-20`y'-300.dta",clear
keep if (p308a<=3 & p308a!=.) & p208a<=25

foreach x of varlist p314a p316_1-p316_8{
replace `x'=0 if `x'>=2 & `x'!=.
}
foreach x of varlist  p314b_1- p314b_4 p314b1_1- p314b1_6{
replace `x'=1 if `x'>=1 & `x'!=.
}
summarize

rename (p208a p308a p314a p314b_1 p314b_3 p314b_4 p314d p314b1_1-p314b1_6 p316_1 p316_2 p316_3 p316_4 p316_5 p316_6 p316_7 p316_8) /*
*/ (edad nivel_asiste uso_internet internet_hogar internet_escuela internet_cabina frecuencia_internet int_compu int_laptop int_celupropio int_celufamilia int_celutrab int_tablet i_info i_mail i_comprar i_banca i_educ i_gestiones i_entreten i_vender)

* Otras variables:
gen primaria=(nivel_asiste==1 | nivel_asiste==2)
gen secundaria=(nivel_asiste==3)

gen grupo_edad=1 if edad>=6 & edad<14
replace grupo_edad=2 if edad>=14 & edad<=19
replace grupo_edad=3 if edad>=20 & edad<=25

* Etiquetas
label var grupo_edad "Grupos de edad"
label define grupo_edad 1 "6-13 años" 2 "14-19 años" 3 "20-25 años"
label values grupo_edad grupo_edad
tab grupo_edad,gen(grupo_edad)

gen year=2000+`y'
order year

$output
save "resumen_habdig_20`y'.dta",replace
}

******************
******************
* Rutina válida para 2018

foreach y in 18{
cd "F:\Laptop2016\Bases\ENAHO\20`y'\Originales"
use ubigeo dominio estrato p208a p308a p314a p314d p314b_1- p314b_4 p314b1_1- p314b1_6 p316_1- p316_8 p316b p316c1-p316c9 factor07 using "enaho01a-20`y'-300.dta",clear
keep if (p308a<=3 & p308a!=.) & p208a<=25

foreach x of varlist p314a p316_1-p316_8 p316b-p316c9{
replace `x'=0 if `x'>=2 & `x'!=.
}
foreach x of varlist  p314b_1- p314b_4 p314b1_1- p314b1_6{
replace `x'=1 if `x'>=1 & `x'!=.
}
summarize

rename (p308a p314a p314b_1 p314b_3 p314b_4 p314d p314b1_1-p314b1_6 p316_1-p316_8 p316b p316c1- p316c9 p208a) (nivel_asiste uso_internet internet_hogar internet_escuela internet_cabina frecuencia_internet int_compu int_laptop int_celupropio int_celufamilia int_celutrab int_tablet i_info i_mail i_comprar i_banca i_educ i_gestiones i_entreten i_vender uso_dispositivo copiar_archivo copiar_pegar enviar_mails usar_formulas instalar software crear_ppt transferir_archivos programar edad)

* Otras variables:
gen primaria=(nivel_asiste==1 | nivel_asiste==2)
gen secundaria=(nivel_asiste==3)

gen grupo_edad=1 if edad>=6 & edad<14
replace grupo_edad=2 if edad>=14 & edad<=19
replace grupo_edad=3 if edad>=20 & edad<=25

* Etiquetas
label var grupo_edad "Grupos de edad"
label define grupo_edad 1 "6-13 años" 2 "14-19 años" 3 "20-25 años"
label values grupo_edad grupo_edad
tab grupo_edad,gen(grupo_edad)

gen year=2000+`y'
order year
drop p314b_2

$output
save "resumen_habdig_20`y'.dta",replace
}

********************
********************

* Rutina válida para 2019,2020

foreach y in 19 20{
cd "F:\Laptop2016\Bases\ENAHO\20`y'\Originales"
use ubigeo dominio estrato p208a p308a p314a p314d p314b_1 p314b_3 p314b_4 p314b1_1-p314b1_9 p316_1- p316_8 p316b p316c1-p316c9 factor07 using "enaho01a-20`y'-300.dta",clear
keep if (p308a<=3 & p308a!=.) & p208a<=25

foreach x of varlist p314a p316_1-p316_8 p316b-p316c9{
replace `x'=0 if `x'>=2 & `x'!=.
}
foreach x of varlist  p314b_1- p314b_4 p314b1_1- p314b1_9{
replace `x'=1 if `x'>=1 & `x'!=.
}
summarize

rename (p308a p314a p314b_1 p314b_3 p314b_4 p314d p314b1_1 p314b1_2 p314b1_6 p314b1_8 p314b1_9 p316_1-p316_8 p316b p316c1- p316c9 p208a) (nivel_asiste uso_internet internet_hogar internet_escuela internet_cabina frecuencia_internet int_compu int_laptop int_tablet int_celularnodatos int_celulardatos i_info i_mail i_comprar i_banca i_educ i_gestiones i_entreten i_vender uso_dispositivo copiar_archivo copiar_pegar enviar_mails usar_formulas instalar software crear_ppt transferir_archivos programar edad)

* Otras variables:
gen primaria=(nivel_asiste==1 | nivel_asiste==2)
gen secundaria=(nivel_asiste==3)

gen grupo_edad=1 if edad>=6 & edad<14
replace grupo_edad=2 if edad>=14 & edad<=19
replace grupo_edad=3 if edad>=20 & edad<=25

* Etiquetas
label var grupo_edad "Grupos de edad"
label define grupo_edad 1 "6-13 años" 2 "14-19 años" 3 "20-25 años"
label values grupo_edad grupo_edad
tab grupo_edad,gen(grupo_edad)

gen year=2000+`y'
order year
drop p314b1_7

$output
save "resumen_habdig_20`y'.dta",replace
}

*/


********************************
* Uniendo las bases de datos ***
********************************
/*
$output
use "resumen_habdig_2010.dta",clear
forvalues y=11(1)20{
append using "resumen_habdig_20`y'.dta"
}
order i_vender,after(i_entreten)
gen int_celular=0 if int_compu!=.
replace int_celular=1 if (int_celupropio==1 | int_celufamilia==1 | int_celutrab==1 | int_celularnodatos==1 | int_celulardatos==1)
order int_celular,after(int_laptop)
drop int_celupropio int_celufamilia int_celutrab int_celularnodatos int_celulardatos grupo_edad- grupo_edad3

* Grupos de edad:
gen grupo_edad=1 if edad>=3 & edad<14
replace grupo_edad=2 if edad>=14 & edad<=19
replace grupo_edad=3 if edad>=20 & edad<=25
label var grupo_edad "Grupos de edad"
label define grupo_edad 1 "6-13 años" 2 "14-19 años" 3 "20-25 años",modify
label values grupo_edad grupo_edad
tab grupo_edad,gen(grupo_edad)

* Frecuencia de uso de internet:
gen int_una_dia=(frecuencia==1) if frecuencia!=.
gen int_una_semana=(frecuencia==2) if frecuencia!=.

save "resumen_habdig_2010_2020.dta",replace
*/

***********************
* Graficos a generar:

** A) USO DE TICs
*a) Evolucion lineal de uso del Internet: desagregado por primaria y secundaria (2010-2020)
*b) Evolución lineal de uso del internet en escuela y cabina: desagregado por primaria y secundaria (2010-2020)
*c) Evolución de la frecuencia de uso de Internet: desagregado por una vez al día/una vez a la semana
*d) Evolución de motivo para usar Internet: i_info-i_vender: desagregado por nivel (2010-2020)
*e) Evolución de dispositivo para usar Internet: int_compu-int_tablet, desagregado por nivel (2016-2020)

** B) HABILIDADES DIGITALES
*f) Evolución de uso de dispositivos informáticos (2018-2020)
*g) Habilidades digitales: copiar_archivo- programar(2020)

**************************
* Generación de gráficos *
**************************

$output
use "resumen_habdig_2010_2020.dta",clear
drop if nivel_asiste==1
label define nivel_asiste 2 "Primaria" 3 "Secundaria"
label values nivel_asiste nivel_asiste

* Información sobre uso de Internet: uso; dispositivo usado; objetivo del uso
collapse (mean) uso_internet internet_hogar internet_escuela internet_cabina int_una_dia int_una_semana i_info- i_vender int_compu- int_tablet uso_dispositivo copiar_archivo- programar [iw=factor07],by(year nivel_asiste)
foreach x of varlist uso_internet- programar{
replace `x'=`x'*100
}

label var year "Año"
label var uso_internet " "
label var uso_dispositivo " "


$graph
sort nivel_asiste year
*a) Evolucion lineal de uso del Internet: desagregado por primaria y secundaria (2010-2020)
twoway (line uso_internet year if nivel_asiste==2) || (line uso_internet year if nivel_asiste==3), ylabel(0(20)100,angle(horizontal)) legend(label(1 "Primaria") label(2 "Secundaria")) title("% de estudiantes que el mes pasado usó Internet",size(medium)) note("Fuente: Encuesta Nacional de Hogares 2010-20",size(vsmall))
graph export "a_Evolucion_acceso_internet.png", width (1000)replace

*b) Evolución lineal de uso del internet en escuela y cabina: desagregado por primaria y secundaria (2010-2020)
twoway (line internet_hogar internet_escuela internet_cabina year),by(nivel_asiste,title("Acceso a Internet según lugar (%)",size(medium)) note("Fuente: Encuesta Nacional de Hogares 2010-20",size(vsmall))) ylabel(0(20)100,angle(horizontal)) xlabel(2010(2)2020,labsize(small))  legend(label(1 "Hogar") label(2 "Escuela") label(3 "Cabina"))  
graph export "b_Lugar_acceso_internet.png", width (1000)replace

*c) Evolución de la frecuencia de uso de Internet: desagregado por una vez al día/una vez a la semana
twoway (line int_una_dia int_una_semana year),by(nivel_asiste,title("Frecuencia de acceso a Internet (%)",size(medium)) note("Fuente: Encuesta Nacional de Hogares 2010-20",size(vsmall))) ylabel(0(20)100,angle(horizontal)) xlabel(2010(2)2020,labsize(small))  legend(label(1 "Al menos una vez al día") label(2 "Al menos una vez a la semana") rows(2) size(small))  
graph export "c_Frecuencia_acceso_internet.png", width (1000)replace

*d) Evolución de motivo para usar Internet: i_info-i_vender: desagregado por nivel (2010-2020)
twoway (line i_info i_mail i_educ i_entreten year),by(nivel_asiste,title("Motivo para usar Internet (%)",size(medium)) note("Fuente: Encuesta Nacional de Hogares 2010-20",size(vsmall))) ylabel(0(20)100,angle(horizontal)) xlabel(2010(2)2020,labsize(small))  legend(label(1 "Obtener información") label(2 "Comunicarse") label (3 "Act. educativas") label (4 "Entretenimiento") rows(2) size(small))  
graph export "d_Motivo_acceso_internet.png", width (1000)replace


keep if year>=2016

*e) Evolución de dispositivo para usar Internet: int_compu-int_tablet, desagregado por nivel (2016-2020)
twoway (line int_compu int_laptop int_celular int_tablet year),by(nivel_asiste,title("Dispositivo para acceder a Internet (%)",size(medium)) note("Fuente: Encuesta Nacional de Hogares 2016-20",size(vsmall))) ylabel(0(20)100,angle(horizontal)) xlabel(2016(1)2020,labsize(small))  legend(label(1 "Computadora") label(2 "Laptop") label(3 "Celular") label(4 "Tablet"))  
graph export "e_Dispositivo_acceso_internet.png", width (1000)replace

keep if year>=2018
keep if nivel_asiste==3

** B) HABILIDADES DIGITALES

*f) Evolución de uso de dispositivos informáticos: desagregado por nivel (2018-2020)
line uso_dispositivo year, ylabel(0(20)100,angle(horizontal)) xlabel(2018(1)2020) title("% de estudiantes de Secundaria que usaron PC, laptop, tablet o similar",size(medium)) note("Fuente: Encuesta Nacional de Hogares 2018-20",size(vsmall))
graph export "f_Evolucion_uso_dispositivo.png", width (1000)replace

keep if year>=2020

*g) Habilidades digitales: copiar_archivo- programar, desagregado por nivel (2020)
keep year copiar_archivo- programar
rename (copiar_archivo-programar) (hab1 hab2 hab3 hab4 hab5 hab6 hab7 hab8 hab9)
reshape long hab,i(year)
rename _j habilidad 
label define habilidad 1 "Copiar/mover archivos" 2 "Usar función copiar/pegar" 3 "Enviar emails con adjuntos" 4 "Usar fórmulas básicas en Excel" 5 "Conectar Hardware" 6 "Instalar/configurar Software" 7 "Crear presentaciones" 8 "Transferir archivos entre equipos" 9 "Programar"
label values habilidad habilidad

$graph
graph hbar (asis) hab, ///
over(habilidad,sort(hab) label(labsize(vsmall))) title("Hab. digitales de estudiantes de secundaria que usan dispositivos tecnológicos (%)",size(small)) note("Fuente: Encuesta Nacional de Hogares 2020",size(vsmall)) blabel(bar, position(inside) format(%2.1f) color(white) size(vsmall)) ytitle("") ylabel(#8,labsize(2))
graph export "g_habilidades_digitales.png", width (1000)replace

********************************************
********************************************
********************************************
********************************************
********************************************
********************************************

****************************
* Información del año 2019 *
****************************

/*
Esta sección permitirá generar los gráficos para el informe de 
centros comunitarios digitales, usando la encuesta del año 2019, 
al ser la última disponible, y no afectada por el retroceso de la Pandemia.

La información de interés es :
Figura X1: Acceso a Internet
- En estudiantes de educación básica regular (según dispositivo móvil/no móvil) por región
- En población adulta menor de 65 años (según dispositivo móvil/no móvil) por región

Figura X2: Uso de herramientas como laptops/pcs
- Población general de 14 a 65 años, por region

Figura X3: Tasa de autoempleo (trabajador independiente) como % de la PEA
- Figura a nivel regional

Figura X4: % de jóvenes menores de 25 años que no estudia ni trabaja (nini) o en situación de desempleo
- A nivel regional
*/

*******************************
* ENAHO 2019 - Modulo 300+500 *
*******************************
cd $enaho19
use ubigeo dominio estrato conglome vivienda hogar codperso p208a p306 p307 p308a p314a p314b_1-p314b_7 p314b1_1-p314b1_9 p316b factor07 using "enaho01a-2019-300.dta",clear
merge 1:1 conglome vivienda hogar codperso using "enaho01a-2019-500.dta",keepusing(ocu500 p504 p507 fac500a)

save..

***************************
* ENAHO 2019 - Modulo 500 *
***************************

use ubigeo dominio estrato p208a  using "enaho01a-2019-300.dta",clear






***************************
* ENAHO 2019 - Modulo 300 *
***************************
/*
$enaho19
use ubigeo dominio estrato p208a p308a p314a p314b1_1- p314b1_9 p316_1- p316_8 p316b p316c1-p316c9 factor07 using "enaho01a-2019-300.dta",clear
keep if p208a>=6 & p208a<=25

foreach x of varlist p314a p316_1-p316c9{
replace `x'=0 if `x'==2
}

rename (p308a p314a p314b1_1-p314b1_9 p316_1-p316_8 p316b p316c1- p316c9 p208a) (nivel_matriculado uso_internet int_compu int_laptop int_tablet int_otro int_celularnodatos int_celulardatos i_info i_mail i_comprar i_banca i_educ i_interact i_entreten i_vender uso_dispositivo copiar_archivo copiar_pegar enviar_mails usar_formulas instalar software crear_ppt transferir_archivos programar edad)

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



