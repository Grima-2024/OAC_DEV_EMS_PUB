--------------------------------------------------------
--  DDL for Trigger BI_STUD_DOC_DET_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_STUD_DOC_DET_TRG" 
BEFORE INSERT ON STUD_DOC_DET 
FOR EACH ROW 
      WHEN (new.DOC_ID IS NULL) BEGIN 
  :new.DOC_ID := STUD_DOC_DET_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_STUD_DOC_DET_TRG" ENABLE;
