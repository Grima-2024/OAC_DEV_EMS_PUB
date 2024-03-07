--------------------------------------------------------
--  DDL for Trigger BI_COUNTRIES_MST_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_COUNTRIES_MST_TRG" 
BEFORE INSERT ON COUNTRIES_MST  
FOR EACH ROW 
     WHEN (new.COUNTRY_ID IS NULL) BEGIN 
  :new.COUNTRY_ID := COUNTRIES_MST_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_COUNTRIES_MST_TRG" ENABLE;
