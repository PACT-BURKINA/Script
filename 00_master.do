*! Version 1.7 Sékou KONE 		 26Aug2019 
*! Version 1.6 Sékou KONE 		 28Sep2018 
*! Version 1.5 Christopher Boyer 28dec2016 

/* This is the master file for the creation of infographic 
   posters for the WB's DIME team. The program cleans the 
   raw data from several surveys; calculates indicator 
   scores, values, and totals; and updates the graphics 
   of two infographic posters summarizing the performance 
   of 140 municipal governments in Burkina Faso. */

clear
version 13
set more off
	global supermun2018 "C:/Users/850/Dropbox/Burkina PACT/2. PACT Phase 2/06. SUPERMUN/07. Data collection/2019/4. Data/INDICATEURS_SUPERMUN_2018" 
	cd "$supermun2018" 

/* =================================================== 
   ================== set globals ==================== 
   =================================================== */ 

global year = 2018 
global national_average = 64.8 
global groupnames = 0 

/* Completed Sets: 
    (+) year = 2014
		national average = 82.2 
		groupnames = 1
	(+) year = 2015
	    national average = 73.5
		groupnames = 0 
    (+) year = 2016
	    national average = 62.1
		groupnames = 0 
    (+) year = 2017
	    national average = 73.7
		groupnames = 0 
		Source: Annuaire statistique 2016-2017, MENA, Page 446. "http://cns.bf/IMG/pdf/annuaire_primaire_2016_2017_final.pdf"
    (+) year = 2018
	    national average = 64.8 
		Source: http://www.mena.gov.bf/index.php?option=com_content&view=article&id=1236:
		point-de-presse-du-gouvernement-le-bilan-des-examens-scolaires-session-de-2018-porte-a-l-opinion&catid=168&Itemid=506
		groupnames = 0  */ 

* define subfolders
global dofile  	"dofile" 
global raw  	"data/raw" 
global interm   "data/intermediary" 
global final  	"data/final" 
global json 	"data/json" 

* create subfolders if they don't already exist 
foreach dir in $interm $final $json { 
	capture drop "`dir'" 
	cap confirm file "`dir'/nul" 
	if _rc { 
		mkdir "`dir'" 
	} 
} 


/* =================================================== 
   ================== run do-files =================== 
   =================================================== */ 

do "01_clean_0.do" 
do "01_clean_1.do" 
do "01_identifiers_2.do" 

do "02_calculate_scores_ic.do" 
do "02_calculate_scores_sd.do" 
+
do "02_completed_data_for_posters_3.do" 

do "03_create_JSON.do" 

