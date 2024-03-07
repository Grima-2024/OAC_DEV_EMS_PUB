--------------------------------------------------------
--  Ref Constraints for Table MEDIUM_MST
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."MEDIUM_MST" ADD CONSTRAINT "MED_MST_AC_YEAR_MST_FK" FOREIGN KEY ("AC_YEAR_ID")
	  REFERENCES "INSTITUTE"."ACADEMIC_YEAR_MST" ("AC_YEAR_ID") ENABLE;
