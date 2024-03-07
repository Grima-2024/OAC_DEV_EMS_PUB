--------------------------------------------------------
--  DDL for Trigger BI_SUBJECT_MST_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_SUBJECT_MST_TRG" 
BEFORE INSERT ON SUBJECT_MST 
FOR EACH ROW 
    WHEN (new.SUB_ID IS NULL) BEGIN 
  :new.SUB_ID := SUBJECT_MST_SEQ.NEXTVAL; 
END; 

/
ALTER TRIGGER "INSTITUTE"."BI_SUBJECT_MST_TRG" ENABLE;
