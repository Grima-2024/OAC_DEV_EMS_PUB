--------------------------------------------------------
--  DDL for Trigger BI_EMPLOYEE_DET_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_EMPLOYEE_DET_TRG" 
BEFORE INSERT ON EMPLOYEE_DET 
FOR EACH ROW 
     WHEN (new.EMPLOYEE_ID IS NULL) BEGIN 
  :new.EMPLOYEE_ID := EMPLOYEE_DET_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_EMPLOYEE_DET_TRG" ENABLE;
