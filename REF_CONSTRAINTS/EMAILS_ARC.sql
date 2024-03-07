--------------------------------------------------------
--  Ref Constraints for Table EMAILS_ARC
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."EMAILS_ARC" ADD CONSTRAINT "EMAILS_ARC_INSTITUTE_MST_FK" FOREIGN KEY ("INSTITUTE_ID")
	  REFERENCES "INSTITUTE"."INSTITUTE_MST" ("INSTITUTE_ID") ENABLE;
