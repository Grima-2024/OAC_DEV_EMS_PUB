--------------------------------------------------------
--  DDL for Trigger BI_EMP_EDUCATION_DET_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_EMP_EDUCATION_DET_TRG" 
BEFORE INSERT ON EMP_EDUCATION_DET 
FOR EACH ROW 
      WHEN (new.EDU_DET_ID IS NULL) BEGIN 
  :new.EDU_DET_ID := EMP_EDUCATION_DET_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_EMP_EDUCATION_DET_TRG" ENABLE;
