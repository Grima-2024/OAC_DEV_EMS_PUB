--------------------------------------------------------
--  DDL for Trigger BI_EVENT_TYPE_MST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_EVENT_TYPE_MST" 
  before insert on "EVENT_TYPE_MST"               
  for each row  
begin   
  if :NEW."EVENT_ID" is null then 
    select "EVENT_TYPE_MST_SEQ".nextval into :NEW."EVENT_ID" from sys.dual; 
  end if; 
end; 

/
ALTER TRIGGER "INSTITUTE"."BI_EVENT_TYPE_MST" ENABLE;
