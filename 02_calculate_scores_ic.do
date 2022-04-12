*! Contributors: Chris Boyer, Sidiki Soubeiga, Tara Balakrishnan, Sekou Koné, Malte Lierl
*! PI: Malte Lierl, co-PI: Marcus Holmlund
*! Version: 2018-05-15

/* this file calculates indicator values, scores and score totals 
   for the SUPERMUN institutional capacity indicators (Scorecard Poster 1). */
   
version 13
set more off


/* =================================================== 
   ====================== SETUP ======================
   =================================================== */
* 2018 parameters
global year = 2018
global national_average = 64.8
global groupnames = 0   

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
   ======== INSTITUTIONAL CAPACITY (POSTER 1)=========
   =================================================== */
   
* read file with raw indicator data
use "${final}/merged.dta", clear 

		
/* 1. indicator values - the number at the bottom of
   the sliding scale in the infographic */
   
* Municipal council/special delegation
   
* Replace number of special delegation meetings with 0 if there was no special delegation
replace total_num_ordinary_sds = 0 if special_delegation == 0

* Replace number of municipal council meetings with 0 if there was no municipal council
replace total_num_ordinary_scm = 0 if municipal_council == 0

* Total number of municipal council and special delegation meetings
g value_meetings1 = total_num_ordinary_scm + total_num_ordinary_sds

* Total number of cadre de concertation meetings
g value_meetings2 = num_cadre_concertation_meeting20
   
* Count number of available meeting attendance records  
* Note: Variables with suffix 'ds' refer to special delegation meetings
replace councilor_attendance_meeting1 = . if councilor_attendance_meeting1 == 0 
replace councilor_attendance_meeting2 = . if councilor_attendance_meeting2 == 0 
replace councilor_attendance_meeting3 = . if councilor_attendance_meeting3 == 0 
replace councilor_attendance_meeting4 = . if councilor_attendance_meeting4 == 0 

replace councilor_attendance_meeting1sd = . if councilor_attendance_meeting1sd == 0 
replace councilor_attendance_meeting2sd = . if councilor_attendance_meeting2sd == 0 
replace councilor_attendance_meeting3sd = . if councilor_attendance_meeting3sd == 0 
replace councilor_attendance_meeting4sd = . if councilor_attendance_meeting4sd == 0 

g attendance_records_cm = 4 - ///
					   mi(councilor_attendance_meeting1) - ///
					   mi(councilor_attendance_meeting2) - ///
					   mi(councilor_attendance_meeting3) - ///
					   mi(councilor_attendance_meeting4)

replace councilor_attendance_meeting1sd = . if councilor_attendance_meeting1sd == 0 
replace councilor_attendance_meeting2sd = . if councilor_attendance_meeting2sd == 0 
replace councilor_attendance_meeting3sd = . if councilor_attendance_meeting3sd == 0 
replace councilor_attendance_meeting4sd = . if councilor_attendance_meeting4sd == 0 

g attendance_records_ds = 4 - ///
					   mi(councilor_attendance_meeting1sd) - ///
					   mi(councilor_attendance_meeting2sd) - ///
					   mi(councilor_attendance_meeting3sd) - ///
					   mi(councilor_attendance_meeting4sd)

replace councilor_attendance_meeting1 = 0 if mi(councilor_attendance_meeting1)
replace councilor_attendance_meeting2 = 0 if mi(councilor_attendance_meeting2)
replace councilor_attendance_meeting3 = 0 if mi(councilor_attendance_meeting3)
replace councilor_attendance_meeting4 = 0 if mi(councilor_attendance_meeting4)
replace councilor_attendance_meeting1sd = 0 if mi(councilor_attendance_meeting1sd)
replace councilor_attendance_meeting2sd = 0 if mi(councilor_attendance_meeting2sd)
replace councilor_attendance_meeting3sd = 0 if mi(councilor_attendance_meeting3sd)
replace councilor_attendance_meeting4sd = 0 if mi(councilor_attendance_meeting4sd)

* Set total number of councilors/special delegation members to 0 if missing
replace total_councilor = 0 if total_councilor == . 
replace total_ds_member = 0 if total_ds_member == . 

