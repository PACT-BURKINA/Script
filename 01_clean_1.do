*! Version 1.7 Sékou KONE 		 09Sep2019
*! Version 1.6 Sékou KONE 		 23Sep2018
*! Version 1.4 Christopher Boyer 23nov2016
*! Version 1.0 Christopher Boyer 01aug2016

/* This file cleans raw indicator csv-files 
   for two infographic posters summarizing the 
   performance of 349 municipal governments in 
   Burkina Faso. */ 
   
clear
version 13
set more off
*global SUPERMUN_CLEAN_2018 "C:/Users/850/Dropbox/Burkina PACT/2. PACT Phase 2/06. SUPERMUN/07. Data collection/2019/4. Data/Cleaning" 
*	cd "$SUPERMUN_CLEAN_2018" 
set more off

/* =================================================== 
   =================== Identifiers =================== 
   =================================================== */

* Raw data files
local f1 `""CEB""'
local f2 `""Directeur Ecole""'
local f3 `""Directeur Formation Sanitaire""'
local f4 `""District Sanitaire""'
local f5 `""Municipalite""'
local f6 `""Access Potable Water""'

local filenames `"`f1' `f2' `f3' `f4' `f5' `f6'"'

* Unique id list
local id1 `""commune""'
local id2 `""commune school school_autre""'
local id3 `""commune formation_sanitaire formation_sanitaire_autre""'
local id4 `""commune""'
local id5 `""commune""'

local ids `"`id1' `id2' `id3' `id4' `id5'"'
local repfiles ""
local filenames2 ""


