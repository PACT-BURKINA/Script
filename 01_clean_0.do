/*================================ 2018 ================================= 
 ========================================================================*/

*global SUPERMUN_CLEAN_2018 "C:\Users\850\Dropbox\Burkina PACT\2. PACT Phase 2\06. SUPERMUN\07. Data collection\2019\4. Data\Cleaning" 
*cd "$SUPERMUN_CLEAN_2018" 

version 13 
set seed 32674	// <- generated on Random.org at Timestamp: 2019-07-17 16:33:29 UTC 

*===============================================================================
*======================================= CEB ===================================
*=============================================================================== 

clear all 
use "${raw}/CEB ${year}_WIDE.dta", clear 				  			 			// Save the temporary data 


*----------- BOUCLE DU MOUHOUN ------------ 
*------------------------------------------ 

*--- Questionnaire for the commune of KOUGNY sent twice 
	// Just drop one 
br if commune == "KOUGNY" 
drop if key == "uuid:be71e58e-4ab1-4a3b-9920-51b7eb073f77" 


*----------- CASCADES ------------ 
*--------------------------------- 


*----------- CENTRE-EST ---------- 
*--------------------------------- 

*--- Questionnaire for the commune of ZABRE sent twice 
	// The one with key = uuid:a7c0c6bb-e176-41d2-96de-2bdb7c869435 should be drop 
br if commune == "ZABRE" 
drop if key == "uuid:a7c0c6bb-e176-41d2-96de-2bdb7c869435" 

*--- Questionnaire for the commune of COMIN-YANGA sent twice 
	// Just drop one 
br if commune == "COMIN_YANGA" 
drop if key == "uuid:ef156ed3-b0cd-4ead-a937-03f90e5637b2" 


*----------- CENTRE-NORD --------- 
*--------------------------------- 

*--- Questionnaire for the commune of BOULSA sent twice 
	// Just drop one 
br if commune == "BOULSA" 
drop if key == "uuid:8057c1c9-7261-434c-9965-a6a0a68a95b4" 

*--- Questionnaires for the communes of DABLO and NAMISSIGUIMA sent twice and the data are not alike 
	// For each, Just drop one, and replace the data by the right information 
br if commune == "DABLO" 
drop if key == "uuid:db653af7-c3ab-4d1e-89d2-94022399b278" 

replace total_students_sitting_exam 	 = 330 							if commune == "DABLO" 
replace total_boys_sitting_exam 		 = 163 							if commune == "DABLO" 
replace total_girls_sitting_exam 		 = 167 							if commune == "DABLO" 
replace students_admitted_exam 			 = 109 							if commune == "DABLO" 
replace boys_admitted_exam 				 = 50 							if commune == "DABLO" 
replace girls_admitted_exam 			 = 59 							if commune == "DABLO" 
replace total_students_sitting_exam_chec = total_students_sitting_exam 	if commune == "DABLO" 
replace total_boys_sitting_exam_check 	 = total_boys_sitting_exam 		if commune == "DABLO" 
replace total_girls_sitting_exam_check 	 = total_girls_sitting_exam		if commune == "DABLO" 
replace students_admitted_exam_check 	 = students_admitted_exam 		if commune == "DABLO" 
replace boys_admitted_exam_check 		 = boys_admitted_exam 			if commune == "DABLO" 
replace girls_admitted_exam_check 		 = girls_admitted_exam 			if commune == "DABLO" 

br if commune == "NAMISSIGUIMA_KAYA" 
drop if key == "uuid:b9598bf6-f2d9-4e74-85ff-708da8f6e579" 

replace total_students_sitting_exam 	 = 347 							if commune == "NAMISSIGUIMA_KAYA" 
replace total_boys_sitting_exam 		 = 169 							if commune == "NAMISSIGUIMA_KAYA" 
replace total_girls_sitting_exam 		 = 178 							if commune == "NAMISSIGUIMA_KAYA" 
replace students_admitted_exam 			 = 129 							if commune == "NAMISSIGUIMA_KAYA" 
replace boys_admitted_exam 				 = 64 							if commune == "NAMISSIGUIMA_KAYA" 
replace girls_admitted_exam 			 = 65 							if commune == "NAMISSIGUIMA_KAYA" 
replace total_students_sitting_exam_chec = total_students_sitting_exam 	if commune == "NAMISSIGUIMA_KAYA" 
replace total_boys_sitting_exam_check 	 = total_boys_sitting_exam 		if commune == "NAMISSIGUIMA_KAYA" 
replace total_girls_sitting_exam_check 	 = total_girls_sitting_exam		if commune == "NAMISSIGUIMA_KAYA" 
replace students_admitted_exam_check 	 = students_admitted_exam 		if commune == "NAMISSIGUIMA_KAYA" 
replace boys_admitted_exam_check 		 = boys_admitted_exam 			if commune == "NAMISSIGUIMA_KAYA" 
replace girls_admitted_exam_check 		 = girls_admitted_exam 			if commune == "NAMISSIGUIMA_KAYA" 


*----------- CENTRE-OUEST -------- 
*--------------------------------- 

*--- Questionnaire for the commune of NANDIALA sent twice 
	// The second one (key= uuid:4f34cd9c-97a1-4a38-98aa-f8769c346ecf) is the one of BINGO 
br if commune == "NANDIALA" 
br if commune == "BINGO" 
replace commune = "BINGO" if key == "uuid:4f34cd9c-97a1-4a38-98aa-f8769c346ecf" 
drop if key == "uuid:1793f917-1681-4f18-b416-e02bc5ae09f4" 


*----------- HAUTS-BASSINS ------- 
*--------------------------------- 

*--- Questionnaire for the commune of HOUNDE sent three times. The 3rd is the sum of the first two (from 2 different CEBs). 
	// Drop the first two (key = uuid:c2fae21f-25de-4443-8aa1-c8b477a5adef, and key = uuid:a843bc73-d01a-4554-93ca-c16ce45c3243) 
br if commune == "HOUNDE" 
drop if key == "uuid:c2fae21f-25de-4443-8aa1-c8b477a5adef" | key == "uuid:a843bc73-d01a-4554-93ca-c16ce45c3243" 


*--------------- SAHEL ----------- 
*--------------------------------- 


*----------- CENTRE-OUEST -------- 
*--------------------------------- 




*=================================== SAVE DATA 

save "${interm}/CEB ${year}_clean.dta", replace 

*=== Save 2018 data for scores calculation 
ren total_students_sitting_exam sd_a_01total_students_sitting_ex 
ren students_admitted_exam 		sd_a_01students_admitted_exam 

save "${interm}/CEB.dta", replace 


*=============================================================================== 
*================================ DIRECTEUR ECOLE ============================== 
*=============================================================================== 

clear all 
use "${raw}/Directeur Ecole ${year}_WIDE.dta", clear 			  				// Save the temporary data 


*------- BOUCLE DU MOUHOUN ------- 
*--------------------------------- 

*--- DJIBASSO: school "SOYE" sent twice 
	// Just drop one 
br if school == "SOYE" 
drop if key == "uuid:5e86f224-49a8-49f5-99ef-8c5fdbf78b05" 

*--- DJIBASSO: school "DJIBASSO B" sent twice 
	// Just drop one 
br if school == "DJIBASSO B" 
drop if key == "uuid:235cc43c-d670-4b3f-8705-db0dbb504c19" 

*--- NOUNA: school "BISSO-DAMANDIGUI" to be corrected sent twice 
	// Boys: 116; Girls: 118; Teachers: 03; No canteens 
br if school == "BISSO-DAMANDIGUI" 
replace number_boys 			= 116					if school == "BISSO-DAMANDIGUI" 
replace number_girls 			= 118 					if school == "BISSO-DAMANDIGUI" 
replace number_teachers 		=   3 					if school == "BISSO-DAMANDIGUI" 

replace number_boys_check    	= number_boys 			if school == "BISSO-DAMANDIGUI" 
replace number_girls_check 		= number_girls 			if school == "BISSO-DAMANDIGUI" 
replace number_teachers_check 	= number_teachers 		if school == "BISSO-DAMANDIGUI" 

replace cantine_scolaire = 0 							if school == "BISSO-DAMANDIGUI" 
replace food_supplies 	 = 0 							if school == "BISSO-DAMANDIGUI" 

foreach var of varlist month_cantine_functional month_cantine_functional_check /// 
					   food_supplies_enough food_supplies_enough_check { 
		replace `var' = . 								if school == "BISSO-DAMANDIGUI" 
} 

*--- TCHERIBA: school "TCHERIBA A" sent twice 
	// Drop the one with key = "uuid:ce75cf0d-1892-40c2-aee8-aaddaf387455" 
br if school == "TCHERIBA A" 
drop if key == "uuid:ce75cf0d-1892-40c2-aee8-aaddaf387455" 

*--- SANABA: For 4 schools (SOUMAKUY, GNOUMAKUY, ZIGA A, FOUNA), food provided at the end of the school year, in June 
	// Set that these schools didn't receive food from the municipality. 
foreach school in SOUMAKUY GNOUMAKUY  FOUNA { 
replace food_supplies 	 			= 0 				if school == "`school'" 
replace food_supplies_enough 		= . 				if school == "`school'" 
replace food_supplies_enough_check  = . 				if school == "`school'" 
} 

replace food_supplies 	 			= 0 				if school == "ZIGA A" 
replace food_supplies_enough 		= . 				if school == "ZIGA A" 
replace food_supplies_enough_check  = . 				if school == "ZIGA A" 

/* 
Drop schools: 
- DJIBASSO		: drop 2 (Need 20 schools) 
- DI			: drop 1 (Need 15 schools) 
*/ 
bysort commune: gen nb_school = _N 
bysort commune: gen rand_school = runiform(1, nb_school) 
sort commune rand_school 
bysort commune: gen rank_school = _n 

count if commune == "DJIBASSO" 
count if commune == "DI" 
drop if rank_school > 20 & commune == "DJIBASSO" 
drop if rank_school > 15 & commune == "DI" 

drop nb_school rand_school rank_school 


*----------- CASCADES ------------ 
*--------------------------------- 

*--- DAKORO: School DJERISSO, canteen functional less than food enough.  
	// Replace canteen functional by food enough. 
replace month_cantine_functional 		= food_supplies_enough			if school == "DJERISSO" 
replace month_cantine_functional_check  = month_cantine_functional		if school == "DJERISSO" 

*--- NIANKORODOUGOU: School KAGBOGORA B, canteen functional less than food enough.  
	// Replace canteen functional by food enough. 
replace month_cantine_functional 		= food_supplies_enough			if school == "KAGBOGORA B" 
replace month_cantine_functional_check  = month_cantine_functional		if school == "KAGBOGORA B" 

*--- KANKALABA: school "BOUGOULA" sent twice 
	// Just drop one 
br if school == "BOUGOULA" 
drop if key == "uuid:f54efc44-c1a7-4d83-a48c-36b9559c3226" 

*--- KANKALABA: school "ZOAYIRI" sent twice 
	// Drop one with number of latrines == 4 
br if school == "ZOAYIRI" 
drop if key == "uuid:b6de8f81-e199-4f8c-a584-1783b29d63aa" 

*--- LOUMANA: school "CISSANA" sent twice 
	// Drop the one with "water school functional" = 9 
br if school == "CISSANA" 
drop if key == "uuid:b1eb2dca-4e6e-417c-ad93-048750c7bf79" 

*--- OUELENI: School "FITIDIGUIDIASSA" sent twice. 
	// replace school FITIDIGUIDIASSA with headmaster name TRAORE DRISSA by FOLONI 
br if school == "FITIGUIDIASSA" 
replace school = "FOLONI" if school == "FITIGUIDIASSA" & nom == "TRAORÉ  DRISSA" 

*--- TOUSSIANA: school "POUANYA NIANWARE" sent twice. Correction in the number of students 
	// Drop the one with key = "uuid:fa05c9f8-397d-410d-9e19-0003d0ffd883".
br if school == "POUANYA NIANWARE" 
drop if key == "uuid:fa05c9f8-397d-410d-9e19-0003d0ffd883" 

replace number_boys 			= 103					if school == "POUANYA NIANWARE" 
replace number_girls 			=  87 					if school == "POUANYA NIANWARE" 

replace number_boys_check    	= number_boys 			if school == "POUANYA NIANWARE" 
replace number_girls_check 		= number_girls 			if school == "POUANYA NIANWARE" 

/* 
Drop schools: 
- DAKORO			: drop 1 (Need 10 schools) 
*/ 
bysort commune: gen nb_school = _N 
bysort commune: gen rand_school = runiform(1, nb_school) 
sort commune rand_school 
bysort commune: gen rank_school = _n 

count if commune == "DAKORO" 
drop if rank_school > 10 & commune == "DAKORO" 

drop nb_school rand_school rank_school 


*-------------- CENTRE ----------- 
*--------------------------------- 

*--- TANGHIN_DASSOURI: School "BALLOLE" sent twice 
	// Just drop one 
br if school == "BALLOLE" 
drop if key == "uuid:2d6faf2c-c017-4aab-8a5e-48af0e6d093a" 


*----------- CENTRE-EST ---------- 
*--------------------------------- 

*--- Enumeryaor OUEDA Edmond: Issues with 7 schools: Month canteen funtional less than food enough. 
	// Reason is that food arrived late, by the end of the school year. 
	// Set Food enough equals to canteen funtional. 
replace food_supplies_enough = month_cantine_functional 	if food_supplies_enough > month_cantine_functional /// 
															 & enumerator_name == "OUEDA_EDMOND" 
replace food_supplies_enough_check  = food_supplies_enough	if enumerator_name == "OUEDA_EDMOND" 


*----------- CENTRE-NORD --------- 
*--------------------------------- 

*--- Enumeryaor ZAMPOU Sibiri: Took into account the aid given by NGO CRS. 
	// Need to add months canteens functional and months food enough 
	// to get the real months canteens functional 
br if enumerator_name == "ZAMPOU_A_SIBIRI" 
gen school_funct = month_cantine_functional + food_supplies_enough if food_supplies == 1 
replace month_cantine_functional = month_cantine_functional + food_supplies_enough	if enumerator_name == "ZAMPOU_A_SIBIRI" /// 
																					 & school_funct <= 9 & food_supplies == 1 
replace month_cantine_functional_check  = month_cantine_functional					if enumerator_name == "ZAMPOU_A_SIBIRI" 
drop school_funct 

*--- BOULSA: Issue with scholar canteen (NABIGTENGA ES and KOBOURE) 
	// Month canteen funtional less than food enough. 
	// Canteen funtional should be Food enough 
replace month_cantine_functional 		= food_supplies_enough		if school == "NABIGTENGA ES" 
replace month_cantine_functional_check  = month_cantine_functional	if school == "NABIGTENGA ES" 

replace month_cantine_functional 		= food_supplies_enough		if school == "KOBOURE" 
replace month_cantine_functional_check  = month_cantine_functional	if school == "KOBOURE" 

*--- BOUROUM: School PETOUGA sent three times 
	// The first 2 are alike. The 3rd is school PELSE, with school director OUEDRAOGO Kiswendsida. 
	// Canteen funtional should be Food enough 
br if school == "PETOUGA" 
drop if key == "uuid:6cd55558-8fd5-42a9-b655-fa4cb37fbacc" 

