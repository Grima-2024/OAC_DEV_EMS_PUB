--------------------------------------------------------
--  Ref Constraints for Table BOOKISSUE_QUOTA_MST
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."BOOKISSUE_QUOTA_MST" ADD CONSTRAINT "BOOKISSUE_QUOTA_MST_LIB_MST_FK" FOREIGN KEY ("LIB_ID")
	  REFERENCES "INSTITUTE"."LIBRARY_MST" ("LIB_ID") ENABLE;
