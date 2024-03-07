--------------------------------------------------------
--  DDL for Trigger BI_EMAIL_TEMPLATE_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_EMAIL_TEMPLATE_TRG" 
BEFORE INSERT ON EMAIL_TEMPLATE 
FOR EACH ROW 
    WHEN (new.ET_ID IS NULL) BEGIN 
  :new.ET_ID := EMAIL_TEMPLATE_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_EMAIL_TEMPLATE_TRG" ENABLE;
