--------------------------------------------------------
--  DDL for Trigger BI_AT_STUD_ATTEND_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_AT_STUD_ATTEND_TRG" 
BEFORE INSERT ON AT_STUD_ATTENDANCE 
FOR EACH ROW 
     WHEN (new.ATTEND_ID IS NULL) BEGIN 
   :new.ATTEND_ID :=  AT_STUD_ATTEND_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_AT_STUD_ATTEND_TRG" ENABLE;
