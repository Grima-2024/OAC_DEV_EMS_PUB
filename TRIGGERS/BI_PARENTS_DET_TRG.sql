--------------------------------------------------------
--  DDL for Trigger BI_PARENTS_DET_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_PARENTS_DET_TRG" 
BEFORE INSERT ON PARENTS_DET 
FOR EACH ROW 
   WHEN (new.PARENTS_ID IS NULL) BEGIN 
  :new.PARENTS_ID := PARENTS_DET_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_PARENTS_DET_TRG" ENABLE;
