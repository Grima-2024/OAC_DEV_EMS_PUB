--------------------------------------------------------
--  DDL for Trigger BI_STUDENT_LEAVE_DETAILS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_STUDENT_LEAVE_DETAILS" 
  before insert on "STUDENT_LEAVE_DETAILS"               
  for each row  
begin   
  if :NEW."LEAVE_ID" is null then 
    select "STUDENT_LEAVE_DETAILS_SEQ".nextval into :NEW."LEAVE_ID" from sys.dual; 
  end if; 
end; 

/
ALTER TRIGGER "INSTITUTE"."BI_STUDENT_LEAVE_DETAILS" ENABLE;
