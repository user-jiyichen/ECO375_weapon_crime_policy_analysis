/* Do file for Assignment 2 ECO375

Author: Yichen Ji
Student number:1004728967

Purpose: Produce labeled tables and figures and appended them after the list of
references in the Assignment 2 report

Must-have: 
1. A table of descriptive statistics (Table 1)
2. A table of four different regression specifications (Table 2, formatted)

Date Started:2020/12/09

Primary Input:
- Ayres.dta
*/

** Standard Setup
* Clear stata memory
clear all
* Load all output without pausing
set more off
* Set directory
cd "D:\2020 Fall\ECO375\A2"

* Start log file
log using A2_log.log, replace 

* Load data (panel data)
use Ayres, clear

* Define panel data
tsset stateid year

* Define the log of the violent crime rate
gen lnvio = ln(vio)

* Table 1
summarize
* summary for cases with shall-carry law enacted
sum if shall==1
* summary for cases with shall-carry law not enacted
sum if shall==0

*Bar graph of the mean of lnvio by year 
egen Mean = mean(lnvio), by(year)

*Scatter plot of log of violent crime rate across time, separating laws enacted/non-enacted
twoway (scatter lnvio year if shall==0, msymbol(X)) (scatter lnvio year/*
*/ if shall==1, msymbol(oh)), legend(label(1 laws not enacted) label(2 laws enacted))

*Bar graph of the mean of log of violent crime rate across time
twoway(bar Mean year, color(ltblue)), ytitle('Mean ln(violent crime rate)')
* Note that these plots cannot be imported into the Word file using asdoc codes,
* so I just copied and pasted it into the Word file.


** Table 2

* Pooled SLR of ln(vio) on shall
reg lnvio shall, robust

* MLR of ln(vio) on shall and control variables
reg lnvio shall incarc_rate density avginc pop pb1064 pw1064 pm1029, robust

* State fixed effect
xtreg lnvio shall incarc_rate density avginc pop pb1064 pw1064 pm1029,/*
*/ fe cluster(stateid)

* Both state and year fixed effects
xtreg lnvio shall incarc_rate density avginc pop pb1064 pw1064 pm1029 i.year, fe cluster(stateid)


** Word tables

*Table 1
asdoc summarize, fs(12) dec(2) title(Table1) replace

* summary for cases with shall-carry law enacted
asdoc sum if shall==1, title(Table 1.b [law enacted])

* summary for cases with shall-carry law not enacted
asdoc sum if shall==0, title(Table 1.c [law not enacted])

*Table 2 
asdoc reg lnvio shall, robust, nest reset fs(12) title(Table2：Regression /*
*/Analysis of the log of the violent crime rate and shall-issue laws)

asdoc reg lnvio shall incarc_rate density avginc pop pb1064 pw1064 /*
*/ pm1029, robust, nest append fs(12) 

asdoc xtreg lnvio shall incarc_rate density avginc pop pb1064 pw1064 pm1029,/*
*/ fe cluster(stateid) nest append keep(shall incarc_rate density avginc pop /*
*/ pb1064 pw1064 pm1029) fs(12) 

asdoc xtreg lnvio shall incarc_rate density avginc pop pb1064 pw1064 pm1029 /*
*/ i.year, fe cluster(stateid), nest append keep(shall incarc_rate density /*
*/ avginc pop pb1064 pw1064 pm1029) fs(12)

asdoc sum vio lnvio, detail

*Other statistics: F-Statistics and p-values and R-squared, etc. have been 
*manually added into the Word file


log close  
