/* Data profiling of demo26q1 table  */

/* Null rate distribution calculation for demo26q1 TABLE */
SELECT  COUNT(*)                                                AS total_rows
       ,COUNT(primaryid)                                        AS non_null_primaryid
       ,COUNT(caseid)                                           AS non_null_caseid
       ,COUNT(caseversion)                                      AS non_null_caseversion
       ,COUNT(i_f_code)                                         AS non_null_i_f_code
       ,COUNT(event_dt)                                         AS non_null_event_dt
       ,COUNT(mfr_dt)                                           AS non_null_mfr_dt
       ,COUNT(init_fda_dt)                                      AS non_null_init_fda_dt
       ,COUNT(fda_dt)                                           AS non_null_fda_dt
       ,COUNT(rept_cod)                                         AS non_null_rept_cod
       ,COUNT(auth_num)as non_null_auth_num
       ,COUNT(mfr_num)                                          AS non_null_mfr_num
       ,COUNT(mfr_sndr)                                         AS non_null_mfr_sndr
       ,COUNT(lit_ref)                                          AS non_null_lit_ref
       ,COUNT(age)                                              AS non_null_age
       ,COUNT(age_cod)                                          AS non_null_age_cod
       ,COUNT(age_grp)                                          AS non_null_age_grp
       ,COUNT(sex)                                              AS non_null_sex
       ,COUNT(e_sub)                                            AS non_null_e_sub
       ,COUNT(wt)                                               AS non_null_wt
       ,COUNT(wt_cod)                                           AS non_null_wt_cod
       ,COUNT(rept_dt)                                          AS non_null_rept_dt
       ,COUNT(to_mfr)                                           AS non_null_to_mfr
       ,COUNT(occp_cod)                                         AS non_null_occp_cod
       ,COUNT(reporter_country)as non_null_reporter_country
       ,COUNT(occr_country)as non_null_occr_country
       ,((COUNT(*) - COUNT(primaryid)) * 100 / COUNT(*))        AS null_rate_primaryid
       ,((COUNT(*) - COUNT(caseid)) * 100 / COUNT(*))           AS null_rate_caseid
       ,((COUNT(*) - COUNT(caseversion)) * 100 / COUNT(*))      AS null_rate_caseversion
       ,((COUNT(*) - COUNT(i_f_code)) * 100 / COUNT(*))         AS null_rate_i_f_code
       ,((COUNT(*) - COUNT(event_dt)) * 100 / COUNT(*))         AS null_rate_event_dt
       ,((COUNT(*) - COUNT(mfr_dt)) * 100/ COUNT(*))            AS null_rate_mfr_dt
       ,((COUNT(*) - COUNT(init_fda_dt)) * 100 / COUNT(*))      AS null_rate_init_fda_dt
       ,((COUNT(*) - COUNT(fda_dt)) * 100 / COUNT(*))           AS null_rate_fda_dt
       ,((COUNT(*) - COUNT(rept_cod)) * 100 / COUNT(*))         AS null_rate_rept_cod
       ,((COUNT(*) - COUNT(auth_num)) * 100 / COUNT(*))         AS null_rate_auth_num
       ,((COUNT(*) - COUNT(mfr_num)) * 100 / COUNT(*))          AS null_rate_mfr_num
       ,((COUNT(*) - COUNT(mfr_sndr)) * 100 / COUNT(*))         AS null_rate_mfr_sndr
       ,((COUNT(*) - COUNT(lit_ref)) * 100 / COUNT(*))          AS null_rate_lit_ref
       ,((COUNT(*) - COUNT(age)) * 100 / COUNT(*))              AS null_rate_age
       ,((COUNT(*) - COUNT(age_cod)) * 100 / COUNT(*))          AS null_rate_age_cod
       ,((COUNT(*) - COUNT(age_grp)) * 100 / COUNT(*))          AS null_rate_age_grp
       ,((COUNT(*) - COUNT(sex)) * 100 / COUNT(*))              AS null_rate_sex
       ,((COUNT(*) - COUNT(e_sub)) * 100 / COUNT(*))            AS null_rate_e_sub
       ,((COUNT(*) - COUNT(wt)) * 100 / COUNT(*))               AS null_rate_wt
       ,((COUNT(*) - COUNT(wt_cod)) * 100 / COUNT(*))           AS null_rate_wt_cod
       ,((COUNT(*) - COUNT(rept_dt)) * 100 / COUNT(*))          AS null_rate_rept_dt
       ,((COUNT(*) - COUNT(to_mfr)) * 100 / COUNT(*))           AS null_rate_to_mfr
       ,((COUNT(*) - COUNT(occp_cod)) * 100 / COUNT(*))         AS null_rate_occp_cod
       ,((COUNT(*) - COUNT(reporter_country)) * 100 / COUNT(*)) AS null_rate_reporter_country
       ,((COUNT(*) - COUNT(occr_country)) * 100 / COUNT(*))     AS null_rate_occr_country