* Average attendance rates of municipal council (special delegation) meetings
g value_attendance_cm = councilor_attendance_meeting1 + councilor_attendance_meeting2 + councilor_attendance_meeting3 + councilor_attendance_meeting4
replace value_attendance_cm =  100 * ///
		(councilor_attendance_meeting1 +  ///
         councilor_attendance_meeting2 +  ///
	     councilor_attendance_meeting3 +  /// 
	     councilor_attendance_meeting4) / ///
		 (attendance_records_cm * total_councilor) ///
		 if attendance_records_cm > 0


g value_attendance_ds = 0
replace value_attendance_ds = 100 * ///
		(councilor_attendance_meeting1sd +  ///
         councilor_attendance_meeting2sd +  ///
	     councilor_attendance_meeting3sd +  /// 
	     councilor_attendance_meeting4sd) / ///
	    (attendance_records_ds * total_ds_member) ///
		 if attendance_records_ds > 0

g value_attendance = (value_attendance_cm*attendance_records_cm + ///
						  value_attendance_ds*attendance_records_ds) / ///
						 (attendance_records_cm + attendance_records_ds)

* Set attendance to zero if no meetings were held
replace value_attendance = 0 if value_meetings1 == 0

* Local tax revenue per capita
g value_taxes_raised = local_taxes_${year}_amount / compop${year}

* Local tax revenue as fraction of tax forecast
g value_taxes_forecast = 100 * local_taxes_${year}_amount / local_taxes_forecast_${year}

* Completion rate of procurement plan
/*g value_procurement = execution_equipment_procurement_*/
g value_procurement = execution_equipment_procurement

