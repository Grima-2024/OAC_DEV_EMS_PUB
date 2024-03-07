--------------------------------------------------------
--  DDL for Trigger BI_AUTO_SCHEDULER
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_AUTO_SCHEDULER" 
  before insert on "AUTO_SCHEDULER"               
  for each row  
begin   
  if :NEW."AUTO_SCH_ID" is null then 
    select "AUTO_SCHEDULER_SEQ".nextval into :NEW."AUTO_SCH_ID" from sys.dual; 
  end if; 
end;

/
ALTER TRIGGER "INSTITUTE"."BI_AUTO_SCHEDULER" ENABLE;
