--------------------------------------------------------
--  DDL for Trigger BI_ASSIGN_SUB_DET_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_ASSIGN_SUB_DET_TRG" 
BEFORE INSERT ON ASSIGN_SUB_DET 
FOR EACH ROW 
      WHEN (new.ASSIGN_ID IS NULL) BEGIN 
  :new.ASSIGN_ID :=ASSIGN_SUB_DET_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_ASSIGN_SUB_DET_TRG" ENABLE;
