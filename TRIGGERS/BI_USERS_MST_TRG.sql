--------------------------------------------------------
--  DDL for Trigger BI_USERS_MST_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_USERS_MST_TRG" 
BEFORE INSERT OR UPDATE ON USERS_MST  
FOR EACH ROW 
      WHEN (new.USER_ID IS NULL) BEGIN 
  :new.USER_ID := USERS_MST_seq.NEXTVAL; 
  :new.password := hash_password(upper(:new.username), :new.password); 
END;

/
ALTER TRIGGER "INSTITUTE"."BI_USERS_MST_TRG" ENABLE;
