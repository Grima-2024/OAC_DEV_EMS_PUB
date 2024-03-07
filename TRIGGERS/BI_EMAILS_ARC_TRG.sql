--------------------------------------------------------
--  DDL for Trigger BI_EMAILS_ARC_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_EMAILS_ARC_TRG" 
BEFORE INSERT ON EMAILS_ARC 
FOR EACH ROW 
     WHEN (new.e_ID IS NULL) BEGIN 
  :new.e_ID := EMAIL_ARC_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_EMAILS_ARC_TRG" ENABLE;