replace school = "PELSE" 				if school == "PETOUGA" & key == "uuid:4d474902-d13e-41ae-a2a0-181f70127088" 
replace nom = "OUEDRAOGO Kiswendsida" 	if school == "PELSE" 

*--- TOUGOURI: School "TOUGOURI CENTRE" sent twice 
	// Just drop one 
br if school == "TOUGOURI CENTRE" 
drop if key == "uuid:42f760a6-65e1-47f0-824f-956cfc6a94ae" 

*--- ZIGA: School "BISSIGA" sent twice. 
	// key = uuid:dc4de579-86d5-4d6e-ad54-e2efb2eeb13b is good one. 
	// Supplies received Week 2, instead of Week 1. 
br if school == "BISSIGA" 
drop if key == "uuid:0069d8e5-236f-456c-bc28-e8368640f434" 
replace week_received_school_supplies = 2 if key == "uuid:dc4de579-86d5-4d6e-ad54-e2efb2eeb13b" 

/*
Drop schools: 
- BARSALOGHO 	: drop 12 (Need 25 schools) 
- DABLO 		: drop  6 (Need 10 schools) 
- BOUROUM 		: drop  3 (Need 20 schools) 
- TOUGOURI 		: drop  1 (Need 25 schools) 
*/ 
bysort commune: gen nb_school = _N 
bysort commune: gen rand_school = runiform(1, nb_school) 
sort commune rand_school 
bysort commune: gen rank_school = _n 

foreach commune in BARSALOGHO DABLO BOUROUM TOUGOURI { 
	count if commune == "`commune'" 
} 

drop if rank_school > 25 & commune == "BARSALOGHO" 
drop if rank_school > 10 & commune == "DABLO" 
drop if rank_school > 20 & commune == "BOUROUM" 
drop if rank_school > 25 & commune == "TOUGOURI" 

drop nb_school rand_school rank_school 


*----------- CENTRE-OUEST -------- 
*--------------------------------- 

*--- NANDIALA: Issue with scholar canteen for school KAONCE 
	// Month canteen functional less than month food enough. 
	// Month food enough should be 3 
br if school == "KAONCE" 
replace food_supplies_enough 		= 3						if school == "KAONCE" 
replace food_supplies_enough_check  = food_supplies_enough	if school == "KAONCE" 

*--- THYOU: School "KOUKIN" sent twice 
	// Key = uuid:ca9261ca-37b4-49b8-a1d5-ff96785e0106 is the good one. 
br if school == "KOUKIN" 
drop if key == "uuid:50078d41-3094-4ca8-95f0-dea9f3917e3a" 

*--- Enumerator VALIAN Mohamadou: Issue with month school received suppmlies 
	// All schools that have received week 4 of September 
	// have received supplied week 1 of October 
br if enumerator_name == "VALIAN_MOHAMADOU" 
replace school_supplies = 0					if enumerator_name == "VALIAN_MOHAMADOU" /// 
											 & year_month_received_school_suppl == "Sep 1, 2018" /// 
											 & week_received_school_supplies == 4 

replace week_received_school_supplies = 1	if enumerator_name == "VALIAN_MOHAMADOU" /// 
											 & year_month_received_school_suppl == "Sep 1, 2018" /// 
											 & week_received_school_supplies == 4 

replace year_month_received_school_suppl = "Oct 1, 2018" if enumerator_name == "VALIAN_MOHAMADOU" /// 
														  & school_supplies == 0 /// 
														  & week_received_school_supplies == 1 /// 
														  & year_month_received_school_suppl == "Sep 1, 2018" 

*--- KINDI: School "NAWEKYIIRI" sent twice 
	// Drop the one with Key = "uuid:026ecf29-4ce9-4c78-bffe-3a3f5254abde". 
br if school == "NAWEKYIIRI" 
drop if key == "uuid:026ecf29-4ce9-4c78-bffe-3a3f5254abde" 


*----------- CENTRE-SUD ---------- 
*--------------------------------- 

*--- TOECE: School "SINCENE TOECE" sent twice 
	// Just drop one 
br if school == "SINCENE TOECE" 
drop if key == "uuid:a6d5a663-fe7d-4e6d-9c0a-0674df3065c3" 

*--- LOUMBILA: School "DAGUILMA B" sent twice 
	// Just drop one 
br if school == "DAGUILMA B" 
drop if key == "uuid:dc719ead-6a58-44ce-91dd-26901665fa89" 

*--- KOMBISSIRI: School TANDAGA with water functional = 1 has wrong name 
	// Rename to "CEEP secteur2", and Director name to SAWADOGO ASSETOU 
br if school == "TANDAGA" 
replace school = "CEEP Secteur 2" if key == "uuid:7e7b52a1-3e84-4e37-a602-037e108030da" 
replace nom = "SAWADOGO ASSETOU" if key == "uuid:7e7b52a1-3e84-4e37-a602-037e108030da" 

*--- LAYE: School LAYE B sent twice 
	// The one with Director "KONE YACOUBA" (phone number 70 14 18 26) should be SAPEO 
br if nom == "KONE YACOUBA" 
replace school = "SAPEO" if nom == "KONE YACOUBA" 


*-------------- EST -------------- 
*--------------------------------- 

*--- Enumerator DABILGOU P. Gildas: School canteen functional less than food enough. 
	// The two variables should be permuted. 
gen food_enough = . 
replace food_enough = month_cantine_functional 						if food_supplies_enough > month_cantine_functional /// 
																	 & enumerator_name == "DABILGOU_GILDAS" 
replace month_cantine_functional 		= food_supplies_enough 		if food_supplies_enough > month_cantine_functional /// 
																	 & enumerator_name == "DABILGOU_GILDAS" 
replace month_cantine_functional_check  = month_cantine_functional	if enumerator_name == "DABILGOU_GILDAS" 

replace food_supplies_enough 			= food_enough				if food_enough != . & enumerator_name == "DABILGOU_GILDAS" 
replace food_supplies_enough_check  	= food_supplies_enough		if food_enough != . & enumerator_name == "DABILGOU_GILDAS" 

drop food_enough 

*--- DIABO: School "DIABO B" sent twice. 
	// The one with Director name OUOBA DIALENLI is "SEIGA B" 
br if school == "DIABO B" 
replace school = "SEIGA B" if key == "uuid:abecddc5-d480-469b-8fc1-1077d97a583c" 

*--- LOGOBOU: School "FANGOU" sent twice. 
	// One is "FANGOU A" and the other is "FANGOU B". 
br if school == "FANGOU" 
replace school = "FANGOU A" if key == "uuid:59e6c440-118b-4ee4-8c9c-d01e97ba53ca" 
replace school = "FANGOU B" if key == "uuid:814f5308-75e8-4e31-a6b8-eb22e4257f3d" 

*--- Enumeryaor KONE Tiefing Mohamed: Month canteen funtional less than food enough. 
	// Set Food enough equals to canteen funtional. 
replace food_supplies_enough 		= month_cantine_functional 	if food_supplies_enough > month_cantine_functional /// 
																 & enumerator_name == "KONE_TIEFING_MOHAMED" 
replace food_supplies_enough_check  = food_supplies_enough		if enumerator_name == "KONE_TIEFING_MOHAMED" 


*--- MATIACOALI: School "DATOUGOU" sent twice 
	// Drop the one with key == "uuid:5549e3c5-014d-4f72-bd29-dcdad81ba60f" 
br if school == "DATOUGOU" 
drop if key == "uuid:426adbf6-1f8c-4531-9d75-f70332a06452" 

*--- KANTCHARI: School "NABOUAMOU" sent twice 
	// Drop the one with key == "uuid:5549e3c5-014d-4f72-bd29-dcdad81ba60f" 
br if school == "NABOUAMOU" 
drop if key == "uuid:5549e3c5-014d-4f72-bd29-dcdad81ba60f" 

*--- Enumeryaor KOUTOU Sayouba: Month canteen funtional less than food enough. 
	// Set Food enough equals to canteen funtional. 
replace food_supplies_enough = month_cantine_functional 	if food_supplies_enough > month_cantine_functional /// 
															 & enumerator_name == "KOUTOU_SAYOUBA" 
replace food_supplies_enough_check  = food_supplies_enough	if enumerator_name == "KOUTOU_SAYOUBA" 


*----------- HAUTS-BASSINS ------- 
*--------------------------------- 

*--- DANDE: School "BAKARIBOUGOU" sent twice 
	// Drop the one with key == "uuid:9a57292f-8fce-44c5-a14c-11bcbbfaec7a" 
br if school == "BAKARIBOUGOU" 
drop if key == "uuid:9a57292f-8fce-44c5-a14c-11bcbbfaec7a" 

*--- DANDE: School "BAKARIBOUGOU" sent twice 
	// The one with key == "uuid:9a57292f-8fce-44c5-a14c-11bcbbfaec7a" is school "DANDE A" 
br if school == "DANDE  D" 
replace school = "DANDE A" if key == "uuid:03fc7f08-c419-446e-bd7a-dee91cfc64f1" 

*--- DANDE: School "DANDE B" sent twice 
	// Drop the one with key == "uuid:d7a20053-990e-40ef-b610-df721442ca78" 
br if school == "DANDE B" 
drop if key == "uuid:d7a20053-990e-40ef-b610-df721442ca78" 

*--- LENA: School "LENA A" sent twice 
	// Drop the one with key == "uuid:5fb0e22d-55cf-4a38-a63e-14506f4f2195" 
br if school == "LENA  A" 
drop if key == "uuid:5fb0e22d-55cf-4a38-a63e-14506f4f2195" 

*--- HOUNDE: School "TOUAHO" sent twice 
	// Drop the one with key == "uuid:2fd58c4a-1bc2-42a7-8cf4-878fc8f94378" 
br if school == "TOUAHO" 
drop if key == "uuid:2fd58c4a-1bc2-42a7-8cf4-878fc8f94378" 

*--- MOROLABA: Issue with scholar canteen for school ZANGUINA 
	// Month canteen functional less than month food enough. 
	// Month canteen functional should be 3 
br if school == "ZANGUINA" 
replace month_cantine_functional 		= 3							if school == "ZANGUINA" 
replace month_cantine_functional_check  = month_cantine_functional	if school == "ZANGUINA" 

/* 
Drop schools: 
- HOUNDE		: drop  9 (Need 20 schools) 
- SINDO			: drop  1 (Need 10 schools) 
- BEREBA 		: drop  1 (Need 15 schools) 
- NDOROLA		: drop  1 (Need 15 schools) 
*/ 
bysort commune: gen nb_school = _N 
bysort commune: gen rand_school = runiform(1, nb_school) 
sort commune rand_school 
bysort commune: gen rank_school = _n 

foreach commune in HOUNDE SINDO BEREBA NDOROLA { 
	count if commune == "`commune'" 
} 

drop if rank_school > 20 & commune == "HOUNDE" 
drop if rank_school > 10 & commune == "SINDO" 
drop if rank_school > 15 & commune == "BEREBA" 
drop if rank_school > 15 & commune == "NDOROLA" 

drop nb_school rand_school rank_school 


*-------------- NORD ------------- 
*--------------------------------- 

*--- BANH: School "ZAMNE" sent twice 
	// Drop the one with key == "uuid:a79689d5-add9-4cff-a7e2-25416ae56dc3" 
br if school == "ZAMNE" 
drop if key == "uuid:a79689d5-add9-4cff-a7e2-25416ae56dc3" 

*--- TITAO: School "SOFFI" sent twice 
	// Drop the one with key == "uuid:6cfeaae6-8afe-4cb5-b67b-79e1ad9ff5d6" 
br if school == "SOFFI" 
drop if key == "uuid:6cfeaae6-8afe-4cb5-b67b-79e1ad9ff5d6" 


*-------- PLATEAU CENTRAL -------- 
*--------------------------------- 

*--- SALOGO: School "ZOMNOGO" sent twice 
	// Drop the one with key == "uuid:c7e7ff9c-3f2e-4bd4-bdff-383dfadca91e" 
br if school == "ZOMNOGO" 
drop if key == "uuid:c7e7ff9c-3f2e-4bd4-bdff-383dfadca91e" 

*--- SALOGO: Issue with scholar canteen for schools BOALGHIN 
	// Month canteen functional less than month food enough. 
	// Month food enough should be 3 
br if school == "BOALGHIN" 
replace food_supplies_enough 		= 2						if school == "BOALGHIN" 
replace food_supplies_enough_check  = food_supplies_enough	if school == "BOALGHIN" 

*--- BOUDRY: School "TANSEIGA" sent twice 
	// Drop the one with key == "uuid:937e297e-538a-4eff-8430-31a3f81b2816" 
br if school == "TANSEIGA" 
drop if key == "uuid:937e297e-538a-4eff-8430-31a3f81b2816" 

*--- ZOUNGOU: School "KUILKANDA" sent twice 
	// Drop the one with key == "uuid:ab06f096-fff5-40ff-801e-e65728760be3" 
br if school == "KUILKANDA" 
drop if key == "uuid:ab06f096-fff5-40ff-801e-e65728760be3" 

*--- MEGUET: Issue with scholar canteen for schools YAMA 
	// Month canteen functional less than month food enough. 
	// Month food enough should be 3 
br if school == "YAMA" 
replace food_supplies_enough 		= 2						if school == "YAMA" 
replace food_supplies_enough_check  = food_supplies_enough	if school == "YAMA" 

*--- DAPELOGO: Issue with school name 
	// Rename school with key = uuid:2d2afa59-970b-48f1-b131-ef7f1f4a8221, GAMBASTENGA 
br if key == "uuid:2d2afa59-970b-48f1-b131-ef7f1f4a8221" 
replace school = "GAMBASTENGA" if key == "uuid:2d2afa59-970b-48f1-b131-ef7f1f4a8221" 

*--- SOURGOUBILA: Two schools "GUELA" not relevant 
	// Drop two schools named GUELA 
br if school == "GUELA" 
drop if school == "GUELA" & commune == "SOURGOUBILA" 


/* 
Drop schools: 
- BOUSSE 		: drop 21 (Need 20 schools) 
- DAPELOGO 		: drop 15 (Need 20 schools) 
- NIOU 			: drop  9 (Need 20 schools) 
- OURGOU-MANEGA : drop 11 (Need 15 schools) 
- SOURGOUBILA 	: drop 11 (Need 20 schools) 
- TOEGHIN 		: drop  8 (Need 15 schools) 
*/ 
bysort commune: gen nb_school = _N 
bysort commune: gen rand_school = runiform(1, nb_school) 
sort commune rand_school 
bysort commune: gen rank_school = _n 

foreach commune in BOUSSE DAPELOGO NIOU OURGOU_MANEGA SOURGOUBILA TOEGHIN { 
	count if commune == "`commune'" 
} 

drop if rank_school > 20 & commune == "BOUSSE" 
drop if rank_school > 20 & commune == "DAPELOGO" 
drop if rank_school > 20 & commune == "NIOU" 
drop if rank_school > 15 & commune == "OURGOU_MANEGA" 
drop if rank_school > 20 & commune == "SOURGOUBILA" 
drop if rank_school > 15 & commune == "TOEGHIN" 

drop nb_school rand_school rank_school 


*------------- SAHEL ------------- 
*--------------------------------- 

