# FAERS-Pharmacovigilance-Data-Analysis-Using-Python-and-SQL
This project is an end-to-end clinical data pipeline and analytics solution designed to process, validate, and analyze post-market drug safety data from the FDA Adverse Event Reporting System (FAERS).

The objective is to ingest raw reporting data, perform rigorous clinical data profiling and validation, standardize the data into an analysis-ready format, and visualize critical safety signals—specifically focusing on Case Fatality Rates (CFR) and Serious Adverse Event (SAE) rates across demographic cohorts and suspected drugs.
## Technology Stack
* Database / Data Engineering: PostgreSQL (CTEs, Window Functions, String Aggregation, Data Profiling)

* Programming Language: Python 3

* Data Wrangling: pandas, numpy

* Data Visualization: matplotlib

## Data Architecture & Pipeline
The pipeline processes raw FAERS data tables (Demographics, Drugs, Reactions, Outcomes) through a strict ETL process:

### 1. Data Profiling (data_profiling.sql)

* Conducted initial Exploratory Data Analysis (EDA) directly in SQL.

* Calculated null-rate distributions across critical variables (e.g., primaryid, event_dt, pt).

* Identified and quantified duplicate records based on caseid and rept_dt combinations.

### 2. Clinical Data Validation & Cleaning (Data_cleaning_validation.sql)

* Developed robust PostgreSQL logic to clean and standardize the raw FAERS data:

* Temporal Logic: Validated dates (e.g., ensuring manufacturer date >= event date).

* Clinical Metrics: Standardized weight reporting by filtering invalid units and flagging extreme clinical outliers (e.g., wt > 600 KG). Ensured age logic validity.

* Deduplication: Removed exact duplicate records using Window Functions (ROW_NUMBER() OVER PARTITION BY primaryid, caseid ORDER BY event_dt DESC).

### 3. Building the Analysis-Ready Dataset (analysis_table.sql)

* Using Common Table Expressions (CTEs), the cleaned tables were merged into a single analysis_table:

* String Aggregation: Grouped multiple primary suspect drugs (role_cod = 'PS') and outcomes for a single patient case into separated strings using STRING_AGG().

* Temporal Aggregation: Extracted the start and end dates for patient therapies.

### 4. Python Analytics & Visualization (faers_analysis.py)

* The cleaned analysis_table.csv was ingested into Python for advanced analytics on the aggregated records.

* Data Transformation: Exploded the aggregated drug and outcome strings to allow for granular analysis without double-counting patient cases.

## Clinical Calculations:

* Serious Adverse Event (SAE) Rate: Calculated severe outcomes (Death, Hospitalization, Life-Threatening, etc.) per drug for statistically significant volumes (>1000 cases).

* Case Fatality Rate (CFR): Calculated the exact percentage of fatal cases (outc_cod = 'DE') associated with high-volume suspected drugs.

## Key Clinical Insights & Visualizations
Based on the generated visualizations, several critical safety signals were identified:

* **Distribution of AE by Age group**:
Adult and Elderly populations accounted for the vast majority of reported adverse events, highlighting the need for age-specific safety monitoring.

<img src="Distribution of AE by Age group.png" width="600">

* **Total fatal cases by age group**:

While Adults had the highest total AE count, the Elderly age group experienced a disproportionately higher absolute number of fatal outcomes, indicating high vulnerability to severe drug reactions in geriatric populations.

<img src="Total fatal cases by age group.png" width="600">

* **Top 10 drugs with most adverse events**:

 Identified the highest raw volume of adverse event reports among primary suspect drugs.

<img src="Top 10 drugs with most adverse events.png" width="600">

* **SAE rate of suspected drugs**:

Highlighted specific therapeutics that demonstrated the highest Serious Adverse Event (SAE) rates among the most frequently reported drugs.

<img src="SAE rate of suspected drugs.png" width="600">

* **CFR Rate of suspected drugs**:

Isolated the top high-volume drugs showing the highest Case Fatality Rate (CFR).

<img src="CFR Rate of suspected drugs.png" width="600">
