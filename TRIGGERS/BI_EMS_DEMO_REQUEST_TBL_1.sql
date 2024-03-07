--------------------------------------------------------
--  DDL for Trigger BI_EMS_DEMO_REQUEST_TBL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_EMS_DEMO_REQUEST_TBL" 
before insert on "EMS_DEMO_REQUEST_TBL"               
for each row  
begin   
	if :NEW."REQUEST_ID" is null then 
		select "EMS_DEMO_REQUEST_TBL_SEQ".nextval into :NEW."REQUEST_ID" from sys.dual; 
  	end if; 
end;
/
ALTER TRIGGER "INSTITUTE"."BI_EMS_DEMO_REQUEST_TBL" ENABLE;