* Loop through files again and standardize for merging
foreach file of local filenames {
	
	* Display progress
	display "   "
	display "--------"
	display "${interm}/`file'.dta"
	
	* Load data set
	use "${interm}/`file'.dta", clear
	
	* Fix inconsistencies in the way communes qnd regions are named across data sets 
	
	replace region = "BOUCLE DU MOUHOUN" if region == "BOUCLE_DU_MOUHOUN" 
	replace region = "CENTRE-EST" 		 if region == "CENTRE_EST" 
	replace region = "CENTRE-NORD" 		 if region == "CENTRE_NORD" 
	replace region = "CENTRE-OUEST" 	 if region == "CENTRE_OUEST" 
	replace region = "CENTRE-SUD" 		 if region == "CENTRE_SUD" 
	replace region = "HAUTS-BASSINS" 	 if region == "HAUTS_BASSINS" 
	replace region = "PLATEAU CENTRAL" 	 if region == "PLATEAU_CENTRAL" 
	replace region = "SUD-OUEST" 		 if region == "SUD_OUEST" 
	

	replace commune = subinstr(commune, "-", "_", .) 
	
	* BOUCLE DU MOUHOUN 
	replace commune = "BOMBOROKUY" 	if commune == "BOMBORO_KUY" 
	replace commune = "BONDOKUY" 	if commune == "BONDOUKUY" 
	replace commune = "KOMBORI" 	if commune == "KOMBORI_KOURA" 
	replace commune = "POMPOI" 		if commune == "POMPOIE" 
	replace commune = "SIBY" 		if commune == "SIBI" 
	* CASCADES 
	replace commune = "WOLONKOTO" 	if commune == "WOLOKONTO" 
	* CENTRE 
	replace commune = "KOMKI-IPALA" 	 if commune == "KOMKI_IPALA" 
	replace commune = "TANGHIN-DASSOURI" if commune == "TANGHIN_DASSOURI" 
	* CENTRE-EST 
	replace commune = "BAGRE" 			  if commune == "BAGRE (TENKODOGO)" 
	replace commune = "BOUSSOUMA_GARANGO" if commune == "BOUSSOUMA" & region == "CENTRE-EST" 
	replace commune = "BOUSSOUMA GARANGO" if commune == "BOUSSOUMA_GARANGO" 
	replace commune = "COMIN-YANGA" 	  if commune == "COMIN_YANGA" | commune == "COMIN YANGA" 
	replace commune = "NIAOGHO" 		  if commune == "NIAOGO" 
	replace commune = "SANGHA" 			  if commune == "SANGA" 
	* CENTRE-NORD 
	replace commune = "BOUSSOUMA_KAYA" 		if commune == "BOUSSOUMA" & region == "CENTRE-NORD" 
	replace commune = "BOUSSOUMA KAYA" 		if commune == "BOUSSOUMA_KAYA" 
	replace commune = "NAMISSIGUIMA" 		if (commune == "NAMISSIGMA" | commune == "NAMISSIGUIMA_KAYA") /// 
												& region == "CENTRE-NORD" 
	replace commune = "ZIMTANGA" 			if commune == "ZIMTENGA" 
	* CENTRE-SUD 
	replace commune = "NOBERE" 		  		if commune == "NOBÉRÉ" 
	replace commune = "GOMBOUSSOUGOU" 		if commune == "GOMBOUSGOU" 
	* EST 
	replace commune = "FADA N'GOURMA" 		if commune == "FADA" | commune == "FADA_NGOURMA" 
	* HAUTS-BASSINS 
	replace commune = "KARANKASSO-SAMBLA" 	if commune == "KARANKASSO_SAMBLA" | commune == "KARANGASSO SAMBLA" | commune == "KARANGASSO_SAMBLA"
	replace commune = "KARANKASSO-VIGUE"  	if commune == "KARANKASSO_VIGUE" | commune == "KARANGASSO VIGUE" | commune == "KARANGASSO_VIGUE"
	replace commune = "N'DOROLA"  			if commune == "NDOROLA" 
	* NORD 
	replace commune = "ARBOLE" 					if commune == "ARBOLLE" 
	replace commune = "KOUMBRI" 				if commune == "KOUMBRIï¿½" | commune == "KOUMBRI�" 
	replace commune = "LA-TODIN" 				if commune == "LA_TODIN" | commune == "LATODIN" | commune == "LATODEN" 
	replace commune = "NAMISSIGUIMA_OUAHIGOUYA" if commune == "NAMISSIGUIMA" & region == "NORD" 
	replace commune = "NAMISSIGUIMA OUAHIGOUYA" if commune == "NAMISSIGUIMA_OUAHIGOUYA" 
	* PLATEAU CENTRAL 
	replace commune = "BOUDRY" 			if commune == "BOUDRY_" 
	replace commune = "DAPELOGO" 		if commune == "DAPELGO" 
	replace commune = "OURGOU-MANEGA"   if commune == "OURGOU_MANEGA" | commune == "OURGOU MANEGA" 
	replace commune = "ZINIARE" 		if commune == "ZINIARÉ" 
	* SAHEL 
	replace commune = "ARBINDA" 		if commune == "ARIBINDA" 
	replace commune = "POBE-MENGAO" 	if commune == "POBE_MENGAO" | commune == "POBE MENGAO" | commune == "POBEMENGAO" 
	replace commune = "TIN-AKOFF" 		if commune == "TIN_AKOFF" | commune == "TIN AKOFF" 
	replace commune = "GOROM-GOROM" 	if commune == "GOROM_GOROM" 
	* SUD-OUEST 
	replace commune = "BOUROUM-BOUROUM" if commune == "BOUROUM_BOUROUM" 
	replace commune = "GBOMBLORA" 		if commune == "GOMBLORA" 
	replace commune = "KOPER" 			if commune == "KOPPER" 
	replace commune = "PERIGBAN" 		if commune == "PERIGNAN" 
	replace commune = "SIGLE" 			if commune == "SIGLE_" 

	* Generate index for first phase communes 
	
	cap gen phase = 0 
	replace phase = 1 if /// 
			region == "CASCADES"   | region == "CENTRE-EST" 	 | region == "CENTRE-NORD" | /// 
			region == "CENTRE-SUD" | region == "PLATEAU CENTRAL" | region == "SAHEL" 
	
	label define phase 1 "PACT 1&2" 0 "PACT 2 Only" 
	label values phase phase 


	* Identify the communes with completed data 

	cap gen completed = 1 
	replace completed = 0 if /// 
		commune == "DABLO" 																| /// 	// CENTRE-NORD 		 - 1 
		commune == "BAKATA" 		| commune == "BOUGNOUNOU" 	| commune == "CASSOU" 	| /// 	// CENTRE-OUEST 	 - 6 
		commune == "DALO" 			| commune == "GAO" 			| commune == "SAPOUY" 	| /// 
		commune == "OUINDIGUI" 																	// NORD 			 - 1 


*keep if completed == 1 
label define completed 0 "Uncompleted" 1 "Completed", replace 
label values completed completed 

	* Save stata data set 
	save "${final}/`file'.dta", replace 
} 


