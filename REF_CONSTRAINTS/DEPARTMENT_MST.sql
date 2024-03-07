--------------------------------------------------------
--  Ref Constraints for Table DEPARTMENT_MST
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."DEPARTMENT_MST" ADD CONSTRAINT "DEPARTMENT_MST_FK" FOREIGN KEY ("INSTITUTE_ID")
	  REFERENCES "INSTITUTE"."INSTITUTE_MST" ("INSTITUTE_ID") ENABLE;
