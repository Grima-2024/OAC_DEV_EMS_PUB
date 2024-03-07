--------------------------------------------------------
--  DDL for Trigger BI_STUDENTS_DET_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_STUDENTS_DET_TRG" 
BEFORE INSERT ON STUDENTS_DET 
FOR EACH ROW 
     WHEN (new.STUDENT_ID IS NULL) BEGIN 
  :new.STUDENT_ID := STUDENTS_DET_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_STUDENTS_DET_TRG" ENABLE;