* Municipal staffing: 'organigramme type' positions filled
forval i = 1/8 {
	g value_personnel`i' = "false"
}
replace value_personnel1 = "true" if agent_materiel_transfere == 1
replace value_personnel2 = "true" if agent_secretaire == 1
replace value_personnel3 = "true" if agent_etat_civil == 1
replace value_personnel4 = "true" if agent_services_statistiques == 1
replace value_personnel5 = "true" if agent_service_techniques == 1
replace value_personnel6 = "true" if comptable == 1
replace value_personnel7 = "true" if regisseur_recettes == 1
replace value_personnel8 = "true" if agent_affaires_domaniales == 1

forval i = 1/4 {
	g value_meetings1_`i' = "false"
	g value_meetings2_`i' = "false"
}

replace value_meetings1_1 = "true" if value_meetings1 >= 1 & value_meetings1 < .
replace value_meetings1_2 = "true" if value_meetings1 >= 2 & value_meetings1 < .
replace value_meetings1_3 = "true" if value_meetings1 >= 3 & value_meetings1 < .
replace value_meetings1_4 = "true" if value_meetings1 >= 4 & value_meetings1 < .

replace value_meetings2_1 = "true" if value_meetings2 >= 1 & value_meetings2 < .
replace value_meetings2_2 = "true" if value_meetings2 >= 2 & value_meetings2 < .
replace value_meetings2_3 = "true" if value_meetings2 >= 3 & value_meetings2 < .
replace value_meetings2_4 = "true" if value_meetings2 >= 4 & value_meetings2 < .

/* 2. indicator scores - the number at the top of the
   sliding scale in the infographic */
   
* Municipal staffing: 'organigramme type' positions filled
g score_personnel = 0 
replace score_personnel = score_personnel + 1 if agent_secretaire == 1
replace score_personnel = score_personnel + 2 if agent_etat_civil == 1
replace score_personnel = score_personnel + 2 if comptable == 1
replace score_personnel = score_personnel + 1 if regisseur_recettes == 1
replace score_personnel = score_personnel + 1 if agent_materiel_transfere == 1
replace score_personnel = score_personnel + 1 if agent_services_statistiqu == 1
replace score_personnel = score_personnel + 1 if agent_service_techniques == 1
replace score_personnel = score_personnel + 1 if agent_affaires_domaniales == 1

* Number of municipal council (special delegation) meetings held (1 - 4)
* 2016 onwards: Corrected point mapping from 0,1,3,4,5 to 0,1,2,3,5
* Changed default to missing
* Changed score 5 from value_meetings1==4 meetings to value_meetings1>=4 meetings
g score_meetings1 = .
replace score_meetings1 = 0 if value_meetings1 == 0
replace score_meetings1 = 1 if value_meetings1 == 1
replace score_meetings1 = 2 if value_meetings1 == 2
replace score_meetings1 = 3 if value_meetings1 == 3
replace score_meetings1 = 5 if value_meetings1 >= 4
replace score_meetings1 = . if value_meetings1 == .


* Number of cadre de concertation meetings held (0-4): How many of these meetings were held: ic_a_05-CdC_meetings_2016
* g score_meetings2 = value_meetings2 * 2 /*where did this come from?*/
g score_meetings2 = .
replace score_meetings2 = 0 if value_meetings2 == 0
replace score_meetings2 = 2 if value_meetings2 == 1
replace score_meetings2 = 4 if value_meetings2 == 2
replace score_meetings2 = 6 if value_meetings2 == 3
replace score_meetings2 = 8 if value_meetings2 >= 4
replace score_meetings2 = . if value_meetings2 == .

* Average attendance at municipal council (special delegation) meeting
g score_attendance = . 
replace score_attendance = 0 if value_attendance != .
replace score_attendance = 1 - ((40 - value_attendance) / 20) if value_attendance >= 20 & value_attendance < 40
replace score_attendance = 5 - ((80 - value_attendance) / 10) if value_attendance >= 40 & value_attendance < 80
replace score_attendance = 7 - ((90 - value_attendance) / 5) if value_attendance >= 80 & value_attendance < 90
replace score_attendance = 10 - ((100 - value_attendance) * 3 / 10) if value_attendance >= 90 & value_attendance < 100
replace score_attendance = 10 if value_attendance >= 100 & value_attendance < .

* Local tax revenue per capita
g score_taxes_raised = . 
replace score_taxes_raised = 0 if value_taxes_raised != .
replace score_taxes_raised = 1 if value_taxes_raised >= 100 & value_taxes_raised < .
replace score_taxes_raised = 2 if value_taxes_raised >= 200 & value_taxes_raised < .
replace score_taxes_raised = 3 if value_taxes_raised >= 400 & value_taxes_raised < .
replace score_taxes_raised = 4 if value_taxes_raised >= 600 & value_taxes_raised < .
replace score_taxes_raised = 5 if value_taxes_raised >= 1000 & value_taxes_raised < .
replace score_taxes_raised = 6 if value_taxes_raised >= 1200 & value_taxes_raised < .
replace score_taxes_raised = 7 if value_taxes_raised >= 1400 & value_taxes_raised < .
replace score_taxes_raised = 8 if value_taxes_raised >= 1800 & value_taxes_raised < .
replace score_taxes_raised = 9 if value_taxes_raised >= 2000 & value_taxes_raised < .
replace score_taxes_raised = 10 if value_taxes_raised >= 2200 & value_taxes_raised < .
replace score_taxes_raised = 11 if value_taxes_raised >= 2400 & value_taxes_raised < .
replace score_taxes_raised = 12 if value_taxes_raised >= 2800 & value_taxes_raised < .
replace score_taxes_raised = 13 if value_taxes_raised >= 3000 & value_taxes_raised < .
replace score_taxes_raised = 14 if value_taxes_raised >= 3500 & value_taxes_raised < .
replace score_taxes_raised = 15 if value_taxes_raised >= 4000 & value_taxes_raised < .
replace score_taxes_raised = 16 if value_taxes_raised >= 4500 & value_taxes_raised < .
replace score_taxes_raised = 17 if value_taxes_raised >= 5000 & value_taxes_raised < .
replace score_taxes_raised = 18 if value_taxes_raised >= 5500 & value_taxes_raised < .
replace score_taxes_raised = 19 if value_taxes_raised >= 6000 & value_taxes_raised < .
replace score_taxes_raised = 20 if value_taxes_raised >= 6500 & value_taxes_raised < .
replace score_taxes_raised = 22 if value_taxes_raised >= 7000 & value_taxes_raised < .
replace score_taxes_raised = 25 if value_taxes_raised >= 7500 & value_taxes_raised < .


* Local tax revenue as fraction of tax forecast
g score_taxes_forecast = .
replace score_taxes_forecast = 0 if value_taxes_forecast != .
replace score_taxes_forecast = 1 if value_taxes_forecast >= 55 & value_taxes_forecast < .
replace score_taxes_forecast = 2 if value_taxes_forecast >= 60 & value_taxes_forecast < .
replace score_taxes_forecast = 3 if value_taxes_forecast >= 66 & value_taxes_forecast < .
replace score_taxes_forecast = 4 if value_taxes_forecast >= 70 & value_taxes_forecast < .
replace score_taxes_forecast = 5 if value_taxes_forecast >= 75 & value_taxes_forecast < .
replace score_taxes_forecast = 6 if value_taxes_forecast >= 80 & value_taxes_forecast < .
replace score_taxes_forecast = 7 if value_taxes_forecast >= 85 & value_taxes_forecast < .
replace score_taxes_forecast = 8 if value_taxes_forecast >= 90 & value_taxes_forecast < .
replace score_taxes_forecast = 9 if value_taxes_forecast >= 95 & value_taxes_forecast < .
replace score_taxes_forecast = 10 if value_taxes_forecast >= 100 & value_taxes_forecast < .

* Completion rate of procurement plan
g score_procurement = .
replace score_procurement = 0 if value_procurement != .
replace score_procurement = 1 if value_procurement >= 20 & value_procurement < .
replace score_procurement = 2 if value_procurement >= 30 & value_procurement < .
replace score_procurement = 3 if value_procurement >= 35 & value_procurement < .
replace score_procurement = 4 if value_procurement >= 40 & value_procurement < .
replace score_procurement = 5 if value_procurement >= 50 & value_procurement < .
replace score_procurement = 6 if value_procurement >= 55 & value_procurement < .
replace score_procurement = 7 if value_procurement >= 60 & value_procurement < .
replace score_procurement = 8 if value_procurement >= 65 & value_procurement < .
replace score_procurement = 9 if value_procurement >= 70 & value_procurement < .
replace score_procurement = 10 if value_procurement >= 75 & value_procurement < .
replace score_procurement = 11 if value_procurement >= 80 & value_procurement < .
replace score_procurement = 12 if value_procurement >= 85 & value_procurement < .
replace score_procurement = 14 if value_procurement >= 90 & value_procurement < .
replace score_procurement = 16 if value_procurement >= 95 & value_procurement < .
replace score_procurement = 18 if value_procurement >= 100 & value_procurement < .

* Calculate subtotals
gen total_services = score_personnel
gen total_council = score_meetings1 + score_meetings2 + score_attendance 
gen total_finances = score_taxes_raised + score_taxes_forecast + score_procurement

xtile stars_services = total_services, nq(5)
xtile stars_council = total_council, nq(5)
xtile stars_finances = total_finances, nq(5)

* Calculate total score
gen total_points = total_services + total_council + total_finances

xtile stars_total = total_points, nq(5)

* Keep only relevant variables
keep region ///
     province ///
	 commune ///
	 commune_edited ///
	 value_personnel* ///
	 value_meetings1 ///
	 value_meetings2 ///
	 value_meetings1_* ///
	 value_meetings2_* ///
	 value_attendance_cm ///
	 value_attendance_ds ///
	 value_attendance ///
	 value_taxes_raised ///
	 value_taxes_forecast ///
	 value_procurement ///
	 score_personnel ///
	 score_meetings1 ///
	 score_meetings2 ///
	 score_attendance ///
	 score_taxes_raised ///
	 score_taxes_forecast ///
	 score_procurement ///
	 total_services ///
	 total_council ///
	 total_finances ///
	 total_points ///
	 stars_services ///
	 stars_council ///
	 stars_finances ///
	 stars_total

* Round numeric variables to the nearest tenth

replace value_attendance = round(value_attendance, 0.1)
replace value_attendance_cm = round(value_attendance, 0.1)
replace value_attendance_ds = round(value_attendance, 0.1)
replace value_taxes_raised = round(value_taxes_raised, 0.1)
replace value_taxes_forecast = round(value_taxes_forecast, 0.1)
replace value_procurement = round(value_procurement, 0.1)

replace score_attendance = round(score_attendance, 0.1)
replace total_council = round(total_council, 0.1)
replace total_points = round(total_points, 0.1)

/* Note: this line is to be replaced by either an export to 
   csv or via the construction of JSON formatted text */
*save "C:/Users/admin/Box Sync/RESEARCH/Burkina Baseline Experiments/Municipal indicators/scorecard data and code/PAYOFF CALCULATION/${year}_institutional_capacity.dta", replace
save "${final}/${year}_institutional_capacity.dta", replace
save "${final}/poster1.dta", replace


