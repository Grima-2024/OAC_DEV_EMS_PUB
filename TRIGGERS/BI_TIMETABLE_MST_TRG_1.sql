--------------------------------------------------------
--  DDL for Trigger BI_TIMETABLE_MST_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_TIMETABLE_MST_TRG" 
BEFORE INSERT ON TIMETABLE_MST 
FOR EACH ROW 
      WHEN (new.TIMEMST_ID IS NULL) BEGIN 
  :new.TIMEMST_ID :=TIMETABLE_MST_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_TIMETABLE_MST_TRG" ENABLE;