FROM demo26q1 dm; /* To check unique values IN the columns of demo26q1 TABLE */

SELECT  COUNT(DISTINCT primaryid)        AS unique_primaryid
       ,COUNT(DISTINCT caseid)           AS unique_caseid
       ,COUNT(DISTINCT caseversion)      AS unique_caseversion
       ,COUNT(DISTINCT i_f_code)         AS unique_i_f_code
       ,COUNT(DISTINCT event_dt)         AS unique_event_dt
       ,COUNT(DISTINCT mfr_dt)           AS unique_mfr_dt
       ,COUNT(DISTINCT init_fda_dt)      AS unique_init_fda_dt
       ,COUNT(DISTINCT fda_dt)           AS unique_fda_dt
       ,COUNT(DISTINCT rept_cod)         AS unique_rept_cod
       ,COUNT(DISTINCT auth_num)         AS unique_auth_num
       ,COUNT(DISTINCT mfr_num)          AS unique_mfr_num
       ,COUNT(DISTINCT mfr_sndr)         AS unique_mfr_sndr
       ,COUNT(DISTINCT lit_ref)          AS unique_lit_ref
       ,COUNT(DISTINCT age)              AS unique_age
       ,COUNT(DISTINCT age_cod)          AS unique_age_cod
       ,COUNT(DISTINCT age_grp)          AS unique_age_grp
       ,COUNT(DISTINCT sex)              AS unique_sex
       ,COUNT(DISTINCT e_sub)            AS unique_e_sub
       ,COUNT(DISTINCT wt)               AS unique_wt
       ,COUNT(DISTINCT wt_cod)           AS unique_wt_cod
       ,COUNT(DISTINCT rept_dt)          AS unique_rept_dt
       ,COUNT(DISTINCT to_mfr)           AS unique_to_mfr
       ,COUNT(DISTINCT occp_cod)         AS unique_occp_cod
       ,COUNT(DISTINCT reporter_country) AS unique_reporter_country
       ,COUNT(DISTINCT occr_country)     AS unique_occr_country
FROM demo26q1 dm; /* To check value range AND frequency distribution of of numeric fields */

SELECT  MIN(caseversion)                                          AS min_caseversion ---ISSUE 
       ,MAX(caseversion)                                          AS max_caseversion
       ,percentile_cont(0.50) within group (order by caseversion) AS median_caseversion
       ,MIN(event_dt)                                             AS min_event_dt
       ,MAX(event_dt)                                             AS max_event_dt
       ,MIN(mfr_dt)                                               AS min_mfr_dt --ISSUE 
       ,MAX(mfr_dt)                                               AS max_mfr_dt --ISSUE 
       ,MIN(init_fda_dt)                                          AS min_init_fda_dt
       ,MAX(init_fda_dt)                                          AS max_init_fda_dt
       ,MIN(fda_dt)                                               AS min_fda_dt
       ,MAX(fda_dt)                                               AS max_fda_dt
       ,MIN(age)                                                  AS min_age --ISSUE 
       ,MAX(age)                                                  AS max_age --ISSUE 
       ,percentile_cont(0.50) within group (order by age)         AS median_age
       ,percentile_cont(0.25) within group (order by age)         AS pct_25_age
       ,percentile_cont(0.75) within group (order by age)         AS pct_75_age
       ,MIN(wt)                                                   AS min_wt
       ,MAX(wt)                                                   AS max_wt
       ,percentile_cont(0.50) within group (order by wt)          AS median_wt
       ,percentile_cont(0.25) within group (order by wt)          AS pct_25_wt
       ,percentile_cont(0.75) within group (order by wt)          AS pct_75_wt
       ,MIN(rept_dt)                                              AS min_rept_dt
       ,MAX(rept_dt)                                              AS max_rept_dt
