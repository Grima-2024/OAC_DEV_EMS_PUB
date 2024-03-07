--------------------------------------------------------
--  DDL for Trigger BI_LEAVE_TYPE_MST_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_LEAVE_TYPE_MST_TRG" 
BEFORE INSERT ON LEAVE_TYPE_MST 
FOR EACH ROW 
     WHEN (new.LEAVE_TYPE_ID IS NULL) BEGIN 
   :new.LEAVE_TYPE_ID :=  LEAVE_TYPE_MST_SEQ.NEXTVAL; 
END;

/
ALTER TRIGGER "INSTITUTE"."BI_LEAVE_TYPE_MST_TRG" ENABLE;
