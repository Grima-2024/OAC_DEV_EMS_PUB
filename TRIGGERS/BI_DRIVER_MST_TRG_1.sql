--------------------------------------------------------
--  DDL for Trigger BI_DRIVER_MST_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_DRIVER_MST_TRG" 
BEFORE INSERT ON DRIVER_MST 
FOR EACH ROW 
      WHEN (new.DRIVER_ID IS NULL) BEGIN 
  :new.DRIVER_ID := DRIVER_MST_SEQ.NEXTVAL; 
END;

/
ALTER TRIGGER "INSTITUTE"."BI_DRIVER_MST_TRG" ENABLE;
