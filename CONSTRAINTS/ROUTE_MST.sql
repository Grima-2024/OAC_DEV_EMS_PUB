--------------------------------------------------------
--  Constraints for Table ROUTE_MST
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."ROUTE_MST" MODIFY ("ROUTE_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."ROUTE_MST" MODIFY ("VEHICAL_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."ROUTE_MST" MODIFY ("INSTITUTE_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."ROUTE_MST" ADD CONSTRAINT "ROUTE_MAST_PK" PRIMARY KEY ("ROUTE_ID")
  USING INDEX "INSTITUTE"."ROUTE_MAST_PK"  ENABLE;
