--------------------------------------------------------
--  DDL for Trigger BI_FEES_TYPE_MST_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_FEES_TYPE_MST_TRG" 
BEFORE INSERT ON FEES_TYPE_MST 
FOR EACH ROW 
      WHEN (new.FEES_TYPE_ID IS NULL) BEGIN 
  :new.FEES_TYPE_ID :=FEES_TYPE_MST_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_FEES_TYPE_MST_TRG" ENABLE;
