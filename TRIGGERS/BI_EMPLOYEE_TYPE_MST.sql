--------------------------------------------------------
--  DDL for Trigger BI_EMPLOYEE_TYPE_MST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_EMPLOYEE_TYPE_MST" 
  before insert on "EMPLOYEE_TYPE_MST"               
  for each row  
begin   
  if :NEW."TYPE_ID" is null then 
    select "EMPLOYEE_TYPE_MST_SEQ".nextval into :NEW."TYPE_ID" from sys.dual; 
  end if; 
end; 

/
ALTER TRIGGER "INSTITUTE"."BI_EMPLOYEE_TYPE_MST" ENABLE;
