--------------------------------------------------------
--  Ref Constraints for Table MESSAGES
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."MESSAGES" ADD CONSTRAINT "MESSAGES_INSTITUTE_MST_FK" FOREIGN KEY ("INSTITUTE_ID")
	  REFERENCES "INSTITUTE"."INSTITUTE_MST" ("INSTITUTE_ID") ENABLE;
