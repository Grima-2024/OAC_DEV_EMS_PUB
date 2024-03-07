--------------------------------------------------------
--  Ref Constraints for Table HOSTEL_FEES_STRUCTURE
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."HOSTEL_FEES_STRUCTURE" ADD CONSTRAINT "HOSTEL_FEES_STRUCT_HSTL_MST_FK" FOREIGN KEY ("HOSTEL_ID")
	  REFERENCES "INSTITUTE"."HOSTEL_MST" ("HOSTEL_ID") ENABLE;
