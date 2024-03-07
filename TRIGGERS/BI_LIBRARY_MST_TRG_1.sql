--------------------------------------------------------
--  DDL for Trigger BI_LIBRARY_MST_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_LIBRARY_MST_TRG" 
BEFORE INSERT ON LIBRARY_MST 
FOR EACH ROW 
     WHEN (new.LIB_ID IS NULL) BEGIN 
  :new.LIB_ID := LIBRARY_MST_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_LIBRARY_MST_TRG" ENABLE;
