--------------------------------------------------------
--  DDL for Trigger BI_TIME_MST_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_TIME_MST_TRG" 
BEFORE INSERT ON TIME_MST 
FOR EACH ROW 
      WHEN (new.TIME_ID IS NULL) BEGIN 
  :new.TIME_ID :=TIME_MST_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_TIME_MST_TRG" ENABLE;
