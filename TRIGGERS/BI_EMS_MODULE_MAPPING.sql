--------------------------------------------------------
--  DDL for Trigger BI_EMS_MODULE_MAPPING
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_EMS_MODULE_MAPPING" 
before insert on "EMS_MODULE_MAPPING"               
for each row  
begin   
	if :NEW."MOD_MAP_ID" is null then 
	    select "EMS_MODULE_MAPPING_SEQ".nextval into :NEW."MOD_MAP_ID" from sys.dual; 
	end if; 
end;
/
ALTER TRIGGER "INSTITUTE"."BI_EMS_MODULE_MAPPING" ENABLE;
