--------------------------------------------------------
--  Ref Constraints for Table XXX_USER_MST
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."XXX_USER_MST" ADD CONSTRAINT "XXX_USER_MST_FK" FOREIGN KEY ("USER_TYPE_ID")
	  REFERENCES "INSTITUTE"."XXX_USER_TYPE_MST" ("USER_TYPE_ID") ENABLE;
