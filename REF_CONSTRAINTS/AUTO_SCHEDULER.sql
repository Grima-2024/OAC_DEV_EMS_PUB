--------------------------------------------------------
--  Ref Constraints for Table AUTO_SCHEDULER
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."AUTO_SCHEDULER" ADD CONSTRAINT "AUTO_SCHEDULER_FK" FOREIGN KEY ("TIME_ID_FK")
	  REFERENCES "INSTITUTE"."TIME_MST" ("TIME_ID") ENABLE;
