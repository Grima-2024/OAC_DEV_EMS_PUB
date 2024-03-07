--------------------------------------------------------
--  Ref Constraints for Table EMAIL_ATTACHMENTS
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."EMAIL_ATTACHMENTS" ADD CONSTRAINT "EMAIL_ATTACHMENTS_EMAILS_FK" FOREIGN KEY ("E_ID")
	  REFERENCES "INSTITUTE"."EMAILS" ("E_ID") ENABLE;
