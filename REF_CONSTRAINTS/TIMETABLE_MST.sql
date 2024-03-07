--------------------------------------------------------
--  Ref Constraints for Table TIMETABLE_MST
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."TIMETABLE_MST" ADD CONSTRAINT "TIMETBLMST_INST_MST_FK" FOREIGN KEY ("INSTITUTE_ID")
	  REFERENCES "INSTITUTE"."INSTITUTE_MST" ("INSTITUTE_ID") ENABLE;
