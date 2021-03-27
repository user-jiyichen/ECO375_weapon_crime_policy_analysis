# ECO375_weapon_crime_policy_analysis

## Table of contents
* [General info](#general-info)
* [Technologies](#technologies)
* [Sample Code](#sample_code)

## General info
An empirical econometric policy analysis on the relationship between concealed weapons laws and violent crimes. This is the final assignment/project of 2020 Fall ECO375 Applied Econometrics. 

This is a report-based assignment in a term-paper structure. All of the regression results including tables, graphs and figures are shown in the appendix.

The topic is based on the following paper:

Ayres, Ian and John J. Donohue III. "Shooting Down the More Guns, Less Crime Hypothesis." 55 
Stanford Law Review 1193 (2003)
	
## Technologies
Project is created with:
* Stata version 15.1

## Sample Code

```
* Pooled SLR of ln(vio) on shall
reg lnvio shall, robust

* MLR of ln(vio) on shall and control variables
reg lnvio shall incarc_rate density avginc pop pb1064 pw1064 pm1029, robust

* State fixed effect
xtreg lnvio shall incarc_rate density avginc pop pb1064 pw1064 pm1029,/*
*/ fe cluster(stateid)

*Scatter plot of log of violent crime rate across time, separating laws enacted/non-enacted
twoway (scatter lnvio year if shall==0, msymbol(X)) (scatter lnvio year/*
*/ if shall==1, msymbol(oh)), legend(label(1 laws not enacted) label(2 laws enacted))

* convert into word file
asdoc xtreg lnvio shall incarc_rate density avginc pop pb1064 pw1064 pm1029 /*
*/ i.year, fe cluster(stateid), nest append keep(shall incarc_rate density /*
*/ avginc pop pb1064 pw1064 pm1029) fs(12)
```
