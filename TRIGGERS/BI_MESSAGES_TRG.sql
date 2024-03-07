--------------------------------------------------------
--  DDL for Trigger BI_MESSAGES_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_MESSAGES_TRG" 
BEFORE INSERT ON MESSAGES 
FOR EACH ROW 
     WHEN (new.M_ID IS NULL) BEGIN 
  :new.M_ID :=MESSAGES_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_MESSAGES_TRG" ENABLE;