*--- BOUNDORE: For 12 schools, month canteen funtional was less than month food enough 
	// This is due to terrorist attacks came just after schools received food. 
	// We consider here month food enough is month canteen funtional. 
replace food_supplies_enough 			= month_cantine_functional	if food_supplies_enough > month_cantine_functional /// 
																	 & commune == "BOUNDORE" 
replace food_supplies_enough_check  	= food_supplies_enough		if commune == "BOUNDORE" 

*--- BOUNDORE: School "TAMPETOU" sent twice 
	// Drop the one with key == "uuid:2ec44c9d-64c9-4a86-a3d9-719b373ab045" 
br if school == "TAMPETOU" 
drop if key == "uuid:2ec44c9d-64c9-4a86-a3d9-719b373ab045" 

*--- BOUNDRORE: School "PENKATOUGOU" sent twice 
	// Drop the one with key == "uuid:8a1759a7-a476-4805-9c57-84633fcfccbc" 
br if school == "PENKATOUGOU" 
drop if key == "uuid:8a1759a7-a476-4805-9c57-84633fcfccbc" 

*--- MANSILA: School "OUSSALTANDONGOBE" sent twice 
	// Drop the one with key == "uuid:c0919d8e-7aaa-441c-b82a-dc8b28f58fff" 
br if school == "OUSSALTANDONGOBE" 
drop if key == "uuid:c0919d8e-7aaa-441c-b82a-dc8b28f58fff" 

*--- FALAGOUNTOU: School "GOURARA" sent twice 
	// Just drop one 
br if school == "GOURARA" 
drop if key == "uuid:5fc06217-893b-4276-8e9c-0ed70fdb055d" 

*--- SEYTENGA: School "BADOURLEBE" sent twice 
	// Drop the one with key == "uuid:e71b73ee-da3a-4243-bed6-f671f12922a4" 
br if school == "BADOURLEBE" 
drop if key == "uuid:e71b73ee-da3a-4243-bed6-f671f12922a4" 

*--- Enumerator SAVADOGO Abdoul Rasmané: For schools from the commune of OURSI and TIN_AKOFF 
	// Month canteen funtional was less than month food enough 
	// Month food enough should be replace by month canteen functional 
replace food_supplies_enough 			= month_cantine_functional	if commune == "OURSI" | commune == "TIN_AKOFF" 
replace food_supplies_enough_check  	= food_supplies_enough		if commune == "OURSI" | commune == "TIN_AKOFF" 


*----------- SUD_OUEST ----------- 
*--------------------------------- 

*--- OUESSA: School "BANKANDI A" sent twice 
	// one should be renamed "BANKANDI C" 
br if school == "BANKANDI A" 
replace school = "BANKANDI C" if key == "uuid:723078d5-2e04-4b64-89a0-20d494caa9cd" 

*--- ZAMBO: School "TOVOR" sent twice 
	// Drop the one with key = "uuid:514f7668-abcb-4e5a-937f-2ec0e2e50918" 
br if school == "TOVOR" 
drop if key == "uuid:514f7668-abcb-4e5a-937f-2ec0e2e50918" 

*--- DAPELOGO: Issue with the name of the school with key = "uuid:9efb76bf-f004-48be-95b4-e72a0fed5abb" 
	// Rename school with key = "uuid:9efb76bf-f004-48be-95b4-e72a0fed5abb", DONKO B 
br if key == "uuid:9efb76bf-f004-48be-95b4-e72a0fed5abb" 
replace school = "DONKO B" if key == "uuid:9efb76bf-f004-48be-95b4-e72a0fed5abb" 


*=================================== SAVE DATA 

save "${interm}/Directeur Ecole ${year}_clean.dta", replace 

*=== Save 2018 data for scores calculation 

ren functional_latrines functional_latrine 
*ren received_supplies 	supplies_received 

gen number_students = number_boys + number_girls 								// Generate the number of students in the school  
order number_students, before(number_boys) 
br if number_students == . 

save "${interm}/Directeur Ecole.dta", replace 


*===============================================================================
*=============================== DISTRICT SANITAIRE ============================
*=============================================================================== 

clear all 
use "${raw}/Additional/District Sanitaire ${year}.dta", clear   	  			// Save the temporary data 

ren projected_deliveries_18 		projected_deliveries_2018 
ren assisted_deliveries_18   		assisted_deliveries_2018 

foreach vacc in bcg var vaa rr1 { 
ren target_vaccination_`vacc'_18 	target_vaccination_`vacc'_2018 
ren vaccination_coverage_`vacc'_18 	vaccination_coverage_`vacc'_2018 
} 

ren target_vaccination_vpo3_18 		target_vaccination_vpo3_2018 
ren vaccination_coverage_vpo_18 	vaccination_coverage_vpo_2018 

ren target_vaccination_dtchephib3_18 	target_vaccination_dtchephib3_20 
*ren vaccination_coverage_dtchephib3_ 	vaccination_coverage_dtchephib3_ 

save "${raw}/District Sanitaire ${year}_add.dta", replace   	  				// Save the temporary data 

*============================= 
use "${raw}/District Sanitaire ${year}_WIDE.dta", clear   	  					// Save the temporary data 
append using "${raw}/District Sanitaire ${year}_add.dta", keep(deviceid region province district commune 					/// 
														  projected_deliveries_2018 assisted_deliveries_2018 				/// 
														  target_vaccination_bcg_2018 vaccination_coverage_bcg_2018 		/// 
														  target_vaccination_vpo3_2018 vaccination_coverage_vpo_2018 		/// 
														  target_vaccination_dtchephib3_20 vaccination_coverage_dtchephib3_ /// 
														  target_vaccination_var_2018 vaccination_coverage_var_2018 		/// 
														  target_vaccination_vaa_2018 vaccination_coverage_vaa_2018 		/// 
														  target_vaccination_rr1_2018 vaccination_coverage_rr1_2018 		/// 
														  key submissiondate today) 

br if region == "" | province == "" | commune == "" 

duplicates tag region commune, gen(dup1) 
br region-commune key submissiondate today 								/// 
   projected_deliveries_2018 assisted_deliveries_2018 					/// 
   target_vaccination_bcg_2018 vaccination_coverage_bcg_2018 			/// 
   target_vaccination_vpo3_2018 vaccination_coverage_vpo_2018 			/// 
   target_vaccination_dtchephib3_20 vaccination_coverage_dtchephib3_ 	/// 
   target_vaccination_var_2018 vaccination_coverage_var_2018 			/// 
   target_vaccination_vaa_2018 vaccination_coverage_vaa_2018 			/// 
   target_vaccination_rr1_2018 vaccination_coverage_rr1_2018 			/// 
  dup1 if dup1 != 0 

drop if key == "uuid:4faeb3c3-287f-44b8-a890-26a0e11d4970" /// 					// Drop old/uncompleted questionnaires 
	  | key == "uuid:f9d2b04f-1a95-485b-bba7-62ea1fca2d30" /// 
	  | key == "uuid:6b12663c-6759-4fbd-9aea-a8e5557982ad" /// 
	  | key == "uuid:329b8f15-08f8-4634-a8f5-5811752831f4" /// 
	  | key == "uuid:f6a018e1-878a-42c4-a3f5-02be3e57ce94" /// 
	  | key == "uuid:327f26cd-32e5-4da1-8321-45517f1abd8a" /// 
	  | key == "uuid:013ac319-d940-4d78-84c2-e0f5dd3d6061" /// 
	  | key == "uuid:c4627806-f5bf-4593-9c18-396437c4fac1" /// 
	  | key == "uuid:f3d2551f-a747-4b49-b928-6d8f5511f871" /// 
	  | key == "uuid:3e431c97-c030-45f8-b0c1-beaf806433f1" /// 
	  | key == "uuid:3ac391a6-a847-401d-b2b6-a296e1b65ec8" /// 
	  | key == "uuid:fa159176-82f3-4f6a-9bd8-a64895810482" /// 
	  | key == "uuid:644ff4e1-e2e1-4db5-ab60-2bad4de8419b" /// 
	  | key == "uuid:7d3b87b5-b9bf-4a34-998f-0ee16ecf4de7" /// 
	  | key == "uuid:5827410e-7341-425a-85c1-7b60775b868e" /// 
	  | key == "uuid:a8bb716e-6d33-48c0-a255-cef3a104fc99" /// 
	  | key == "uuid:058959db-29b3-41da-bde6-2795d5ed6288" /// 
	  | key == "uuid:67634afa-599e-4b30-b262-4715d1dc75cc" /// 
	  | key == "uuid:fbdfab03-082d-4db4-9569-2ff1ee024e94" /// 
	  | key == "uuid:e392ed8c-20aa-4fcd-8fce-edbba39a7646" /// 
	  | key == "uuid:9e73dfd2-e255-481e-a893-5cfd039c7372" /// 
	  | key == "uuid:00d757f3-a68e-44b3-b760-615ab546b370" /// 
	  | key == "uuid:17d11d1f-7be3-4014-8ef9-833ce19241e4" /// 
	  | key == "uuid:5f36ac14-2c88-40e7-95ae-deb192fabfff" /// 
	  | key == "uuid:dd3d98c5-62bd-4e1d-9017-b640df55194b" /// 
	  | key == "uuid:69500744-6779-4315-9a74-0a2d683f2d59" /// 
	  | key == "uuid:500a8d3e-2163-465e-87a9-e5c4643ab159" /// 
	  | key == "uuid:973a8d7e-1466-4f54-839a-6e7f9a959451" /// 
	  | key == "uuid:697c5043-065c-4cb2-9dc8-435b12fcb1ea" /// 
	  | key == "uuid:ea6feba2-2883-4e29-a1c0-d3b6c56231f5" /// 
	  | key == "uuid:033d05ef-9464-4a1f-aaa4-9de3299da999"
  
*----------- BOUCLE DU MOUHOUN ------------ 
*------------------------------------------ 

*--- Questionnaire for the commune of MADOUBA sent twice. 
	// Just drop one 
br if commune == "MADOUBA" 
drop if key == "uuid:ad7bc666-c99b-44b5-b82b-395057cc9eb2" 

*--- Unconsistant data for RR1 in BOMBOROKUY (ZOUNGRANA Sébastien) 
	// Replace with the right value 
replace vaccination_coverage_rr1_2018 		= 843							if commune == "BOMBORO_KUY" 
replace vaccination_coverage_rr1_2018_ch    = vaccination_coverage_rr1_2018	if commune == "BOMBORO_KUY" 


*----------- CASCADES ------------
*---------------------------------

*--- Missing Projected and Assisted delivery for DAKORO, DOUNA and NIANKORODOUGOU (ZOUBGA Ousmane) 
	// Replace with the right values 
replace projected_deliveries_2018 		= 1030						if commune == "DAKORO" 
replace assisted_deliveries_2018 		=  933						if commune == "DAKORO" 
replace projected_deliveries_2018_check = projected_deliveries_2018	if commune == "DAKORO" 
replace assisted_deliveries_2018_check	= assisted_deliveries_2018 	if commune == "DAKORO" 

replace projected_deliveries_2018 		= 709						if commune == "DOUNA" 
replace assisted_deliveries_2018 		= 378						if commune == "DOUNA" 
replace projected_deliveries_2018_check = projected_deliveries_2018	if commune == "DOUNA" 
replace assisted_deliveries_2018_check	= assisted_deliveries_2018 	if commune == "DOUNA" 

replace projected_deliveries_2018 		= 2831						if commune == "NIANKORODOUGOU" 
replace assisted_deliveries_2018 		= 2606						if commune == "NIANKORODOUGOU" 
replace projected_deliveries_2018_check = projected_deliveries_2018	if commune == "NIANKORODOUGOU" 
replace assisted_deliveries_2018_check	= assisted_deliveries_2018 	if commune == "NIANKORODOUGOU" 


*--- Missing Projected and Assisted delivery for all 5 communes (LOUMANA, OUELENI, KANKALABA, SINDOU, WOLONKOTO). (ZARE Malick) 
	// Replace with the right values 
replace projected_deliveries_2018 		= 1909						if commune == "LOUMANA" 
replace assisted_deliveries_2018 		= 1356						if commune == "LOUMANA" 

replace projected_deliveries_2018 		= 911						if commune == "OUELENI" 
replace assisted_deliveries_2018 		= 770						if commune == "OUELENI" 

replace projected_deliveries_2018 		= 750						if commune == "KANKALABA" 
replace assisted_deliveries_2018 		= 429						if commune == "KANKALABA" 

replace projected_deliveries_2018 		= 1395						if commune == "SINDOU" 
replace assisted_deliveries_2018 		= 1766						if commune == "SINDOU" 

replace projected_deliveries_2018 		= 305						if commune == "WOLONKOTO" 
replace assisted_deliveries_2018 		= 212						if commune == "WOLONKOTO" 

replace projected_deliveries_2018_check = projected_deliveries_2018	/// 
	 if commune == "LOUMANA" | commune == "OUELENI" | commune == "KANKALABA" | commune == "SINDOU" | commune == "WOLONKOTO" 
replace assisted_deliveries_2018_check	= assisted_deliveries_2018 	/// 
	 if commune == "LOUMANA" | commune == "OUELENI" | commune == "KANKALABA" | commune == "SINDOU" | commune == "WOLONKOTO" 


*----------- CENTRE-EST ---------- 
*--------------------------------- 

*--- Missing Projected and Assisted delivery for all 6 communes. (TAITA Ramatou) 
	// Replace with the values 
replace projected_deliveries_2018 		= 3450						if commune == "ANDEMTENGA" 
replace projected_deliveries_2018 		= 1752						if commune == "KANDO" 
replace projected_deliveries_2018 		= 5694						if commune == "POUYTENGA" 
replace projected_deliveries_2018 		= 790						if commune == "BASKOURE" 
replace projected_deliveries_2018 		= 1290						if commune == "KOUPELA" 
replace projected_deliveries_2018 		= 2094						if commune == "GOUNGHIN" 

replace projected_deliveries_2018_check = projected_deliveries_2018	/// 
		if commune == "ANDEMTENGA" | commune == "KANDO"   | commune == "POUYTENGA" | /// 
		   commune == "BASKOURE"   | commune == "KOUPELA" | commune == "GOUNGHIN" 

replace assisted_deliveries_2018 		= 2909						if commune == "ANDEMTENGA" 
replace assisted_deliveries_2018 		= 1039						if commune == "KANDO" 
replace assisted_deliveries_2018 		= 5297						if commune == "POUYTENGA" 
replace assisted_deliveries_2018 		= 601						if commune == "BASKOURE" 
replace assisted_deliveries_2018 		= 4673						if commune == "KOUPELA" 
replace assisted_deliveries_2018 		= 1592						if commune == "GOUNGHIN" 

replace assisted_deliveries_2018_check	= assisted_deliveries_2018 /// 
		if commune == "ANDEMTENGA" | commune == "KANDO"   | commune == "POUYTENGA" | /// 
		   commune == "BASKOURE"   | commune == "KOUPELA" | commune == "GOUNGHIN" 

*--- Questionnaire for BANE sent twice. 
	// Just drop one. 
br if commune == "BANE" 
drop if key == "uuid:f4f3a147-4f76-4abb-a0df-b5d10e6a2fc8" 

*--- Questionnaire for ZONSE sent twice. 
	// Just drop one. 
