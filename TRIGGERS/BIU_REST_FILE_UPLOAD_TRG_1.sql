--------------------------------------------------------
--  DDL for Trigger BIU_REST_FILE_UPLOAD_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BIU_REST_FILE_UPLOAD_TRG" 
BEFORE INSERT OR UPDATE  ON REST_FILE_UPLOAD 
FOR EACH ROW 
BEGIN 
    CASE 
        WHEN INSERTING THEN 
            :new.CREATED_ON := localtimestamp;          
        WHEN UPDATING THEN 
            :new.UPDATED_ON := localtimestamp; 
    END CASE; 
END;

/
ALTER TRIGGER "INSTITUTE"."BIU_REST_FILE_UPLOAD_TRG" ENABLE;
