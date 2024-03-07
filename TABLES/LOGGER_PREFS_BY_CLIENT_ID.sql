--------------------------------------------------------
--  DDL for Table LOGGER_PREFS_BY_CLIENT_ID
--------------------------------------------------------

  CREATE TABLE "INSTITUTE"."LOGGER_PREFS_BY_CLIENT_ID" 
   (	"CLIENT_ID" VARCHAR2(64 BYTE) COLLATE "USING_NLS_COMP", 
	"LOGGER_LEVEL" VARCHAR2(20 BYTE) COLLATE "USING_NLS_COMP", 
	"INCLUDE_CALL_STACK" VARCHAR2(5 BYTE) COLLATE "USING_NLS_COMP", 
	"CREATED_DATE" DATE DEFAULT sysdate, 
	"EXPIRY_DATE" DATE
   )  DEFAULT COLLATION "USING_NLS_COMP" SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 10 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "DATA" ;

   COMMENT ON COLUMN "INSTITUTE"."LOGGER_PREFS_BY_CLIENT_ID"."CLIENT_ID" IS 'Client identifier';
   COMMENT ON COLUMN "INSTITUTE"."LOGGER_PREFS_BY_CLIENT_ID"."LOGGER_LEVEL" IS 'Logger level. Must be OFF, PERMANENT, ERROR, WARNING, INFORMATION, DEBUG, TIMING';
   COMMENT ON COLUMN "INSTITUTE"."LOGGER_PREFS_BY_CLIENT_ID"."INCLUDE_CALL_STACK" IS 'Include call stack in logging';
   COMMENT ON COLUMN "INSTITUTE"."LOGGER_PREFS_BY_CLIENT_ID"."CREATED_DATE" IS 'Date that entry was created on';
   COMMENT ON COLUMN "INSTITUTE"."LOGGER_PREFS_BY_CLIENT_ID"."EXPIRY_DATE" IS 'After the given expiry date the logger_level will be disabled for the specific client_id. Unless sepcifically removed from this table a job will clean up old entries';
   COMMENT ON TABLE "INSTITUTE"."LOGGER_PREFS_BY_CLIENT_ID"  IS 'Client specific logger levels. Only active client_ids/logger_levels will be maintained in this table';
