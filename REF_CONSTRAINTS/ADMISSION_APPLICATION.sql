--------------------------------------------------------
--  Ref Constraints for Table ADMISSION_APPLICATION
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."ADMISSION_APPLICATION" ADD CONSTRAINT "ADM_APPL_INST_MAST_FK" FOREIGN KEY ("INSTITUTE_ID")
	  REFERENCES "INSTITUTE"."INSTITUTE_MST" ("INSTITUTE_ID") ENABLE;
