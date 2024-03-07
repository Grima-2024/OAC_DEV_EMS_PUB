--------------------------------------------------------
--  DDL for Trigger BI_STANDARD_MST_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_STANDARD_MST_TRG" 
BEFORE INSERT ON STANDARD_MST 
FOR EACH ROW 
    WHEN (new.STD_ID IS NULL) BEGIN 
  :new.STD_ID := STANDARD_MST_SEQ.NEXTVAL; 
END; 

/
ALTER TRIGGER "INSTITUTE"."BI_STANDARD_MST_TRG" ENABLE;
