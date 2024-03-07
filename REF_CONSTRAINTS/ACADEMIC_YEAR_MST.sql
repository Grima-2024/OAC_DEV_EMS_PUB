--------------------------------------------------------
--  Ref Constraints for Table ACADEMIC_YEAR_MST
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."ACADEMIC_YEAR_MST" ADD CONSTRAINT "AC_YEAR_MST_INST_MST_FK" FOREIGN KEY ("INSTITUTE_ID")
	  REFERENCES "INSTITUTE"."INSTITUTE_MST" ("INSTITUTE_ID") ENABLE;
