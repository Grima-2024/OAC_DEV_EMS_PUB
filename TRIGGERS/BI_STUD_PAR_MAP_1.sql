--------------------------------------------------------
--  DDL for Trigger BI_STUD_PAR_MAP
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_STUD_PAR_MAP" 
  before insert on "STUD_PAR_MAP"               
  for each row  
begin   
  if :NEW."MAP_ID_PK" is null then 
    select "STUD_PAR_MAP_SEQ".nextval into :NEW."MAP_ID_PK" from sys.dual; 
  end if; 
end; 

/
ALTER TRIGGER "INSTITUTE"."BI_STUD_PAR_MAP" ENABLE;
