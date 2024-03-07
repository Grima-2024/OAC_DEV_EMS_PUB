--------------------------------------------------------
--  DDL for Trigger EMS_ERRORS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."EMS_ERRORS" 
    before insert or update on EMS_ERROR_LOG
    for each row
begin
    if :new.id is null then
        select to_number(sys_guid(),'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') into :new.id from dual;
    end if;
end;

/
ALTER TRIGGER "INSTITUTE"."EMS_ERRORS" ENABLE;
