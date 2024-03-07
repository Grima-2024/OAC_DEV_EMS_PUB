--------------------------------------------------------
--  DDL for Trigger BI_REST_FILE_UPLOAD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_REST_FILE_UPLOAD" 
  before insert on "REST_FILE_UPLOAD"               
  for each row  
begin   
  if :NEW."FILE_ID" is null then 
    select "REST_FILE_UPLOAD_SEQ".nextval into :NEW."FILE_ID" from sys.dual; 
  end if; 
end; 

/
ALTER TRIGGER "INSTITUTE"."BI_REST_FILE_UPLOAD" ENABLE;
