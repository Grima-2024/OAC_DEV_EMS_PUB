--------------------------------------------------------
--  DDL for Trigger BI_XXX_USER_MST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_XXX_USER_MST" 
  before insert on "XXX_USER_MST"               
  for each row  
begin   
  if :NEW."USER_ID" is null then 
    select "XXX_USER_MST_SEQ".nextval into :NEW."USER_ID" from sys.dual; 
  end if; 
end;
/
ALTER TRIGGER "INSTITUTE"."BI_XXX_USER_MST" ENABLE;
