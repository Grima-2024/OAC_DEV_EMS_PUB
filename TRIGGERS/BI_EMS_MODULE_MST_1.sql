--------------------------------------------------------
--  DDL for Trigger BI_EMS_MODULE_MST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_EMS_MODULE_MST" 
before insert on "EMS_MODULE_MST"               
for each row  
begin   
	if :NEW."MODULE_ID" is null then 
		select "EMS_MODULE_MST_SEQ".nextval into :NEW."MODULE_ID" from sys.dual; 
	end if; 
end;
/
ALTER TRIGGER "INSTITUTE"."BI_EMS_MODULE_MST" ENABLE;
