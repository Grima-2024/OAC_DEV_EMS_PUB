--------------------------------------------------------
--  DDL for Index EMAILS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "INSTITUTE"."EMAILS_PK" ON "INSTITUTE"."EMAILS" ("E_ID") 
  PCTFREE 10 INITRANS 20 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "DATA" ;
