/* ----------------------------------------------------------------------------- 
   Inspect dataset variables (no data dictionary available)
----------------------------------------------------------------------------- */

/* View structure and metadata */
proc contents data="\\serverX\project_data\input_data\data_2025.sas7bdat";
run;

/* ----------------------------------------------------------------------------- 
   Select relevant variables and filter records
----------------------------------------------------------------------------- */

data mydata;
      set "\\serverX\project_data\input_data\data_2025.sas7bdat";
      
      /* Filter rows by category */
      where color in ("blue", "red", "yellow", "green", "white");
      
      /* Keep only relevant variables */
      keep name store price month;
run;

