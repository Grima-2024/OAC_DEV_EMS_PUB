--------------------------------------------------------
--  DDL for Trigger BIU_FEES_SUBTYPE_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BIU_FEES_SUBTYPE_TRG" 
BEFORE INSERT OR UPDATE  ON FEES_SUB_TYPE 
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
ALTER TRIGGER "INSTITUTE"."BIU_FEES_SUBTYPE_TRG" ENABLE;
