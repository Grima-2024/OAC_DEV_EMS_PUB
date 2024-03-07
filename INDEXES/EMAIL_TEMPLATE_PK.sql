--------------------------------------------------------
--  DDL for Index EMAIL_TEMPLATE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "INSTITUTE"."EMAIL_TEMPLATE_PK" ON "INSTITUTE"."EMAIL_TEMPLATE" ("ET_ID") 
  PCTFREE 10 INITRANS 20 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "DATA" ;
