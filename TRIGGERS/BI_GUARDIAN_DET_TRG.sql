--------------------------------------------------------
--  DDL for Trigger BI_GUARDIAN_DET_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_GUARDIAN_DET_TRG" 
BEFORE INSERT ON GUARDIAN_DET 
FOR EACH ROW 
      WHEN (new.GUARDIAN_ID IS NULL) BEGIN 
  :new.GUARDIAN_ID :=GUARDIAN_DET_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_GUARDIAN_DET_TRG" ENABLE;