br if commune == "ZONSE" 
drop if key == "uuid:b92002a1-8a90-4e7f-b162-bf3dfa780361" 

*--- Wrong data for KOMTOEGA. 
	// Replace with the right values. 
replace target_vaccination_bcg_2018 	 = 1668 			if commune == "KOMTOEGA" 
replace vaccination_coverage_bcg_2018 	 = 1027 			if commune == "KOMTOEGA" 
replace target_vaccination_vpo3_2018 	 = 1794 			if commune == "KOMTOEGA" 
replace vaccination_coverage_vpo_2018 	 = 1061 			if commune == "KOMTOEGA" 
replace target_vaccination_dtchephib3_20 = 1794 			if commune == "KOMTOEGA" 
replace vaccination_coverage_dtchephib3_ = 1061 			if commune == "KOMTOEGA" 
replace target_vaccination_vaa_2018 	 = 1794 			if commune == "KOMTOEGA" 
replace vaccination_coverage_vaa_2018 	 = 1022 			if commune == "KOMTOEGA" 
replace target_vaccination_rr1_2018 	 = 1794 			if commune == "KOMTOEGA" 
replace vaccination_coverage_rr1_2018 	 = 1074 			if commune == "KOMTOEGA" 

*--- Questionnaire for BOALA sent twice. 
	// The second is for BOALA instead. 
replace commune = "BOALA" if key == "uuid:e4ee167f-c7f9-41df-a3f1-9b33aeabb84b" 


*----------- CENTRE-NORD --------- 
*--------------------------------- 

*--- Questionnaire for the commune of KAYA sent twice. 
	// Just drop one 
br if commune == "KAYA" 
drop if key == "uuid:d2284a1b-a622-419c-8fdc-0441f566c3ce" 

*--- Questionnaire for the commune of NAGBINGOU sent twice. 
	// Just drop one with enumerator name DIALLO Karim. 
br if commune == "NAGBINGOU" 
drop if key == "uuid:0ac4fcdb-b77b-443a-a596-7abfa5258866" 

replace projected_deliveries_2018 		= 5805						if commune == "PISSILA" 
replace projected_deliveries_2018 		= 1545						if commune == "PIBAORE" 

replace assisted_deliveries_2018 		= 5572						if commune == "PISSILA" 
replace assisted_deliveries_2018 		= 1724						if commune == "PISSILA" 


*----------- CENTRE-OUEST -------- 
*--------------------------------- 

*--- Missing data for KINDI. 
	// Replace with the right values. 
replace projected_deliveries_2018 		 = 2051				if commune == "KINDI" 
replace assisted_deliveries_2018 		 = 1240				if commune == "KINDI" 

replace target_vaccination_bcg_2018 	 = 1894 			if commune == "KINDI" 
replace vaccination_coverage_bcg_2018 	 = 1826 			if commune == "KINDI" 
replace target_vaccination_vpo3_2018 	 = 1749 			if commune == "KINDI" 
replace vaccination_coverage_vpo_2018 	 = 1762 			if commune == "KINDI" 
replace target_vaccination_dtchephib3_20 = 1747 			if commune == "KINDI" 
replace vaccination_coverage_dtchephib3_ = 1751 			if commune == "KINDI" 
replace target_vaccination_var_2018 	 = 1746 			if commune == "KINDI" 
replace vaccination_coverage_var_2018 	 = 1790 			if commune == "KINDI" 
replace target_vaccination_vaa_2018 	 = 1746 			if commune == "KINDI" 
replace vaccination_coverage_vaa_2018 	 = 1790 			if commune == "KINDI" 
replace target_vaccination_rr1_2018 	 = 1746 			if commune == "KINDI" 
replace vaccination_coverage_rr1_2018 	 = 1790 			if commune == "KINDI" 


replace target_vaccination_bcg_2018 	 = 1819 		if commune == "BAKATA" 
replace target_vaccination_vpo3_2018 	 = 1636 		if commune == "BAKATA" 
replace target_vaccination_dtchephib3_20 = 1638 		if commune == "BAKATA" 
replace target_vaccination_vaa_2018 	 = 1636 		if commune == "BAKATA" 
replace target_vaccination_rr1_2018 	 = 1636 		if commune == "BAKATA" 
	
replace target_vaccination_bcg_2018 	 = 1305 		if commune == "BOUGNOUNOU" 
replace target_vaccination_vpo3_2018 	 = 1174 		if commune == "BOUGNOUNOU" 
replace target_vaccination_dtchephib3_20 = 1174 		if commune == "BOUGNOUNOU" 
replace target_vaccination_vaa_2018 	 = 1174 		if commune == "BOUGNOUNOU" 
replace target_vaccination_rr1_2018 	 = 761 			if commune == "BOUGNOUNOU" 

replace target_vaccination_bcg_2018 	 = 2045 		if commune == "CASSOU" 
replace target_vaccination_vpo3_2018 	 = 2204 		if commune == "CASSOU" 
replace target_vaccination_dtchephib3_20 = 2204 		if commune == "CASSOU" 
replace target_vaccination_vaa_2018 	 = 1674 		if commune == "CASSOU" 
replace target_vaccination_rr1_2018 	 = 1674 		if commune == "CASSOU" 
	
replace target_vaccination_bcg_2018 	 = 748 			if commune == "DALO" 
replace target_vaccination_vpo3_2018 	 = 673 			if commune == "DALO" 
replace target_vaccination_dtchephib3_20 = 673 			if commune == "DALO" 
replace target_vaccination_vaa_2018 	 = 673 			if commune == "DALO" 
replace target_vaccination_rr1_2018 	 = 673 			if commune == "DALO" 

replace target_vaccination_bcg_2018 	 = 1214 		if commune == "GAO" 
replace target_vaccination_vpo3_2018 	 = 1181 		if commune == "GAO" 
replace target_vaccination_dtchephib3_20 = 1181 		if commune == "GAO" 
replace target_vaccination_vaa_2018 	 = 1181			if commune == "GAO" 
replace target_vaccination_rr1_2018 	 = 1181			if commune == "GAO" 

replace target_vaccination_bcg_2018 	 = 4023 		if commune == "SAPOUY" 
replace target_vaccination_vpo3_2018 	 = 3619			if commune == "SAPOUY" 
replace target_vaccination_dtchephib3_20 = 3619 		if commune == "SAPOUY" 
replace target_vaccination_vaa_2018 	 = 3619			if commune == "SAPOUY" 
replace target_vaccination_rr1_2018 	 = 3619			if commune == "SAPOUY" 


*----------- CENTRE-SUD ---------- 
*--------------------------------- 

*--- Wrong data for BERE. 
	// Replace with the right values. 
replace target_vaccination_bcg_2018 	 = 1725 		if commune == "BERE" 
replace vaccination_coverage_bcg_2018 	 = 1262 		if commune == "BERE" 
replace vaccination_coverage_vpo_2018 	 = 1296 		if commune == "BERE" 
replace vaccination_coverage_dtchephib3_ = 1296 		if commune == "BERE" 
replace vaccination_coverage_vaa_2018 	 = 1201 		if commune == "BERE" 
replace vaccination_coverage_rr1_2018 	 = 1201 		if commune == "BERE" 

*--- Wrong data for BINDE. 
	// Replace with the right values. 
replace target_vaccination_bcg_2018 	 = 1762 		if commune == "BINDE" 
replace vaccination_coverage_bcg_2018 	 = 1450 		if commune == "BINDE" 
replace vaccination_coverage_vpo_2018 	 = 1554 		if commune == "BINDE" 
replace vaccination_coverage_dtchephib3_ = 1554 		if commune == "BINDE" 
replace vaccination_coverage_vaa_2018 	 = 1404 		if commune == "BINDE" 
replace vaccination_coverage_rr1_2018 	 = 1404 		if commune == "BINDE" 

*--- Wrong data for GOGO. 
	// Replace with the right values. 
replace target_vaccination_bcg_2018 	 = 2102 if commune == "GOGO" 
replace vaccination_coverage_bcg_2018 	 = 1862 if commune == "GOGO" 
replace vaccination_coverage_vpo_2018 	 = 2163 if commune == "GOGO" 
replace vaccination_coverage_dtchephib3_ = 2163 if commune == "GOGO" 
replace vaccination_coverage_vaa_2018 	 = 2053 if commune == "GOGO" 
replace vaccination_coverage_rr1_2018 	 = 2053 if commune == "GOGO" 

*--- Wrong data for GOMBOUSSOUGOU. 
	// Replace with the right values. 
replace target_vaccination_bcg_2018 	 = 2482 if commune == "GOMBOUSGOU" 
replace vaccination_coverage_bcg_2018 	 = 2891 if commune == "GOMBOUSGOU" 
replace vaccination_coverage_vpo_2018 	 = 2739 if commune == "GOMBOUSGOU" 
replace vaccination_coverage_dtchephib3_ = 2739 if commune == "GOMBOUSGOU" 
replace vaccination_coverage_vaa_2018 	 = 2668 if commune == "GOMBOUSGOU" 
replace vaccination_coverage_rr1_2018 	 = 2668 if commune == "GOMBOUSGOU" 

*--- Wrong data for GUIBA. 
	// Replace with the right values. 
replace target_vaccination_bcg_2018 	 = 1796 if commune == "GUIBA" 
replace vaccination_coverage_bcg_2018 	 = 1288 if commune == "GUIBA" 
replace vaccination_coverage_vpo_2018 	 = 1399 if commune == "GUIBA" 
replace vaccination_coverage_dtchephib3_ = 1399 if commune == "GUIBA" 
replace vaccination_coverage_vaa_2018 	 = 1409 if commune == "GUIBA" 
replace vaccination_coverage_rr1_2018 	 = 1409 if commune == "GUIBA" 

*--- Wrong data for MANGA. 
	// Replace with the right values. 
replace target_vaccination_bcg_2018 	 = 1776 if commune == "MANGA" 
replace vaccination_coverage_bcg_2018 	 = 1284 if commune == "MANGA" 
replace vaccination_coverage_vpo_2018 	 = 1206 if commune == "MANGA" 
replace vaccination_coverage_dtchephib3_ = 1206 if commune == "MANGA" 
replace vaccination_coverage_vaa_2018 	 = 1177 if commune == "MANGA" 
replace vaccination_coverage_rr1_2018 	 = 1177 if commune == "MANGA" 

*--- Wrong data for NOBERE. 
	// Replace with the right values. 
replace target_vaccination_bcg_2018 	 = 1775 if commune == "NOBERE" 
replace vaccination_coverage_bcg_2018 	 = 1346 if commune == "NOBERE" 
replace vaccination_coverage_vpo_2018 	 = 1281 if commune == "NOBERE" 
replace vaccination_coverage_dtchephib3_ = 1281 if commune == "NOBERE" 
replace vaccination_coverage_vaa_2018 	 = 1354 if commune == "NOBERE" 
replace vaccination_coverage_rr1_2018 	 = 1354 if commune == "NOBERE" 


*--------------- EST ------------- 
*--------------------------------- 

*--- Vaccinated is the coverage percentage for 3 communes (THION, MANI and COALLA) 
	// Should multiply the target by the percentage. 

br if commune == "THION" | commune == "MANI" | commune == "COALLA" 

foreach commune in THION MANI COALLA { 
	replace vaccination_coverage_bcg_2018 		= round(target_vaccination_bcg_2018*(vaccination_coverage_bcg_2018/10000)) 			if commune == "`commune'" 
	replace vaccination_coverage_vpo_2018 		= round(target_vaccination_vpo3_2018*(vaccination_coverage_vpo_2018/10000)) 		if commune == "`commune'" 
	replace vaccination_coverage_dtchephib3_ 	= round(target_vaccination_dtchephib3_20*(vaccination_coverage_dtchephib3_/10000)) 	if commune == "`commune'" 
	replace vaccination_coverage_var_2018 		= round(target_vaccination_var_2018*(vaccination_coverage_var_2018/10000)) 			if commune == "`commune'" 
	replace vaccination_coverage_vaa_2018 		= round(target_vaccination_vaa_2018*(vaccination_coverage_vaa_2018/10000)) 			if commune == "`commune'" 
	replace vaccination_coverage_rr1_2018		= round(target_vaccination_rr1_2018*(vaccination_coverage_rr1_2018/10000)) 			if commune == "`commune'" 
	replace vaccination_coverage_bcg_2018_ch 	= vaccination_coverage_bcg_2018 					if commune == "`commune'" 
	replace vaccination_coverage_vpo_2018_ch	= vaccination_coverage_vpo_2018 					if commune == "`commune'" 
	replace v26 								= vaccination_coverage_dtchephib3_ 					if commune == "`commune'" 
	replace vaccination_coverage_var_2018_ch 	= vaccination_coverage_var_2018 					if commune == "`commune'" 
	replace vaccination_coverage_vaa_2018_ch 	= vaccination_coverage_vaa_2018 					if commune == "`commune'" 
	replace vaccination_coverage_rr1_2018_ch 	= vaccination_coverage_rr1_2018 					if commune == "`commune'" 
} 

*--- Zero values for: 
	  *- Target VPO3 and RR1 for PAMA: Should be 2541. 
	  *- Target DTC-HEPHIB3 for KOMPIENGA: Should be 2210. 
	  *- Target VAA for MADJOARI and KOMPIENGA: Should be 759 and 2349 respectively. 
	replace target_vaccination_vpo3_2018 		= 2541 							if commune == "PAMA" 
	replace target_vaccination_vpo3_2018_che	= target_vaccination_vpo3_2018  if commune == "PAMA" 
	replace target_vaccination_rr1_2018 		= 2541 							if commune == "PAMA" 
	replace target_vaccination_rr1_2018_che		= target_vaccination_rr1_2018   if commune == "PAMA" 

	replace target_vaccination_dtchephib3_20 	= 2210 								if commune == "KOMPIENGA" 
	replace target_vaccination_vaa_2018 		= 759 								if commune == "KOMPIENGA" 
	replace target_vaccination_rr1_2018 		= 759 								if commune == "KOMPIENGA" 
	replace v24 								= target_vaccination_dtchephib3_20 	if commune == "KOMPIENGA" 
	replace target_vaccination_vaa_2018_chec 	= target_vaccination_vaa_2018 		if commune == "KOMPIENGA" 
	replace target_vaccination_rr1_2018_chec 	= target_vaccination_rr1_2018		if commune == "KOMPIENGA" 

	replace target_vaccination_vaa_2018 		= 2349 							if commune == "MADJOARI" 
	replace target_vaccination_vaa_2018_chec 	= target_vaccination_vaa_2018 	if commune == "MADJOARI" 

*--- Wrong data for MADJOARI. 
	// Replace with the right values. 
	replace target_vaccination_vaa_2018 		= 943 		if commune == "MADJOARI" 
	replace target_vaccination_rr1_2018 		= 943 		if commune == "MADJOARI" 


*----------- HAUTS-BASSINS -------
*---------------------------------

