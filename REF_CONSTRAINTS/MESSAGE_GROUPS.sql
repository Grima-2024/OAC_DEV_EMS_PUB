--------------------------------------------------------
--  Ref Constraints for Table MESSAGE_GROUPS
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."MESSAGE_GROUPS" ADD CONSTRAINT "MESSAGE_GRPS_INST_MST_FK" FOREIGN KEY ("INSTITUTE_ID")
	  REFERENCES "INSTITUTE"."INSTITUTE_MST" ("INSTITUTE_ID") ENABLE;
