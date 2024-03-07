--------------------------------------------------------
--  DDL for Trigger BIU_EMS_DEMO_REQUEST_TBL_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BIU_EMS_DEMO_REQUEST_TBL_TRG" 
BEFORE INSERT OR UPDATE  ON EMS_DEMO_REQUEST_TBL 
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
ALTER TRIGGER "INSTITUTE"."BIU_EMS_DEMO_REQUEST_TBL_TRG" ENABLE;
