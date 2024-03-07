--------------------------------------------------------
--  Constraints for Table POINTS_MST
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."POINTS_MST" MODIFY ("POINT_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."POINTS_MST" MODIFY ("ROUTE_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."POINTS_MST" ADD CONSTRAINT "POINTS_MST_PK" PRIMARY KEY ("POINT_ID")
  USING INDEX "INSTITUTE"."POINTS_MST_PK"  ENABLE;
