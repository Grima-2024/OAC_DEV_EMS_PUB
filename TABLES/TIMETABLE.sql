--------------------------------------------------------
--  DDL for Table TIMETABLE
--------------------------------------------------------

  CREATE TABLE "INSTITUTE"."TIMETABLE" 
   (	"TIMETBL_ID" NUMBER, 
	"DAY" VARCHAR2(50 BYTE) COLLATE "USING_NLS_COMP", 
	"TIME_ID" NUMBER, 
	"ASSIGN_ID" NUMBER, 
	"DETAILS" VARCHAR2(500 BYTE) COLLATE "USING_NLS_COMP", 
	"STATUS" NUMBER(5,0), 
	"INSTITUTE_ID" NUMBER, 
	"CREATED_BY" VARCHAR2(100 BYTE) COLLATE "USING_NLS_COMP", 
	"CREATED_ON" TIMESTAMP (6), 
	"UPDATED_BY" VARCHAR2(100 BYTE) COLLATE "USING_NLS_COMP", 
	"UPDATED_ON" TIMESTAMP (6), 
	"TIMEMST_ID" NUMBER
   )  DEFAULT COLLATION "USING_NLS_COMP" SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 10 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA" ;
