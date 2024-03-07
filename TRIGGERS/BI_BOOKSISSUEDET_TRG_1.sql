--------------------------------------------------------
--  DDL for Trigger BI_BOOKSISSUEDET_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_BOOKSISSUEDET_TRG" 
BEFORE INSERT ON BOOKSISSUEDET 
FOR EACH ROW 
     WHEN (new.BOOKISSUEID IS NULL) BEGIN 
  :new.BOOKISSUEID := BOOKSISSUEDET_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_BOOKSISSUEDET_TRG" ENABLE;