/* =================================================== 
   ==================== collapse ===================== 
   =================================================== */ 

   /* This section aggregates the school and gas stock
      data to the commune level */
	  
* 1. Schooling data 
use "${final}/Directeur Ecole.dta", clear 

*gen number_students 					= number_boys + number_girls 

gen sd_a_01water_source_functional 		= water_source_functional 
gen sd_a_02functional_latrines 			= functional_latrine 
gen sd_a_02number_students 				= number_students 
gen sd_a_03year_month_received_schoo 	= year_month_received_school_suppl 
gen sd_a_03week_received_school_supp 	= week_received_school_supplies 

gen sd_a_04cantine_scolaire 			= cantine_scolaire 
gen sd_a_04month_cantine_functional 	= month_cantine_functional 
gen sd_a_04food_supp	 				= food_supplies 
gen sd_a_04food_enough					= food_supplies_enough 

* Calculate indicators to be aggregated 
if ${groupnames} { 
	g functional_latrines 	= (sd_a_02functional_latrines / number_classes) >= 1 
	g latrines 				= (sd_a_02number_students / sd_a_02functional_latrines) <= 40 // Latrines new indicator, according to national standards 
	g functional_water 		= sd_a_01water_source_functional >= 9 
	g supplies_received 	= sd_a_03year_month_received_schoo - /// 
		date("10/01/${year}", "MDY", 2100) + 7 * (sd_a_03week_received_school_supp - 1) 
	g food_enough 			= sd_a_04food_enough >= 9 
} 
else { 
	replace functional_latrines = (functional_latrine / number_classes) >= 1 
	g latrines 					= (number_students / functional_latrine) <= 40 
	g functional_water 			= water_source_functional >= 9 
	g supplies_received 		= date(year_month_received_schoo, "MDY", 2100) - /// 
		date("10/01/${year}", "MDY") + 7 * (week_received_school_supp - 1) 
	g food_enough 				= food_supplies_enough >= 9 
} 

replace supplies_received 	= 0 if supplies_received < 0 | school_supplies == 1 
replace supplies_received 	= 364 if mi(supplies_received) | supplies_received >= 365 | supplies_received <= -200
replace functional_latrine 	= functional_latrines 
replace food_enough 		= 0 if mi(food_supplies_enough) 


* Aggregate schooling data by commune 
collapse (mean) functional_latrine latrines functional_water supplies_received food_enough, by(region province commune) 

save "${final}/Directeur Ecole.dta", replace 


* 2. Gas stock data 
use "${final}/Directeur Formation Sanitaire.dta", clear 

* Aggregate gas stock data by commune 

if !${groupnames} { 
	g sd_a_01stock_gas = stock_gas 
}
if ${year} == 2018 { 
	gen sd2 = sd_a_01stock_gas == 1 
	collapse (mean) sd2, by(region province commune) 
	rename sd2 sd_a_01stock_gas 
}
else {
	collapse (mean) sd_a_01stock_gas, by(region province commune) 
}


save "${final}/Directeur Formation Sanitaire.dta", replace


/* =================================================== 
   ====================== Merge ====================== 
   =================================================== */ 

gettoken file filenames : filenames 
use "${final}/`file'.dta", clear 

foreach file of local filenames { 

	merge 1:1 region commune using "${final}/`file'.dta", force nogen 

	save "${final}/merged.dta", replace 
	
	save "${final}/merged_${year}.dta", replace 
} 
