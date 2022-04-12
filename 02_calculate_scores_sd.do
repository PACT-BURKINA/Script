*! Contributors: Chris Boyer, Sidiki Soubeiga, Tara Balakrishnan, Sekou Koné, Malte Lierl
*! PI: Malte Lierl, co-PI: Marcus Holmlund
*! Version: 2018-05-15

/* this file calculates indicator values, scores and score totals 
   for the SUPERMUN service delivery indicators (Scorecard Poster 2). */
   
version 13
set more off

/* =================================================== 
   ====================== SETUP ======================
   =================================================== */

* 2018 parameters
global year = 2018
global national_average = 64.8
global groupnames = 0   
*
   
/* 2017 parameters 
global year = 2017 
global national_average = 73.24
global groupnames = 0 
*/
   
/* 2016 parameters 
global year = 2016 
global national_average = 62.1 
global groupnames = 0 
*/

/* 2015 parameters 
global year = 2015
global national_average = 73.3
global groupnames = 0 
*/

/* 2014 parameters 
global year = 2014
global national_average = 65.2
global groupnames = 1 
*/

		
/* =================================================== 
   ========== SERVICE DELIVERY (POSTER 2) ============ 
   =================================================== */
	
* read csv file with raw indicator data
use "${final}/merged.dta", clear
	
  /* Note - aggregate_final.csv is created in a separate do-file by
     combining the ecole, district sanitaire, CEB, water access, and 
	 questionnaire files and aggregating data to the district level */

/* 1. indicator values - the number at the bottom of
   the sliding scale in the infographic */

* Students passing CEP exam: Difference to national average (in percentage points)
g value_passing_exam = 100 * (sd_a_01students_admitted_exam / sd_a_01total_students_sitting_ex) - $national_average

* Delay in receiving school supplies (weeks after start of school year) 
g value_school_supplies = supplies_received

* Latrines: check indicator definition
* Previous comment: "calculated by aggregating number of latrines per class"
g value_school_latrines = 100 * functional_latrine

* Percentage of schools with functioning water source
g value_school_wells = 100 * functional_water

* Percentage of assisted births
g value_assisted_births = 100 * assisted_deliveries / projected_deliveries

* Vaccination coverage
g bcg = vaccination_coverage_bcg / target_vaccination_bcg

g vpo3 = vaccination_coverage_vpo / target_vaccination_vpo3 

g dtc = vaccination_coverage_dtchephib3 / target_vaccination_dtchephib3

g vaa  = vaccination_coverage_vaa / target_vaccination_vaa

g var = vaccination_coverage_var / target_vaccination_var

* RR1 replaces VAR from 2017 onwards. Take the maximum among the two vaccination rates for every commune. 

g rr1var = var 
cap g rr1  = vaccination_coverage_rr1 / target_vaccination_rr1
cap replace rr1var = rr1 if (rr1!=. & (rr1>var | var==.))

* Average coverage of 5 vaccines
g value_vaccines = (bcg + vpo3 + dtc + vaa + rr1var)/5 * 100
/* Isn't the indicator the proportion of newborns vaccinated with all five vaccines? 
   So we can't use the average vaccination rate across the five. 
   If no better data is available, we should use the minimum of the five?? */

* Gas stockouts: check indicator definition
g value_csps = 100 * sd_a_01stock_gas

* Water access rate
g value_water_access = tauxaccess

* Birth certificate coverage
g value_birth_certificates = 100 * birth_certificates / projected_deliveries
/* Shouldn't this be defined as a fraction of recorded, rather than projected deliveries */


/* 2. indicator scores - the number at the top of the
   sliding scale in the infographic */

