/* Creation of analysis ready table */

DROP TABLE IF EXISTS analysis_table;

CREATE TABLE analysis_table AS 
WITH primary_drugs AS (

    SELECT primaryid, STRING_AGG(DISTINCT drugname, ' | ') AS suspect_drugs
    FROM drug26q1_final
    WHERE role_cod = 'PS'
    GROUP BY primaryid
),
patient_outcomes AS (

    SELECT primaryid, STRING_AGG(DISTINCT outc_cod, ', ') AS outcomes
    FROM outc26q1_final
    GROUP BY primaryid
),
therapy_dates AS (

    SELECT primaryid, MIN(start_dt) AS first_start_dt, MAX(end_dt) AS last_end_dt
    FROM ther26q1_final
    GROUP BY primaryid
)
SELECT 
    dm.primaryid,
    dm.caseid,
    dm.age,
    dm.age_grp,
    dm.sex,
    dm.wt,
    dm.wt_cod,
    dm.event_dt,
    pd.suspect_drugs,
    rc.pt AS adverse_event,
    po.outcomes,
    td.first_start_dt,
    td.last_end_dt
FROM demo26q1_final dm
INNER JOIN primary_drugs pd 
    ON dm.primaryid = pd.primaryid
INNER JOIN reac26q1_final rc 
    ON dm.primaryid = rc.primaryid
LEFT JOIN patient_outcomes po 
    ON dm.primaryid = po.primaryid
LEFT JOIN therapy_dates td 
    ON dm.primaryid = td.primaryid;

