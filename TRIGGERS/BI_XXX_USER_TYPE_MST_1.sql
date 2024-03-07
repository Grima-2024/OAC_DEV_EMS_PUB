--------------------------------------------------------
--  DDL for Trigger BI_XXX_USER_TYPE_MST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_XXX_USER_TYPE_MST" 
  before insert on "XXX_USER_TYPE_MST"               
  for each row  
begin   
  if :NEW."USER_TYPE_ID" is null then 
    select "XXX_USER_TYPE_MST_SEQ".nextval into :NEW."USER_TYPE_ID" from sys.dual; 
  end if; 
end;
/
ALTER TRIGGER "INSTITUTE"."BI_XXX_USER_TYPE_MST" ENABLE;
