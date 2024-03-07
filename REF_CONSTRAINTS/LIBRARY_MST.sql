--------------------------------------------------------
--  Ref Constraints for Table LIBRARY_MST
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."LIBRARY_MST" ADD CONSTRAINT "LIBRARY_MST_INSTITUTE_MST_FK" FOREIGN KEY ("INSTITUTE_ID")
	  REFERENCES "INSTITUTE"."INSTITUTE_MST" ("INSTITUTE_ID") ENABLE;