FROM demo26q1; /* To check duplicate records IN demo26q1 TABLE based
ON caseid AND rept_dt */
WITH duplicates AS
(
	SELECT  primaryid
	       ,caseid
	       ,rept_dt
	       ,ROW_NUMBER() OVER ( PARTITION BY rept_dt,caseid ORDER BY  rept_dt DESC ) AS rn
	FROM demo26q1
)
SELECT  *
FROM duplicates
WHERE rn > 1
ORDER BY rept_dt desc;
--No duplicate records found based

/* Data profiling of demo26q1 table */

/* Null rate distribution calculation for demo26q1 TABLE */
SELECT  COUNT(*)                                             AS total_rows
       ,COUNT(caseid)                                        AS non_null_caseid
       ,COUNT(drug_seq)                                      AS non_null_drug_seq
       ,COUNT(role_cod)                                      AS non_null_role_cod
       ,COUNT(drugname)                                      AS non_null_drugname
       ,COUNT(prod_ai)                                       AS non_null_prod_ai
       ,COUNT(val_vbm)                                       AS non_null_val_vbm
       ,COUNT(route)                                         AS non_null_route
       ,COUNT(dose_vbm)                                      AS non_null_dose_vbm
       ,COUNT(cum_dose_chr)                                  AS non_null_cum_dose_chr
       ,COUNT(cum_dose_unit)                                 AS non_null_cum_dose_unit
       ,COUNT(dechal)                                        AS non_null_dechal
       ,COUNT(rechal)                                        AS non_null_rechal
       ,COUNT(lot_num)                                       AS non_null_lot_num
       ,COUNT(exp_dt)                                        AS non_null_exp_dt
       ,COUNT(nda_num)                                       AS non_null_nda_num
       ,COUNT(dose_amt)                                      AS non_null_dose_amt
       ,COUNT(dose_unit)                                     AS non_null_dose_unit
       ,COUNT(dose_form)                                     AS non_null_dose_form
       ,COUNT(dose_freq)                                     AS non_null_dose_freq
       ,((COUNT(*) - COUNT(primaryid)) * 100 / COUNT(*))     AS null_rate_primaryid
       ,((COUNT(*) - COUNT(caseid)) * 100 / COUNT(*))        AS null_rate_caseid
       ,((COUNT(*) - COUNT(drug_seq)) * 100 / COUNT(*))      AS null_rate_drug_seq
       ,((COUNT(*) - COUNT(role_cod)) * 100 / COUNT(*))      AS null_rate_role_cod
       ,((COUNT(*) - COUNT(drugname)) * 100 / COUNT(*))      AS null_rate_drugname
       ,((COUNT(*) - COUNT(prod_ai)) * 100 / COUNT(*))       AS null_rate_prod_ai
       ,((COUNT(*) - COUNT(val_vbm)) * 100 / COUNT(*))       AS null_rate_val_vbm
       ,((COUNT(*) - COUNT(route)) * 100 / COUNT(*))         AS null_rate_route
       ,((COUNT(*) - COUNT(dose_vbm)) * 100 / COUNT(*))      AS null_rate_dose_vbm
       ,((COUNT(*) - COUNT(cum_dose_chr)) * 100 / COUNT(*))  AS null_rate_cum_dose_chr
       ,((COUNT(*) - COUNT(cum_dose_unit)) * 100 / COUNT(*)) AS null_rate_cum_dose_unit
       ,((COUNT(*) - COUNT(dechal)) * 100 / COUNT(*))        AS null_rate_dechal
       ,((COUNT(*) - COUNT(rechal)) * 100 / COUNT(*))        AS null_rate_rechal
       ,((COUNT(*) - COUNT(lot_num)) * 100 / COUNT(*))       AS null_rate_lot_num
       ,((COUNT(*) - COUNT(exp_dt)) * 100 / COUNT(*))        AS null_rate_exp_dt
       ,((COUNT(*) - COUNT(nda_num)) * 100 / COUNT(*))       AS null_rate_nda_num
       ,((COUNT(*) - COUNT(dose_amt)) * 100 / COUNT(*))      AS null_rate_dose_amt
       ,((COUNT(*) - COUNT(dose_unit)) * 100 / COUNT(*))     AS null_rate_dose_unit
       ,((COUNT(*) - COUNT(dose_form)) * 100 / COUNT(*))     AS null_rate_dose_form
       ,((COUNT(*) - COUNT(dose_freq)) * 100 / COUNT(*))     AS null_rate_dose_freq
