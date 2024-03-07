--------------------------------------------------------
--  DDL for Trigger BI_COMPANY_MST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_COMPANY_MST" 
  before insert on "OMS_COMPANY_MST"               
  for each row  
begin   
  if :NEW."COMP_ID" is null then 
    select "COMPANY_MST_SEQ".nextval into :NEW."COMP_ID" from sys.dual; 
  end if; 
end; 
/
ALTER TRIGGER "INSTITUTE"."BI_COMPANY_MST" ENABLE;
