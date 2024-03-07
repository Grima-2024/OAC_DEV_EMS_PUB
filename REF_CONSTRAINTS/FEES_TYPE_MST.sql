--------------------------------------------------------
--  Ref Constraints for Table FEES_TYPE_MST
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."FEES_TYPE_MST" ADD CONSTRAINT "FEES_TYPE_MST_INSTITUTE_MST_FK" FOREIGN KEY ("INSTITUTE_ID")
	  REFERENCES "INSTITUTE"."INSTITUTE_MST" ("INSTITUTE_ID") ENABLE;
