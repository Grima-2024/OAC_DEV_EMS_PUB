--------------------------------------------------------
--  Ref Constraints for Table POINTS_MST
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."POINTS_MST" ADD CONSTRAINT "POINTS_MST_ROUTE_MST_FK" FOREIGN KEY ("ROUTE_ID")
	  REFERENCES "INSTITUTE"."ROUTE_MST" ("ROUTE_ID") ENABLE;
