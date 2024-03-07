--------------------------------------------------------
--  DDL for Trigger BI_EMS_TASK_MST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_EMS_TASK_MST" 
before insert on "EMS_TASK_MST"               
for each row  
begin   
	if :NEW."TASK_ID" is null then 
		select "EMS_TASK_MST_SEQ".nextval into :NEW."TASK_ID" from sys.dual; 
  	end if; 
end;
/
ALTER TRIGGER "INSTITUTE"."BI_EMS_TASK_MST" ENABLE;
