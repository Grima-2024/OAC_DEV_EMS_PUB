--------------------------------------------------------
--  Ref Constraints for Table STANDARD_MST
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."STANDARD_MST" ADD CONSTRAINT "STD_MST_MED_MST_FK" FOREIGN KEY ("MED_ID")
	  REFERENCES "INSTITUTE"."MEDIUM_MST" ("MED_ID") ENABLE;
