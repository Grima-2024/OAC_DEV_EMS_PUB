--------------------------------------------------------
--  DDL for Trigger BI_SCHEDULE_MST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_SCHEDULE_MST" 
  before insert on "SCHEDULE_MST"               
  for each row  
begin   
  if :NEW."SCHEDULE_ID" is null then 
    select "SCHEDULE_MST_SEQ".nextval into :NEW."SCHEDULE_ID" from sys.dual; 
  end if; 
end; 

/
ALTER TRIGGER "INSTITUTE"."BI_SCHEDULE_MST" ENABLE;
