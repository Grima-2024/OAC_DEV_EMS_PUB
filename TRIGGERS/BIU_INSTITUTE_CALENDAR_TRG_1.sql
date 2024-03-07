--------------------------------------------------------
--  DDL for Trigger BIU_INSTITUTE_CALENDAR_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BIU_INSTITUTE_CALENDAR_TRG" 
BEFORE INSERT OR UPDATE  ON INSTITUTE_CALENDAR 
FOR EACH ROW 
BEGIN 
 
  CASE 
    WHEN INSERTING THEN 
              :new.CREATED_BY :=v('APP_USER'); 
              :new.CREATED_ON :=sysdate;          
    WHEN UPDATING THEN 
            
            :new.UPDATED_BY :=v('APP_USER'); 
            :new.UPDATED_ON :=sysdate; 
END CASE; 
END;

/
ALTER TRIGGER "INSTITUTE"."BIU_INSTITUTE_CALENDAR_TRG" ENABLE;
