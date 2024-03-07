--------------------------------------------------------
--  Constraints for Table EMAILS
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."EMAILS" MODIFY ("E_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."EMAILS" MODIFY ("INSTITUTE_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."EMAILS" ADD CONSTRAINT "EMAILS_PK" PRIMARY KEY ("E_ID")
  USING INDEX "INSTITUTE"."EMAILS_PK"  ENABLE;