*--- Unconsistant data for FARAMANA (OUATTARA San Paulin) 
	// Replace with the right values 

	replace projected_deliveries_2018 		 	= 901								if commune == "FARAMANA" 
	replace assisted_deliveries_2018 		 	= 961								if commune == "FARAMANA" 
	replace target_vaccination_bcg_2018 	 	= 989 								if commune == "FARAMANA" 
	replace vaccination_coverage_bcg_2018 	 	= 1020 								if commune == "FARAMANA" 
	replace target_vaccination_vpo3_2018 	 	= 887 								if commune == "FARAMANA" 
	replace vaccination_coverage_vpo_2018 	 	= 927 								if commune == "FARAMANA" 
	replace target_vaccination_dtchephib3_20 	= 869								if commune == "FARAMANA" 
	replace vaccination_coverage_dtchephib3_ 	= 902								if commune == "FARAMANA" 
	replace target_vaccination_var_2018 		= 805								if commune == "FARAMANA" 
	replace vaccination_coverage_var_2018 		= 376								if commune == "FARAMANA" 
	replace target_vaccination_vaa_2018 		= 805								if commune == "FARAMANA" 
	replace vaccination_coverage_vaa_2018 		= 753								if commune == "FARAMANA" 
	replace target_vaccination_rr1_2018 		= 805 								if commune == "FARAMANA" 
	replace vaccination_coverage_rr1_2018 		= 817 								if commune == "FARAMANA" 

*--- Questionnaire for the commune of HOUNDE sent twice. 
	// Just drop one 
br if commune == "HOUNDE" 
drop if key == "uuid:5d164e47-16f9-428f-922b-c8fe68244144" 

*--- Wrong data for FO. 
	// Replace with the right values. 
	replace projected_deliveries_2018 		 	= 901								if commune == "FO" 
	replace assisted_deliveries_2018 		 	= 1065								if commune == "FO" 
	replace target_vaccination_bcg_2018 	 	= 1483 								if commune == "FO" 
	replace vaccination_coverage_bcg_2018 	 	= 1066 								if commune == "FO" 
	replace target_vaccination_vpo3_2018 	 	= 1483 								if commune == "FO" 
	replace vaccination_coverage_vpo_2018 	 	= 1053 								if commune == "FO" 
	replace target_vaccination_dtchephib3_20 	= 1483								if commune == "FO" 
	replace vaccination_coverage_dtchephib3_ 	= 1050								if commune == "FO" 
	replace target_vaccination_var_2018 		= 636								if commune == "FO" 
	replace vaccination_coverage_var_2018 		= 576								if commune == "FO" 
	replace target_vaccination_vaa_2018 		= 465								if commune == "FO" 
	replace vaccination_coverage_vaa_2018 		= 902								if commune == "FO" 
	replace target_vaccination_rr1_2018 		= 636 								if commune == "FO" 
	replace vaccination_coverage_rr1_2018 		= 906 								if commune == "FO" 

*--- Wrong data for KOUNDOUGOU. 
	// Replace with the right values. 
	replace projected_deliveries_2018 		 	= 1764								if commune == "KOUNDOUGOU" 
	replace assisted_deliveries_2018 		 	= 1028								if commune == "KOUNDOUGOU" 
	replace target_vaccination_bcg_2018 	 	= 1836 								if commune == "KOUNDOUGOU" 
	replace vaccination_coverage_bcg_2018 	 	= 1321 								if commune == "KOUNDOUGOU" 
	replace target_vaccination_vpo3_2018 	 	= 1712 								if commune == "KOUNDOUGOU" 
	replace vaccination_coverage_vpo_2018 	 	= 1043 								if commune == "KOUNDOUGOU" 
	replace target_vaccination_dtchephib3_20 	= 1895								if commune == "KOUNDOUGOU" 
	replace vaccination_coverage_dtchephib3_ 	= 1043								if commune == "KOUNDOUGOU" 
	replace target_vaccination_var_2018 		= 495								if commune == "KOUNDOUGOU" 
	replace vaccination_coverage_var_2018 		= 458								if commune == "KOUNDOUGOU" 
	replace target_vaccination_vaa_2018 		= 1895								if commune == "KOUNDOUGOU" 
	replace vaccination_coverage_vaa_2018 		= 1201								if commune == "KOUNDOUGOU" 
	replace target_vaccination_rr1_2018 		= 1895 								if commune == "KOUNDOUGOU" 
	replace vaccination_coverage_rr1_2018 		= 1201 								if commune == "KOUNDOUGOU" 

*--- Wrong data for PADEMA. 
	// Replace with the right values. 
	replace projected_deliveries_2018 		 	= 2242								if commune == "PADEMA" 
	replace assisted_deliveries_2018 		 	= 2573								if commune == "PADEMA" 
	replace target_vaccination_bcg_2018 	 	= 1836 								if commune == "PADEMA" 
	replace vaccination_coverage_bcg_2018 	 	= 3032 								if commune == "PADEMA" 
	replace target_vaccination_vpo3_2018 	 	= 1712 								if commune == "PADEMA" 
	replace vaccination_coverage_vpo_2018 	 	= 2839 								if commune == "PADEMA" 
	replace target_vaccination_dtchephib3_20 	= 1895								if commune == "PADEMA" 
	replace vaccination_coverage_dtchephib3_ 	= 2839								if commune == "PADEMA" 
	replace target_vaccination_var_2018 		= 964								if commune == "PADEMA" 
	replace vaccination_coverage_var_2018 		= 452								if commune == "PADEMA" 
	replace target_vaccination_vaa_2018 		= 1315								if commune == "PADEMA" 
	replace vaccination_coverage_vaa_2018 		= 2676								if commune == "PADEMA" 
	replace target_vaccination_rr1_2018 		= 1315 								if commune == "PADEMA" 
	replace vaccination_coverage_rr1_2018 		= 2843 								if commune == "PADEMA" 


*----------- NORD ---------------- 
*--------------------------------- 

*--- A typo in the name of the commune KOUMBRI 
replace commune = "KOUMBRI" if commune == "KOUMBRI�" 


*------- PLATEAU CENTRAL --------- 
*--------------------------------- 

*--- A typo in the name of the commune BOUDRY 
replace commune = "BOUDRY" if commune == "BOUDRY_" 


*------------- SAHEL ------------- 
*--------------------------------- 

*--- Three additional for BANI, DORI and GORGADJI by DIALLO Tahirou. 
	// They should be (and are) done by SAWADOGO Rasmane. Need to drop them. 
br if commune == "BANI" | commune == "DORI" | commune == "GORGADJI" 
br if commune == "BANI" 
br if commune == "DORI" 
br if commune == "GORGADJI" 

drop if commune == "DORI" 		& key == "uuid:2ffb5f7e-4adb-4f3a-84f8-822f8c0b2949" 
drop if commune == "GORGADJI" 	& key == "uuid:6fc95ed5-bf9a-410f-b6be-b3a85ccd81a8" 
drop if commune == "BANI" 		& key == "uuid:ec6d840c-0a90-422a-997e-c165b937e18e" 

*--- Issues with projected and assisted delivery for FALAGOUNTOU, SEYTENGA and SAMPELGA 
	// Data were not correct 
	replace projected_deliveries_2018 = 1415			if commune == "FALAGOUNTOU" 
	replace assisted_deliveries_2018  = 1367			if commune == "FALAGOUNTOU" 

	replace projected_deliveries_2018 = 2110			if commune == "SEYTENGA" 
	replace assisted_deliveries_2018  = 1296			if commune == "SEYTENGA" 

	replace projected_deliveries_2018 =  773			if commune == "SAMPELGA" 
	replace assisted_deliveries_2018  =  713			if commune == "SAMPELGA" 

foreach commune in FALAGOUNTOU SEYTENGA SAMPELGA { 
	replace projected_deliveries_2018_check = projected_deliveries_2018	if commune == "`commune'" 
	replace assisted_deliveries_2018_check	= assisted_deliveries_2018 	if commune == "`commune'" 
} 


*----------- SUD_OUEST ----------- 
*--------------------------------- 

*--- Wrong data for DISSIN. 
	// Replace with the right values. 
	replace projected_deliveries_2018 	= 1928			if commune == "DISSIN" 
	replace assisted_deliveries_2018 	= 1954			if commune == "DISSIN" 

*--- Wrong data for ZAMBO. 
	// Replace with the right values. 
	replace projected_deliveries_2018 	= 964			if commune == "ZAMBO" 
	replace assisted_deliveries_2018 	= 719			if commune == "ZAMBO" 


*=================================== Replace double entry variables by the corrected values 

replace target_vaccination_bcg_2018_chec = target_vaccination_bcg_2018 		if target_vaccination_bcg_2018_chec != target_vaccination_bcg_2018 
replace vaccination_coverage_bcg_2018_ch = vaccination_coverage_bcg_2018 	if vaccination_coverage_bcg_2018_ch != vaccination_coverage_bcg_2018 
replace target_vaccination_vpo3_2018_che = target_vaccination_vpo3_2018		if target_vaccination_vpo3_2018_che != target_vaccination_vpo3_2018 
replace vaccination_coverage_vpo_2018_ch = vaccination_coverage_vpo_2018 	if vaccination_coverage_vpo_2018_ch	!= vaccination_coverage_vpo_2018 
replace v24 							 = target_vaccination_dtchephib3_20 if v24 								!= target_vaccination_dtchephib3_20 
replace v26 							 = vaccination_coverage_dtchephib3_ if v26 								!= vaccination_coverage_dtchephib3_ 
replace target_vaccination_var_2018_chec = target_vaccination_var_2018 		if target_vaccination_var_2018_chec != target_vaccination_var_2018 
replace vaccination_coverage_var_2018_ch = vaccination_coverage_var_2018 	if vaccination_coverage_var_2018_ch != vaccination_coverage_var_2018 
replace target_vaccination_vaa_2018_chec = target_vaccination_vaa_2018		if target_vaccination_vaa_2018_chec != target_vaccination_vaa_2018 
replace vaccination_coverage_vaa_2018_ch = vaccination_coverage_vaa_2018 	if vaccination_coverage_vaa_2018_ch != vaccination_coverage_vaa_2018 
replace target_vaccination_rr1_2018_chec = target_vaccination_rr1_2018		if target_vaccination_rr1_2018_chec != target_vaccination_rr1_2018 
replace vaccination_coverage_rr1_2018_ch = vaccination_coverage_rr1_2018 	if vaccination_coverage_rr1_2018_ch != vaccination_coverage_rr1_2018 


*=================================== SAVE DATA

save "${interm}/District Sanitaire ${year}_clean.dta", replace 

*=== Save 2018 data for scores calculation 

ren projected_deliveries_2018 		projected_deliveries 
ren assisted_deliveries_2018 		assisted_deliveries 

ren target_vaccination_bcg_2018 	target_vaccination_bcg 
ren vaccination_coverage_bcg_2018 	vaccination_coverage_bcg 

ren target_vaccination_vpo3_2018 	target_vaccination_vpo3 
ren vaccination_coverage_vpo_2018 	vaccination_coverage_vpo 

ren target_vaccination_dtchephib3_20 	target_vaccination_dtchephib3 
ren vaccination_coverage_dtchephib3_ 	vaccination_coverage_dtchephib3 

ren target_vaccination_var_2018 	target_vaccination_var 
ren vaccination_coverage_var_2018 	vaccination_coverage_var 

ren target_vaccination_vaa_2018 	target_vaccination_vaa 
ren vaccination_coverage_vaa_2018 	vaccination_coverage_vaa 

ren target_vaccination_rr1_2018 	target_vaccination_rr1 
ren vaccination_coverage_rr1_2018	vaccination_coverage_rr1 


save "${interm}/District Sanitaire.dta", replace 



*===============================================================================
*============================ INFIRMIER CHEF DE POSTE ==========================
*=============================================================================== 

clear all 
use "${raw}/Additional/Infirmier Chef de Poste ${year}.dta", clear   	  				// Save the temporary data 

ren fridge_power 	fridge_power_2018
ren power			power_2018

save "${raw}/Directeur Formation Sanitaire ${year}_add.dta", replace   	  				// Save the temporary data 

*============================= 
use "${raw}/Directeur Formation Sanitaire ${year}_WIDE.dta", clear   	  		// Save the temporary data 
append using "${raw}/Directeur Formation Sanitaire ${year}_add.dta", keep(deviceid region province district commune /// 
														  formation_sanitaire formation_sanitaire_autre 			/// 
														  fridge fridge_power_2018 power_2018 						/// 
														  bottles_gas stock_gas stock_gas_months					/// 
														  key submissiondate today) 

br if region == "" | province == "" | commune == "" 


*------- BOUCLE DU MOUHOUN ------- 
*--------------------------------- 


*----------- CASCADES ------------ 
*--------------------------------- 

*--- CSPS DAKORO from commune of DAKORO sent twice. 
	// The one with 2 bottles needed per month is the right 
br if commune == "DAKORO" 
drop if key == "uuid:aa13f38b-ee8e-4e6b-b30a-5e8c4f368a85" 


*----------- CENTRE-EST ---------- 
*--------------------------------- 


*----------- CENTRE-NORD --------- 
*--------------------------------- 


*----------- CENTRE-OUEST -------- 
*--------------------------------- 


*----------- CENTRE-SUD ---------- 
*--------------------------------- 

*--- CSPS "NAGNIMI" from commune of KOMBISSIRI sent twice. 
	// The one with ICP name "BILGO MOHAMED" is GOUDRY. 
br if formation_sanitaire == "NAGNIMI" 
replace formation_sanitaire = "GOUDRY"			if director_name == "BILGO MOHAMED" /// 
												 & formation_sanitaire == "NAGNIMI" & commune == "KOMBISSIRI" 


*-------------- EST -------------- 
*--------------------------------- 


*----------- HAUTS-BASSINS -------
*---------------------------------

*--- CSPS "ZANGOMA" from the commune of PADEMA sent twice. 
	// The one with IPC name "REMENE SERGE" is the good one. 
	// Drop the one with key = "uuid:b00520d0-4d15-4a27-bbf3-bfab2a1181ba". 
br if formation_sanitaire == "ZANGOMA" 
drop if key == "uuid:b00520d0-4d15-4a27-bbf3-bfab2a1181ba" 


*-------------- NORD -------------
*---------------------------------

*--- CSPS BANGO from commune of THIOU sent twice. 
	// Just drop one. 
br if formation_sanitaire == "BANGO" 
drop if key == "uuid:ca57eb38-dceb-4e77-84ab-671876183811" 


*-------- PLATEAU CENTRAL --------
*---------------------------------

*--- CSPS BOENA from commune of BOUDRY:  
	// 2 bottles needed per month, instead of 24. 
replace bottles_gas 	  = 2					if formation_sanitaire == "BOENA" & commune == "BOUDRY" 
replace bottles_gas_check = bottles_gas			if formation_sanitaire == "BOENA" & commune == "BOUDRY" 


*------------- SAHEL ------------- 
*--------------------------------- 

*--- CSPS HIGA from commune of TANKOUGOUNADIE sent twice. 
	// Just drop one. 
br if formation_sanitaire == "HIGA" 
drop if key == "uuid:ccd43094-9656-485d-aa88-2754601ad26a" 


*----------- SUD_OUEST ----------- 
*--------------------------------- 

*--- CSPS VARPOUO from commune of NIEGO sent twice. 
	// Just drop one. 
br if formation_sanitaire == "VARPOUO" 
drop if key == "uuid:911e2d4d-2ef6-4619-8984-b17f9718cb13" 


*=================================== SAVE DATA 