* difference from national average in pass rates of CEP
g score_passing_exam = .
replace score_passing_exam = 0 if value_passing_exam != .
replace score_passing_exam = 1 if value_passing_exam <= -40 
replace score_passing_exam = 2 if value_passing_exam <= -30 & value_passing_exam > -40
replace score_passing_exam = 3 if value_passing_exam <= -25 & value_passing_exam > -30
replace score_passing_exam = 4 if value_passing_exam <= -20 & value_passing_exam > -25
replace score_passing_exam = 5 if value_passing_exam <= -15 & value_passing_exam > -20
replace score_passing_exam = 6 if value_passing_exam <= -10 & value_passing_exam > -15
replace score_passing_exam = 7 if value_passing_exam <= -5 & value_passing_exam > -10
replace score_passing_exam = 8 if value_passing_exam <= 5 & value_passing_exam > -5
replace score_passing_exam = 9 if value_passing_exam <= 10 & value_passing_exam > 5
replace score_passing_exam = 10 if value_passing_exam <= 15 & value_passing_exam > 10
replace score_passing_exam = 12 if value_passing_exam <= 20 & value_passing_exam > 15
replace score_passing_exam = 14 if value_passing_exam <= 25 & value_passing_exam > 20
replace score_passing_exam = 18 if value_passing_exam <= 35 & value_passing_exam > 25
replace score_passing_exam = 20 if value_passing_exam > 35 & value_passing_exam < .

* delay in provision of school supplies
g score_school_supplies = .
replace score_school_supplies = 0 if value_school_supplies != .
replace score_school_supplies = 10 if value_school_supplies <= 1
replace score_school_supplies = 10 / (value_school_supplies ^ 0.5) if value_school_supplies > 1 & value_school_supplies <= 200
replace score_school_supplies = 0 if value_school_supplies > 200 & !mi(value_school_supplies)

* percentage of schools with working water source
g score_school_wells = .
replace score_school_wells = 0 if value_school_wells != .
replace score_school_wells = 1 if value_school_wells < 20 & value_school_wells >= 0
replace score_school_wells = 2 if value_school_wells < 25 & value_school_wells >= 20
replace score_school_wells = 3 if value_school_wells < 30 & value_school_wells >= 25
replace score_school_wells = 4 if value_school_wells < 35 & value_school_wells >= 30
replace score_school_wells = 5 if value_school_wells < 40 & value_school_wells >= 35
replace score_school_wells = 6 if value_school_wells < 45 & value_school_wells >= 40
replace score_school_wells = 7 if value_school_wells < 50 & value_school_wells >= 45
replace score_school_wells = 8 if value_school_wells < 55 & value_school_wells >= 50
replace score_school_wells = 9 if value_school_wells < 60 & value_school_wells >= 55
replace score_school_wells = 10 if value_school_wells < 65 & value_school_wells >= 60
replace score_school_wells = 11 if value_school_wells < 70 & value_school_wells >= 65
replace score_school_wells = 12 if value_school_wells < 75 & value_school_wells >= 70
replace score_school_wells = 13 if value_school_wells < 80 & value_school_wells >= 75
replace score_school_wells = 14 if value_school_wells < 85 & value_school_wells >= 80
replace score_school_wells = 15 if value_school_wells < 90 & value_school_wells >= 85
replace score_school_wells = 16 if value_school_wells < 95 & value_school_wells >= 90
replace score_school_wells = 20 if value_school_wells < 100 & value_school_wells >= 95
replace score_school_wells = 25 if value_school_wells >= 100 & value_school_wells < .

* percentage of schools with functioning latrines for each class
g score_school_latrines = .
replace score_school_latrines = 0 if value_school_latrines != .
replace score_school_latrines = 1 if value_school_latrines >= 30 & value_school_latrines < . 
replace score_school_latrines = 2 if value_school_latrines >= 35 & value_school_latrines < .
replace score_school_latrines = 3 if value_school_latrines >= 40 & value_school_latrines < .
replace score_school_latrines = 4 if value_school_latrines >= 50 & value_school_latrines < .
replace score_school_latrines = 5 if value_school_latrines >= 55 & value_school_latrines < .
replace score_school_latrines = 6 if value_school_latrines >= 60 & value_school_latrines < .
replace score_school_latrines = 7 if value_school_latrines >= 65 & value_school_latrines < .
replace score_school_latrines = 8 if value_school_latrines >= 70 & value_school_latrines < .
replace score_school_latrines = 9 if value_school_latrines >= 75 & value_school_latrines < .
replace score_school_latrines = 10 if value_school_latrines >= 80 & value_school_latrines < .
replace score_school_latrines = 11 if value_school_latrines >= 85 & value_school_latrines < .
replace score_school_latrines = 12 if value_school_latrines >= 90 & value_school_latrines < .
replace score_school_latrines = 14 if value_school_latrines >= 95 & value_school_latrines < .
replace score_school_latrines = 15 if value_school_latrines >= 100 & value_school_latrines < .

