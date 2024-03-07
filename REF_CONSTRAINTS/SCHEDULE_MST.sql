--------------------------------------------------------
--  Ref Constraints for Table SCHEDULE_MST
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."SCHEDULE_MST" ADD CONSTRAINT "SCHEDULE_MST_FK" FOREIGN KEY ("TIME_ID_FK")
	  REFERENCES "INSTITUTE"."TIME_MST" ("TIME_ID") ENABLE;
