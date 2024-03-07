--------------------------------------------------------
--  DDL for Trigger BI_EMP_PAYROLL_DET_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_EMP_PAYROLL_DET_TRG" 
BEFORE INSERT ON EMP_PAYROLL_DET 
FOR EACH ROW 
      WHEN (new.PAY_DET_ID IS NULL) BEGIN 
  :new.PAY_DET_ID := EMP_PAYROLL_DET_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_EMP_PAYROLL_DET_TRG" ENABLE;