save "${interm}/Directeur Formation Sanitaire ${year}_clean.dta", replace 

*=== Save 2018 data for scores calculation 

save "${interm}/Directeur Formation Sanitaire.dta", replace 



*=============================================================================== 
*================================= MUNICIPALITE ================================ 
*=============================================================================== 

clear all 
use "${raw}/Municipalite ${year}_WIDE.dta", clear 								// Save the temporary data 

destring local_taxes_2016 local_taxes_forecast_2016 /// 						// Destring Local tax variables 
		 local_taxes_2017 local_taxes_forecast_2017 /// 
		 local_taxes_2018_amount local_taxes_forecast_2018, replace 

destring local_taxes_2016_check local_taxes_forecast_2016_check /// 
		 local_taxes_2017_check local_taxes_forecast_2017_check /// 
		 local_taxes_2018_amount_check local_taxes_forecast_2018_check, replace 


*----------- BOUCLE DU MOUHOUN ------------ 
*------------------------------------------ 

*--- Replace 2016 and 2017 local taxes for SAFANE. 
	// Data was missing due to Accountant unavailable 
replace local_taxes_2016 			=  58090232						if commune == "SAFANE" 
replace local_taxes_2017 			= 103000000						if commune == "SAFANE" 
replace local_taxes_forecast_2016 	=  54817808						if commune == "SAFANE" 
replace local_taxes_forecast_2017 	=  64783955						if commune == "SAFANE" 

replace local_taxes_2016_check 			= local_taxes_2016 			if commune == "SAFANE" 
replace local_taxes_2017_check 			= local_taxes_2017 			if commune == "SAFANE" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "SAFANE" 
replace local_taxes_forecast_2017_check = local_taxes_forecast_2017 if commune == "SAFANE" 
	
*--- Correct the value of Population for YAHO 
	// Value was very low (1,200) 
replace commune_population_number = 22851 							if commune == "YAHO" 
replace commune_population_number_check = commune_population_number if commune == "YAHO" 

*--- Correct the value of 2016 and 2017 local taxes for NOUNA 
	// Sudden taxes increase in from 2016 to 2017. Need to correct the data 
replace local_taxes_2016 		= 76376143				if commune == "NOUNA" 
replace local_taxes_2017 		= 90388688				if commune == "NOUNA" 
replace local_taxes_2016_check 	= local_taxes_2016 		if commune == "NOUNA" 
replace local_taxes_2017_check 	= local_taxes_2017 		if commune == "NOUNA" 

*--- Replace 2018 local taxes for BALAVE 
	// This was not calculated yet 
replace local_taxes_2018_amount 		= 10745729					if commune == "BALAVE" 
replace local_taxes_forecast_2018 		= 10333000					if commune == "BALAVE" 
replace local_taxes_2018_amount_check 	= local_taxes_2018 			if commune == "BALAVE" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "BALAVE" 

*--- Replace 2016 local taxes for TOENI 
	// This was missing due to insecurity 
replace local_taxes_2016 				= 0							if commune == "TOENI" 
replace local_taxes_forecast_2016 		= 53333188					if commune == "TOENI" 
replace local_taxes_2016_check 			= local_taxes_2016 			if commune == "TOENI" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "TOENI" 

*--- Correct local taxes, transferred resources and procurement for GOMBORO 
	// There were mistake in the data 
replace local_taxes_2016 			=  5518869						if commune == "GOMBORO" 
replace local_taxes_2017 			= 10375793						if commune == "GOMBORO" 
replace local_taxes_2018_amount 	=  8836780						if commune == "GOMBORO" 
replace local_taxes_forecast_2016 	=  9658000						if commune == "GOMBORO" 
replace local_taxes_forecast_2017 	=  9996000						if commune == "GOMBORO" 
replace local_taxes_forecast_2018 	= 15357404						if commune == "GOMBORO" 

replace local_taxes_2016_check 			= local_taxes_2016 			if commune == "GOMBORO" 
replace local_taxes_2017_check 			= local_taxes_2017 			if commune == "GOMBORO" 
replace local_taxes_2018_amount_check 	= local_taxes_2018_amount	if commune == "GOMBORO" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "GOMBORO" 
replace local_taxes_forecast_2017_check = local_taxes_forecast_2017 if commune == "GOMBORO" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "GOMBORO" 

replace ressources_transferees_2018 	 = 25279343 					if commune == "GOMBORO" 
replace depenses_ressources_transferees_ = 24781560 					if commune == "GOMBORO" 
replace ressources_transferees_2018_chec = ressources_transferees_2018 	if commune == "GOMBORO" 
replace v151 = depenses_ressources_transferees_							if commune == "GOMBORO" 

replace execution_equipment_procurement_ = 70 						if commune == "GOMBORO" 
replace v153 = execution_equipment_procurement_ 					if commune == "GOMBORO" 

*--- Replace Birth certificate data for GOMBORO 
	// This was missing due to strikes 
replace birth_certificates_2018 		= 1273						if commune == "GOMBORO" 
replace birth_certificates_2018_check 	= birth_certificates_2018 	if commune == "GOMBORO" 

*--- Correct local taxes and procurement for DOUMBALA 
	// Data were missing 
replace local_taxes_2016 			=  6322712						if commune == "DOUMBALA" 
replace local_taxes_2017 			=  9108969						if commune == "DOUMBALA" 
replace local_taxes_2018_amount 	=  9241701						if commune == "DOUMBALA" 
replace local_taxes_forecast_2016 	=  7310000						if commune == "DOUMBALA" 
replace local_taxes_forecast_2017 	=  9188000						if commune == "DOUMBALA" 
replace local_taxes_forecast_2018 	= 13619000						if commune == "DOUMBALA" 

replace local_taxes_2016_check 			= local_taxes_2016 			if commune == "DOUMBALA" 
replace local_taxes_2017_check 			= local_taxes_2017 			if commune == "DOUMBALA" 
replace local_taxes_2018_amount_check 	= local_taxes_2018_amount	if commune == "DOUMBALA" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "DOUMBALA" 
replace local_taxes_forecast_2017_check = local_taxes_forecast_2017 if commune == "DOUMBALA" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "DOUMBALA" 

replace execution_equipment_procurement_ = 75 						if commune == "DOUMBALA" 
replace v153 = execution_equipment_procurement_ 					if commune == "DOUMBALA" 

*--- Correct attendance score and 2016/2017 local taxes for KOMBORI 
	// Data were missing for all 4 sessions held 
replace councilor_attendance_meeting1 	= 29 				if commune == "KOMBORI" 
replace councilor_attendance_meeting2 	= 28 				if commune == "KOMBORI" 
replace councilor_attendance_meeting3 	= 28 				if commune == "KOMBORI" 
replace councilor_attendance_meeting4 	= 27 				if commune == "KOMBORI" 

replace date_2018meeting1 = date("03/15/2018", "MDY", 2050)	if commune == "KOMBORI" 
replace date_2018meeting2 = date("06/21/2018", "MDY", 2050)	if commune == "KOMBORI" 
replace date_2018meeting3 = date("11/22/2018", "MDY", 2050)	if commune == "KOMBORI" 
replace date_2018meeting4 = date("12/29/2018", "MDY", 2050)	if commune == "KOMBORI" 

forvalues t = 1/4 { 
replace councilor_attendance_meeting`t'_ch 	= councilor_attendance_meeting`t' /// 
	 if commune == "KOMBORI" 
} 

replace local_taxes_2016 			= 1516134						if commune == "KOMBORI" 
replace local_taxes_2017 			= 2516694						if commune == "KOMBORI" 
replace local_taxes_forecast_2016 	= 4857634						if commune == "KOMBORI" 
replace local_taxes_forecast_2017 	= 5008000						if commune == "KOMBORI" 

replace local_taxes_2016_check 			= local_taxes_2016 			if commune == "KOMBORI" 
replace local_taxes_2017_check 			= local_taxes_2017 			if commune == "KOMBORI" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "KOMBORI" 
replace local_taxes_forecast_2017_check = local_taxes_forecast_2017 if commune == "KOMBORI" 

*--- Replace Procurement data for KOMBORI 
	// There were missing in the data 
replace execution_equipment_procurement_ = 99 			if commune == "KOMBORI" 
replace v153 = execution_equipment_procurement_ 		if commune == "KOMBORI" 

*--- Replace Birth certificate data for KOMBORI 
	// This was missing due to strikes 
replace birth_certificates_2018 		= 77						if commune == "KOMBORI" 
replace birth_certificates_2018_check 	= birth_certificates_2018 	if commune == "KOMBORI" 

*--- Correct transferred resources for GASSAN 
	// Tranferees less than depensees. 
	// This is due to depensees include 2017 and 2018; but all 2018 have been used 
replace depenses_ressources_transferees_ = ressources_transferees_2018	if commune == "GASSAN" 
replace v151 = depenses_ressources_transferees_							if commune == "GASSAN" 

*--- Correct Birth certificate data for SOLENZO 
	// Data was wrong 
replace birth_certificates_2018 		= 6300						if commune == "SOLENZO" 
replace birth_certificates_2018_check 	= birth_certificates_2018 	if commune == "SOLENZO" 


*----------- CASCADES ------------ 
*--------------------------------- 

*--- Replace Birth certificate data for SOUBAKANIEDOUGOU 
	// This was missing due to strikes 
replace birth_certificates_2018 		= 590						if commune == "SOUBAKANIEDOUGOU" 
replace birth_certificates_2018_check 	= birth_certificates_2018 	if commune == "SOUBAKANIEDOUGOU" 

*--- Less than 20 councilors in DOUNA: 
	// Replace by the right value 
replace total_councilor  		= 20 if commune == "DOUNA" 
replace total_councilor_check   = 20 if commune == "DOUNA" 

*--- Correct Birth certificate data for NIANGOLOKO 
	// Data was wrong 
replace birth_certificates_2018 		= 1399						if commune == "NIANGOLOKO" 
replace birth_certificates_2018_check 	= birth_certificates_2018 	if commune == "NIANGOLOKO" 


*----------- CENTRE-EST ----------
*---------------------------------

*--- Replace Birth certificate data for DIALGAYE 
	// This was missing due to strikes 
replace birth_certificates_2018 		= 2661						if commune == "DIALGAYE" 
replace birth_certificates_2018_check 	= birth_certificates_2018 	if commune == "DIALGAYE" 

*--- Replace 2018 local taxes for ZOAGA 
	// This was not calculated yet 
replace local_taxes_2018_amount 		= 18058270					if commune == "ZOAGA" 
replace local_taxes_forecast_2018 		=  7050000					if commune == "ZOAGA" 
replace local_taxes_2018_amount_check 	= local_taxes_2018_amount	if commune == "ZOAGA" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "ZOAGA"  

*--- Replace 2016 local taxes for SANGHA 
	// This was missing 
replace local_taxes_2016 				= 12135000					if commune == "SANGA" 
replace local_taxes_forecast_2016 		= 24475000					if commune == "SANGA" 
replace local_taxes_2016_check 			= local_taxes_2016 			if commune == "SANGA" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "SANGA" 

*--- Replace Birth certificate data for BASKOURE 
	// This was missing due to strikes 
replace birth_certificates_2018 		= 402						if commune == "BASKOURE" 
replace birth_certificates_2018_check 	= birth_certificates_2018 	if commune == "BASKOURE" 


*----------- CENTRE-NORD ---------
*---------------------------------

*--- Correct 2018 local taxes forecast for ROLLO 
	// This was 4 times less than the others 
replace local_taxes_2018_amount 	= 17876053						if commune == "ROLLO" 
replace local_taxes_forecast_2018 	= 40863257						if commune == "ROLLO" 

replace local_taxes_2018_amount_check 	= local_taxes_2018_amount	if commune == "ROLLO" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "ROLLO" 

*--- Correct local taxes and transferred resources for BARSALOGHO 
	// There were mistake in the data 
replace local_taxes_2016 			= 28861945						if commune == "BARSALOGHO" 
replace local_taxes_2017 			= 37845310						if commune == "BARSALOGHO" 
replace local_taxes_2018_amount 	= 45981855						if commune == "BARSALOGHO" 
replace local_taxes_forecast_2016 	= 29355037						if commune == "BARSALOGHO" 
replace local_taxes_forecast_2017 	= 41155910						if commune == "BARSALOGHO" 
replace local_taxes_forecast_2018 	= 51026037						if commune == "BARSALOGHO" 

replace local_taxes_2016_check 			= local_taxes_2016 			if commune == "BARSALOGHO" 
replace local_taxes_2017_check 			= local_taxes_2017 			if commune == "BARSALOGHO" 
replace local_taxes_2018_amount_check 	= local_taxes_2018_amount	if commune == "BARSALOGHO" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "BARSALOGHO" 
replace local_taxes_forecast_2017_check = local_taxes_forecast_2017 if commune == "BARSALOGHO" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "BARSALOGHO" 

replace ressources_transferees_2018 	 = 52979795 					if commune == "BARSALOGHO" 
replace depenses_ressources_transferees_ = 39909075 					if commune == "BARSALOGHO" 
replace ressources_transferees_2018_chec = ressources_transferees_2018 	if commune == "BARSALOGHO" 
replace v151 = depenses_ressources_transferees_							if commune == "BARSALOGHO" 

*--- Correct transferred resources for NAMISSIGUIMA 
	// There were mistake in the data 
replace ressources_transferees_2018 	 = 11005736 					if commune == "NAMISSIGUIMA_KAYA" 
replace depenses_ressources_transferees_ = 7071909	 					if commune == "NAMISSIGUIMA_KAYA" 
replace ressources_transferees_2018_chec = ressources_transferees_2018 	if commune == "NAMISSIGUIMA_KAYA" 
replace v151 = depenses_ressources_transferees_							if commune == "NAMISSIGUIMA_KAYA" 

*--- Correct transferred resources for KAYA 
	// There were mistake in the data 
replace ressources_transferees_2018 	 = 13231596 					if commune == "KAYA" 
replace depenses_ressources_transferees_ =  7042752	 					if commune == "KAYA" 
replace ressources_transferees_2018_chec = ressources_transferees_2018 	if commune == "KAYA" 
replace v151 = depenses_ressources_transferees_							if commune == "KAYA" 

*--- Correct local taxes for YALGO 
	// Suddent growth in Local taxes from 2016 to 2017 and 2018 
	// Should be corrected by the right data 
replace local_taxes_forecast_2016 = 16375000						if commune == "YALGO" 
replace local_taxes_forecast_2017 = 224667429						if commune == "YALGO" 
replace local_taxes_forecast_2018 = 395987800						if commune == "YALGO" 

replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "YALGO" 
replace local_taxes_forecast_2017_check = local_taxes_forecast_2017 if commune == "YALGO" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "YALGO" 

*--- Correct transferred resources for BOUROUM 
	// Tranferees less than depensees. 
	// This is due to depensees include 2017 and 2018; but all 2018 have been used 
replace depenses_ressources_transferees_ = ressources_transferees_2018	if commune == "BOUROUM" 
replace v151 = depenses_ressources_transferees_							if commune == "BOUROUM" 

*--- Correct 2016 local taxes for PISSILA 
	// Data was missing 
replace local_taxes_forecast_2016 		= 14263025					if commune == "PISSILA" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "PISSILA" 

