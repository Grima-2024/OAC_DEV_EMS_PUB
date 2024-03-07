--------------------------------------------------------
--  Ref Constraints for Table EMAILS
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."EMAILS" ADD CONSTRAINT "EMAILS_INSTITUTE_MST_FK" FOREIGN KEY ("INSTITUTE_ID")
	  REFERENCES "INSTITUTE"."INSTITUTE_MST" ("INSTITUTE_ID") ENABLE;
