--------------------------------------------------------
--  DDL for Index MESSAGE_GROUPS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "INSTITUTE"."MESSAGE_GROUPS_PK" ON "INSTITUTE"."MESSAGE_GROUPS" ("GROUP_ID") 
  PCTFREE 10 INITRANS 20 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "DATA" ;