*--- Replace Procurement data for BOULSA 
	// Was set zero. Is missing due to strikes 
replace execution_equipment_procurement_ = 98 						if commune == "BOULSA" 
replace v153 = execution_equipment_procurement_ 					if commune == "BOULSA" 

*--- Correct Birth certificate data for NAGBINGOU 
	// Data was wrong 
replace birth_certificates_2018 		= 308						if commune == "NAGBINGOU" 
replace birth_certificates_2018_check 	= birth_certificates_2018 	if commune == "NAGBINGOU" 

*--- Zero ordinary sessions for DABLO 
	// Data was wrong 
replace total_num_ordinary_scm_2018 	 = 0							if commune == "DABLO" 
replace total_num_ordinary_scm_2018_chec = total_num_ordinary_scm_2018 	if commune == "DABLO" 


*----------- CENTRE-OUEST -------- 
*--------------------------------- 

*--- Replace Birth certificate data for POA 
	// This was missing due to strikes 
replace birth_certificates_2018 	  = 651							if commune == "POA" 
replace birth_certificates_2018_check = birth_certificates_2018 	if commune == "POA" 

*--- Correct transferred resources for KYON 
	// Tranferees less than depensees. 
	// This is due to depensees include 2017 and 2018; but all 2018 have been used 
replace depenses_ressources_transferees_ = ressources_transferees_2018	if commune == "KYON" 
replace v151 = depenses_ressources_transferees_							if commune == "KYON" 

*--- Replace Birth certificate data for BIEHA 
	// This was missing due to strikes 
replace birth_certificates_2018 	  = 793							if commune == "BIEHA" 
replace birth_certificates_2018_check = birth_certificates_2018 	if commune == "BIEHA" 

*--- Correct local taxes and transferred resources for DIDYR 
	// There were mistake in the data 
replace local_taxes_2018_amount 	= 13277943						if commune == "DIDYR" 
replace local_taxes_forecast_2016 	= 38051041						if commune == "DIDYR" 
replace local_taxes_forecast_2018 	= 15318433						if commune == "DIDYR" 

replace local_taxes_2018_amount_check 	= local_taxes_2018_amount	if commune == "DIDYR" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "DIDYR" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "DIDYR" 

*--- Replace Birth certificate data for DIDYR 
	// This was missing due to strikes 
replace birth_certificates_2018 	  = 986							if commune == "DIDYR" 
replace birth_certificates_2018_check = birth_certificates_2018 	if commune == "DIDYR" 

*--- Replace Local taxe and Procurement data for SOURGOU 
	// There were missing in the data 
replace execution_equipment_procurement_ = 76 			if commune == "SOURGOU" 
replace v153 = execution_equipment_procurement_ 		if commune == "SOURGOU" 
 
replace local_taxes_forecast_2018 		= 11702372					if commune == "SOURGOU" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018	if commune == "SOURGOU" 

*--- Correct transferred resources for KOUDOUGOU 
	// Tranferees less than depensees. 
	// This is due to depensees include 2017 and 2018; but all 2018 have been used 
replace depenses_ressources_transferees_ = ressources_transferees_2018	if commune == "KOUDOUGOU" 
replace v151 = depenses_ressources_transferees_							if commune == "KOUDOUGOU" 

*--- Correct 2018 local taxes for IMASGO 
	// Data was not calculated yet 
replace local_taxes_2018_amount 		= 12972030					if commune == "IMASGO" 
replace local_taxes_2018_amount_check 	= local_taxes_2018_amount	if commune == "IMASGO" 


*----------- CENTRE-SUD ---------- 
*--------------------------------- 

*--- Correct 2016 local taxes for PO 
	// They were missing 
replace local_taxes_2016 			= 169400000						if commune == "PO" 
replace local_taxes_forecast_2016 	= 157800000						if commune == "PO" 

replace local_taxes_2016_check 			= local_taxes_2016 			if commune == "PO" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "PO" 


*--------------- EST -------------
*---------------------------------

*--- Correct number of sessions and attendance for BARTIEBOUGOU 
	// No session in that commune due to insecurity 
replace total_num_scm_2018 					= 0 			if commune == "BARTIEBOUGOU" 
replace total_num_scm_2018_check  			= 0 			if commune == "BARTIEBOUGOU" 
replace total_num_extraordinary_scm_2018 	= 0 			if commune == "BARTIEBOUGOU" 
replace v64 = 0 											if commune == "BARTIEBOUGOU" 
replace total_num_ordinary_scm_2018 		= 0 			if commune == "BARTIEBOUGOU" 
replace total_num_ordinary_scm_2018_chec 	= 0 			if commune == "BARTIEBOUGOU" 

forvalues t = 1/4 { 
replace councilor_attendance_meeting`t' 	= . 			if commune == "BARTIEBOUGOU" 
replace councilor_attendance_meeting`t'_ch 	= . 			if commune == "BARTIEBOUGOU" 
} 

*--- Correct presence of "Agent Etat civil" for BARTIEBOUGOU 
	// There were mistake in the data 
replace agent_etat_civil_2018 = 0 							if commune == "BARTIEBOUGOU" 

*--- Correct presence of "Agent Etat civil" for FOUTOURI 
	// There were mistake in the data 
replace agent_etat_civil_2018 = 0 							if commune == "FOUTOURI" 

*--- Correct 1st session attendance for BILANGA 
	// There were mistake in the data 
replace councilor_attendance_meeting1 		= 123 							if commune == "BILANGA" 
replace councilor_attendance_meeting1_ch 	= councilor_attendance_meeting1 if commune == "BILANGA" 

*--- Correct transferred resources for BILANGA 
	// Tranferees less than depensees. 
	// This is due to depensees include 2017 and 2018; but all 2018 have been used 
replace depenses_ressources_transferees_ = ressources_transferees_2018	if commune == "BILANGA" 
replace v151 = depenses_ressources_transferees_							if commune == "BILANGA" 

*--- Replace Birth certificate data for TIBGA 
	// This was missing due to strikes 
replace birth_certificates_2018 		= 580						if commune == "TIBGA" 
replace birth_certificates_2018_check 	= birth_certificates_2018 	if commune == "TIBGA" 

/* BARTIEBOUGOU and FOUTOURI didn't deliver certificates because of Municipality burnt. */ 

*--- Correct local taxes, transferred resources and Attendance for BOTOU 
	// They were missing 
replace local_taxes_2016 			= 51599051						if commune == "BOTOU" 
replace local_taxes_2017 			= 58841104						if commune == "BOTOU" 
replace local_taxes_2018_amount 	= 79040272						if commune == "BOTOU" 
replace local_taxes_forecast_2016 	= 54411202						if commune == "BOTOU" 
replace local_taxes_forecast_2017 	= 57878492						if commune == "BOTOU" 
replace local_taxes_forecast_2018 	= 68319262						if commune == "BOTOU" 

replace local_taxes_2016_check 			= local_taxes_2016 			if commune == "BOTOU" 
replace local_taxes_2017_check 			= local_taxes_2017 			if commune == "BOTOU" 
replace local_taxes_2018_amount_check 	= local_taxes_2018_amount	if commune == "BOTOU" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "BOTOU" 
replace local_taxes_forecast_2017_check = local_taxes_forecast_2017 if commune == "BOTOU" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "BOTOU" 

/* 
replace ressources_transferees_2018 	 = 52979795 					if commune == "BOTOU" 
replace depenses_ressources_transferees_ = 39909075 					if commune == "BOTOU" 
replace ressources_transferees_2018_chec = ressources_transferees_2018 	if commune == "BOTOU" 
replace v151 = depenses_ressources_transferees_							if commune == "BOTOU" 
*/ 

replace execution_equipment_procurement_ = 60 			if commune == "BOTOU" 
replace v153 = execution_equipment_procurement_ 		if commune == "BOTOU" 

*--- Correct meeting Attendance for BOTOU and KOMPIENGA 
	// They were missing 
replace total_num_scm_2018 					= 6 								if commune == "BOTOU" 
replace total_num_ordinary_scm_2018 		= 4 								if commune == "BOTOU" 
replace total_num_extraordinary_scm_2018 	= 2 								if commune == "BOTOU" 

replace total_num_scm_2018_check  			= total_num_scm_2018 				if commune == "BOTOU" 
replace total_num_ordinary_scm_2018_chec 	= total_num_ordinary_scm_2018 		if commune == "BOTOU" 
replace v64 								= total_num_extraordinary_scm_2018 	if commune == "BOTOU" 

replace councilor_attendance_meeting1 	= 49 				if commune == "BOTOU" 
replace councilor_attendance_meeting2 	= 44 				if commune == "BOTOU" 
replace councilor_attendance_meeting3 	= 49 				if commune == "BOTOU" 
replace councilor_attendance_meeting4 	= 48 				if commune == "BOTOU" 

replace councilor_attendance_meeting1 	= 34 				if commune == "KOMPIENGA" 
replace councilor_attendance_meeting2 	= 34 				if commune == "KOMPIENGA" 
replace councilor_attendance_meeting3 	= 34 				if commune == "KOMPIENGA" 
replace councilor_attendance_meeting4 	= 34 				if commune == "KOMPIENGA" 

forvalues t = 1/4 { 
replace councilor_attendance_meeting`t'_ch 	= councilor_attendance_meeting`t' 	/// 
	 if commune == "BOTOU" | commune == "KOMPIENGA" 
} 

*--- Correct meeting dates for BOTOU 
	// They were missing 
replace date_2018meeting1 = date("03/07/2018", "MDY", 2050)	if commune == "BOTOU" 
replace date_2018meeting2 = date("06/18/2018", "MDY", 2050)	if commune == "BOTOU" 
replace date_2018meeting3 = date("10/18/2018", "MDY", 2050)	if commune == "BOTOU" 
replace date_2018meeting4 = date("12/07/2018", "MDY", 2050)	if commune == "BOTOU" 

*--- Replace Birth certificate data for KOMPIENGA and MADJOARI 
	// This was missing due to strikes 
replace birth_certificates_2018 		= 99						if commune == "MADJOARI" 
replace birth_certificates_2018_check  	= birth_certificates_2018 	if commune == "MADJOARI" 

replace birth_certificates_2018 		= 2972						if commune == "KOMPIENGA" 
replace birth_certificates_2018_check  	= birth_certificates_2018 	if commune == "KOMPIENGA" 

*--- Correct Birth certificate data for THION 
	// Data was wrong 
replace birth_certificates_2018 		= 968						if commune == "THION" 
replace birth_certificates_2018_check 	= birth_certificates_2018 	if commune == "THION" 

*--- Correct Birth certificate data for PARTIAGA 
	// Data was wrong 
replace local_taxes_2018_amount 	= 19224681						if commune == "PARTIAGA" 
replace local_taxes_forecast_2018 	= 103900000						if commune == "PARTIAGA" 
replace local_taxes_2018_amount_check 	= local_taxes_2018_amount	if commune == "PARTIAGA" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "PARTIAGA" 


*----------- HAUTS-BASSINS -------
*---------------------------------

*--- Correct 2016 and 2017 local taxes for KOUMBIA 
	// They were missing due to unavailable docmuents. 
replace local_taxes_2016 			= 11875599						if commune == "KOUMBIA" 
replace local_taxes_2017 			= 23000000						if commune == "KOUMBIA" 
replace local_taxes_forecast_2016 	= 13425400						if commune == "KOUMBIA" 
replace local_taxes_forecast_2017 	= 19275448						if commune == "KOUMBIA" 

replace local_taxes_2016_check 			= local_taxes_2016 			if commune == "KOUMBIA" 
replace local_taxes_2017_check 			= local_taxes_2017 			if commune == "KOUMBIA" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "KOUMBIA" 
replace local_taxes_forecast_2017_check = local_taxes_forecast_2017 if commune == "KOUMBIA" 

*--- Correct 2018 local taxes for KARANKASSO-VIGUE 
	// Was not calculated yet. 
replace local_taxes_2018_amount 		= 43773003					if commune == "KARANKASSO_VIGUE" 
replace local_taxes_forecast_2018 		= 30930270					if commune == "KARANKASSO_VIGUE" 
replace local_taxes_2018_amount_check 	= local_taxes_2018_amount 	if commune == "KARANKASSO_VIGUE" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "KARANKASSO_VIGUE" 

/* KARANKASSO-SAMBLA 
  * Staff start date missing: all are set 01/07/2018. 
  * Sessions dates missing for 2 sessions: all are set 01/07/2018. 
  * Missing participation for 2 sessions: They are set 1. 
*/ 
*--- Correct number of sessions and attendance and councilors for KARANKASSO-SAMBLA 
	// Missing participation for 2 sessions  (While they delared 4 sessions) 
	// Data was missing for KARANKASSO-SAMBLA
replace councilor_attendance_meeting1 	= 27 				if commune == "KARANKASSO_SAMBLA" 
replace councilor_attendance_meeting2 	= 27 				if commune == "KARANKASSO_SAMBLA" 
replace councilor_attendance_meeting3 	= 28 				if commune == "KARANKASSO_SAMBLA" 
replace councilor_attendance_meeting4 	= 26 				if commune == "KARANKASSO_SAMBLA" 

forvalues t = 1/4 { 
replace councilor_attendance_meeting`t'_ch 	= councilor_attendance_meeting`t' 	/// 
	 if commune == "KARANKASSO_SAMBLA" 
} 

replace date_2018meeting1 = date("04/15/2018", "MDY", 2050)	if commune == "KARANKASSO_SAMBLA" 
replace date_2018meeting2 = date("07/15/2018", "MDY", 2050)	if commune == "KARANKASSO_SAMBLA" 
replace date_2018meeting3 = date("09/15/2018", "MDY", 2050)	if commune == "KARANKASSO_SAMBLA" 
replace date_2018meeting4 = date("11/15/2018", "MDY", 2050)	if commune == "KARANKASSO_SAMBLA" 

*--- Less than 20 councilors in KARANKASSO_SAMBLA 
	// Replace by the right value 
replace total_councilor  		= 30 if commune == "KARANKASSO_SAMBLA" 
replace total_councilor_check   = 30 if commune == "KARANKASSO_SAMBLA" 

*--- Correct 2018 local taxes for LENA 
	// Was not calculated yet. 
replace local_taxes_2018_amount 		= 7582989					if commune == "LENA" 
replace local_taxes_forecast_2018 		= 8115000					if commune == "LENA" 

replace local_taxes_2018_amount_check 	= local_taxes_2018_amount 	if commune == "LENA" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "LENA" 

*--- Correct transferred resources for LENA 
	// Data were missing 
replace ressources_transferees_2018 	 = 103802778					if commune == "LENA" 
replace depenses_ressources_transferees_ = 	93673916					if commune == "LENA" 

replace ressources_transferees_2018_chec = ressources_transferees_2018	if commune == "LENA" 
replace v151 = depenses_ressources_transferees_							if commune == "LENA" 

*--- Correct number of sessions and attendance for LENA 
	// Missing participation for 2 first sessions (While they delared 4 sessions) 
forvalues t = 1/2 { 
replace councilor_attendance_meeting`t' 	= . 			if commune == "LENA" 
replace councilor_attendance_meeting`t'_ch 	= . 			if commune == "LENA" 
} 

forvalues t = 1/2 { 
replace councilor_attendance_meeting`t'_ch 	= councilor_attendance_meeting`t' 	/// 
	 if commune == "LENA" 
} 

