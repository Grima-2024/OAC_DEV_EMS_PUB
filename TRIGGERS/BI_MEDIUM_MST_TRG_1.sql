--------------------------------------------------------
--  DDL for Trigger BI_MEDIUM_MST_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_MEDIUM_MST_TRG" 
BEFORE INSERT ON MEDIUM_MST  
FOR EACH ROW 
    WHEN (new.MED_ID IS NULL) BEGIN 
  :new.MED_ID := MEDIUM_MST_SEQ.NEXTVAL; 
END; 

/
ALTER TRIGGER "INSTITUTE"."BI_MEDIUM_MST_TRG" ENABLE;
