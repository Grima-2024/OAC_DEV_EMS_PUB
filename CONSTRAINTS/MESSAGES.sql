--------------------------------------------------------
--  Constraints for Table MESSAGES
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."MESSAGES" MODIFY ("M_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."MESSAGES" MODIFY ("INSTITUTE_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."MESSAGES" ADD CONSTRAINT "MESSAGES_PK" PRIMARY KEY ("M_ID")
  USING INDEX "INSTITUTE"."MESSAGES_PK"  ENABLE;
