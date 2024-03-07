--------------------------------------------------------
--  DDL for Trigger BI_HOSTEL_FEES_DET_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_HOSTEL_FEES_DET_TRG" 
BEFORE INSERT ON HOSTEL_FEES_DET 
FOR EACH ROW 
     WHEN (new.HSTL_FEES_ID IS NULL) BEGIN 
  :new.HSTL_FEES_ID := HOSTEL_FEES_DET_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_HOSTEL_FEES_DET_TRG" ENABLE;
