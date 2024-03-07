--------------------------------------------------------
--  DDL for Trigger BI_HOSTEL_MST_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_HOSTEL_MST_TRG" 
BEFORE INSERT ON HOSTEL_MST 
FOR EACH ROW 
     WHEN (new.HOSTEL_ID IS NULL) BEGIN 
  :new.HOSTEL_ID := HOSTEL_MST_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_HOSTEL_MST_TRG" ENABLE;
