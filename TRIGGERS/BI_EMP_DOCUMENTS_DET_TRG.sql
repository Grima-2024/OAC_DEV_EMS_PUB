--------------------------------------------------------
--  DDL for Trigger BI_EMP_DOCUMENTS_DET_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_EMP_DOCUMENTS_DET_TRG" 
BEFORE INSERT ON EMP_DOCUMENTS_DET 
FOR EACH ROW 
      WHEN (new.DOC_ID IS NULL) BEGIN 
  :new.DOC_ID := EMP_DOCUMENTS_DET_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_EMP_DOCUMENTS_DET_TRG" ENABLE;
