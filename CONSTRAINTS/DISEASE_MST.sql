--------------------------------------------------------
--  Constraints for Table DISEASE_MST
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."DISEASE_MST" MODIFY ("DISEASE_MAST_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."DISEASE_MST" ADD CONSTRAINT "DISEASE_MAST_PK" PRIMARY KEY ("DISEASE_MAST_ID")
  USING INDEX "INSTITUTE"."DISEASE_MAST_PK"  ENABLE;
