/* Data Validation and Cleaning of drug26q1 table */

WITH formated_data AS
(
	SELECT  TRIM(primaryid)            AS primaryid
	       ,TRIM(caseid)               AS caseid
	       ,drug_seq
	       ,TRIM(UPPER(role_cod))      AS role_cod
	       ,TRIM(UPPER(drugname))      AS drugname
	       ,TRIM(UPPER(prod_ai))       AS prod_ai
	       ,val_vbm
	       ,TRIM(UPPER(route))         AS route
	       ,TRIM(dose_vbm)             AS dose_vbm
	       ,cum_dose_chr
	       ,TRIM(UPPER(cum_dose_unit)) AS cum_dose_unit
	       ,TRIM(UPPER(dechal))        AS dechal
	       ,TRIM(UPPER(rechal))        AS rechal
	       ,TRIM(UPPER(lot_num))       AS lot_num
	       ,exp_dt
	       ,nda_num
	       ,dose_amt
	       ,TRIM(UPPER(dose_unit))     AS dose_unit
	       ,TRIM(UPPER(dose_form))     AS dose_form
	       ,TRIM(UPPER(dose_freq))     AS dose_freq
	FROM drug26q1
), validated_data AS
(
	SELECT  *
	       ,CASE WHEN drugname IS NULL AND role_cod IN ('PS','SS') THEN 'INVALID'  ELSE 'VALID' END AS drug_status
	       ,CASE WHEN role_cod IN ('PS','SS','C','I') THEN 'VALID'  ELSE 'INVALID' END              AS role_cod_status
	       ,CASE WHEN primaryid IS NULL OR caseid IS NULL THEN 'INVALID'  ELSE 'VALID' END          AS primary_case_status
	       ,CASE WHEN dose_amt < 0 THEN 'INVALID'  ELSE 'VALID' END                                 AS dose_amt_status
	       ,CASE WHEN cum_dose_chr < 0 AND cum_dose_chr < dose_amt THEN 'INVALID'  ELSE 'VALID' END AS cum_dose_chr_status
	FROM formated_data
), deduplicated_data AS
(
	SELECT  *
	       ,ROW_NUMBER()over(PARTITION BY primaryid,caseid,drugname,drug_seq ORDER BY primaryid) AS rn
	FROM validated_data
	WHERE drug_status = 'VALID'
	AND role_cod_status = 'VALID'
	AND primary_case_status = 'VALID'
	AND dose_amt_status = 'VALID'
)
	SELECT  primaryid
	       ,caseid
	       ,drug_seq
	       ,role_cod
	       ,drugname
	       ,prod_ai
	       ,val_vbm
	       ,route
	       ,dose_vbm
	       ,cum_dose_chr
	       ,cum_dose_unit
	       ,dechal
	       ,rechal
	       ,lot_num
	       ,exp_dt
	       ,nda_num
	       ,dose_amt
	       ,dose_unit
	       ,dose_form
	       ,dose_freq
	FROM deduplicated_data
	WHERE rn = 1

/* Data cleanind and validation of reac26q1 table */

WITH formatted_data AS
(
	SELECT  primaryid
	       ,caseid
	       ,TRIM(INITCAP(pt))  AS pt
	       ,TRIM(drug_rec_act) AS drug_rec_act
	FROM reac26q1
), validated_data AS
(
	SELECT  *
	       ,CASE WHEN primaryid IS NULL OR caseid IS NULL THEN 'INVALID'  ELSE 'VALID' END AS primary_case_status
	       ,CASE WHEN pt IS NULL THEN 'INVALID'  ELSE 'VALID' END                          AS pt_status
	FROM formatted_data
), deduplicated_data AS
(
	SELECT  *
	       ,ROW_NUMBER()over(PARTITION BY primaryid,caseid,pt,drug_rec_act) AS rn
	FROM validated_data
	WHERE primary_case_status = 'VALID'
	AND pt_status = 'VALID' 
), final_reac26q1 AS
(
	SELECT  primaryid
	       ,caseid
	       ,pt
	       ,drug_rec_act
	       ,rn
	FROM deduplicated_data
	WHERE rn = 1 
)
SELECT primaryid,
       caseid,
	   pt,
	   drug_rec_act 
FROM final_reac26q1

/* Data cleaning and validation of demo26q1 table */


