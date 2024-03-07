--------------------------------------------------------
--  DDL for Trigger BI_LIBFINEDET_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_LIBFINEDET_TRG" 
BEFORE INSERT ON LIBFINEDET 
FOR EACH ROW 
     WHEN (new.LIBFINID IS NULL) BEGIN 
  :new.LIBFINID := LIBFINEDET_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_LIBFINEDET_TRG" ENABLE;
