--------------------------------------------------------
--  Ref Constraints for Table VEHICAL_MST
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."VEHICAL_MST" ADD CONSTRAINT "VEHICAL_MST_INSTITUTE_MST_FK" FOREIGN KEY ("INSTITUTE_ID")
	  REFERENCES "INSTITUTE"."INSTITUTE_MST" ("INSTITUTE_ID") ENABLE;