FROM drug26q1; /* To check unique values IN the columns of drug26q1 TABLE */

SELECT  COUNT(DISTINCT primaryid)     AS unique_primaryid
       ,COUNT(DISTINCT caseid)        AS unique_caseid
       ,COUNT(DISTINCT drug_seq)      AS unique_drug_seq
       ,COUNT(DISTINCT role_cod)      AS unique_role_cod
       ,COUNT(DISTINCT drugname)      AS unique_drugname
       ,COUNT(DISTINCT prod_ai)       AS unique_prod_ai
       ,COUNT(DISTINCT val_vbm)       AS unique_val_vbm
       ,COUNT(DISTINCT route)         AS unnique_route
       ,COUNT(DISTINCT dose_vbm)      AS unnique_dose_vbm
       ,COUNT(DISTINCT cum_dose_chr)  AS unnique_cum_dose_chr
       ,COUNT(DISTINCT cum_dose_unit) AS unnique_cum_dose_unit
       ,COUNT(DISTINCT dechal)        AS unnique_dechal
       ,COUNT(DISTINCT rechal)        AS unnique_rechal
       ,COUNT(DISTINCT lot_num)       AS unnique_lot_num
       ,COUNT(DISTINCT exp_dt)        AS unnique_exp_dt
       ,COUNT(DISTINCT nda_num)       AS unnique_nda_num
       ,COUNT(DISTINCT dose_amt)      AS unnique_dose_amt
       ,COUNT(DISTINCT dose_unit)     AS unnique_dose_unit
       ,COUNT(DISTINCT dose_form)     AS unnique_dose_form
       ,COUNT(DISTINCT dose_freq)     AS unnique_dose_freq
FROM drug26q1; /* To check value range AND distribution of categorical AND numerical columns IN demo26q1 TABLE */

SELECT  MIN(exp_dt)   AS min_exp_dt
       ,MAX(exp_dt)   AS max_exp_dt
       ,MIN(drug_seq) AS min_drug_seq
       ,MAX(drug_seq) AS max_drug_seq
FROM drug26q1; /* To check duplicate records IN drug26q1 TABLE */
WITH duplicates AS
(
	SELECT  primaryid
	       ,caseid
	       ,drug_seq
	       ,drugname
	       ,ROW_NUMBER()over(PARTITION BY primaryid,caseid,drugname,drug_seq) AS rn
	FROM drug26q1
)
SELECT count(*) AS no_of_duplicates 
FROM duplicates
WHERE rn > 1
-- ~22% of records are duplicate based

/* Data profiling of reac26q1 table */

/* Null rate distribution calculation for reac26q1 TABLE */
SELECT  COUNT(*)                                            AS total_rows
       ,COUNT(primaryid)                                    AS non_null_primaryid
       ,COUNT(caseid)                                       AS non_null_caseid
       ,COUNT(pt)                                           AS non_null_pt
       ,COUNT(drug_rec_act)                                 AS non_null_drug_rec_act
       ,((COUNT(*) - COUNT(primaryid)) * 100 / COUNT(*))    AS null_rate_primaryid
       ,((COUNT(*) - COUNT(caseid)) * 100 / COUNT(*))       AS null_rate_caseid
       ,((COUNT(*) - COUNT(pt)) * 100 / COUNT(*))           AS null_rate_pt
       ,((COUNT(*) - COUNT(drug_rec_act)) * 100 / COUNT(*)) AS null_rate_drug_rec_act
FROM reac26q1; /* To check unique values IN the columns of reac26q1 TABLE */

SELECT  COUNT(DISTINCT primaryid)    AS unique_primaryid
       ,COUNT(DISTINCT caseid)       AS unique_caseid
       ,COUNT(DISTINCT pt)           AS unique_pt
       ,COUNT(DISTINCT drug_rec_act) AS unique_drug_rec_act
FROM reac26q1; /* To check duplicate records based
ON caseid AND rept_dt combination IN reac26q1 TABLE */
WITH duplicates AS
(
	SELECT  primaryid
	       ,caseid
	       ,pt
	       ,drug_rec_act
	       ,ROW_NUMBER() over(PARTITION BY primaryid,caseid,pt,drug_rec_act ORDER BY  caseid ) AS rn
	FROM reac26q1
)
SELECT  COUNT(*) AS no_of_duplicates
FROM duplicates
WHERE rn > 1
-- ~5% of records are duplicate based
