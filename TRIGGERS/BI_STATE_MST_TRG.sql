--------------------------------------------------------
--  DDL for Trigger BI_STATE_MST_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_STATE_MST_TRG" 
BEFORE INSERT ON STATE_MST  
FOR EACH ROW 
     WHEN (new.STATE_ID IS NULL) BEGIN 
  :new.STATE_ID := STATE_MST_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_STATE_MST_TRG" ENABLE;
