--------------------------------------------------------
--  Ref Constraints for Table SEMESTER_MST
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."SEMESTER_MST" ADD CONSTRAINT "SEM_MST_STD_MST_FK" FOREIGN KEY ("STD_ID")
	  REFERENCES "INSTITUTE"."STANDARD_MST" ("STD_ID") ENABLE;
