--------------------------------------------------------
--  DDL for Trigger BI_POINTS_MST_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_POINTS_MST_TRG" 
BEFORE INSERT ON POINTS_MST 
FOR EACH ROW 
     WHEN (new.POINT_ID IS NULL) BEGIN 
  :new.POINT_ID := POINT_MST_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_POINTS_MST_TRG" ENABLE;
