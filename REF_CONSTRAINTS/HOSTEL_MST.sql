--------------------------------------------------------
--  Ref Constraints for Table HOSTEL_MST
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."HOSTEL_MST" ADD CONSTRAINT "HOSTEL_MST_INSTITUTE_MST_FK" FOREIGN KEY ("INSTITUTE_ID")
	  REFERENCES "INSTITUTE"."INSTITUTE_MST" ("INSTITUTE_ID") ENABLE;
