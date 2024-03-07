--------------------------------------------------------
--  DDL for Table GUARDIAN_DET
--------------------------------------------------------

  CREATE TABLE "INSTITUTE"."GUARDIAN_DET" 
   (	"GUARDIAN_ID" NUMBER, 
	"STUDENT_ID" NUMBER, 
	"GFIRSTNAME" VARCHAR2(100 BYTE) COLLATE "USING_NLS_COMP", 
	"GMIDDLENAME" VARCHAR2(100 BYTE) COLLATE "USING_NLS_COMP", 
	"GLASTNAME" VARCHAR2(100 BYTE) COLLATE "USING_NLS_COMP", 
	"GOCCUPATION" VARCHAR2(10 BYTE) COLLATE "USING_NLS_COMP", 
	"GCONT_NO" VARCHAR2(20 BYTE) COLLATE "USING_NLS_COMP", 
	"CREATED_BY" VARCHAR2(50 BYTE) COLLATE "USING_NLS_COMP", 
	"CREATED_ON" TIMESTAMP (6), 
	"UPDATED_BY" VARCHAR2(50 BYTE) COLLATE "USING_NLS_COMP", 
	"UPDATED_ON" TIMESTAMP (6)
   )  DEFAULT COLLATION "USING_NLS_COMP" SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 10 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA" ;
