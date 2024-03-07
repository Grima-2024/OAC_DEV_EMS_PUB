--------------------------------------------------------
--  Ref Constraints for Table GUARDIAN_DET
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."GUARDIAN_DET" ADD CONSTRAINT "GUARDIAN_DET_STUDENTS_DET_FK" FOREIGN KEY ("STUDENT_ID")
	  REFERENCES "INSTITUTE"."STUDENTS_DET" ("STUDENT_ID") ENABLE;
