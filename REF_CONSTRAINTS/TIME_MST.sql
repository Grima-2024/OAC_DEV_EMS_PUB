--------------------------------------------------------
--  Ref Constraints for Table TIME_MST
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."TIME_MST" ADD CONSTRAINT "TIME_MST_INSTITUTE_MST_FK" FOREIGN KEY ("INSTITUTE_ID")
	  REFERENCES "INSTITUTE"."INSTITUTE_MST" ("INSTITUTE_ID") ENABLE;
