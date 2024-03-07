--------------------------------------------------------
--  Ref Constraints for Table HOSTEL_FEES_DET
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."HOSTEL_FEES_DET" ADD CONSTRAINT "HOSTEL_FEES_DET_HOSTEL_MST_FK" FOREIGN KEY ("HOSTEL_ID")
	  REFERENCES "INSTITUTE"."HOSTEL_MST" ("HOSTEL_ID") ENABLE;
