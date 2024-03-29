--------------------------------------------------------
--  DDL for Table BOOKSISSUEDET
--------------------------------------------------------

  CREATE TABLE "INSTITUTE"."BOOKSISSUEDET" 
   (	"BOOKISSUEID" NUMBER, 
	"BOOKID" NUMBER, 
	"BOOKCAT_ID" NUMBER, 
	"EMPLOYEE_ID" NUMBER, 
	"STUDENT_ID" NUMBER, 
	"INSTITUTE_ID" NUMBER, 
	"LIB_ID" NUMBER, 
	"ISSUEDATE" DATE, 
	"RETURNDATE" DATE, 
	"NOOFBOOK" VARCHAR2(100 BYTE) COLLATE "USING_NLS_COMP", 
	"ISREWNEW" VARCHAR2(10 BYTE) COLLATE "USING_NLS_COMP", 
	"AC_YEARID" NUMBER, 
	"CREATED_BY" VARCHAR2(100 BYTE) COLLATE "USING_NLS_COMP", 
	"CREATED_ON" TIMESTAMP (6), 
	"UPDATED_BY" VARCHAR2(100 BYTE) COLLATE "USING_NLS_COMP", 
	"UPDATED_ON" TIMESTAMP (6), 
	"STATUS" VARCHAR2(15 BYTE) COLLATE "USING_NLS_COMP"
   )  DEFAULT COLLATION "USING_NLS_COMP" SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 10 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA" ;
