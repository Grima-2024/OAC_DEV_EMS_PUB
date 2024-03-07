--------------------------------------------------------
--  DDL for Trigger BI_DISEASE_MST_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_DISEASE_MST_TRG" 
BEFORE INSERT ON DISEASE_MST 
FOR EACH ROW 
      WHEN (new.DISEASE_MAST_ID IS NULL) BEGIN 
  :new.DISEASE_MAST_ID :=DISEASE_MST_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_DISEASE_MST_TRG" ENABLE;
