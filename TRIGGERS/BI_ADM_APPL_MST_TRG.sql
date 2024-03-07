--------------------------------------------------------
--  DDL for Trigger BI_ADM_APPL_MST_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_ADM_APPL_MST_TRG" 
BEFORE INSERT ON ADMISSION_APPLICATION 
FOR EACH ROW 
    WHEN (new.ADM_APPL_ID IS NULL) BEGIN 
  :new.ADM_APPL_ID := ADM_APPL_MST_SEQ.NEXTVAL; 
END; 

/
ALTER TRIGGER "INSTITUTE"."BI_ADM_APPL_MST_TRG" ENABLE;
