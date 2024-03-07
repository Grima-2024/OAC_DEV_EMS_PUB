--------------------------------------------------------
--  DDL for Trigger BI_BOOKSLISTDET_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_BOOKSLISTDET_TRG" 
BEFORE INSERT ON BOOKSLISTDET 
FOR EACH ROW 
     WHEN (new.BOOKID IS NULL) BEGIN 
  :new.BOOKID := BOOKSLISTDET_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_BOOKSLISTDET_TRG" ENABLE;
