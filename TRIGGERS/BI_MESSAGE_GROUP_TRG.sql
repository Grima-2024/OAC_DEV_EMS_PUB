--------------------------------------------------------
--  DDL for Trigger BI_MESSAGE_GROUP_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_MESSAGE_GROUP_TRG" 
BEFORE INSERT ON MESSAGE_GROUPS 
FOR EACH ROW 
     WHEN (new.GROUP_ID IS NULL) BEGIN 
  :new.GROUP_ID :=MESSAGE_GROUPS_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_MESSAGE_GROUP_TRG" ENABLE;
