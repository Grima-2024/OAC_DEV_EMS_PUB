--------------------------------------------------------
--  Ref Constraints for Table STATE_MST
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."STATE_MST" ADD CONSTRAINT "STATE_MAST_COUNTRY_MAST_FK" FOREIGN KEY ("COUNTRIES_ID")
	  REFERENCES "INSTITUTE"."COUNTRIES_MST" ("COUNTRY_ID") ENABLE;
