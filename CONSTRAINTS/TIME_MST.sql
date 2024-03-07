--------------------------------------------------------
--  Constraints for Table TIME_MST
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."TIME_MST" MODIFY ("TIME_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."TIME_MST" MODIFY ("INSTITUTE_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."TIME_MST" ADD CONSTRAINT "TIME_MST_PK" PRIMARY KEY ("TIME_ID")
  USING INDEX "INSTITUTE"."TIME_MST_PK"  ENABLE;
