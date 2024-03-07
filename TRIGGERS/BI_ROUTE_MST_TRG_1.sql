--------------------------------------------------------
--  DDL for Trigger BI_ROUTE_MST_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_ROUTE_MST_TRG" 
BEFORE INSERT ON ROUTE_MST 
FOR EACH ROW 
     WHEN (new.ROUTE_ID IS NULL) BEGIN 
  :new.ROUTE_ID := ROUTE_MST_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_ROUTE_MST_TRG" ENABLE;
