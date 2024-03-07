--------------------------------------------------------
--  DDL for Trigger BI_EMAILS_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_EMAILS_TRG" 
BEFORE INSERT ON EMAILS 
FOR EACH ROW 
    WHEN (new.e_ID IS NULL) BEGIN 
  :new.e_ID := EMAIL_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_EMAILS_TRG" ENABLE;
