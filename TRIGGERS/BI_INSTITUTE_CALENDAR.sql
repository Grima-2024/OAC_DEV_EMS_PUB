--------------------------------------------------------
--  DDL for Trigger BI_INSTITUTE_CALENDAR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_INSTITUTE_CALENDAR" 
  before insert on "INSTITUTE_CALENDAR"               
  for each row  
begin   
  if :NEW."CAL_ID" is null then 
    select "INSTITUTE_CALENDAR_SEQ".nextval into :NEW."CAL_ID" from sys.dual; 
  end if; 
end; 

/
ALTER TRIGGER "INSTITUTE"."BI_INSTITUTE_CALENDAR" ENABLE;
