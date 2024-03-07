--------------------------------------------------------
--  DDL for Trigger BI_HEALTH_REPORT_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_HEALTH_REPORT_TRG" 
BEFORE INSERT ON HEALTH_REPORT 
FOR EACH ROW 
      WHEN (new.DISEASE_ID IS NULL) BEGIN 
  :new.DISEASE_ID :=HEALTH_REPORT_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_HEALTH_REPORT_TRG" ENABLE;
