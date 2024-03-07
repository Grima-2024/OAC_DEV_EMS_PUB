--------------------------------------------------------
--  DDL for Trigger BI_TIMETABLE_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_TIMETABLE_TRG" 
BEFORE INSERT ON TIMETABLE 
FOR EACH ROW 
      WHEN (new.TIMETBL_ID IS NULL) BEGIN 
  :new.TIMETBL_ID :=TIMETABLE_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_TIMETABLE_TRG" ENABLE;
