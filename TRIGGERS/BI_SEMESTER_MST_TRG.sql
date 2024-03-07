--------------------------------------------------------
--  DDL for Trigger BI_SEMESTER_MST_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_SEMESTER_MST_TRG" 
BEFORE INSERT ON SEMESTER_MST 
FOR EACH ROW 
    WHEN (new.SEM_ID IS NULL) BEGIN 
  :new.SEM_ID := SEMESTER_MST_SEQ.NEXTVAL; 
END; 

/
ALTER TRIGGER "INSTITUTE"."BI_SEMESTER_MST_TRG" ENABLE;
