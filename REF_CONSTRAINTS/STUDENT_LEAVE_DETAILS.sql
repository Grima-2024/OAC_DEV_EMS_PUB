--------------------------------------------------------
--  Ref Constraints for Table STUDENT_LEAVE_DETAILS
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."STUDENT_LEAVE_DETAILS" ADD CONSTRAINT "STUDENT_LEAVE_DETAILS_FK" FOREIGN KEY ("LEAVE_TYPE_ID")
	  REFERENCES "INSTITUTE"."LEAVE_TYPE_MST" ("LEAVE_TYPE_ID") ENABLE;
