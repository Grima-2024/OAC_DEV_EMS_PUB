--------------------------------------------------------
--  Ref Constraints for Table EMAIL_TEMPLATE
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."EMAIL_TEMPLATE" ADD CONSTRAINT "EMAIL_TEMPLATE_INST_MST_FK" FOREIGN KEY ("INSTITUTE_ID")
	  REFERENCES "INSTITUTE"."INSTITUTE_MST" ("INSTITUTE_ID") ENABLE;
