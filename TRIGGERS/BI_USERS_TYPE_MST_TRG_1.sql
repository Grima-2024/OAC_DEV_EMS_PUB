--------------------------------------------------------
--  DDL for Trigger BI_USERS_TYPE_MST_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_USERS_TYPE_MST_TRG" 
BEFORE INSERT ON USERS_TYPE_MST  
FOR EACH ROW 
   WHEN (new.USER_TYPE_ID IS NULL) BEGIN 
  :new.USER_TYPE_ID := USERS_TYPE_MST_seq.NEXTVAL; 
END; 

/
ALTER TRIGGER "INSTITUTE"."BI_USERS_TYPE_MST_TRG" ENABLE;
