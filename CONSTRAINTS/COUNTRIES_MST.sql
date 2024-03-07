--------------------------------------------------------
--  Constraints for Table COUNTRIES_MST
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."COUNTRIES_MST" MODIFY ("COUNTRY_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."COUNTRIES_MST" ADD CONSTRAINT "COUNTRIES_MAST_PK" PRIMARY KEY ("COUNTRY_ID")
  USING INDEX "INSTITUTE"."COUNTRIES_MAST_PK"  ENABLE;
