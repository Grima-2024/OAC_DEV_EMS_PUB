--------------------------------------------------------
--  DDL for Trigger BI_HOSTEL_ROOM_MST_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_HOSTEL_ROOM_MST_TRG" 
BEFORE INSERT ON HOSTEL_ROOM_MST 
FOR EACH ROW 
     WHEN (new.ROOM_ID IS NULL) BEGIN 
  :new.ROOM_ID := HOSTEL_ROOM_MST_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_HOSTEL_ROOM_MST_TRG" ENABLE;
