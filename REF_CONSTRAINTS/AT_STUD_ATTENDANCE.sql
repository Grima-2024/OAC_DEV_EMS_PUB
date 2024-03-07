--------------------------------------------------------
--  Ref Constraints for Table AT_STUD_ATTENDANCE
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."AT_STUD_ATTENDANCE" ADD CONSTRAINT "AT_STUD_ATTEND_STUD_DET_FK" FOREIGN KEY ("STUDENT_ID")
	  REFERENCES "INSTITUTE"."STUDENTS_DET" ("STUDENT_ID") ENABLE;
