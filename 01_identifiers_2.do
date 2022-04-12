*! Version 1.0 Sékou KONE 		 09Sep2019

/* This file set the communes identifiers, 
   mainly for the 140 fist-phase communes. */ 
   
clear
version 13
set more off
*	global posterdir "C:\Users\850\Desktop\DIME-infographics" 
*	cd "$posterdir" 
set more off 

*============= Correction of identifers in 2018 merged data ===================*

use "${final}/merged_${year}.dta", clear 


*--- Correction of identifers' name for scores calculation and posters generation 

replace region = "CENTRE-SUD" 	if commune == "BINDE" & region == "" 
replace province = "ZOUNDWEOGO" if commune == "BINDE" & province == "" 

replace region = "CENTRE-EST" 	if commune == "ZOAGA" & region == "" 
replace province = "BOULGOU" 	if commune == "ZOAGA" & province == "" 

replace region = "SAHEL" 		if commune == "OURSI" & region == "" 
replace province = "OUDALAN" 	if commune == "OURSI" & province == "" 

replace commune = "GARANGO" 	if commune == "GARANGO" & (commune == "BOUSSOUMA" | commune == "BOUSSOUMA GARANGO") 

replace region = "CENTRE-EST" 		if region == "CENTRE_EST"  | region == "CENTRE EST" 
replace region = "CENTRE-NORD" 		if region == "CENTRE_NORD" | region == "CENTRE NORD" 
replace region = "CENTRE-SUD" 		if region == "CENTRE_SUD"  | region == "CENTRE SUD" 
replace region = "PLATEAU CENTRAL"  if region == "PLATEAU_CENTRAL" 

replace commune = "SOUBAKANIEDOUGOU" 	if region == "CASCADES" 	& commune == "SOUBAKANIE-DOUGOU" 

replace commune = "BOUSSOUMA GARANGO" 	if region == "CENTRE-EST" 	& commune == "BOUSSOUMA" 
replace commune = "NIAOGHO" 			if region == "CENTRE-EST" 	& commune == "NIAOGO" 
replace commune = "COMIN-YANGA" 		if region == "CENTRE-EST" 	& (commune == "COMIN YANGA" | commune == "COMIN_YANGA") 
replace commune = "SANGHA" 				if region == "CENTRE-EST" 	& commune == "SANGA" 

replace commune = "BOUSSOUMA KAYA" 		if region == "CENTRE-NORD" 	& commune == "BOUSSOUMA" 
replace commune = "NAMISSIGUIMA" 		if (commune == "NAMISSIGMA" | commune == "NAMISSIGUIMA_KAYA" | commune == "NAMISSIGUIMA KAYA") /// 
											& region == "CENTRE-NORD" 

replace commune = "OURGOU-MANEGA" 		if region == "PLATEAU CENTRAL" & (commune == "OURGOU MANEGA" | commune == "OURGOU_MANEGA") 


replace commune = "GOROM-GOROM" 	if region == "SAHEL" 			& (commune == "GOROM_GOROM" | commune == "GOROM -GOROM") 
replace commune = "TIN-AKOFF" 		if region == "SAHEL" 			& (commune == "TIN AKOFF" 	| commune == "TIN_AKOFF") 
replace commune = "GORGADJI" 		if region == "SAHEL" 			& (commune == "GORGADJI " 	| commune == " GORGADJI") 
replace commune = "SAMPELGA" 		if region == "SAHEL" 			& (commune == "SAMPELGA " 	| commune == " SAMPELGA") 
replace commune = "SEYTENGA" 		if region == "SAHEL" 			& (commune == "SEYTENGA " 	| commune == " SEYTENGA") 
replace commune = "POBE-MENGAO" 	if region == "SAHEL" 			& (commune == "POBE MENGAO" | commune == "POBE_MENGAO") 
replace commune = "NOBERE" 			if region == "CENTRE-SUD" 		&  commune == "NOBÉRÉ" 
replace commune = "ZINIARE" 		if region == "PLATEAU CENTRAL" 	&  commune == "ZINIARÉ" 


*--- Correction of identifers' name for merging data over years (2014, 2015, 2016 and 2017)  

capture drop commune_edited 
gen commune_edited = commune 
order commune_edited, after(commune) 

replace commune_edited = "SOUBAKANIE-DOUGOU" 	if region == "CASCADES" 		&  commune_edited == "SOUBAKANIEDOUGOU" 
replace commune_edited = "BOUSSOUMA" 			if region == "CENTRE-EST" 		&  commune_edited == "BOUSSOUMA GARANGO" 
replace commune_edited = "BOUSSOUMA" 			if region == "CENTRE-NORD" 		&  commune_edited == "BOUSSOUMA KAYA" 
replace commune_edited = "GOROM -GOROM" 		if region == "SAHEL" 			& (commune_edited == "GOROM_GOROM" | commune_edited == "GOROM-GOROM") 


save "${final}/merged_${year}.dta", replace 
save "${final}/merged.dta", replace 