*--- Correct 2018 local taxes for ORODARA 
	// Was not calculated yet 
replace local_taxes_2018_amount 		=  95337142						if commune == "ORODARA" 
replace local_taxes_forecast_2018 		= 129653444 					if commune == "ORODARA" 

replace local_taxes_2018_amount_check 	= local_taxes_2018_amount 		if commune == "ORODARA" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 	if commune == "ORODARA" 

*--- Correct local taxes for KOUNDOUGOU 
	// There were missing in the data 
replace local_taxes_2018_amount 	= 10973965						if commune == "KOUNDOUGOU" 
replace local_taxes_forecast_2018 	=  7870000						if commune == "KOUNDOUGOU" 

replace local_taxes_2018_amount_check 	= local_taxes_2018_amount	if commune == "KOUNDOUGOU" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "KOUNDOUGOU" 

*--- Correct attendance score for KOUNDOUGOU 
	// Data were missing for all 4 sessions held 
replace councilor_attendance_meeting1 	= 17 				if commune == "KOUNDOUGOU" 
replace councilor_attendance_meeting2 	= 16 				if commune == "KOUNDOUGOU" 
replace councilor_attendance_meeting3 	= 18 				if commune == "KOUNDOUGOU" 
replace councilor_attendance_meeting4 	= 18 				if commune == "KOUNDOUGOU" 

replace date_2018meeting1 = date("02/26/2018", "MDY", 2050)	if commune == "KOUNDOUGOU" 
replace date_2018meeting2 = date("05/09/2018", "MDY", 2050)	if commune == "KOUNDOUGOU" 
replace date_2018meeting3 = date("06/18/2018", "MDY", 2050)	if commune == "KOUNDOUGOU" 
replace date_2018meeting4 = date("10/30/2018", "MDY", 2050)	if commune == "KOUNDOUGOU" 

forvalues t = 1/4 { 
replace councilor_attendance_meeting`t'_ch 	= councilor_attendance_meeting`t' /// 
	 if commune == "KOUNDOUGOU" 
} 


*--------------- NORD ------------ 
*--------------------------------- 

*--- Replace Birth certificate data for LEBA 
	// This was missing due to strikes 
replace birth_certificates_2018 		= 768						if commune == "LEBA" 
replace birth_certificates_2018_check 	= birth_certificates_2018 	if commune == "LEBA" 

*--- Correct 2016 local taxes for KOUMBRI 
	// They were missing due to unavailable docmuents. 
replace local_taxes_2016 			= 14017000						if commune == "KOUMBRI" 
replace local_taxes_forecast_2016 	= 12969000						if commune == "KOUMBRI" 

replace local_taxes_2016_check 			= local_taxes_2016 			if commune == "KOUMBRI" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "KOUMBRI" 

*--- Correct transferred resources for KALSAKA 
	// Tranferees less than depensees. 
	// This is due to depensees include 2017 and 2018; but all 2018 have been used 
replace depenses_ressources_transferees_ = ressources_transferees_2018	if commune == "KALSAKA" 
replace v151 = depenses_ressources_transferees_							if commune == "KALSAKA" 

*--- Replace Birth certificate data for OUINDIGUI 
	// This was missing due to strikes 
replace birth_certificates_2018 		= 583						if commune == "OUINDIGUI" 
replace birth_certificates_2018_check 	= birth_certificates_2018 	if commune == "OUINDIGUI" 

*--- Zero ordinary sessions for OUINDIGUI 
	// Data was wrong 
replace total_num_ordinary_scm_2018 	 = 0							if commune == "OUINDIGUI" 
replace total_num_ordinary_scm_2018_chec = total_num_ordinary_scm_2018 	if commune == "OUINDIGUI" 

*--- Correct transferred resources for YAKO 
	// Data were missing 
replace ressources_transferees_2018 	 = 306220379					if commune == "YAKO" 
replace depenses_ressources_transferees_ = 189866169					if commune == "YAKO" 

replace ressources_transferees_2018_chec = ressources_transferees_2018	if commune == "YAKO" 
replace v151 = depenses_ressources_transferees_							if commune == "YAKO" 

*--- Correct transferred resources for NAMISSIGUIMA_OUAHIGOUYA 
	// Tranferees less than depensees. 
	// This is due to depensees include 2017 and 2018; but all 2018 have been used 
replace depenses_ressources_transferees_ = ressources_transferees_2018	if commune == "NAMISSIGUIMA_OUAHIGOUYA" 
replace v151 = depenses_ressources_transferees_							if commune == "NAMISSIGUIMA_OUAHIGOUYA" 

*--- Correct transferred resources for THIOU 
	// Tranferees less than depensees. 
	// This is due to depensees include 2017 and 2018; but all 2018 have been used 
replace depenses_ressources_transferees_ = ressources_transferees_2018	if commune == "THIOU" 
replace v151 = depenses_ressources_transferees_							if commune == "THIOU" 

*--- Correct Birth certificate data for OUAHIGOUYA 
	// Data was wrong 
replace birth_certificates_2018 		= 4618						if commune == "OUAHIGOUYA" 
replace birth_certificates_2018_check 	= birth_certificates_2018 	if commune == "OUAHIGOUYA" 


*--------- PLATEAU CENTRAL ------- 
*--------------------------------- 

*--- Correct transferred resources for ZORGHO 
	// Tranferees less than depensees. 
	// This is due to depensees include 2017 and 2018; but all 2018 have been used 
replace depenses_ressources_transferees_ = ressources_transferees_2018	if commune == "ZORGHO" 
replace v151 = depenses_ressources_transferees_							if commune == "ZORGHO" 


*--------------- SAHEL ----------- 
*--------------------------------- 

*--- Correct 2016 and 2017 local taxes for NASSOUMBOU 
	// They were missing due to unavailable docmuents 
replace local_taxes_2017 			=  7599032						if commune == "NASSOUMBOU" 
replace local_taxes_forecast_2017 	= 10896331						if commune == "NASSOUMBOU" 

replace local_taxes_2016_check 			= local_taxes_2017 			if commune == "NASSOUMBOU" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2017 if commune == "NASSOUMBOU" 

*--- Replace Procurement data for MANSILA 
	// There were error in tha data (No activity in that commune) 
replace execution_equipment_procurement_ = 0 						if commune == "MANSILA" 
replace v153 = execution_equipment_procurement_ 					if commune == "MANSILA" 

*--- Correct local taxes for MANSILA 
	// They were missing 
replace local_taxes_2016 			= 17869412						if commune == "MANSILA" 
replace local_taxes_2017 			= 20500000						if commune == "MANSILA" 
replace local_taxes_2018_amount 	= 0								if commune == "MANSILA" // Missing due to insecurity, and municipality didn't work in 2018 
replace local_taxes_forecast_2016 	= 14213707						if commune == "MANSILA" 
replace local_taxes_forecast_2017 	= 16925000						if commune == "MANSILA" 
replace local_taxes_forecast_2018 	= 21710664 						if commune == "MANSILA" 

replace local_taxes_2016_check 			= local_taxes_2016 			if commune == "MANSILA" 
replace local_taxes_2017_check 			= local_taxes_2017 			if commune == "MANSILA" 
replace local_taxes_2018_amount_check 	= local_taxes_2018_amount	if commune == "MANSILA" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "MANSILA" 
replace local_taxes_forecast_2017_check = local_taxes_forecast_2017 if commune == "MANSILA" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "MANSILA" 

*--- Correct local taxes for DEOU 
	// They were missing 
replace local_taxes_2016 			= 24255024						if commune == "DEOU" 
replace local_taxes_2017 			= 28500000						if commune == "DEOU" 
replace local_taxes_2018_amount 	= 0								if commune == "DEOU" // Missing due to insecurity, and municipality didn't work in 2018 
replace local_taxes_forecast_2016 	= 26535394						if commune == "DEOU" 
replace local_taxes_forecast_2017 	= 31656728						if commune == "DEOU" 
replace local_taxes_forecast_2018 	= 37079975 						if commune == "DEOU" 

replace local_taxes_2016_check 			= local_taxes_2016 			if commune == "DEOU" 
replace local_taxes_2017_check 			= local_taxes_2017 			if commune == "DEOU" 
replace local_taxes_2018_amount_check 	= local_taxes_2018_amount	if commune == "DEOU" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "DEOU" 
replace local_taxes_forecast_2017_check = local_taxes_forecast_2017 if commune == "DEOU" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "DEOU" 

*--- Local taxe for 2016 and 2017 missing for OURSI (due to Insecurity and archives not available) 
	// Data replaced from 2017 data set 
replace local_taxes_2016 			=  5426202						if commune == "OURSI" 
replace local_taxes_2017 			=  7612373						if commune == "OURSI" 
replace local_taxes_forecast_2016 	=  7562206						if commune == "OURSI" 
replace local_taxes_forecast_2017 	= 11339109						if commune == "OURSI" 

replace local_taxes_2016_check 			= local_taxes_2016 			if commune == "OURSI" 
replace local_taxes_2017_check 			= local_taxes_2017 			if commune == "OURSI" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "OURSI" 
replace local_taxes_forecast_2017_check = local_taxes_forecast_2017 if commune == "OURSI" 

*--- Correct 2016, 2017 and 2018 local taxes forecast for BARABOULE 
	// They were missing due to unavailable docmuents. 
replace local_taxes_forecast_2016 = 12113008						if commune == "BARABOULE" 
replace local_taxes_forecast_2017 = 11402307						if commune == "BARABOULE" 
replace local_taxes_forecast_2018 =  9863200						if commune == "BARABOULE" 

replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "BARABOULE" 
replace local_taxes_forecast_2017_check = local_taxes_forecast_2017 if commune == "BARABOULE" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "BARABOULE" 

*--- Correct 2018 local taxes forecast for KOUTOUGOU 
	// They were missing. 
replace local_taxes_2018_amount 		= 0							if commune == "KOUTOUGOU" 
replace local_taxes_forecast_2018 		= 108475424					if commune == "KOUTOUGOU" 
replace local_taxes_2018_amount_check 	= local_taxes_2018_amount	if commune == "KOUTOUGOU" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018	if commune == "KOUTOUGOU" 

*--- Less than 20 councilors in DJIBO 
	// Replace by the right value 
replace total_councilor  		= 76 if commune == "DJIBO" 
replace total_councilor_check   = 76 if commune == "DJIBO" 

*--- Correct 2018 local taxes for SAMPELGA 
	// Data was not calculated yet 
replace local_taxes_2018_amount 		= 19762474					if commune == "SAMPELGA" 
replace local_taxes_forecast_2018 		= 59202508					if commune == "SAMPELGA" 
replace local_taxes_2018_amount_check 	= local_taxes_2018_amount	if commune == "SAMPELGA" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "SAMPELGA" 


*------------ SUD-OUEST ---------- 
*--------------------------------- 

*--- Correct 2018 local taxes for DIEBOUGOU 
	// Was not calculated yet 
replace local_taxes_2018_amount 		= 180698680					if commune == "DIEBOUGOU" 
replace local_taxes_2018_amount_check 	= local_taxes_2018_amount 	if commune == "DIEBOUGOU" 

*--- Correct 2018 local taxes for KAMPTI 
	// Was not calculated yet 
replace villages 		= 117					if commune == "KAMPTI" 
replace villages_check  = villages 				if commune == "KAMPTI" 


*=================================== SAVE DATA 

save "${interm}/Municipalite ${year}_clean.dta", replace 

*=== Save 2018 data for scores calculation 

ren secretaire_g_2018 		secretaire_g 
ren agent_secretaire_2018 	agent_secretaire 
ren agent_etat_civil_2018 	agent_etat_civil 
ren comptable_2018 			comptable 
ren regisseur_2018 			regisseur_recettes 
ren agent_materiel_2018 	agent_materiel_transfere 
ren agent_service_tech_2018 agent_service_techniques 
ren agent_affaires_dom_2018 agent_affaires_domaniales 

gen agent_services_statistiques = agent_etat_civil 

ren sds_2018 					 	 sds 
ren total_num_sds_2018 			 	 total_num_sds 
ren total_num_ordinary_sds_2018  	 total_num_ordinary_sds 
ren total_num_extraordinary_sds_2018 total_num_extraordinary_sds 
ren total_num_ordinary_scm_2018  	 total_num_ordinary_scm 
ren total_num_scm_2018 				 total_num_scm 
ren total_num_extraordinary_scm_2018 total_num_extraordinary_scm 

ren num_journee_redevabilite_2018 	 num_journee_redevabilite 

ren ressources_transferees_2018 	 ressources_transferees 
ren depenses_ressources_transferees_ depenses_ressources_transferees 

ren execution_equipment_procurement_ execution_equipment_procurement 

ren birth_certificates_2018 birth_certificates 


forvalues i = 1/4 { 
	replace councilor_attendance_meeting`i' = . /// 
		 if total_num_ordinary_scm >= `i' & councilor_attendance_meeting`i' == 0 
	replace councilor_attendance_meeting`i'_ch = councilor_attendance_meeting`i' 
} 

gen special_delegation = 0 
order special_delegation, before(total_num_sds) 
gen municipal_council  = 1 
order municipal_council, before(total_councilor) 

forvalues i = 1/4 { 
	gen councilor_attendance_meeting`i'sd = . if special_delegation == 0 
	order councilor_attendance_meeting`i'sd, before(municipal_council) 
} 


replace local_taxes_2018 = 1 if local_taxes_2018_amount != 0 & local_taxes_2018_amount != . 

forvalues t = 6/7 { 
replace local_taxes_201`t' = . 				if local_taxes_201`t' == 0 
replace local_taxes_forecast_201`t' = . 	if local_taxes_forecast_201`t' == 0 

replace local_taxes_201`t'_check 			= local_taxes_201`t' 
replace local_taxes_forecast_201`t'_check 	= local_taxes_forecast_201`t' 
} 

replace depenses_ressources_transferees = ressources_transferees /// 
	 if depenses_ressources_transferees < ressources_transferees 

save "${interm}/Municipalite.dta", replace 



*=============================================================================== 
*============================== ACCES A L'EAU POTABLE ========================== 
*=============================================================================== 

/* Data on Water access is from the ministry in charge of Water and Sanitation 
   The data is received in Excel format and then imported to Stata */ 

use "${raw}/Access Potable Water ${year}.dta", clear 							// Open raw data 

br if REGION == "" | PROVINCE == "" | COMMUNE == "" 

ren REGION region 
ren PROVINCE province 
ren COMMUNE commune 

ren Population2018 compop2018 													// Rename the variable as in the previous data sets 
ren Taux tauxaccess 															// Rename the variable as in the previous data sets 
replace tauxaccess = round(tauxaccess * 100, .01) 								// Rescale the values (thir imported values are between 0 and 1) 

/* Two communes are not part is this data collection */ 

drop if commune == "OUAGADOUGOU" | commune == "BOBO-DIOULASSO" 


*=== Save 2018 data for scores calculation 

keep region province commune compop2018 tauxaccess 

save "${interm}/Access Potable Water ${year}_clean.dta", replace 
save "${interm}/Access Potable Water.dta", replace 


*=============================================================================== 
*=============================================================================== 
*=============================================================================== 
*=============================================================================== 

