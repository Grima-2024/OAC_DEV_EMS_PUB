--------------------------------------------------------
--  DDL for Index EMAIL_ATTACHMENTS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "INSTITUTE"."EMAIL_ATTACHMENTS_PK" ON "INSTITUTE"."EMAIL_ATTACHMENTS" ("EMAIL_ATACH_ID") 
  PCTFREE 10 INITRANS 20 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "DATA" ;