* percentage of births assisted by trained health worker
g score_assisted_births = .
replace score_assisted_births = 0 if value_assisted_births != .
replace score_assisted_births = 1 if value_assisted_births >= 40 & value_assisted_births < .
replace score_assisted_births = 2 if value_assisted_births >= 55 & value_assisted_births < .
replace score_assisted_births = 4 if value_assisted_births >= 60 & value_assisted_births < .
replace score_assisted_births = 5 if value_assisted_births >= 65 & value_assisted_births < .
replace score_assisted_births = 7 if value_assisted_births >= 70 & value_assisted_births < .
replace score_assisted_births = 8 if value_assisted_births >= 75 & value_assisted_births < .
replace score_assisted_births = 9 if value_assisted_births >= 80 & value_assisted_births < .
replace score_assisted_births = 10 if value_assisted_births >= 85 & value_assisted_births < .
replace score_assisted_births = 11 if value_assisted_births >= 90 & value_assisted_births < .
replace score_assisted_births = 12 if value_assisted_births >= 95 & value_assisted_births < .
replace score_assisted_births = 13 if value_assisted_births >= 100 & value_assisted_births < .
replace score_assisted_births = 14 if value_assisted_births >= 110 & value_assisted_births < .
replace score_assisted_births = 15 if value_assisted_births >= 120 & value_assisted_births < .

* percentage of infants vaccinated for BCG, VAR, VAA, VPO3, and DTC-Hep+Hib3
g score_vaccines = .
replace score_vaccines = 0 if value_vaccines != .
replace score_vaccines = 1 if value_vaccines >= 60 & value_vaccines < .
replace score_vaccines = 2 if value_vaccines >= 65 & value_vaccines < .
replace score_vaccines = 3 if value_vaccines >= 70 & value_vaccines < .
replace score_vaccines = 5 if value_vaccines >= 75 & value_vaccines < .
replace score_vaccines = 7 if value_vaccines >= 80 & value_vaccines < .
replace score_vaccines = 8 if value_vaccines >= 85 & value_vaccines < .
replace score_vaccines = 9 if value_vaccines >= 90 & value_vaccines < .
replace score_vaccines = 10 if value_vaccines >= 100 & value_vaccines < .
replace score_vaccines = 12 if value_vaccines >= 120 & value_vaccines < .
replace score_vaccines = 14 if value_vaccines >= 140 & value_vaccines < .
replace score_vaccines = 15 if value_vaccines >= 150 & value_vaccines < .
/* Why are there values greater than 100%?? And why do scores increase past 100%? */

* percentage of CSPS with stocked gas
g score_csps = .
replace score_csps = value_csps / 10 if value_csps != .

* percentage of the population with access to potable water source
g score_water_access = .
replace score_water_access = 0 if value_water_access != .
replace score_water_access = 1 if value_water_access >= 20 & value_water_access < .
replace score_water_access = 2 if value_water_access >= 25 & value_water_access < .
replace score_water_access = 3 if value_water_access >= 30 & value_water_access < .
replace score_water_access = 4 if value_water_access >= 35 & value_water_access < .
replace score_water_access = 5 if value_water_access >= 40 & value_water_access < .
replace score_water_access = 6 if value_water_access >= 45 & value_water_access < .
replace score_water_access = 7 if value_water_access >= 50 & value_water_access < .
replace score_water_access = 8 if value_water_access >= 55 & value_water_access < .
replace score_water_access = 9 if value_water_access >= 60 & value_water_access < .
replace score_water_access = 10 if value_water_access >= 65 & value_water_access < .
replace score_water_access = 11 if value_water_access >= 70 & value_water_access < .
replace score_water_access = 12 if value_water_access >= 75 & value_water_access < .
replace score_water_access = 13 if value_water_access >= 80 & value_water_access < .
replace score_water_access = 14 if value_water_access >= 85 & value_water_access < .
replace score_water_access = 16 if value_water_access >= 90 & value_water_access < .
replace score_water_access = 18 if value_water_access >= 95 & value_water_access < .

