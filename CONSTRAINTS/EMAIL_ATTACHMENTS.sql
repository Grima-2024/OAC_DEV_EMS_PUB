--------------------------------------------------------
--  Constraints for Table EMAIL_ATTACHMENTS
--------------------------------------------------------

  ALTER TABLE "INSTITUTE"."EMAIL_ATTACHMENTS" MODIFY ("EMAIL_ATACH_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."EMAIL_ATTACHMENTS" MODIFY ("E_ID" NOT NULL ENABLE);
  ALTER TABLE "INSTITUTE"."EMAIL_ATTACHMENTS" ADD CONSTRAINT "EMAIL_ATTACHMENTS_PK" PRIMARY KEY ("EMAIL_ATACH_ID")
  USING INDEX "INSTITUTE"."EMAIL_ATTACHMENTS_PK"  ENABLE;