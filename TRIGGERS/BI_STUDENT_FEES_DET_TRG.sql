--------------------------------------------------------
--  DDL for Trigger BI_STUDENT_FEES_DET_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_STUDENT_FEES_DET_TRG" 
BEFORE INSERT ON STUDENT_FEES_DET 
FOR EACH ROW 
      WHEN (new.FEES_ID IS NULL) BEGIN 
  :new.FEES_ID :=STUDENT_FEES_DET_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_STUDENT_FEES_DET_TRG" ENABLE;
