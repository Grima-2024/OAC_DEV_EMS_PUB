--------------------------------------------------------
--  DDL for Trigger BI_VEHICAL_MST_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_VEHICAL_MST_TRG" 
BEFORE INSERT ON VEHICAL_MST 
FOR EACH ROW 
     WHEN (new.VEHICAL_ID IS NULL) BEGIN 
  :new.VEHICAL_ID := VEHICAL_MST_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_VEHICAL_MST_TRG" ENABLE;
