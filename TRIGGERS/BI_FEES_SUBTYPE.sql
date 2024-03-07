--------------------------------------------------------
--  DDL for Trigger BI_FEES_SUBTYPE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_FEES_SUBTYPE" 
  before insert on "FEES_SUB_TYPE"               
  for each row  
begin   
  if :NEW."FEES_SUBTYPE_ID" is null then 
    select "FEES_SUBTYPE_SEQ".nextval into :NEW."FEES_SUBTYPE_ID" from sys.dual; 
  end if; 
end; 

/
ALTER TRIGGER "INSTITUTE"."BI_FEES_SUBTYPE" ENABLE;
