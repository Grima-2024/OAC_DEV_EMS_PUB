--------------------------------------------------------
--  DDL for Trigger BI_AEP_USER_MST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_AEP_USER_MST" 
before insert on "AEP_USER_MST"                
for each row   
begin    
  if :NEW."USER_ID" is null then  
    select "AEP_USER_MST_SEQ".nextval into :NEW."USER_ID" from sys.dual;  
  end if;  
end; 

/
ALTER TRIGGER "INSTITUTE"."BI_AEP_USER_MST" ENABLE;
