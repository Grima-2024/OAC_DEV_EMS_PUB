--------------------------------------------------------
--  DDL for Trigger BI_DIVISION_MST_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_DIVISION_MST_TRG" 
BEFORE INSERT ON DIVISION_MST 
FOR EACH ROW 
    WHEN (new.DIVISION_ID IS NULL) BEGIN 
  :new.DIVISION_ID := DIVISION_MST_SEQ.NEXTVAL; 
END; 

/
ALTER TRIGGER "INSTITUTE"."BI_DIVISION_MST_TRG" ENABLE;