WITH formated_data AS
(
	SELECT  TRIM(primaryid)               AS primaryid
	       ,TRIM(caseid)                  AS caseid
	       ,caseversion
	       ,TRIM(UPPER(i_f_code))         AS i_f_code
	       ,event_dt
	       ,mfr_dt
	       ,init_fda_dt
	       ,fda_dt
	       ,TRIM(UPPER(rept_cod))         AS rept_cod
	       ,TRIM(auth_num)                AS auth_num
	       ,TRIM(UPPER(mfr_num))          AS mfr_num
	       ,TRIM(UPPER(mfr_sndr))         AS mfr_sndr
	       ,lit_ref
	       ,age
	       ,TRIM(UPPER(age_cod))          AS age_cod
	       ,TRIM(UPPER(age_grp))          AS age_grp
	       ,TRIM(UPPER(sex))              AS sex
	       ,TRIM(UPPER(e_sub))            AS e_sub
	       ,wt
	       ,TRIM(UPPER(wt_cod))           AS wt_cod
	       ,rept_dt
	       ,to_mfr
	       ,TRIM(UPPER(occp_cod))         AS occp_cod
	       ,TRIM(UPPER(reporter_country)) AS reporter_country
	       ,TRIM(UPPER(occr_country))     AS occr_country
	FROM demo26q1
), validated_data AS
(
	SELECT  *
	       ,CASE WHEN primaryid is null or caseid is null THEN 'INVALID'  ELSE 'VALID' END                            AS primary_case_status
	       ,CASE WHEN caseversion < 0 THEN 'INVALID'  ELSE 'VALID' END                                                AS caseversion_status
	       ,CASE WHEN i_f_code in('I','F') or i_f_code is null THEN 'VALID'  ELSE 'INVALID' END                       AS i_f_code_status
	       ,CASE WHEN mfr_dt >= event_dt or event_dt is null THEN 'VALID'  ELSE 'INVALID' END                         AS mfr_dt_status
	       ,CASE WHEN fda_dt >= event_dt OR event_dt IS NULL OR fda_dt IS NULL THEN 'VALID'  ELSE 'INVALID' END       AS evfda_dt_status
	       ,CASE WHEN fda_dt >= init_fda_dt OR init_fda_dt IS NULL OR fda_dt IS NULL THEN 'VALID'  ELSE 'INVALID' END AS fda_dt_status
	       ,CASE WHEN rept_dt >= mfr_dt THEN 'VALID'  ELSE 'INVALID' END                                              AS rept_date_status
	       ,CASE WHEN rept_cod not in('EXP','PER') THEN 'INVALID'  ELSE 'VALID' END                                   AS rept_cod_status
	       ,CASE WHEN age < 0 OR age > 100 THEN 'INVALLID'  ELSE 'VALID' END                                          AS age_status
	       ,CASE WHEN (wt_cod IS NOT NULL AND wt_cod NOT IN ('KG','LBS','G')) OR wt <= 0 OR (wt_cod = 'KG' AND wt > 600) OR (wt_cod = 'LBS' AND wt > 1300) THEN 'INVALID'  ELSE 'VALID' END AS wt_status
	FROM formated_data
), duplicated_data AS
(
	SELECT  *
	       ,ROW_NUMBER()OVER(PARTITION BY primaryid,caseid,caseversion ORDER BY  event_dt DESC) AS rn
	FROM validated_data
	WHERE primary_case_status = 'VALID'
	AND caseversion_status = 'VALID'
	AND i_f_code_status = 'VALID'
	AND mfr_dt_status = 'VALID'
	AND evfda_dt_status = 'VALID'
	AND fda_dt_status = 'VALID'
	AND rept_date_status = 'VALID'
	AND rept_cod_status = 'VALID'
	AND age_status = 'VALID'
	AND wt_status = 'VALID' 
)
SELECT  primaryid
       ,caseid
       ,caseversion
       ,i_f_code
       ,event_dt
       ,mfr_dt
       ,init_fda_dt
       ,fda_dt
       ,rept_cod
       ,auth_num
       ,mfr_num
       ,mfr_sndr
       ,lit_ref
       ,age
       ,age_cod
       ,age_grp
       ,sex
       ,e_sub
       ,wt
       ,wt_cod
       ,rept_dt
       ,to_mfr
       ,occp_cod
       ,reporter_country
       ,occr_country
FROM duplicated_data
WHERE rn = 1
-- No dupllicates found IN demo26q1 

/* Data validation of out26q1 table */


with dedups as
(
select 
TRIM(primaryid) as primaryid,
TRIM(caseid) as caseid,
TRIM(outc_cod) as outc_cod,
row_number()over(partition by primaryid, caseid, outc_cod order by primaryid ) as rn
from outc26q1
) 
select * from dedups where rn = 1