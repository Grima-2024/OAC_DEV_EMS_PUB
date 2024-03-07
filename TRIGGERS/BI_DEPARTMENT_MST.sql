--------------------------------------------------------
--  DDL for Trigger BI_DEPARTMENT_MST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_DEPARTMENT_MST" 
  before insert on "DEPARTMENT_MST"               
  for each row  
begin   
  if :NEW."DEPT_ID" is null then 
    select "DEPARTMENT_MST_SEQ".nextval into :NEW."DEPT_ID" from sys.dual; 
  end if; 
end; 

/
ALTER TRIGGER "INSTITUTE"."BI_DEPARTMENT_MST" ENABLE;
