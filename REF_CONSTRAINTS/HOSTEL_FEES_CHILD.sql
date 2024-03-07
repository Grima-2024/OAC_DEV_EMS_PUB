--------------------------------------------------------
--  Ref Constraints for Table HOSTEL_FEES_CHILD
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."HOSTEL_FEES_CHILD" ADD CONSTRAINT "HOSTEL_FEES_CHILD_CON" FOREIGN KEY ("HOSTEL_FEES_ID")
	  REFERENCES "INSTITUTE"."HOSTEL_FEES_DET" ("HSTL_FEES_ID") ENABLE;
