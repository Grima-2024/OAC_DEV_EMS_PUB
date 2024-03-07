--------------------------------------------------------
--  Ref Constraints for Table FEES_STRUCTURE_YEARLY
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."FEES_STRUCTURE_YEARLY" ADD CONSTRAINT "FEES_STRU_YEARLY_AC_YR_MST_FK" FOREIGN KEY ("AC_YEAR_ID")
	  REFERENCES "INSTITUTE"."ACADEMIC_YEAR_MST" ("AC_YEAR_ID") ENABLE;
