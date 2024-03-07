--------------------------------------------------------
--  DDL for Trigger BI_EMS_CONTACT_US
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_EMS_CONTACT_US" 
before insert on "EMS_CONTACT_US"               
for each row  
begin   
	if :NEW."CONTACT_ID" is null then 
		select "EMS_CONTACT_US_SEQ".nextval into :NEW."CONTACT_ID" from sys.dual; 
  	end if; 
end;
/
ALTER TRIGGER "INSTITUTE"."BI_EMS_CONTACT_US" ENABLE;
