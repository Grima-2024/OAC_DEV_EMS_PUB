--------------------------------------------------------
--  DDL for Trigger BI_BOOKISSUE_QUOTA_MST_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BI_BOOKISSUE_QUOTA_MST_TRG" 
BEFORE INSERT ON BOOKISSUE_QUOTA_MST 
FOR EACH ROW 
     WHEN (new.BOOKQTID IS NULL) BEGIN 
  :new.BOOKQTID := BOOKISSUE_QUOTA_MST_SEQ.NEXTVAL; 
END; 
 

/
ALTER TRIGGER "INSTITUTE"."BI_BOOKISSUE_QUOTA_MST_TRG" ENABLE;