* percentage of birth certificates to births attended
g score_birth_certificates = .
replace score_birth_certificates = 0 if value_birth_certificates != .
replace score_birth_certificates = 1 if value_birth_certificates >= 20 & value_birth_certificates < .
replace score_birth_certificates = 2 if value_birth_certificates >= 30 & value_birth_certificates < .
replace score_birth_certificates = 3 if value_birth_certificates >= 40 & value_birth_certificates < .
replace score_birth_certificates = 4 if value_birth_certificates >= 50 & value_birth_certificates < .
replace score_birth_certificates = 5 if value_birth_certificates >= 60 & value_birth_certificates < .
replace score_birth_certificates = 6 if value_birth_certificates >= 70 & value_birth_certificates < .
replace score_birth_certificates = 7 if value_birth_certificates >= 80 & value_birth_certificates < .
replace score_birth_certificates = 8 if value_birth_certificates >= 85 & value_birth_certificates < .
replace score_birth_certificates = 9 if value_birth_certificates >= 90 & value_birth_certificates < .
replace score_birth_certificates = 10 if value_birth_certificates >= 95 & value_birth_certificates < .
replace score_birth_certificates = 12 if value_birth_certificates >= 100 & value_birth_certificates < .

* calculate subtotals
g total_school = score_passing_exam + score_school_supplies + score_school_wells + score_school_latrines
g total_health = score_assisted_births + score_vaccines + score_csps
g total_water_access = score_water_access
g total_birth_certificates = score_birth_certificates

xtile stars_school = total_school, nq(5)
xtile stars_health = total_health, nq(5)
xtile stars_water_access = total_water_access, nq(5)
xtile stars_birth_certificates = total_birth_certificates, nq(5)

* calculate total score
g total_points = total_school + total_health + total_water_access + total_birth_certificates

xtile stars_total = total_points, nq(5)

* keep only important variables
keep region ///
     province ///
	 commune ///
	 commune_edited ///
     value_passing_exam ///
	 value_school_supplies ///
	 value_school_latrines ///
	 value_school_wells ///
	 value_assisted_births ///
	 value_vaccines ///
	 value_csps ///
	 value_water_access ///
	 value_birth_certificates ///
	 score_passing_exam ///
	 score_school_supplies ///
	 score_school_latrines ///
	 score_school_wells ///
	 score_assisted_births ///
	 score_vaccines ///
	 score_csps ///
	 score_water_access ///
	 score_birth_certificates ///
	 total_school ///
	 total_health ///
	 total_water_access ///
	 total_birth_certificates ///
	 total_points ///
	 stars_school ///
	 stars_health ///
	 stars_water_access ///
	 stars_birth_certificates ///
	 stars_total

* round numeric variables to the nearest tenth

replace value_passing_exam = round(value_passing_exam, 0.1)
replace value_school_supplies = round(value_school_supplies, 0.1)
replace value_school_latrines = round(value_school_latrines, 0.1)
replace value_school_wells = round(value_school_wells, 0.1)
replace value_assisted_births = round(value_assisted_births, 0.1)
replace value_vaccines = round(value_vaccines, 0.1)
replace value_csps = round(value_csps, 0.1)
replace value_water_access = round(value_water_access, 0.1)
replace value_birth_certificates = round(value_birth_certificates, 0.1)
replace score_school_supplies = round(score_school_supplies, 0.1)
replace score_csps = round(score_csps, 0.1)
replace total_school = round(total_school, 0.1)
replace total_health = round(total_health, 0.1)
replace total_points = round(total_points, 0.1)

/* Note: this line is to be replaced by either an export to 
   csv or via the construction of JSON formatted text */
*save "C:/Users/admin/Box Sync/RESEARCH/Burkina Baseline Experiments/Municipal indicators/scorecard data and code/PAYOFF CALCULATION/${year}_service_delivery.dta", replace
save "${final}/${year}_service_delivery.dta", replace
save "${final}/poster2.dta", replace

